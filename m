Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC0C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26ED218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUMTNxxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26ED218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34559 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ7mY-0002Uw-Ic
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 22:37:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7kw-00015Y-1H
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7bk-0004Cr-1v
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:26:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:46201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7bj-0004Bo-RL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:25:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id o7so6219647pll.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=PTT9xHE3j5tFetkiYN43v8s1am98Os43MagEwxOo2v4=;
	b=HUMTNxxJxE6ADB9GPWmnbGFIb42zgGOqoBpzCC3HjjJYfz8qIYLmJxs8wDfwEmSDTK
	C+H/dIVii1n9VsYEZHpE/IG7PVtGxwpnjkE97qzvnmlonfuZCkYGEsIZUPdgB0eQsUZk
	E8IKGL42P+DNxiuhRdhq1WsExpgADdtgp84srq5xd1HjahqaIjesS8O1HiNAXJ3KqhSb
	aumm0V5G0tTP9UA4cqYtppBtV/QmHT24Cv4Uc+P5Sd/Q/edR2bsxae4yMSkAHPHw2p9I
	4so372TqQvbp939NUiI49IdF518/lPk7nepXQIhUpZI0Wl7H/1FeeM/Vi7Ixiu+gfC+H
	Vrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=PTT9xHE3j5tFetkiYN43v8s1am98Os43MagEwxOo2v4=;
	b=YfeqrcULty2pMVtXavVcs43mpVDZrPSzql/bVEn0yp7PYv6XEsSbMMb53E34sWsVNR
	xr2irP5dfT4WyVh51MoLXvpRDcSGp/CFDbKqcUR+d1pezcOf/4qJV8kTbV9A/Ibwi2mC
	IYHpRgpurj4qPRLZhHMotOn6XX1LFKPFLfrXkBr5xqq07GIa+8p6u3TpQgT65DlXs+HR
	U/PSfUkti89S9BhcCzVxX7Q8njve2URMXStG++NzD9mFmQVXdDEiwnaeziFxuwVBCDbj
	pWK5N/x8gpnFZDkKlF3IdIAz8+IFk1YV/UpOu9XiFQzePLdiRFSdSQTyvXTheKGtcoH+
	JAcw==
X-Gm-Message-State: APjAAAXrAoUM8hzQFZNIHrhqvyNy6ILgW9roewPG0OXFGwUxZuXGItMZ
	e0RB4TKzkWUJfs/A0jU/FZtVzDdKIWU=
X-Google-Smtp-Source: APXvYqzbjsYVDaL+f7PuzszA+EQdpMXgk8z3oVKDJOXBjYeR6/hAhTc5xRgfPeUuQ50MRNXZD9dZSQ==
X-Received: by 2002:a17:902:76c5:: with SMTP id
	j5mr28901297plt.337.1556072758483; 
	Tue, 23 Apr 2019 19:25:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	r11sm20009481pga.87.2019.04.23.19.25.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 19:25:57 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-27-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <225678d1-5bf1-d210-642b-c5040f12104c@linaro.org>
Date: Tue, 23 Apr 2019 19:25:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::636
Subject: Re: [Qemu-devel] [PATCH 26/26] target/arm: Enable FPU for Cortex-M4
 and Cortex-M33
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
Message-ID: <20190424022555.o64GK1Zvzpop7UEUPq6NPtVHLS9GKHsHZ2a3lFv93Fs@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Enable the FPU by default for the Cortex-M4 and Cortex-M33.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


