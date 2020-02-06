Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F829218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajsvi6VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F829218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izduB-0002DO-Cq
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1izdst-0001kz-Uc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1izdsq-0005SE-O7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:55:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57402
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1izdsq-0005KJ-1O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580982934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SscazImKevBMxCnSo6uK6I2+cu1YBTNkt3lVSNQjl5I=;
 b=ajsvi6VAbsjEVC1PoGogXACRVOsrtlJkmn60A0z4GjrQzs2UmMX01u1Uk1lzfBgzRa/jkF
 3BjP+Tu9FPhe1cLZZrmMJnycgmUmv0iAW7viSipRuKG9l7hnyfJo1jgDqn+erWIlZWSSA3
 PG0xWvo5g1HPhbDF1qmtlGDiiquIVNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-rtz04DhtNDe1vu7zR_F85w-1; Thu, 06 Feb 2020 04:55:32 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 078361083EA6;
 Thu,  6 Feb 2020 09:55:31 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 182F760BF7;
 Thu,  6 Feb 2020 09:55:29 +0000 (UTC)
Date: Thu, 6 Feb 2020 10:55:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
Message-ID: <20200206105527.00fb21e7.cohuck@redhat.com>
In-Reply-To: <20200205182126.13010-1-jjherne@linux.ibm.com>
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rtz04DhtNDe1vu7zR_F85w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  5 Feb 2020 13:21:26 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> This fixes vfio-ccw when booting non-Linux operating systems. Without this
> struct being packed, a few extra bytes of low core memory get overwritten when
> we  assign a value to memory address 0 in jump_to_IPL_2. This is enough to
> cause some non-Linux OSes of fail when booting.

s/of/to/

> 
> The problem was introduced by:
> 5c6f0d5f46a77d77 "pc-bios/s390x: Fix reset psw mask".

So, what introduced the problem was turning two 32 bit values into a 64
bit value?

> 
> The fix is to pack the struct thereby removing the 4 bytes of padding that get
> added at the end, likely to allow an array of these structs to naturally align
> on an 8-byte boundary.
> 
> Fixes: 5c6f0d5f46a7 ("pc-bios/s390x: Fix reset psw mask")
> CC: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/jump2ipl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index da13c43cc0..1e9eaa037f 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -18,7 +18,7 @@
>  typedef struct ResetInfo {
>      uint64_t ipl_psw;
>      uint32_t ipl_continue;
> -} ResetInfo;
> +} __attribute__((packed)) ResetInfo;
>  
>  static ResetInfo save;
>  

I'm wondering if we have more stuff like that lurking in the bios.


