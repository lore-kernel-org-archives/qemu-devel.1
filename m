Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D891C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831D5208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnH2Aaam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831D5208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHo1z-0002yG-JH
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHo0s-0001iI-NW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:55:18 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:43880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHo0p-0003qB-KE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:55:18 -0400
Received: by mail-ej1-x643.google.com with SMTP id o8so23089512ejb.10
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DVaCRgx1fQKr14/rUIRwArlH3VkYirm2d8m195lA3Ns=;
 b=YnH2AaamclDWLtGSojwbFNsdtFCoD6NFtF0Bc0Uo56CUeG9ySEETO5JHXbQao8iFzB
 TxNsKsVvIsa/e93sa9s4u6bA8R72PstYfBlWApsaO/Jpitet6ERGysU+akae92hBlD8C
 PGPseXpFXRTMVzk9SNflqGi03UYozGfc7Q2E007Wnn8NsteSA1WQpv4iVnCH085S4NjE
 b34g2gwXtDr0SeYAVOg2Rqv07sBcF9kqxBYf84jZ1nB2jJL1W3NizZO+23oFcMxDIIzz
 mSeD8JfAVfqAWLM68ItGULbGyarve+MOQ3lYKkvnYprF5YtQqf7D8G1gxjYVaeUK7/yi
 Vn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DVaCRgx1fQKr14/rUIRwArlH3VkYirm2d8m195lA3Ns=;
 b=Amz63tcLU++B6P5GsK7m4KEID5yoXkhgrCrxciGbmpWvId+5o9Dh7BWI6Mxx3sHBm3
 bcDHAtVzPQnFZRJ28e/KBIj69tPjGWdOhlP3g6XYab5+1aVevtyJ0GTTARIMepzPaKKv
 SniNhLuAmIfwiC+f5utoq9K58dvSxUETmr7aELei8QeIHVrYTEEBgW+DhoBegrqYaU10
 8e01Iil1ctCyubIhwoqCps2cMEfaojhlJGZ0DoJ+BsGS+dcvZhpSuHArhaQdaYAjp5n4
 VGK2uK2hkTsrJ28o0hkq9UXMo2D6bR1vuQsgChFjMk535WsuDMYBVuq3KYukiFqR5UwL
 k3EA==
X-Gm-Message-State: AOAM531FgyCE3ZKgvVs89MY+E9CLU82XwGBBESNV8IKPtfQIcwNeNtoS
 3RmxLsdPnWESdLEqmIi01DONDIRhxjfHasNVo/FsrQ==
X-Google-Smtp-Source: ABdhPJxMqTnGDIMByFQBnIsin7Yvmjgv1YBkiAL6USkCGgUriR5LNjabNeJIKkmD7q1MSF1fv2ide2ML5TQPceB7pY0=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr14284636ejk.250.1600088113855; 
 Mon, 14 Sep 2020 05:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200911052101.2602693-1-hskinnemoen@google.com>
In-Reply-To: <20200911052101.2602693-1-hskinnemoen@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 13:55:02 +0100
Message-ID: <CAFEAcA-77U7p3RCQS5z7ZJf-CBNKqXrkwB+Kdz3ZCjPQgEge6Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 at 06:21, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> This should be fully reviewed now, but the Timer patch may deserve another
> look, as I fixed a few bugs in it. Huge thanks to everyone who reviewed and/or
> tested this patchset, it has clearly improved a lot since I started.
>
> I also pushed this and the previous patchsets to my qemu fork on github.  The
> branches are named npcm7xx-v[1-9].
>
>   https://github.com/hskinnemoen/qemu
>
> This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
> an OpenBMC image built for quanta-gsj.



Applied to target-arm.next, thanks.

-- PMM

