Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ACCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82AA7206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEeYQ8sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AA7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaayY-0002J7-Ny
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jaaxn-0001jy-1b
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:17:31 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linus.walleij@linaro.org>)
 id 1jaaxm-0002Hj-1Z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:17:30 -0400
Received: by mail-lj1-x241.google.com with SMTP id o14so8851245ljp.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KgB5iCRiDY1xUpzvcmt2qA5qOxhIvxFlroLwQSWXKVk=;
 b=cEeYQ8sMtfIcnqhDnaBX58ozf3oJI5XHFUC7g3rtIUDyqFXqr/s6o9QnE2+uFP1k/J
 LILQgdSPbgh22hGw180ItVeDUD7AU7RWmUS7tnKBpMk9U4t2JKNxq2pw8DY0Dr0glxoc
 9h935pnTmgCgvB8iSgullSwo71ZCKnR3oJERR89JnjUG0THbBdRQXx1WxsyFErA0JpzB
 b4NIVLEPTvVtsFQqcbTuJ4CrynyFpmf8ZXHARe3MZX3xlqHCX9g+ZlZpXgYibNMcuvu5
 SuKbidv7OF9jh3VrmN4uc7XV48TL9pRc4TJevPeF2eMsNSiYx4LoZTRVZTp2C4Vyh1/N
 SVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KgB5iCRiDY1xUpzvcmt2qA5qOxhIvxFlroLwQSWXKVk=;
 b=n6b6ekaj/aJ78VhFdrA2be+4PLj6HG7qKdNFYHa2106Edkfd4yh5S+HNRxHLab1rP0
 0Vo3QuA8hWoU1B6BnkU/m2U+gySZvVJlXpxz8ZGOTJOw75/yGjjbXgWzr8JqEeoJcJ8Z
 FFEwGCH0XZrhckdbxEqS57+zXNQ3CoZa2H1gZJ2MxzymVDHClsKR4jYvOWk/VmsFys1n
 bZiOlwUmQfRldU4dPSbkzNrcpcG6grI5Q4ufuuCB8oiL2fA7EGWLW47AAOwaEQoh0LoM
 MRJdOMAv+rYFrdeooRgpP3C5Svtig3BnQyTaQ8Nff9qwU3KN9IE6Tw7A9Vj4dunSnFqI
 vbTg==
X-Gm-Message-State: AOAM5301yZzBCcl5cVf0XQZflDRbjKagCpIiuKIyt1Ta7Zq6ANRxRtDt
 djga3ULmCcACPQ/zKUbsADYnqtU/eawJ18FGZjrACw==
X-Google-Smtp-Source: ABdhPJwh1h7WOq2+DVADM4reEeAZtZ0+Bi37spSD7MX9/2PvrGxVJ5a7SXExxc9Et8QUQoYjFbtIPHqiLPfc0Ni3lug=
X-Received: by 2002:a2e:b609:: with SMTP id r9mr9513452ljn.125.1589789846527; 
 Mon, 18 May 2020 01:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
In-Reply-To: <20200511145257.22970-1-geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 May 2020 10:17:15 +0200
Message-ID: <CACRpkdaz34Bc_EzcXKMEVCCCUt82_c2+t4X6YSLW2b59oi+9gA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=linus.walleij@linaro.org; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Phil Reid <preid@electromag.com.au>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

I have queued this v7 patch set in an immutable branch for testing and also
merged to my "devel" branch for testing.

If all goes well it also hits linux-next soon.

Yours,
Linus Walleij

