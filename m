Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5700CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B2D206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTEwgkP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B2D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBz2-0001B3-D0
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqBx3-0007Jw-D3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:49:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqBx1-0000SV-96
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593506950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnEgn/76pMXFdjHMyP9O+/Sj9aHaLbzTYkL9U62wrk4=;
 b=LTEwgkP9Ditc+eoIdp2HoXY63D76Xa4CAmPFa0GvG0KK5zQOlFa1knu2fDVgatF1Z83LtK
 5Z93mU1ZCZ8vzfykk3kpSSusVe2zN0jsNxF7mxIfIlXTUbOo8ip8hIZt/xZckxbohBUHeU
 p4Pt23jAJZ/Br5u50l0UM1Z3Dy6bUfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-dMZ6tbWQMc2jMDWVX5sxng-1; Tue, 30 Jun 2020 04:49:07 -0400
X-MC-Unique: dMZ6tbWQMc2jMDWVX5sxng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C217100960F;
 Tue, 30 Jun 2020 08:49:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-46.ams2.redhat.com [10.36.112.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CCFC1A919;
 Tue, 30 Jun 2020 08:48:56 +0000 (UTC)
Subject: Re: [PATCH v5 00/12] pc-bios: s390x: Cleanup part 1
To: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624124406.2baac59f.cohuck@redhat.com>
 <3c30f41c-1875-d288-9f6c-0e7c63b7b4a9@redhat.com>
 <5373b97f-e553-629e-326a-f3c703a1288b@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d192b312-32bc-369a-2d06-cac806b0c0c8@redhat.com>
Date: Tue, 30 Jun 2020 10:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5373b97f-e553-629e-326a-f3c703a1288b@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, borntraeger@de.ibm.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 12.57, Janosch Frank wrote:
> On 6/24/20 12:46 PM, Thomas Huth wrote:
>> On 24/06/2020 12.44, Cornelia Huck wrote:
>>> On Wed, 24 Jun 2020 03:52:14 -0400
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>
>>>> The bios is in dire need for a cleanup as there are still a lot of
>>>> magic constants being used throughout as well as duplicated code.
>>>>
>>>> In the first part of this series we consolidate constants and
>>>> functions, as well as doing some minor cleanups and fixes.
>>>>
>>>> The patches are available here:
>>>> https://github.com/frankjaa/qemu/pull/new/cleanup_bios
>>>>
>>>> v5:
>>>> 	* Fixed whitespace damage
>>>> 	* Removed reset PSW mask changes in dasd-ipl.c
>>>> 	* Added jump2ipl.c cleanup patches
>>>>
>>>> v4:
>>>> 	* Renamed time.h to s390-time.h
>>>> 	* Fixed function names in sleep()
>>>> 	* Changed order of sense_id_ccw initialization
>>>> 	* Added missing include before sleep()
>>>>
>>>> v3:
>>>> 	* Dropped 0x00 to 0x0/0 patch
>>>> 	* Moved some timing functions into helper.h instead of time.h
>>>> 	* Fixed IPL psw manipulation in dasd-ipl.c
>>>>    	* Minor cosmetic fixes found by review
>>>>
>>>> v2:
>>>> 	* Included cio fixup to get rid of compile errors...
>>>> 	* Minor cosmetic fixes found by review
>>>>
>>>>
>>>> Janosch Frank (12):
>>>>     pc-bios: s390x: cio.c cleanup and compile fix
>>>>     pc-bios: s390x: Consolidate timing functions into time.h
>>>>     pc-bios: s390x: Move sleep and yield to helper.h
>>>>     pc-bios: s390x: Get rid of magic offsets into the lowcore
>>>>     pc-bios: s390x: Remove unneeded dasd-ipl.c reset psw mask changes
>>>>     pc-bios: s390x: Rename PSW_MASK_ZMODE to PSW_MASK_64
>>>>     pc-bios: s390x: Use PSW masks where possible and introduce
>>>>       PSW_MASK_SHORT_ADDR
>>>>     pc-bios: s390x: Move panic() into header and add infinite loop
>>>>     pc-bios: s390x: Use ebcdic2ascii table
>>>>     pc-bios: s390x: Make u32 ptr check explicit
>>>>     pc-bios: s390x: Fix bootmap.c passing PSWs as addresses
>>>>     pc-bios: s390x: Cleanup jump to ipl code
>>>>
>>>>    pc-bios/s390-ccw/bootmap.c     |  9 ++++----
>>>>    pc-bios/s390-ccw/bootmap.h     |  2 +-
>>>>    pc-bios/s390-ccw/cio.c         | 40 +++++++++++++++++++---------------
>>>>    pc-bios/s390-ccw/cio.h         | 17 ++++++++++-----
>>>>    pc-bios/s390-ccw/dasd-ipl.c    |  3 ---
>>>>    pc-bios/s390-ccw/helper.h      | 19 +++++++++++++++-
>>>>    pc-bios/s390-ccw/jump2ipl.c    | 35 ++++++++++++-----------------
>>>>    pc-bios/s390-ccw/main.c        | 15 +++----------
>>>>    pc-bios/s390-ccw/menu.c        |  1 +
>>>>    pc-bios/s390-ccw/netmain.c     | 23 +++----------------
>>>>    pc-bios/s390-ccw/s390-arch.h   |  4 +++-
>>>>    pc-bios/s390-ccw/s390-ccw.h    | 27 ++++++-----------------
>>>>    pc-bios/s390-ccw/s390-time.h   | 23 +++++++++++++++++++
>>>>    pc-bios/s390-ccw/start.S       |  5 +++--
>>>>    pc-bios/s390-ccw/virtio-net.c  |  2 ++
>>>>    pc-bios/s390-ccw/virtio-scsi.c |  2 ++
>>>>    pc-bios/s390-ccw/virtio.c      | 18 +++------------
>>>>    17 files changed, 120 insertions(+), 125 deletions(-)
>>>>    create mode 100644 pc-bios/s390-ccw/s390-time.h
>>>>
>>>
>>> Hm... what's the general status of this? Most of the patches have at
>>> least one R-b/A-b already, I see.
>>>
>>> Do the s390-ccw boot maintainers want to pick this (once the rest has
>>> been looked at) and then send me a pull req, or should I pick it when
>>> it is good to go? Softfreeze is less than two weeks away :)
>>
>> I'd like to review the missing parts and run my tests with the patches
>> applied ... I'm just a little bit swamped right now, so please give me
>> some more time...
>>
>>    Thomas
> 
> I'd suggest we hold off on the RFC patch since it makes testing all of
> the boot methods necessary and I was only able to test direct, dasd
> passthrough and virtio-ccw up to now. Time to build a testing environment...
> 
> I can move that patch into the next series for further discussion. It
> was mostly added to prove the 64 bit PSW mask removal in patch #5.

I think patches 1-4 and 6-10 are ready to go, I also tested them now 
with my usual manual regression tests and there was no issue.

For patch 5, I first like to get some feedback from Jason, to understand 
the original intention of the removed code there.

Patch 11 needs a rework.

And for patch 12, I'd appreciate some feedback from Christian.

I'm planning to send a s390-ccw pull request for the softfreeze on 
Thursday, so if you want to see 5, 11 or 12 included there, it would be 
good to get this done within the next two days (otherwise, I think it's 
also not too critical to delay them to QEMU 5.2 instead).

  Thomas


