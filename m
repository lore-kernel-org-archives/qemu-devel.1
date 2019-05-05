Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2907C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8FC20578
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDmkLnDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8FC20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJYE-0006PS-A5
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:59:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJXP-00062F-Mq
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJXO-0000aa-R3
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:58:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:45834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNJXO-0000Zw-Ko
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:58:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id a5so146846pls.12
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=9mYtf1Hmlb0HTichZcXhqCTyP6SxP8uufIlihX8JgXI=;
	b=FDmkLnDEBz7qTmZp5mLLGcM2uEp8UWpC8RpOrU1eK5shtO6euGzlpoLBmNH7hFotCu
	wcmFf+3SdFbOlzefoxEPLW1HXUS1WVmq5ttFUrxxCZQiGEkeHLjqX3nM4kJNiu+UQ+/G
	RW/gUUbNVNTFvs+RqlZ/eIQaHLRWcvK979oBNN2mD6i164v5vyWufpNp+sqejkAkhGxq
	PXIbF4U8iSWiYvmO1g1X5HOErlOVndj9Atsl7L01ZJOZrO2IIsVJ0hZAceYxSdx9qS0d
	hroPXOyVJxs+sK8giLOc/yd1KKLXtHiUL9AbUZuGElrZlfCC83L0ul6HjesmwK9R7GaW
	ujag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9mYtf1Hmlb0HTichZcXhqCTyP6SxP8uufIlihX8JgXI=;
	b=rc5b87ktemjKhx4uNvONnv7SDQtNm8t1SRxXQacNieGiuLIz8W1aHvM1iKKQpKHGZU
	w+toKlUH2bv06z2tgGAA+E8P8fiTS+rl5ItsSjTel14FIzlXad4ZyiVjKpJzNhxeKZ78
	BC24zqtjWwIwdLEoen8JUQI1SP+Sxan+SiZ1tHTDS13Nl3K5bXCMZawdaasalSccQs/n
	Q1qrnzK8KJaUIMAAunBYZKW0Rm6llDI7y0BNZn1fV492AQUy+Fy53z0D/KWWizU7ycuO
	apvhDQqE/egFeF6ievzUHOl6dMWUqKIJkcaRF0U43fGejVc/95WdQUckVWWI8apOy664
	OS+Q==
X-Gm-Message-State: APjAAAV99364Vg6j6cgBUrA/ve4AuI/O0qgK/mArdeo1tqA7p/I9FlDx
	JywZUK3RAWL0jxqfNG9jaOqR2w==
X-Google-Smtp-Source: APXvYqwclpA6cLDRhSipTaijIfIKsPf68ghLXD4V7stBy3ocguTR3TFZQE02QcWzJvTJpSqSJEs7Zw==
X-Received: by 2002:a17:902:e086:: with SMTP id
	cb6mr26178843plb.237.1557071929323; 
	Sun, 05 May 2019 08:58:49 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id v40sm449371pgn.17.2019.05.05.08.58.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 08:58:48 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
	<55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
	<7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
	<626519f6-28c2-9870-0c6d-12869fbf57f1@linaro.org>
	<cf86b84d-bf12-7b50-267d-cb2897cfd20d@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1bf82942-f737-724e-978e-cc5061ecebb4@linaro.org>
Date: Sun, 5 May 2019 08:58:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf86b84d-bf12-7b50-267d-cb2897cfd20d@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::634
Subject: Re: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505155846.dCZD--i0Qqjm1oy9uyICQ_CUxHjpyPaWteUp_ZIgfeY@z>

On 5/5/19 8:49 AM, Mark Cave-Ayland wrote:
> Okay in that case I'll leave it as-is. So just to satisfy my curiosity here: is the
> problem here the mixing and matching of offsets and TCG globals, rather than the use
> of offsets as done for the VMX/VSX registers?

Correct.


r~

