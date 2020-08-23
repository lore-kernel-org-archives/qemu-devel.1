Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C06C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85192072D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rj+iN5zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85192072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9nch-0007RO-2w
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 06:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nbl-0006zH-O6
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:52:17 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:42471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nbk-0007So-0D
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:52:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id l63so2514333edl.9
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xWqSjcsohn2S3CYbxuNtUwbwWnRhjj1xTSwb5a9ZfL0=;
 b=Rj+iN5zz6pSVhny/YapGYHqfqGQhRE4D4F1xfg5pvgAufai5zRRRCbvrmlhpV4E37w
 B5U9BUNNx0QnGjveFE+W+C1CMjR9Mh3eVciZXS0r+PP8ZtEsCFbbN0r2E6/gfIKQrmTy
 wuHEuv5B6AeEhdEiElEGzLGdxQZZOf75ktRzwUmfLXZ3LRtuCx1UYropX8FDjoeIDKkp
 XiwWIQNREckuhwUquPvfxka3mvDrG32s7Svj9UZ6zFKc3miEjb2P9hN08+V56DWPu2aW
 BDfmUd4Nq1Hkc9XAovRCFa6ShTCFgsZsW4ReI/++I+Rw9ge2qbesy8HEEOMij339EDYe
 xtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xWqSjcsohn2S3CYbxuNtUwbwWnRhjj1xTSwb5a9ZfL0=;
 b=WW3xmui3Q3Nk3aZwajAtiYMbjiVdDLiJVuwvpbpQLvQKOgm0jChN75kJL4wUJLA3Zp
 7+HckwRzD7L5vT5DMFnNP9IlSQ4wpFk++dBETP94JHmvUw9O6nn9NPglRyAP4dPhTdby
 ewCPlo06ySIdF8RafZJnaO0+d/PGK0bTUMHsnU6pC6zX7EfYo+SfzVkPxt4qa7yCx57E
 YDqqrIsxujPmI83kU6WubxH5MX9GEBTKYVpam6rWJvvBO0mvhyWadzVe1s4Kyv1uaU9y
 B2MgeL8PFDG8hZ2LCK7fI9MVfgzrfoRr3ICRLeO7vvjxGR6+6xVnHgiJY3PdN0WjnAg3
 HKpg==
X-Gm-Message-State: AOAM5319XzzqzMes7QiCfpHDc3c97pIJuD+hjBSzLxSHPN8xhpysXotT
 GpNeG6RKR1aBp+EgEICNtqLGKphuO66ynGcG5eYzzw==
X-Google-Smtp-Source: ABdhPJz1osYGYcIcAkI0MMRRsglf9apAwAKVJ/vKTyc1mdWs51FGCe2sNvdUCtQQGHvvOTfsx3fCAX5o/Q64ik1Saa4=
X-Received: by 2002:aa7:ca0c:: with SMTP id y12mr879441eds.251.1598179934068; 
 Sun, 23 Aug 2020 03:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200821211412.17321-1-pbonzini@redhat.com>
In-Reply-To: <20200821211412.17321-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Aug 2020 11:52:02 +0100
Message-ID: <CAFEAcA-vnbUupqy78wOs_mQCgqGOq18GVOA8T5g2ugKULg63uQ@mail.gmail.com>
Subject: Re: [PULL 0/6] Meson build system fixes
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 21 Aug 2020 at 22:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> ----------------------------------------------------------------
> meson fixes:
>
> * --disable-tools --enable-system build
> * s390 no-TCG build
> * fdmon-io_uring
> * 'shift' error message in version_ge()
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       meson: convert pc-bios/keymaps/Makefile
>
> Paolo Bonzini (2):
>       target/s390x: fix meson.build issue
>       keymaps: update

I have noticed that now if I do a build starting from a
source tree with this keymaps update, the build seems
to cause the keymap files to be modified:

e104462:bionic:qemu$ git status
On branch master
Your branch is up-to-date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   pc-bios/keymaps/ar
        modified:   pc-bios/keymaps/bepo
        modified:   pc-bios/keymaps/cz
        modified:   pc-bios/keymaps/da
        modified:   pc-bios/keymaps/de
        modified:   pc-bios/keymaps/de-ch
        modified:   pc-bios/keymaps/en-gb
        modified:   pc-bios/keymaps/en-us
        modified:   pc-bios/keymaps/es
        modified:   pc-bios/keymaps/et
        modified:   pc-bios/keymaps/fi
        modified:   pc-bios/keymaps/fo
        modified:   pc-bios/keymaps/fr
        modified:   pc-bios/keymaps/fr-be
        modified:   pc-bios/keymaps/fr-ca
        modified:   pc-bios/keymaps/fr-ch
        modified:   pc-bios/keymaps/hr
        modified:   pc-bios/keymaps/hu
        modified:   pc-bios/keymaps/is
        modified:   pc-bios/keymaps/it
        modified:   pc-bios/keymaps/ja
        modified:   pc-bios/keymaps/lt
        modified:   pc-bios/keymaps/lv
        modified:   pc-bios/keymaps/mk
        modified:   pc-bios/keymaps/nl
        modified:   pc-bios/keymaps/no
        modified:   pc-bios/keymaps/pl
        modified:   pc-bios/keymaps/pt
        modified:   pc-bios/keymaps/pt-br
        modified:   pc-bios/keymaps/ru
        modified:   pc-bios/keymaps/th
        modified:   pc-bios/keymaps/tr

no changes added to commit (use "git add" and/or "git commit -a")

The changes seem to be like this:

--- a/pc-bios/keymaps/ar
+++ b/pc-bios/keymaps/ar
@@ -776,244 +776,6 @@ XF86AudioMedia 0xed

 # evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)

-# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
-
-# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
-
-# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
...
-# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
-
-# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorite=
s)
-
-# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
-
-# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard=
)


Why is a build (which is now by definition in a build tree)
causing my source tree to be changed, and can we make it stop?

thanks
-- PMM

