Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B5AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E5220781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2XG/G+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E5220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2xB-0005Qn-Jq
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo2vl-0004IU-9e
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:47:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo2vj-0008Ov-7g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOVAv8YYtcD7qZ+L9lJigE155ZVDMxB3IVrJ3GX1itg=;
 b=d2XG/G+EznflvgNbp+6PPudzOdMy0NJztwsHc8GegBO7rfYQq1q9MTnysLPpDQAsc7NnHs
 NzKTGnKAgYRuL0VYtJ2YfTOq+MZlfF6uR1l1pi7klvpSDwiEIPbALYr0heiIGHPMA7IdBG
 O73zALsbKIjIY4xI8g407ZVNj9OouIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Ow8SSfMYPV-BB2Bk6ZreNg-1; Wed, 24 Jun 2020 06:46:56 -0400
X-MC-Unique: Ow8SSfMYPV-BB2Bk6ZreNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D00A1005512;
 Wed, 24 Jun 2020 10:46:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-35.ams2.redhat.com [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FFCE7CADE;
 Wed, 24 Jun 2020 10:46:50 +0000 (UTC)
Subject: Re: [PATCH v5 00/12] pc-bios: s390x: Cleanup part 1
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624124406.2baac59f.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3c30f41c-1875-d288-9f6c-0e7c63b7b4a9@redhat.com>
Date: Wed, 24 Jun 2020 12:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624124406.2baac59f.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 12.44, Cornelia Huck wrote:
> On Wed, 24 Jun 2020 03:52:14 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> The bios is in dire need for a cleanup as there are still a lot of
>> magic constants being used throughout as well as duplicated code.
>>
>> In the first part of this series we consolidate constants and
>> functions, as well as doing some minor cleanups and fixes.
>>
>> The patches are available here:
>> https://github.com/frankjaa/qemu/pull/new/cleanup_bios
>>
>> v5:
>> 	* Fixed whitespace damage
>> 	* Removed reset PSW mask changes in dasd-ipl.c
>> 	* Added jump2ipl.c cleanup patches
>>
>> v4:
>> 	* Renamed time.h to s390-time.h
>> 	* Fixed function names in sleep()
>> 	* Changed order of sense_id_ccw initialization
>> 	* Added missing include before sleep()
>>
>> v3:
>> 	* Dropped 0x00 to 0x0/0 patch
>> 	* Moved some timing functions into helper.h instead of time.h
>> 	* Fixed IPL psw manipulation in dasd-ipl.c
>>   	* Minor cosmetic fixes found by review
>>
>> v2:
>> 	* Included cio fixup to get rid of compile errors...
>> 	* Minor cosmetic fixes found by review
>>
>>
>> Janosch Frank (12):
>>    pc-bios: s390x: cio.c cleanup and compile fix
>>    pc-bios: s390x: Consolidate timing functions into time.h
>>    pc-bios: s390x: Move sleep and yield to helper.h
>>    pc-bios: s390x: Get rid of magic offsets into the lowcore
>>    pc-bios: s390x: Remove unneeded dasd-ipl.c reset psw mask changes
>>    pc-bios: s390x: Rename PSW_MASK_ZMODE to PSW_MASK_64
>>    pc-bios: s390x: Use PSW masks where possible and introduce
>>      PSW_MASK_SHORT_ADDR
>>    pc-bios: s390x: Move panic() into header and add infinite loop
>>    pc-bios: s390x: Use ebcdic2ascii table
>>    pc-bios: s390x: Make u32 ptr check explicit
>>    pc-bios: s390x: Fix bootmap.c passing PSWs as addresses
>>    pc-bios: s390x: Cleanup jump to ipl code
>>
>>   pc-bios/s390-ccw/bootmap.c     |  9 ++++----
>>   pc-bios/s390-ccw/bootmap.h     |  2 +-
>>   pc-bios/s390-ccw/cio.c         | 40 +++++++++++++++++++---------------
>>   pc-bios/s390-ccw/cio.h         | 17 ++++++++++-----
>>   pc-bios/s390-ccw/dasd-ipl.c    |  3 ---
>>   pc-bios/s390-ccw/helper.h      | 19 +++++++++++++++-
>>   pc-bios/s390-ccw/jump2ipl.c    | 35 ++++++++++++-----------------
>>   pc-bios/s390-ccw/main.c        | 15 +++----------
>>   pc-bios/s390-ccw/menu.c        |  1 +
>>   pc-bios/s390-ccw/netmain.c     | 23 +++----------------
>>   pc-bios/s390-ccw/s390-arch.h   |  4 +++-
>>   pc-bios/s390-ccw/s390-ccw.h    | 27 ++++++-----------------
>>   pc-bios/s390-ccw/s390-time.h   | 23 +++++++++++++++++++
>>   pc-bios/s390-ccw/start.S       |  5 +++--
>>   pc-bios/s390-ccw/virtio-net.c  |  2 ++
>>   pc-bios/s390-ccw/virtio-scsi.c |  2 ++
>>   pc-bios/s390-ccw/virtio.c      | 18 +++------------
>>   17 files changed, 120 insertions(+), 125 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/s390-time.h
>>
> 
> Hm... what's the general status of this? Most of the patches have at
> least one R-b/A-b already, I see.
> 
> Do the s390-ccw boot maintainers want to pick this (once the rest has
> been looked at) and then send me a pull req, or should I pick it when
> it is good to go? Softfreeze is less than two weeks away :)

I'd like to review the missing parts and run my tests with the patches 
applied ... I'm just a little bit swamped right now, so please give me 
some more time...

  Thomas


