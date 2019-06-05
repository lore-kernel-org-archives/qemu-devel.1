Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA7FC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4113206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="F9AhlCK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4113206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXUC-0004gT-Sk
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:05:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYXSb-0003vt-0o
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hYXSZ-0005QW-KE
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:04:16 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:50684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1hYXSZ-0005Nk-0C
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.uni-paderborn.de; s=20170601;
	h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2do2sMAIm7e8TJAL+gd7xIHVH5HyBu5SAu8WRWPdU+g=;
	b=F9AhlCK3MfjkGfo9GPGg92r9B4
	CVeQbfeFxdy/A/g6RjZu1Gx5LEE5YBozAKwy3Efgah+XUgaduWOKz8kMXvMZqBbF/Uzx0wSjlKkko
	Kjpml9CW6C3LQqJjP6INRvJUFcSGqa18H21c5Oi+O0ViQi4pVIk4xUhJtoYEXsir6jQI=; 
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
	<20190605061126.10244-5-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <9baa6207-17a2-7218-9ad2-9627de232304@mail.uni-paderborn.de>
Date: Wed, 5 Jun 2019 17:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605061126.10244-5-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
	Antispam-Data: 2019.6.5.150016, AntiVirus-Engine: 5.63.0,
	AntiVirus-Data: 2019.6.4.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
Subject: Re: [Qemu-devel] [PATCH 4/5] tricore: add QSEED instruction
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
Cc: Lars Biermanski <lars.biermanski@efs-auto.de>,
	Andreas Konopik <andreas.konopik@efs-auto.com>,
	Georg Hofstetter <georg.hofstetter@efs-auto.de>,
	David Brenken <david.brenken@efs-auto.de>,
	Robert Rasche <robert.rasche@efs-auto.de>,
	Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 6/5/19 8:11 AM, David Brenken wrote:
> +/*
> + * Target TriCore QSEED.F significand Lookup Table
> + *
> + * The QSEED.F output significand depends on the least-significant
> + * exponent bit and the 6 most-significant significand bits.
> + *
> + * IEEE 754 float datatype
> + * partitioned into Sign (S), Exponent (E) and Significand (M):
> + *
> + * S   E E E E E E E E   M M M M M M ...
> + *    |             |               |
> + *    +------+------+-------+-------+
> + *           |              |
> + *          for        lookup table
> + *      calculating     index for
> + *        output E       output M
> + */
> +static const uint8_t target_qseed_significand_table[128] = {
> +    253, 252, 245, 244, 239, 238, 231, 230, 225, 224, 217, 216,
> +    211, 210, 205, 204, 201, 200, 195, 194, 189, 188, 185, 184,
> +    179, 178, 175, 174, 169, 168, 165, 164, 161, 160, 157, 156,
> +    153, 152, 149, 148, 145, 144, 141, 140, 137, 136, 133, 132,
> +    131, 130, 127, 126, 123, 122, 121, 120, 117, 116, 115, 114,
> +    111, 110, 109, 108, 103, 102, 99, 98, 93, 92, 89, 88, 83,
> +    82, 79, 78, 75, 74, 71, 70, 67, 66, 63, 62, 59, 58, 55,
> +    54, 53, 52, 49, 48, 45, 44, 43, 42, 39, 38, 37, 36, 33,
> +    32, 31, 30, 27, 26, 25, 24, 23, 22, 19, 18, 17, 16, 15,
> +    14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2
> +};


Can you explain in a comment how you arrived at this lookup table?


> +    } else if (float32_is_neg(arg1)) {
> +        result = float32_sqrt_nan;
> +        env->FPU_FI = 1;
[...]
> +
> +    flags = f_get_excp_flags(env);
> +    if (flags) {
> +        if (flags & float_flag_invalid) {
> +            f_update_psw_flags(env, flags);
> +        } else {
> +            env->FPU_FS = 0;
> +        }
> +    } else {
> +        env->FPU_FS = 0;

You are setting FPU_FS to 0, even though FPU_FI might have been set in 
case of a NaN. I think it's best to remove the whole softfloat check, as 
none of the softfloat functions you call, can raise any flags.

Cheers,

Bastian



