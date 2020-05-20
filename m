Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA87BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E16207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9leWnVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E16207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNHT-0000Yu-Od
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jbNGo-0007jA-W2
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:52:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35955
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jbNGn-0008EV-WB
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLR2+0PwQUCD3WQXjL8Zf2H6r5oH5dlOdP0mK4qahyE=;
 b=H9leWnVqXarjEkBsutxtYaRYOBQ78zZa+cv3gbxxp69kjp4BuBjnEN60r3xzL7ZYciBXaz
 6oYuebM7BAfFRjiBT9Fun7HsToITuSrkbS3og68xdn8m7Ftb0xVxvkDghdRUPxsldABfIu
 QKRh6vAnQaSV7/CwStYNTm4ie0VGA1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-fAim3l05NWCFuaAveI-hPg-1; Wed, 20 May 2020 07:52:18 -0400
X-MC-Unique: fAim3l05NWCFuaAveI-hPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3E51800D42;
 Wed, 20 May 2020 11:52:16 +0000 (UTC)
Received: from gondolin (ovpn-113-5.ams2.redhat.com [10.36.113.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C659D5C1BE;
 Wed, 20 May 2020 11:52:12 +0000 (UTC)
Date: Wed, 20 May 2020 13:52:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] pc-bios: s390x: Cleanup part 1
Message-ID: <20200520135210.1b8f0d22.cohuck@redhat.com>
In-Reply-To: <20200514123729.156283-1-frankja@linux.ibm.com>
References: <20200514123729.156283-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 08:37:20 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> The bios is in dire need for a cleanup as there are still a lot of
> magic constants being used throughout as well as duplicated code.
> 
> In the first part of this series we consolidate constants and
> functions, as well as doing some minor cleanups and fixes.
> 
> The patches are available here:
> https://github.com/frankjaa/qemu/pull/new/cleanup_bios
> 
> v2:
> 	* Included cio fixup to get rid of compile errors...
> 	* Minor cosmetic fixes found by review
> 
> Janosch Frank (9):
>   pc-bios: s390x: cio.c cleanup and compile fix
>   pc-bios: s390x: Consolidate timing functions into time.h
>   pc-bios: s390x: Get rid of magic offsets into the lowcore
>   pc-bios: s390x: Rename and use PSW_MASK_ZMODE constant
>   pc-bios: s390x: Use PSW masks where possible
>   pc-bios: s390x: Move panic() into header and add infinite loop
>   pc-bios: s390x: Use ebcdic2ascii table
>   pc-bios: s390x: Replace 0x00 with 0x0 or 0
>   pc-bios: s390x: Make u32 ptr check explicit
> 
>  pc-bios/s390-ccw/bootmap.c     |  4 +---
>  pc-bios/s390-ccw/cio.c         | 36 +++++++++++++++----------------
>  pc-bios/s390-ccw/cio.h         | 17 +++++++++------
>  pc-bios/s390-ccw/dasd-ipl.c    | 17 +++++++--------
>  pc-bios/s390-ccw/helper.h      |  2 +-
>  pc-bios/s390-ccw/jump2ipl.c    | 10 ++++-----
>  pc-bios/s390-ccw/main.c        | 15 +++----------
>  pc-bios/s390-ccw/menu.c        |  1 +
>  pc-bios/s390-ccw/netmain.c     | 23 +++-----------------
>  pc-bios/s390-ccw/s390-arch.h   |  4 +++-
>  pc-bios/s390-ccw/s390-ccw.h    | 27 ++++++-----------------
>  pc-bios/s390-ccw/start.S       |  5 +++--
>  pc-bios/s390-ccw/time.h        | 39 ++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-net.c  |  1 +
>  pc-bios/s390-ccw/virtio-scsi.c |  1 +
>  pc-bios/s390-ccw/virtio.c      | 18 +++-------------
>  16 files changed, 107 insertions(+), 113 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/time.h
> 

I assume Christian/Thomas will pick that one up once the last wrinkles
have been ironed out?


