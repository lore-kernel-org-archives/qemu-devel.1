Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62E02084F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAJlr2vE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62E02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iboAl-0006fx-Ns
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibo5L-0003nV-SG
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibo5K-0007v0-MJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:58:03 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:43877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibo5K-0007ua-Ck
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:58:02 -0500
Received: by mail-pj1-x1042.google.com with SMTP id g4so4266510pjs.10
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3tQkWWgh8Usc3X35kIQnFqRXchgCy3Epf2H7wGf4ymM=;
 b=jAJlr2vE4op8JEMuhyx1qT3of2aynCVggeAXRUR8iwyBGiEYTjfWsFjJ4/irlCPlDd
 5vY7qxG1G1QyHAS+v2ebzSmG7HA8nuDFvta5rxDYD+VyvzqcEhfXTDw2cJBM/CmVcOPX
 2grOQU8ah8B97FUi2qto+ouH9KN5C7VVHzgR8zFmIW5i+v9FXDzKfkojxSVIgbIEl2CW
 kNAHLZ79UgZKpk88xjcIZRb/xVgyCpt9jVWun16+c3Y+KryiaM6cne4HTpODHiHAcME/
 qFczFHUCJXuCDUaS8hDVBYgI8ZUxQ8Pa8VSroZivwfWXsAfPmbo7YBY4icEr5ahD60Rt
 YxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3tQkWWgh8Usc3X35kIQnFqRXchgCy3Epf2H7wGf4ymM=;
 b=VGo8xcuPLRDX/ZMgTi0+lzMu0EHAhQP6Py2op6JvKvCndXXYhB9ShU42G8ayIqf0yw
 lZSJeelEmhFlpFNR4YPBsu+CEbXcNHYpOGGGtMFnm84pGfyHcC5blrLdUaaOhHlmjoKV
 cyE8+QLbxfWp3Q4ZwD/YgFQZZEyRRNLn5+Z7KQtcdhnhyf+xAHcGvYKidWx57cf5reR9
 gEPFvr/GLlxfgQPdlr7UDLh++3ukSXTuwp2Vg/9oeLyO7ng8VzhYOrwbNlRz5G1WzAyu
 eqVhIl39WSqMYdig8naugt3Wph0mOcsOjf2GsWmiUU23nawxcBooRAsJnTuY571kX86r
 h5gQ==
X-Gm-Message-State: APjAAAVE2wTbrgd8kwA4Lg1Bycm3xzSSPPAxjSsLWMHF25ks0bWspU76
 nwIVhKXYYJQPu3TtwmkZdX+f0Q==
X-Google-Smtp-Source: APXvYqwJsisP3iKAMVvXHBr/4kWb2M0W4Wt6k3oFQZJffIpuUqLq0l8H4leBy4NR1Cnxn9+6c0rv5w==
X-Received: by 2002:a17:90a:508:: with SMTP id h8mr7117411pjh.91.1575302281500; 
 Mon, 02 Dec 2019 07:58:01 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x11sm3801803pfn.53.2019.12.02.07.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 07:58:00 -0800 (PST)
Subject: Re: [PATCH v2 5/5] target/arm: Add support for missing Jazelle system
 registers
To: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-6-maz@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27089f4b-5bd3-04a9-9c16-91474a225c45@linaro.org>
Date: Mon, 2 Dec 2019 07:57:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191201122018.25808-6-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 12:20 PM, Marc Zyngier wrote:
> +    if (cpu_isar_feature(jazelle, cpu)) {
> +        ARMCPRegInfo jazelle_regs[] = {

static const.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


