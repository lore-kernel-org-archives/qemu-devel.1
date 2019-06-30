Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062BCC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CBE20659
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 10:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BqN0r0Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CBE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhXTn-00032P-1y
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhXOh-0001d2-1t
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhXOf-0003R5-TC
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:49:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhXOe-0003Lu-Fd
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 06:49:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so12924586wmj.5
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5aypXGafoMpindIPXW1KKL8j7b7Ge84P5wCGAgWpcDE=;
 b=BqN0r0Em4hD59g8/srFTB3AGXjl9MFE4/GJTF0L9HCCtS2HURaiF60kR+4F6TVTuHx
 pBpNLBN8emYLJb1LiAJ08MAmR5FPjSAyX60j1ikjfrEoqLx1E/rEsw79OAOark6WOUNT
 xCDP+2K8G+joIVqNqCWUQxj1dw9Im6mI7W9BAglFCWk2zH7mZx2K2/GPIF8B3dQwqxQG
 6BMYrp/jqj59udPNYaZThj9aqlyHT1/SGSgpeafSfQWM17WVrxKSUAmnVlAf+HPEXxFS
 wILHyix9PTftosPUqKL9QNiybWLGW3OizLYak9okA6yH+gXs2jcxEohmrOpyQhzMdXou
 BNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5aypXGafoMpindIPXW1KKL8j7b7Ge84P5wCGAgWpcDE=;
 b=c7FH5gVMGPDGmN7ndLFAOzPRQx2Gx3TDNrDfNleu0XI5Wre3DrkQQLjBgA2GGRgWX+
 T3LM62JLo4GNfJrcep7gxkT5BLuG32Q8kird+SXfN1j9c2q168bGoKZclZYhLtRHEqoE
 PeBM6A6XscCre8jJ6w6mlu6IG/20N76zRPUZCP43MEl1rrkEbYWss16VkS0B8fxsCE4k
 b6O1rj54QsxW6EC5EmD4rZDMvCEaqthJLVKIr7DZanq3DwlEOQMVqAldOeoGr14DJxGB
 fDfioeigtgKpmOVgxfyslVElzAPvfiZ7p+p3mYcHEQW+mq9wPFDi4s9a04Yb1Gu23hch
 x2iw==
X-Gm-Message-State: APjAAAX32bMBKR9sqNTkeYgkZ1PkkA9Lo7WHumEwIFtniaxA+e8Hv9Th
 VQWILvZ2UrsGm+I3aHNoe3H8kQ==
X-Google-Smtp-Source: APXvYqyeDltt1s0e2XJFT5UhUqZZ4qNh+zAcVRibG8vQL9s/3IJyL0muH7/QrkdXrB20GcDX81zz+A==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr11771501wmi.79.1561891760777; 
 Sun, 30 Jun 2019 03:49:20 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id v65sm8541906wme.31.2019.06.30.03.49.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Jun 2019 03:49:20 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-10-richard.henderson@linaro.org>
 <CAL1e-=hwJmYvYbbdWoQjEcFqNginiTY8xDsgDwDY5t8GF6qBWg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f29f6f66-8b68-94b2-adaf-1d8dfbb54e89@linaro.org>
Date: Sun, 30 Jun 2019 12:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hwJmYvYbbdWoQjEcFqNginiTY8xDsgDwDY5t8GF6qBWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v6 09/16] tcg/ppc: Prepare case for vector
 multiply
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
Cc: "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "hsp.cat7@gmail.com" <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/19 11:52 AM, Aleksandar Markovic wrote:
> 
> 
> On Saturday, June 29, 2019, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     This line is just preparation for full vector multiply support
>     in some of subsequent patches.
> 
> 
> This patch should be aquashed into the patch on implementing multiply.

Yes it should.

Incidentally, why did you split it out in the first place?


r~

