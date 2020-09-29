Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA7C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BE92076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oH4iqeqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BE92076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBxo-0000kH-OD
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBxE-0000I2-L1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:29:48 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:37264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBxB-0004vd-MI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:29:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id nw23so14027741ejb.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PG/VpBgOkLY6snbBIwEEBcmYBhimV5oV0qF+uqkoE8Y=;
 b=oH4iqeqQDWXGQ/xQOHICGfxwm+AUM9OEtiAz5mTDhlQcHm0/6YH+dfGKSZNkdz8hC8
 uP7vhaVQ3/NGRtvKThwOWt3OY+4D1mi6PNffhxe/WPw+C85wbLCxuSjOVnjoSG9kcc1h
 VyuTUvkTejAsdxCgAwEtwJRmnvqJ6i7NplJr2TCG0uxCfIf6jNqB6oqUfS4vWQrygiFF
 AjrdZV61GcFSFMxf/Rt0feE3DNZpGFHwm2J4ISH5iM4j1MOWdrhHTdJ+Jg+vshVOrH1q
 vzDXwLKl/ZY3CYnW3Xy9r5JmlPdPhoxW5lCQbPGNGHBjl5aSPqk47UWMhGfgWIZtZYBM
 8GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PG/VpBgOkLY6snbBIwEEBcmYBhimV5oV0qF+uqkoE8Y=;
 b=thyJ9Byw7XOwS4ChVWdvFjAAey1pfUJbo/DZ0tKvWGY3Kmxhet8eldww2ZqD6JMvhR
 s7lre7e/Q5DgHftkH6ms4QzYKF444iuXqJbyc0x9FBRhs2S/1cQzW6HUJ2r3NLf7EL7A
 Cw7y+ayGuYmeFfeljFVzz/ZAIqhoQ7dAhlQSgBH+zpDw+yvcKTIfp50/1Z6rICp44+ql
 TrTK2HzgR5Dh5Al+NUDkvy00lbakkfvPx9Lep7+LjGH59NoHXtpQaiz2K1/ICW4Cm77z
 K47V2tyxnXxAh9l7gEZFlGknf2l4DIbQAu1MrykmOTj6RTb93stZqiGVP4Amb64e/bH3
 8pCg==
X-Gm-Message-State: AOAM530CkTIclq3bUzcAkI3GPXxSs6W1lXJzrQvcbHNLmvjx6nmOrmlu
 HHG3KOZMuOVrrzKoiLn15Ano09uKOw4aoOLl7pFktA==
X-Google-Smtp-Source: ABdhPJyOGJuoq49+crKUjkrjZ9VPAupId1lvbAvE3YmAOgjjYO6vRsv+RYm6QT2/D7GVuw64ShWcpxqeHz+dyWj2hdw=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr2818120ejb.85.1601371783970; 
 Tue, 29 Sep 2020 02:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131638.9486-1-kraxel@redhat.com>
In-Reply-To: <20200928131638.9486-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:29:33 +0100
Message-ID: <CAFEAcA_=WGX1M2FcxpsunLQr7Jeh8gPuHmHe7XHzXqfkVW7-CA@mail.gmail.com>
Subject: Re: [PULL 0/5] Usb 20200928 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 14:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 8d16e72f2d4df2c9e631393adf1669a1da7efe8a:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200925a' into staging (2020-09-25 14:46:18 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200928-pull-request
>
> for you to fetch changes up to 5c43b603a2e3f77f41e0cf339e72bee2077bfe61:
>
>   hw/usb: Use lock guard macros (2020-09-28 13:13:58 +0200)
>
> ----------------------------------------------------------------
> usb: xhci sysbus support.
> usb: use lock guards.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

