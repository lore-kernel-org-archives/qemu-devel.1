Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2527CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3E020787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3E020787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabyr-0006Ee-5W
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jabxX-0004Tg-J4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:21:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert.uytterhoeven@gmail.com>)
 id 1jabxV-0001L8-VK
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:21:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id g25so1728298otp.13
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kAa2psThKQ7YN1P9hrBIVOheMSQY5tyl7YTngLsSf9s=;
 b=rpHkTJB+qWdtaa0OXcHV2PMN23LVRWmSUXQJbOxm9dOCNgeIgtkHJTO9jixi2iZjL8
 MF7BtHro4155Y27BY8RATAJRSbi1xMgiVIkvxWEb2mz1Y2YZhGrhP1Nl4lxqPkp8wBWK
 8JZ9AFdeKqX2gyvbib9K+HN5HtZ9jYMmMKgnrwukkGdz/HDSQGa0xzUOHgDdL3hNURQz
 wEwahx0wx83qgOJsVXORUrUShBKIoQOwnNb7/Q1d1jHCI/5OaEaBu8s5Nq7x6qQ7JdMK
 IzKsCCm0UQuOMox0UfJuFSSIZzaGOfQXG9hnXIJePtcXWw4+lMSpo8oX9F5L+UFWMxUw
 9a/A==
X-Gm-Message-State: AOAM530R9pJQy5Qduvdp7ZUDncqtOlmqCHG9znZgCwayAfgfLudWpP90
 6rzKYPOVZnadIf4A5HNIJ1P7bSIMLiTCEFexXVw=
X-Google-Smtp-Source: ABdhPJy/jYVzr4UFhMG3XsAuCDffsP6l/ymaV+byoPvr3DO7/Hr0St2Gcq6sQ6SCaJT6ercVH1Hg1rifAgCbjYjrD3Q=
X-Received: by 2002:a9d:7e92:: with SMTP id m18mr11298557otp.145.1589793676622; 
 Mon, 18 May 2020 02:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200511145257.22970-1-geert+renesas@glider.be>
 <CACRpkdaz34Bc_EzcXKMEVCCCUt82_c2+t4X6YSLW2b59oi+9gA@mail.gmail.com>
In-Reply-To: <CACRpkdaz34Bc_EzcXKMEVCCCUt82_c2+t4X6YSLW2b59oi+9gA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2020 11:20:59 +0200
Message-ID: <CAMuHMdUtNVfAnQODjWaDo_+ncFBwq=cNLMt=hsMqiVbqx-1XVg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] gpio: Add GPIO Aggregator
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.210.65;
 envelope-from=geert.uytterhoeven@gmail.com; helo=mail-ot1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 05:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
 Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
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

Hi Linus,

On Mon, May 18, 2020 at 10:17 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> I have queued this v7 patch set in an immutable branch for testing and also
> merged to my "devel" branch for testing.
>
> If all goes well it also hits linux-next soon.

Thank a lot!

Back to the QEMU side...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

