Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F55CC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE70321738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 18:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B1ET1JRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE70321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIzr0-0006Yz-7y
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 14:09:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzq6-0006Bg-Js
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIzq4-0005Wm-M2
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:08:18 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIzq3-0005Vn-13
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:08:16 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so7887889pfo.5
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=RLSi04VfP+nHRsWhvLYZJ8KBoIp2PuqT2/cVUyLbCbE=;
	b=B1ET1JRSUg6YrQ5158g4U6VTrCmzpyQdsQBnKTUP/gN12V486CKonOHp8ErnozVUq3
	uAHBrDNHpHO/3RoPrLM+mVMX6z4YIHWO0d3Se+GfMg9kBRN7B5Ey8qhjF7pwzFgVLmMt
	dvlfbkhjx3aOaUR4sMCUDomVlGBgGfdqGrt7Lo15IE1pe/mPqj6xjVJxZw8uBDb/ZA4x
	tC+MeN5563oAoFk5XzJd1rHxI9pD2vBvqpAbToNRnLh0rvhjnfH7/bYxz5988OnOkD7S
	3DFQNwJzPhLr26ADl27qCfAxzCgJ0S251pM6faZYZLc+6OskO/0tWa1zp/g2AgRmH478
	E8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=RLSi04VfP+nHRsWhvLYZJ8KBoIp2PuqT2/cVUyLbCbE=;
	b=MBQTrFT0lYEPk9QJ3NBprEdqd5uTZm+1DFQNeDPDw8HUvAZul7HZTnB/DkFXCKc+w4
	UGZnhb4TNUqqSkbpog18c0U4VDDJbRoX1PvxTcv26HT2bI/OZJJvPtN0oav3/3hKtL1f
	Wuxa+GHUwrxNc36qFPiYuim93m1zmowMqw4//DoVLqUzPxnMYp/ZZMsTi4lHwqPWayWL
	zp5yZTkuTGpr2KtdbBDEi42DuzmKq7vD5a0zfcnk+a8D/2O5bdzr2FHbzUWT+i+cCxEO
	i73YYghCKAXcB3YSqTxdkP499eo61ViGok7fdCFq6A1qcI7KhDRdPhvSul6nHbwYRm7L
	5AAQ==
X-Gm-Message-State: APjAAAWlOdKZwniTudF4jrEAo6nXHasIK5S5mpQfyVhW1/nsZ0BiLhHQ
	TAxWkHPlrA+yaJN8RsovL7fHCY7N4bo=
X-Google-Smtp-Source: APXvYqxDbdD3HhPWnITrL6Tj2+I9yr9HaCmxdq//1uxEXfkvv6bEQsGyuyrhtzfuqZMdxCQm2/uuaA==
X-Received: by 2002:a63:8f4b:: with SMTP id r11mr26129831pgn.271.1556042893705;
	Tue, 23 Apr 2019 11:08:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	h16sm7072476pfr.101.2019.04.23.11.08.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 11:08:12 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <42db75fd-84a8-eb45-b1e7-d64c3201440d@linaro.org>
Date: Tue, 23 Apr 2019 11:08:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 04/26] target/arm: Disable most VFP sysregs
 for M-profile
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
Message-ID: <20190423180810.DOBj99IxV7YCvzvdcS0QLD0Kzq5e4HrANpPDMPulihQ@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The only "system register" that M-profile floating point exposes
> via the VMRS/VMRS instructions is FPSCR, and it does not have
> the odd special case for rd==15. Add a check to ensure we only
> expose FPSCR.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


