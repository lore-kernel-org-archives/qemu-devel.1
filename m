Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C3C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C7A218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEGDrp5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C7A218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33143 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ5RH-000353-Q2
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 20:07:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5OR-0001cP-86
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ58Z-0004GT-NF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:47:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ58Z-0004FB-Ey
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:47:43 -0400
Received: by mail-pf1-x442.google.com with SMTP id c207so8276235pfc.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=pyqLEmgeTSgBOStVP69o0wQviqV5DPT/F96foFL2Qqo=;
	b=KEGDrp5S/ixcS6m2keSmGukdm88KYfC4nf0TfKWHbaFOG3snJoMylS0WkssRfVV/YC
	/xi6ObVchaKrCeHSInZLhCxoqKRHs0U4rTWOy2nkXcgDz8KVkrQI/yC8VzcS5cRTrsBo
	XSeJw/EXSe84OuVugIQPsQ001N++Tf2wA3bYfCWgcdUB2Z03o5N5wpRt9929qCE1IHM9
	qdrRzA1atqQSmJyaIbboAh6G2WJ9gWsoqdJMTgE1GmXju2UM0eGoOrXELvVfnXdUhj1S
	2ZCr8AMN9ryleqRR4gWBgy1FTSDUDZNsT7R1vqC8Y97CWdoNbso3LZ8mvDrJ+4plYD+d
	odIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pyqLEmgeTSgBOStVP69o0wQviqV5DPT/F96foFL2Qqo=;
	b=KC+9cmgrwdtjJp4kYVH7yaZz5NnMsapcEQl4VIWOZ2GK2/EELt7Toog1tzBs/+O+iQ
	lgkGzh4p8xiq7nsjnwBZBG2JUp3VK5kYMGSJIcqMgL48DRLaWbJdWaR71JLFSpBbqh99
	VK/swCwQHmR434CliqzYwGmpn4bwDCA0LAFcyCOyDaiMQZkEEAxSxfjwzks8zW3X4zCG
	vF/KhYuRygzGbZ3d3GTKGnwHbdeWDSyPE3iYv9w6GARLFP588v2q8bL77yfLsTwulMTx
	Yvoaez0tdQAWfJpBgdMYIBAQNrAIuxtxWJ3yKuSwbOztDXm1OnMfGkw1jXcCBgfr+LVk
	iHdg==
X-Gm-Message-State: APjAAAXBQTEw3gFHHDc/kv9Q0qDGMsyhNyIQff9cE2+x0g/K5hCrBFLE
	f+uNtfrWRCXx9iXUegAmORSFOlOJvSE=
X-Google-Smtp-Source: APXvYqy8gNh17z3VXX65LJAOiSy+k224cA6q5mKYldJqg9LNd7Lny5tTZXVSbYyQh6tkLoHlFvqfYQ==
X-Received: by 2002:a63:cc0d:: with SMTP id x13mr27347679pgf.280.1556063260736;
	Tue, 23 Apr 2019 16:47:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	s21sm22684106pfm.3.2019.04.23.16.47.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 16:47:39 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <cbefe736-b85f-1b97-6ffb-07630992d3f4@linaro.org>
Date: Tue, 23 Apr 2019 16:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 16/26] target/arm: Move NS TBFLAG from bit
 19 to bit 6
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
Message-ID: <20190423234737.GJhEumWvDdWgdSgqYMt3i7artX4Qw2CB5E0023jpYz0@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Move the NS TBFLAG down from bit 19 to bit 6, which has not
> been used since commit c1e3781090b9d36c60 in 2015, when we
> started passing the entire MMU index in the TB flags rather
> than just a 'privilege level' bit.
> 
> This rearrangement is not strictly necessary, but means that
> we can put M-profile-only bits next to each other rather
> than scattered across the flag word.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


