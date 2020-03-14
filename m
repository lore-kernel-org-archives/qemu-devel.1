Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FAC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 05:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79E72074B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 05:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCemA9dY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79E72074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCzpg-0003ro-Tu
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 01:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCzp5-0003RK-AN
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 01:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCzp4-0004iG-0H
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 01:58:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCzp3-0004fL-PM
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 01:58:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id b72so6566309pfb.11
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V7mxmz7uXlCpgsnx481z7pPV9h406Rzi/xQp8Vpx5tY=;
 b=vCemA9dYRCDkz2KG1MpVf3VTvWNEtZcNrH/8i09cWpylKwow7bCL0xBgU5Kd4ZaHou
 3w4bemZb2IZzMitjVgGNKvx+hAC+I1WoHLbtdFcEQkO7ftreMSE5knb0bNMebkYHbdyo
 meKK8bzZ59l8tqiWXMP8vamSyU9aHkS1SLX9PXiWe7hwKw5Ajol76EW/qSfQL7zhFson
 7ksPN9e/EWf8+XM0t8Y10bJzjk0M52QGAknSYSacDhWdF1IavKGbxwvgSl/D9N/QSRqh
 IlC37xdZN22XhvjGfwBa91ZY1dDl1HPPhM3wPQmZyJnm7NbSwaUDlg86CYmMXHL87c/o
 39Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V7mxmz7uXlCpgsnx481z7pPV9h406Rzi/xQp8Vpx5tY=;
 b=XXhLwKt6vnyN5K+sxOpz4F+mmYxnj1/IKQGEqey+cmV4W8T2CMtvA3MLzwjArHR8e9
 Pd4ZnnpA8fJeyBPIRIUfTU7mZJ13pRj2pb1FIWESWiNED4DcNjkEjYS4v4XyiAB5K0oS
 d+rZ4876tkhMFXUV5925bic2zUFmYw16UsyXNvA9meS0XUlXq7Ez8XTo6c9E04Xib9AN
 redPz33sydh2WPtRL07D7tFxN7Ega2GuZvQghE2KKsx7oHdp88+xuC5ZWlpB7unyANT8
 cjv8bkNWURxTBqmf25Jwi4qIRXfEFBxm317MOHnwc7hM/4wTNA1XTN0wOHlEXVHuFbwB
 zO/Q==
X-Gm-Message-State: ANhLgQ1WIs1FoFPUCcJCH0wWwaYczCWR2u4kb9qH9xt7WWsg4lf5QX6h
 Z5PJfEbL0tmSoSro6T1S7JCKwg==
X-Google-Smtp-Source: ADFU+vvJ14bynRBoOHoC6Iwb4oJKDggsqYkBWFLg7m6T93ri3N2L01gtkvhfltDStVs2WLP90dsdcA==
X-Received: by 2002:aa7:9d0a:: with SMTP id k10mr15910027pfp.266.1584165536493; 
 Fri, 13 Mar 2020 22:58:56 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b70sm20344029pfb.6.2020.03.13.22.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 22:58:55 -0700 (PDT)
Subject: Re: [PATCH v5 11/60] target/riscv: vector integer add-with-carry /
 subtract-with-borrow instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-12-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77fcc875-ba5e-ea18-1228-6a1e7989491b@linaro.org>
Date: Fri, 13 Mar 2020 22:58:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-12-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +#define DO_MADC(N, M, C) ((__typeof(N))(N + M + C) < N ? 1 : 0)

Incorrect.  E.g N = 1, M = UINT_MAX, C = 1, adds to 1, which is not less than
N, despite the carry-out.

You want

    C ? N + M <= N : N + M < N

> +#define DO_MSBC(N, M, C) ((__typeof(N))(N - M - C) > N ? 1 : 0)

Similarly

    C ? N <= M : N < M


r~

