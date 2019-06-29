Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C25C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 12:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A3A20828
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 12:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz3FdA/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A3A20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhC8l-0001r5-UE
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 08:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33316)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhC4n-00007s-4W
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhC4m-0008L9-51
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:03:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhC4l-0008KF-R3
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 08:03:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id c6so11402636wml.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vUIqbBEf+r+00S+ShCAgcSOkHDQrJpTqzoPgsJKd8Uo=;
 b=Dz3FdA/966FBbXIOESz4HnXSrBJHILTutvMLcHIkmUrVyiZaQXEa68YcdCt5E5SxBy
 Hi5jB6LWIbZ2LNHQNnyAJD7W5RiJYhrm446nsSKoPNBu9pAXyqMHCoFsLGinHpGIuCRy
 ic9EcToRpwgzg9KRobaoxKuUprR6W5xPhGhofO5sovhGuUP1jx+zFCQdtkrRXxHJMnUw
 Bsq4+5B3EgVqhYnXesW7uotqTxmhdPaxSIHgYBQmRcdnMEkZLn+2sCIz2qMLyzPO67kM
 Q7mxHyYEZEm2/lrV66Amf353gtrMiIBBe9tjO9s305tvNeFjY2Uri26ISIXNK0Xjtxmx
 kezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vUIqbBEf+r+00S+ShCAgcSOkHDQrJpTqzoPgsJKd8Uo=;
 b=mEThxYsPlHz8eUQEOadvnCUCcEFKIlwqoObmMcNLzH65WNELomoCq4ewkbobN9VRml
 1uAOBZPtHUVpromF+prA0rTmDP52sAFr85wkZkEKefdfMQAQfct5JywN2t2ZWHzWz7kE
 AuaNg8bU8k6NjK1/xuPztDiczX8/r66VwKARKayQJmDl17dErxPFKPSw/aLlAzhkCAbI
 QMtVwH08nuZdPHvfMi83WOAyC7qhMfLr45e7phOyjJ6yWNsK+op7z5+wqVGkBh1i59GQ
 PZobJQk1xbagaRm8eiz6Z2IJ8ESDL2MFG5kZPskWj7up8Fq+HONmI6OUfQDqeuTrRFle
 mhsw==
X-Gm-Message-State: APjAAAXdZMT95kaLuMqDkniozComWiZmEic4D1pJMoI/rhfC8Sok+6si
 FqAMIFs6BWq/VXjPZN9YC4zwxeOmCGnYYg==
X-Google-Smtp-Source: APXvYqzxq19fMFXNO9sAhM09fbNJOMmwyOpIc9ZEFGjZ67l6+lKwwbPekSDVXVxvfaA/m8/7GdGP/A==
X-Received: by 2002:a1c:3c8a:: with SMTP id
 j132mr10534099wma.172.1561809806404; 
 Sat, 29 Jun 2019 05:03:26 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id c1sm9860084wrh.1.2019.06.29.05.03.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Jun 2019 05:03:25 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-5-jan.bobek@gmail.com>
 <f00e9c29-592e-06b2-04cd-b3c3c28b4cc0@linaro.org>
 <58987aa3-7b8b-0ef7-741a-2c0b79943fe7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fa3776c7-5b82-0fb5-c151-0946e7b90a1b@linaro.org>
Date: Sat, 29 Jun 2019 14:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <58987aa3-7b8b-0ef7-741a-2c0b79943fe7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 4/7] risugen_x86: add module
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

On 6/28/19 7:06 PM, Jan Bobek wrote:
> That's true. (Although not in all cases; see Table 2-5 in the Intel Manual,
> Volume 2, Chapter 2, Section 2.2.1 "REX Prefixes" for some cases when REX.B
> is not decoded.) This is a compromise that I've accepted, at least for v1
> of the patch series. Note that this problem is also present in config entries
> such as
> 
> PMOVMSKB        SSE     00001111 11010111 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
> 
> Here, we force MODRM.REG != 4, but this avoids not only ESP/RSP, but
> also R12.
> 
> Hmmm... I suppose I have some ideas on how to do it better. I'll try
> to fix this, though I suspect getting it 100 % right might be
> difficult and time-consuming.

I wonder if it might be better to do the randomization at a higher level:

* Pick full registers, either 3 bits for 32-bit or 4 bits for 64-bit,
  and eventually 5 bits for avx512 z-regs for evex encoding.  Let
  risugen_x86_asm encode those depending on the chosen encoding.

* Pick only register vs memory for MODRM.MOD.  If memory, randomize
  base + index + shift + disp.  Let risugen_x86_asm encode those
  values into the modrm+sib+offset.


r~

