Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA5C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F1221881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0xv0wXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F1221881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinGt-0007pQ-Cr
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1himum-00016K-Jj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1himul-0001Ue-JG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:35:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1himug-0001OG-Oq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:35:40 -0400
Received: by mail-wm1-x344.google.com with SMTP id s3so3663121wms.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8d5IY0brn4G7eBLoXgp5fLc+r12ute8haCcpIHvNmoo=;
 b=f0xv0wXHX8wdtSjE3+WE+TpnoxUw2FmZMp6FV8fKHuzvxR1Wu1w+vsnCPxvJSRRten
 Vp3l3msIu9H+28dSOKm+eEujpKvh+1a9AQbXe72dZ7W1g/34t3wY/ABYLUr3WbiMP8IV
 H31tJOEs5MQGSO6BvoQikwWk0gAvMGYLSqTTmNrskkbvdFxWF5WMtm5wL4ZfNOtcXuoq
 ai0oNXyI8QIUkYI2iAKvXnkIpkysJeK6Q0Uou+Lt0Xeo36sE+wTF2dyjiL0daQ+c8siE
 54uObU6p9+ysVwFba5fTBE9H/bm2GYvRjd6/VRWlbOObS4nXcBvpRAaC1ONZyMesgwv9
 /M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8d5IY0brn4G7eBLoXgp5fLc+r12ute8haCcpIHvNmoo=;
 b=q2gjk0BZdjhBEXWsMohkCNeNeVItUOik9Enx8yOG8GGbnXGR5LcIn7/gf6j1YH33rS
 GCTsq0YIZs7ArjFqiFOS1XBuCezcMDxE5Ajwc5b7TsdVt0080D4cRlb0YSoN4E9hP5Uw
 rzwszF0061ohjjqLaQsjs+bKtWX/z93gb6IS9vuzJh3RDiH3anZ+VsM0INjFYVwzL/JO
 d4KHm/JJ1cd3VnnYugLcudoT6Kfm0W9Bp2LiWh5Zl1FHqYGwaUYA7GwHp8HObnsk3iy1
 R2wDudd6Nk2t4c8XoTNGbFxRcz039AyBIYkY0yTsG1vdlri8iyX2QqKpMJjUFfPq/ux9
 2M/A==
X-Gm-Message-State: APjAAAWX6/td8yH0dm25h9yH0qZdUp1STiXe4dLJ7ijxmPxhOt6++g2C
 0TJhrwHz4KFwu4ltiwYhGFSKVA==
X-Google-Smtp-Source: APXvYqyHCDtLR16mDsQtrg57ySozFY+GWyUwVBL2iLWLH6ncBy0KKcIpvvkimN8F1LLvILijcVY9xg==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr9697565wma.120.1562189734713; 
 Wed, 03 Jul 2019 14:35:34 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id z1sm4282610wrv.90.2019.07.03.14.35.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 14:35:34 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9e107b82-4a51-e2ea-ee1e-19c4d4e05d01@linaro.org>
Date: Wed, 3 Jul 2019 23:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701043536.26019-7-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:35 AM, Jan Bobek wrote:
> Add an x86 configuration file with all MMX instructions.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  x86.risu | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 x86.risu

Note that most of these MMX instructions affect the FPU, not the vector unit.
We would want to extend risu again to handle this.  You'd also need to seed the
FPU with random data.

I was thinking for a moment that this is really beyond what you've signed up
for, but on second thoughts it's not.  Decoding SSE is really tangled with
decoding MMX, via the 0x66 prefix, and you'll want to be able to verify that
you don't regress.

> +# State Management Instructions
> +EMMS            MMX     00001111 01110111 !emit { }

I'm not sure this is really testable, because of the state change.  But we'll
see what happens with the aforementioned dumping.

> +# Arithmetic Instructions
> +PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size => 8); }
> +PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size => 8); }
> +PADDD           MMX     00001111 11111110 !emit { modrm(); mem(size => 8); }
> +PADDQ           MMX     00001111 11010100 !emit { modrm(); mem(size => 8); }

PADDQ is sse2.


r~

