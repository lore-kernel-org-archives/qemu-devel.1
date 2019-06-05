Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C4C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7AA20693
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="VHgXHA+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7AA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYX3X-0000Cm-O9
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:38:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYX0C-0006DA-Q0
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYX0B-0005gC-Qz
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:34:56 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:42062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1hYX0A-0005Xe-W7
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.uni-paderborn.de; s=20170601;
	h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zkEbc/dzofgQsyiWdFHVMsu+iVxuHVnDsY35gvk5YQU=;
	b=VHgXHA+RxV3MJbIUwjsBo+nSLX
	CXsODykKYyph3nwyqyOn4tJaXeWN37ilp2kvjJFZTSTHh0z/FTvPinDzel3013W1pWEpRaaxW9bHO
	ZGAuBXvSzm0sLfmtYX5jDkz/JRIztw/vbdoKDswNuYozdBM/Kdl6Ot7kmeGzBWZ9OODk=; 
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
	<20190605061126.10244-4-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <ffb4ba2c-318e-6b08-c206-a90b000074d2@mail.uni-paderborn.de>
Date: Wed, 5 Jun 2019 16:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605061126.10244-4-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
	Antispam-Data: 2019.6.5.143016, AntiVirus-Engine: 5.63.0,
	AntiVirus-Data: 2019.6.4.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
Subject: Re: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andreas Konopik <andreas.konopik@efs-auto.de>,
	David Brenken <david.brenken@efs-auto.de>,
	Robert Rasche <robert.rasche@efs-auto.de>,
	Georg Hofstetter <georg.hofstetter@efs-auto.de>,
	Lars Biermanski <lars.biermanski@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 6/5/19 8:11 AM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
>
> Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
> Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
> Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
>
> ---
>   target/tricore/translate.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index a8b4de647a..19d8db7a46 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -7004,6 +7004,7 @@ static void decode_rrpw_extract_insert(CPUTriCoreState *env, DisasContext *ctx)
>       uint32_t op2;
>       int r1, r2, r3;
>       int32_t pos, width;
> +    TCGv temp1, temp2;
>   
>       op2 = MASK_OP_RRPW_OP2(ctx->opcode);
>       r1 = MASK_OP_RRPW_S1(ctx->opcode);
> @@ -7042,9 +7043,13 @@ static void decode_rrpw_extract_insert(CPUTriCoreState *env, DisasContext *ctx)
>           }
>           break;
>       case OPC2_32_RRPW_INSERT:
> -        if (pos + width <= 31) {
> -            tcg_gen_deposit_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
> -                               width, pos);
Can you explain the problem causing the bug? Deposit looks fine to me. 
After reading the specs again, I agree that the check needs to be <= 32.


> +        if (pos + width <= 32) {
> +            temp1 = tcg_const_i32(pos);   /* pos */
> +            temp2 = tcg_const_i32(width); /* width */
Useless comments.


Cheers,

Bastian


