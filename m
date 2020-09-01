Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53935C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D75206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+wBJBFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D75206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD33P-0001Tx-60
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD2xm-0000bc-R2
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:52:26 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:46043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD2xk-0003Lc-IO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:52:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id i26so713083ejb.12
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hb63U+aHLaO1yLixJr9yuKIfM8hxtHyZsRoKgMNGRP4=;
 b=T+wBJBFEepn1dzrK8mHEwjwhVmenxIg6FwVn8r50R5m++yhGUgZ+lNzno4+05NILuE
 qS44y84yAbarGN5G0HNy2Igz9mQq0VMInoTGwA7SGRJzIeSTvXxXS/W/WLndBC3YhfMF
 KwSSSRsGQ31lFY6As3++R7D7jPiUhrU8Cu6JOoBclx7jPTTsH//E74MTp/Yw1nFAh9Nr
 4gej7rHpOaKg6yjuU+IcTVazBH4qhU5XtMeVSFIH+hcMxZyrUi7d6vwlPDwSDtKY4H3c
 UWFaL940eu+GljXsYwYb+SUmkYyNyzCcabRL1Dmh0mwzQyYQ1tCM4M7yM3oW9iZwlmdF
 drWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hb63U+aHLaO1yLixJr9yuKIfM8hxtHyZsRoKgMNGRP4=;
 b=QaS3vh1p+AMMgw8159uakA70ske3Eh1ft/RMf5kJ3BNRw5fPtnvc5HMN4hLQvaDMEi
 dumzMXuwe9lcofa29h91FTWE+xY/tY0fY4s4hmL5RKcJPovpMfqeSo2BY/hxKHoksPEG
 VkwtI76N/cZptbuXOcvPM5XgB/7GBeapqhqbuW8COJYrs7krhAhrq+hcCiJX+Xs7k9lm
 eWS6ciyvR+9Uf9NZuSyz3v3E33iQYPACjARXP/+2KmpeZNcPm2lWY5a4aPiQnDHF6rO1
 fFI2BXvWQF2PqufoBq3wZGfBMyELVaOC2PIeHSJFUVGQ41ak9tlOm/sOWG5DyWhTtKAw
 vBpA==
X-Gm-Message-State: AOAM532Dyfj460Dfv1L49cJ9L0ncsgo2Nr/uOyM7lOX7bwc/R90Awh9+
 5+rIT9o/5FMFj9PHwsIwU76RaDHbShF3S5+erEZN6Vk4OmfJ84Nj
X-Google-Smtp-Source: ABdhPJzYlGpLl72t3jlYgmfkVcTwwH8ve5Qyr76+ISCkBTedcmjjyDH27PsNw8SgqLCBT2agcXOaCf1y+wfG4BOKDnU=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr709028ejb.85.1598953942728; 
 Tue, 01 Sep 2020 02:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200831110416.15176-1-kraxel@redhat.com>
In-Reply-To: <20200831110416.15176-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 10:52:11 +0100
Message-ID: <CAFEAcA99xWV2=12YeZL2Aq+U5kDGLx9eC2vfEVtbqs=Avz78Pw@mail.gmail.com>
Subject: Re: [PULL 0/5] Ui 20200831 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Mon, 31 Aug 2020 at 12:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-=
> request' into staging (2020-08-28 22:30:11 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20200831-pull-request
>
> for you to fetch changes up to e54635710f1cf667191a0a1d9df9a37d1c9b0ad0:
>
>   ui/gtk: Update refresh interval after widget is realized (2020-08-31 10:41:=
> 43 +0200)
>
> ----------------------------------------------------------------
> ui: memleak fixes.
> gtk: refresh interval fix.
> keymaps: don't require qemu-keymap (fix gitlab ci).
> spice: add mouse buttons.
>
> ----------------------------------------------------------------
>
> Frediano Ziglio (1):
>   ui: Add more mouse buttons to SPICE
>
> Gerd Hoffmann (1):
>   meson: fix keymaps witout qemu-keymap
>
> Pan Nengyuan (2):
>   ui/gtk-gl-area: Plug memleak in gd_gl_area_create_context()
>   vnc-auth-sasl: Plug memleak in vnc_socket_ip_addr_string
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   ui/gtk: Update refresh interval after widget is realized

NB: something in your cover letter creation process is mangling UTF-8.

Fails to build, windows crossbuild:

./ninjatool -t ninja2make --omit clean dist uninstall < build.ninja >
Makefile.ninja
make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
Generating qemu-version.h with a meson_exe.py custom command
Generating ar with a custom command
cp: '../../pc-bios/keymaps/ar' and 'pc-bios/keymaps/ar' are the same file
Generating bepo with a custom command
cp: '../../pc-bios/keymaps/bepo' and 'pc-bios/keymaps/bepo' are the same file
Makefile.ninja:5172: recipe for target 'pc-bios/keymaps/ar.stamp' failed
make: *** [pc-bios/keymaps/ar.stamp] Error 1
make: *** Waiting for unfinished jobs....
Makefile.ninja:5174: recipe for target 'pc-bios/keymaps/bepo.stamp' failed
make: *** [pc-bios/keymaps/bepo.stamp] Error 1
Generating cz with a custom command
cp: '../../pc-bios/keymaps/cz' and 'pc-bios/keymaps/cz' are the same file
Makefile.ninja:5176: recipe for target 'pc-bios/keymaps/cz.stamp' failed
make: *** [pc-bios/keymaps/cz.stamp] Error 1
make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'

Fails to build, x86:

[...]
Configuring 50-edk2-i386-secure.json using configuration
Configuring 50-edk2-x86_64-secure.json using configuration
Configuring 60-edk2-aarch64.json using configuration
Configuring 60-edk2-arm.json using configuration
Configuring 60-edk2-i386.json using configuration
Configuring 60-edk2-x86_64.json using configuration
Program qemu-keymap found: NO
../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'ar' can't be converted to File object(s).
This will become a hard error in the future.
../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'bepo' can't be converted to File object(s).
This will become a hard error in the future.
../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'cz' can't be converted to File object(s).
This will become a hard error in the future.
../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'da' can't be converted to File object(s).
This will become a hard error in the future.
../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'de' can't be converted to File object(s).
This will become a hard error in the future.
[...]

Command line for building ['libcommon.fa'] is long, using a response file
Command line for building ['libqemu-aarch64-softmmu.fa'] is long,
using a response file
Command line for building ['qemu-system-aarch64'] is long, using a response file
Command line for building ['qemu-system-arm'] is long, using a response file
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
/usr/bin/python3 -B
/home/petmay01/linaro/qemu-for-merges/meson/meson.py introspect
--tests | /usr/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
./ninjatool -t ninja2make --omit clean dist uninstall < build.ninja >
Makefile.ninja
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
  GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 meson dtc capstone slirp
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
make[1]: Nothing to be done for 'all'.
make: *** No rule to make target '../../pc-bios/keymaps/ar', needed by
'pc-bios/keymaps/ar.stamp'. Stop.
make: *** Waiting for unfinished jobs....

thanks
-- PMM

