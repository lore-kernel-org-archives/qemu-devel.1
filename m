Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4073C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D56B20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qv2n2CHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D56B20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsnQ-00023s-KD
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jDqim-0007oH-L4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jDqil-0000Dm-GH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:28:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jDqil-0000BI-AK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584368879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoppFsbbvyA7kK0N+2AWfM9tZdwTTZmszHuy1FLWWSM=;
 b=Qv2n2CHBseZgbUIK4PhVS1isviBu4znaN7pzP8Uk5tqMrivVXMtrHLuaNS3dO4gbxCABak
 t4EbsBulIXdnCoZikWF7v96k9yOCVT8GpWY8ouX5luraODtDRlKw1WjgCwDdR6S16ZOXbe
 JNfKZbW4lTqS+q9wMx/jOwwTV6eCR/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-SB-_A9JANSyPGec6i0HLJQ-1; Mon, 16 Mar 2020 10:27:57 -0400
X-MC-Unique: SB-_A9JANSyPGec6i0HLJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C86800D50;
 Mon, 16 Mar 2020 14:27:56 +0000 (UTC)
Received: from gondolin (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2251910027B9;
 Mon, 16 Mar 2020 14:27:40 +0000 (UTC)
Date: Mon, 16 Mar 2020 15:27:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9] fixup! Fix subcode/pbt
Message-ID: <20200316152738.4c1c65ee.cohuck@redhat.com>
In-Reply-To: <20200313095232.2392-1-frankja@linux.ibm.com>
References: <a1ed33c4-91c0-90fa-2f95-417e320e172c@de.ibm.com>
 <20200313095232.2392-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 05:52:32 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/ipl.h      | 11 +++++++----
>  target/s390x/diag.c |  2 +-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 95e3183c9cccf8b6..f799f7cfcf4763b1 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -261,15 +261,18 @@ static inline bool ipl_valid_pv_header(IplParameterBlock *iplb)
>          return true;
>  }
>  
> -static inline bool iplb_valid(IplParameterBlock *iplb)
> +static inline bool iplb_valid(IplParameterBlock *iplb, uint64_t subcode)
>  {
>      switch (iplb->pbt) {
>      case S390_IPL_TYPE_FCP:
> -        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
> +        return (subcode == DIAG308_SET &&
> +                be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN);
>      case S390_IPL_TYPE_CCW:
> -        return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
> +        return (subcode == DIAG308_SET &&
> +                be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN);
>      case S390_IPL_TYPE_PV:
> -        if (be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
> +        if (subcode != DIAG308_PV_SET ||
> +            be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
>              return false;

I'm not sure I like passing the subcode here...

>          }
>          if (!ipl_valid_pv_header(iplb)) {
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index b1ca81633b83bbdc..d4f33db5c23c818d 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -118,7 +118,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
>  
> -        if (!iplb_valid(iplb)) {
> +        if (!iplb_valid(iplb, subcode)) {
>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
>              goto out;
>          }

...because you're basically checking whether you either have a valid
normal iplb, or a valid pv iplb, with the two being mutually exclusive,
IIUC. So what about introducing iplb_valid_pv and calling that for the
pv case? Would be a bit nicer to read, I think, and also matches what
you do for the STORE case.


