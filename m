Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED7C76186
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 00:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F9D2084C
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 00:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2a9Apa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F9D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp005-0007mt-Ov
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 20:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hozzv-0007Os-4l
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hozzu-0007KA-6m
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:46:43 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hozzt-0007J6-T0
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 20:46:42 -0400
Received: by mail-pf1-x444.google.com with SMTP id i189so15721095pfg.10
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CvKNFfjqzVWjmW61PCSWEN+ViGW6GLnNAweWmd+RS7M=;
 b=P2a9Apa96B/YWfLmwtvoCT+9uXrVbBCjcttzJKlcwfHRwK0eiXOK4c5hLYCsrXw+aY
 UxSFXy+mhkH3tk33P2UMXC2kqfdL1Gi0KOuQoPArtd3gqqwuSjkXBdAtS3ALG8Nu9qow
 7iDH/1mTBPEoW+TOYSAW5V0OFL/cGHjQw3UjZCysyrgUIEMWIU5+oBeDeRMjMJVQqoMF
 KFoZ+bSSsGf1LWCp5gC6t/THq5P7CfwdjPTwJaEA/2rtZ8ovy5b02LOM9r+MXvYOuNdJ
 V0larwHB4CA68lFYm7sIvX485pvF9pht5TNZBA+xC55kgbMNXgFueBukXMOIw/4HJ+D7
 /Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CvKNFfjqzVWjmW61PCSWEN+ViGW6GLnNAweWmd+RS7M=;
 b=bAzGXGG/nHd0M6os3clpZjmKXtFr4phEpdSuIoxBUS47WERQLeY0bS3Wf9ikyDFt8j
 Gs1nyHGDFHr76Mf/qBkXGQkl152ZjE5vwDsKhMfnmE8vj2S4XGPG62Gl+rRwQMKiEPFe
 7OfkXWr2i8FwSrAMR7cqWGkEwVh30d0QmU4wCa1pITFY3jJZsznDHMm4YbUElobysinQ
 keiZepFehAg1NXK22ae6LGFFF1A54FKtoJ5/rhmQqGS1CQW3qPwMIKxaSkXaneDQyPSI
 fbPrptfoJI1ra07MtKePCsCIuwl+Puc8BgyT0a4dPkrYB5zT/OT08K/vJWPtZtJ+eSRL
 9+1A==
X-Gm-Message-State: APjAAAVZUf9AUZcPQK+hcU4LgA8NcHHiJysf6KkHoxoH7Tewl8hbaeW+
 hNgGtz0LPaZn1PELWKNcxqs65Q==
X-Google-Smtp-Source: APXvYqxKKNgOqTrKBA9YDOaeLW4O7FBMQ7S4bGqfnNMU20Ym4rFd5OvXDGqBbCPJOpkukRypWWVTKw==
X-Received: by 2002:a17:90a:b387:: with SMTP id
 e7mr69709906pjr.113.1563670000207; 
 Sat, 20 Jul 2019 17:46:40 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o32sm33823713pje.9.2019.07.20.17.46.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 17:46:39 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-19-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <06613847-8f5c-7b49-f074-31c8292900f1@linaro.org>
Date: Sat, 20 Jul 2019 17:46:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-19-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [RISU PATCH v3 18/18] x86.risu: add AVX2
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

On 7/11/19 3:33 PM, Jan Bobek wrote:
> +# VEX.256.0F.WIG 28 /r: VMOVAPS ymm1, ymm2/m256
> +# VEX.256.0F.WIG 29 /r: VMOVAPS ymm2/m256, ymm1
> +VMOVAPS AVX2 0010100 d \
> +  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
> +  !memory { $d ? store(size => 32, align => 32) : load(size => 32, align => 32); }

I believe all of the floating-point 256-bit operations are actually AVX1.
Which, I see, would annoyingly require a renaming, since that would put two
VMOVAPS insns into the same group.

I wonder if it's worth calling the two groups AVX128 and AVX256 and ignore the
actual cpuid to which the insn is assigned?  Which ever way, they're still tied
to the same --xstate value to indicate ymmh.

Or could we fold the two insns together:

VMOVAPS AVX 0010100 d \
!constraints { vex($_, m => 0x0F, v => 0); modrm($_); 1 } \
!memory { my $len = $_->{vex}{l} / 8; \
          $d ? store(size => $len, align => $len) \
             : load(size => $len, align => $len); }


r~

