Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB738C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D1C20575
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAWzFgfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D1C20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGiVC-0002AR-7K
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGiUA-0000z6-DQ; Fri, 11 Sep 2020 08:49:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGiU8-0003Sx-Iq; Fri, 11 Sep 2020 08:49:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id c18so11349698wrm.9;
 Fri, 11 Sep 2020 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k3so3iOhghxX0P3V5yLMjec7M/1Y/Q/1JCu54/n0Gc0=;
 b=BAWzFgfJZiXHcEz7bQb9PYPZUNLeQUGU8eS3gbFZtFkOW7e5wAg7VqBYiK5ExRp4Z2
 7IErsNSOQuOl3eyo20xX/co80wJczpFl6LyCoYeZ9M8Dl3PoB8Mz22rbGf+Y3e4Bq1Ha
 OpuGlCV30cm14BvBM59ozOqz9/DeKC3R3Gxgvm2lzXqiOP7s+JKAVGT7CcAQhdeLAoHH
 M4Rb4km0HkzYoIjt/FBEqEdm8l051xN2QDMUN17cy+fxe7YYG2WfvHDsklTgs3RkngPM
 v9u11niPY/4jMA4+sQEC+56p3qmX3QbD1g9M/g/L7SoOYtIefTrKY64gViPxp8vokcOz
 El+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k3so3iOhghxX0P3V5yLMjec7M/1Y/Q/1JCu54/n0Gc0=;
 b=RTBHtEvVpYwQ+OVo03HK45nxCNsaI3oBZmNUyi47xj9+VNrn2lYp5yxeOmO7FO6cP2
 RAKPcuoFX6cGxVOWj48+sO3w0HEc+QJrFMWrAGKz9S5TkDjx36qgixnYx6H2jfh9E2up
 gDm/2bmIa3IsCwYH/oIVDxx92Dnc33TWLw+feOFK8C8U2RUq6vm0I6W1gJG4GfJuxNjG
 6iCnGxycOl1213XJVwkJIeOSp2oG4gIzb5sfcJhMaVoZER9eRsU4Ltu6l7pVNuVpse7e
 7qnq/6rFt7A4Ayseevwn/MgB9KY1NiWPjrtT/FlkINBaD4xRn1dDLbfmx+o+/KGaiPja
 17rg==
X-Gm-Message-State: AOAM532ew21eJ2Cx+D528HnT1XTcInUIBbEfvxrIwWy3uRioDxdsMLOH
 60TolYgno2nzv1WnpV1wQ0M=
X-Google-Smtp-Source: ABdhPJwpQ7SIvHjS5F88hbM5zWogwBWBJoovA3VgG7CgpBObSLGNhJMJt6o4N26i49kyT9pimK3Yeg==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr1930479wrt.160.1599828538663; 
 Fri, 11 Sep 2020 05:48:58 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h17sm4789453wro.27.2020.09.11.05.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 05:48:58 -0700 (PDT)
Subject: Re: [PATCH v9 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200911052101.2602693-1-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d99ae484-511a-a2ab-08cc-5c55b92d84dc@amsat.org>
Date: Fri, 11 Sep 2020 14:48:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911052101.2602693-1-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 7:20 AM, Havard Skinnemoen via wrote:
> This should be fully reviewed now, but the Timer patch may deserve another
> look, as I fixed a few bugs in it. Huge thanks to everyone who reviewed and/or
> tested this patchset, it has clearly improved a lot since I started.

Yes, all patches reviewed.
Very good quality. I also learned while reviewing your patches,
so thanks for your contribution :)

> 
> I also pushed this and the previous patchsets to my qemu fork on github.  The
> branches are named npcm7xx-v[1-9].
> 
>   https://github.com/hskinnemoen/qemu
> 
> This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
> an OpenBMC image built for quanta-gsj. This includes device models for:
> 
>   - Global Configuration Registers
>   - Clock Control
>   - Timers
>   - Fuses
>   - Memory Controller
>   - Flash Controller

