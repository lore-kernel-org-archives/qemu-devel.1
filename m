Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E07C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DC3214AE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0dcImXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC3214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhFl-00043Z-ET
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh1I-0006tF-Vf
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh1I-0007AX-1X
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:52 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh1H-0007A3-TX
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:51 -0400
Received: by mail-ot1-x341.google.com with SMTP id j19so4926293otq.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TAJ9CaM2BRx0z1OoTQRHPE4OMAZbSfV4DTPBoBvpTIw=;
 b=T0dcImXaHxEWxlK6Mo1x42hlJU6sl2TcAIkO/rxj/Zzqk/gKUoixvxFfuksPpRxKpb
 OlH9fqM4JqT0ecBBB874yYkcdrP4WmFENpPEvk7+HFp8MHQIceczHq7AJPjBwCkAvoM4
 ToL8r3uCCEtv5Ot7hjZ6N6HYF59104HX3JOsbhH8Y0R87fqRIuhOMQmm8RVGHm29O4AT
 7OkVDMVTseDC+kE2Z7qZlZ/ay3ZNjpO4fWVdLvWLJF0PKOeZbs3HIPcqHJ1lYvnfuJqf
 Ea/1Mh4iTEi1HRQZoOXtxnbAxEbAQV+3+VH1Ad+vu9+yf9kLGpcK/Wc0zXvTDpc89c4F
 UHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TAJ9CaM2BRx0z1OoTQRHPE4OMAZbSfV4DTPBoBvpTIw=;
 b=LcITkQLGE1r9eoQsI1EySgBZzyrl0yPw5kvLlt+wOcZW30ctF459VkRbJ8X/ybuSFv
 Ik4cGlOoWBhtb3ZfXzhDGas9c0vtVdaeORWLdzi4piFWMXSH9qa+c3rjbylkizeHOk8X
 +xFRqfJrexk9d2FSsrNEW1rf+/BHN/we49jW4Dx01rnSSh60hMMiUR3GnzlcEV8WlYZf
 nrlGpvQQzjYotEtrdSnpN47zcf3A1oCUYNysIV6iePrBHb+ET1he5oaWGDBnmmRj51Lb
 b0EUKD71fTGPhuhbXg1sUtjNtrTClNBcmukmj1kh4/EiEqS3UUSAx+nv/IFbOCOgp7AK
 HZpw==
X-Gm-Message-State: APjAAAWshEklR+gwax/mOJL/Z36nvnIB9qnrEzSzgZsJuxFQ0D37KQ3t
 lQCWXGzJE4Ux2W8B1tIOlgw0sBcIg4XSPQ==
X-Google-Smtp-Source: APXvYqyuIUrinzhU8hgTlTF6oNrGMfEH8bfZlGkbYyFbZ+ApImgN8P17iZFA1TaSWG2hw9XYReiC+Q==
X-Received: by 2002:a9d:350:: with SMTP id 74mr24805765otv.309.1560022130998; 
 Sat, 08 Jun 2019 12:28:50 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id k25sm2063405oig.5.2019.06.08.12.28.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:28:50 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-28-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1b151559-67e2-3806-aa62-2b2d0d0f1b1c@linaro.org>
Date: Sat, 8 Jun 2019 13:40:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-28-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 27/42] target/arm: Convert VFP fused
 multiply-add insns to decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:45 PM, Peter Maydell wrote:
> +VFM_sp       ---- 1110 1.01 .... .... 1010 . o2:1 . 0 .... \
> +             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=1
> +VFM_dp       ---- 1110 1.01 .... .... 1011 . o2:1 . 0 .... \
> +             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=1
> +VFM_sp       ---- 1110 1.10 .... .... 1010 . o2:1 . 0 .... \
> +             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=2
> +VFM_dp       ---- 1110 1.10 .... .... 1011 . o2:1 . 0 .... \
> +             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=2

While this is what the ARM names these fields, I wonder if it would be clearer
to rename o2 as neg_vn, and o1<0> as neg_vd.

But what you have isn't wrong, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

