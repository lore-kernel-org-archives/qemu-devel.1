Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F06C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A70206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFZMs9+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A70206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2acT-0001fQ-MF
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2aar-0000of-6Y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2aap-0007Wh-Ad
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:29:01 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2aao-0007VH-Nn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:28:58 -0400
Received: by mail-oi1-x242.google.com with SMTP id b25so14790743oib.4
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xPDXpN3grkyznJ6QhShz/SdKlP/SXAWAkufonS4P26Y=;
 b=zFZMs9+CgtHIuyxE5gdl2COm65GzBH0apu6wSbeEZLUrBIXLyzuJ1vQ0zPCt3RijAm
 o9ngStpKfTnG/NGKDrm05BphjtyhuL1d1kB2SqAB2piQyFZzOGqIDcAdfTxh0Q+zCyQx
 0vApXfTGy4BnM9kPK13/H+0X1TpDtrE/ntU4SURwiPmjWRFuORRHKtbs/vJyHSBCu+eR
 l4eZOT1orafMF7IaYjURWOZ2a6IiH2vscrxceWSY3wZfRXrPfFnJ3Mv7I+nBf+4i75v1
 fZcLCQwDCAiUvazdmigiVZz/zZfSSJMJnBoOqOf0FLOQqfh75Z7QyUxseGhObK3Og8d1
 0JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xPDXpN3grkyznJ6QhShz/SdKlP/SXAWAkufonS4P26Y=;
 b=UKd6eXJ+rpwSWzob24gW6OZg9iV7NVFwXEBdpNaM23CGGTNuuS+Vlh/Dwql6dCEvH+
 zaXR1zaUK2LoYhdkeXJdCjt7WqwTB2tg7L6ecTvENPy/D/85MkitEuwYhzWPVXTY4keA
 mR9AY0R39rS564NdCqtQY2ciExVqKss2YcCywDDFFiGIrn/9aoyL6E/g7Rfkld4YWJgN
 pTR5trDfrZinHdrhfE3iKP8m5yeEPGdlJlrofbKmFOu+A/+TgtaBz5RgUyAEKwsBGOVI
 +a/Uwh6ozEkW0ZTmx4bTyFfj076J0q6kCcRh38gvQHJJCrRCF24hJDLwu6WckMe5Gomv
 WqmA==
X-Gm-Message-State: APjAAAW/DxiFCpo3q1molyXAulirc4ADmjZkAGssgyF/VbqvreIj7t8b
 lojHLZN3Yw2L7XlywhBr/gi5PWcv5hoBVSLUCLVXnQ==
X-Google-Smtp-Source: APXvYqxnRGNOVs2o4gJcea7TKYDioFhgvJA/S9Y0JkOYUE3M/m8JutJHJlqMYnt5JRD2FoLEAauV5v6JTyFm5qGpiBY=
X-Received: by 2002:aca:4b86:: with SMTP id
 y128mr15953818oia.163.1566908937509; 
 Tue, 27 Aug 2019 05:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 13:28:46 +0100
Message-ID: <CAFEAcA_tVzD7+4n7BrzBT3tvh=ovOFPBJJ9OhpGVUsV85WOEyg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 00/68] target/arm: Convert aa32 base isa
 to decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This unifies the implementation of the actual instructions for
> a32, t32, and t16.
>
> This has been tested by running the debian 9 armhf installer,
> which does a far amount of switching between arm and thumb modes.
> I've also run Peter's ARM TFM image, and all of the existing
> RISU tests that we have.  (Our RISU test cases are nowhere near
> complete for 32-bit mode, but it did find 3 bugs, so not useless.)
>
> Based-on: 20190819151743.17267-1-richard.henderson@linaro.org
> "[PULL 0/3] decodetree improvements"
>
> Changes from v1:
>   * Lots of prep patches merged.
>   * Lots of patches split into smaller bits.
>     Which is why this patch set is larger than v1 despite the merge.
>   * Do not use STREG_EXC_RET in Hyp mode (patch 3).
>   * Map more UNPREDICTABLE to UNDEF in LDM/STM (patches 28-30).
>   * Split gen_nop_hint (patch 59).
>   * Do not move single-step check to gen_goto_tb, but do simplify
>     gen_jmp by inlining gen_bx_im (patch 68).

I think I've gone through all of this patchset now (I didn't
bother to review anything that somebody else had already reviewed).
Let me know if I missed any patches.

thanks
-- PMM

