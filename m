Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAF7C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276DF2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaJZXnjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276DF2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS7VP-0001HG-7J
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7UB-0008I5-2m; Mon, 12 Oct 2020 19:44:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:44852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7U9-0007hF-Ev; Mon, 12 Oct 2020 19:44:10 -0400
Received: by mail-pl1-x62a.google.com with SMTP id h2so9602734pll.11;
 Mon, 12 Oct 2020 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MpY84DTZDyis25ai4POrdcehSbT7TmgpVCFX4yD6oQY=;
 b=ZaJZXnjjKWz+p1U88PjE+9ZahkA4kvncKkSrf3tTG/B66hsECre9R+HrjTKuXRcgsu
 7SMkEG6tPoxW9PbfqpY+r0DCBpnP9ND38jc0jA2IZMtQ9KEYHoxFloULbEJuY3Bar5WO
 WGDE6ZYUKlOGLCNkjCwXl0108cDYsmN4wRUriYQMCML9RomVN0DMmhCUuEql+f/soJbR
 XaRMjhdRka2c9ZZTwZoQA0/XA4qWZRSZrqC4rOnoWVHNoNGJwfC/xDlJmxa6ruCbBsQL
 CqhjBX2GCexv9WcnSVyDB7WHtyXljRMPYP+0G/1R6xwMMRtQe0CsQgflbhm7H9quNTHW
 sfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MpY84DTZDyis25ai4POrdcehSbT7TmgpVCFX4yD6oQY=;
 b=koY1j0sA4VxrIca650F3WRrGDQ1IJGNaSQ/QkLjTlyJGIGQu3+bLOxkgq8Y9MiwU6c
 e8ZNfM9x2zD73aYP2/W1GXn3jjIW8YVVleopUMXFeOMEw0gbZwenqk9sqASz+5F0kLps
 zjnRwBBoudeQL0on+d+nBEoqztlMPlXDkMft29rpU3U3HgJV0z54BHkGKrwM7tHg8aNw
 6C2g1dtFr/Vh3szCdwqkM2u8T1wbHBRpKixA8lUuYtKHnL+khWKg+Roy19ajsEhlug8Z
 Ng8Vb13OzkaK8jIcRodv3sNCL17Hnm6Eba+JfyAudORxl26yrAwJJSdUCM3+A1X2A1nV
 nqjA==
X-Gm-Message-State: AOAM530AVcfhnmgQNcsoqX4P/OKGJheYPBhZNm843ZD13YljF7Ikhm/8
 BuzpYQ6zCSi6iRWMxl3a0a0hLQCmSsHucA==
X-Google-Smtp-Source: ABdhPJwo8yITWxx2bsCTouOQKDIinAWDjqoi4qKrO+RklJojkcAN+dNxx4dlPon9k4VYL+/jt+c+0g==
X-Received: by 2002:a17:902:d88e:b029:d0:89f4:6222 with SMTP id
 b14-20020a170902d88eb02900d089f46222mr26221306plz.10.1602546246849; 
 Mon, 12 Oct 2020 16:44:06 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j3sm9714890pjv.20.2020.10.12.16.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 16:44:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v9 0/5] Fixes curses on msys2/mingw
Date: Tue, 13 Oct 2020 07:43:43 +0800
Message-Id: <20201012234348.1427-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V8-V9=0D
Rebase to resolve conflict.=0D
Add configure: Fixes ncursesw detection under msys2/mingw by convert them t=
o =3D=0D
meson,=0D
because we don't know when upstream to be fixed. we can revise the script o=
nc=3D=0D
e upstream=0D
done=0D
=0D
V7-V8=0D
Rebase to master and  resolve conflict of=0D
*configure: fixes indent of $meson setup=0D
=0D
V6-V7=0D
Update the configure script for=0D
* curses: Fixes compiler error that complain don't have langinfo.h on msys2=
/m=3D=0D
ingw=0D
=0D
V5-V6=0D
Dropping configure: Fixes ncursesw detection under msys2/mingw by convert t=
he=3D=0D
m to meson first.=0D
That need the meson 0.56 upstream to fixes the curses detection.=0D
Add=0D
* configure: fixes indent of $meson setup=0D
=0D
Yonggang Luo (5):=0D
  configure: fixes indent of $meson setup=0D
  curses: Fixes compiler error that complain don't have langinfo.h on=0D
    msys2/mingw=0D
  curses: Fixes curses compiling errors.=0D
  win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE=0D
    are defined on msys2/mingw=0D
  configure: Fixes ncursesw detection under msys2/mingw by convert them=0D
    to meson=0D
=0D
 configure                 | 169 ++++----------------------------------=0D
 include/sysemu/os-win32.h |   4 +-=0D
 meson.build               |  83 ++++++++++++++++---=0D
 meson_options.txt         |   4 +=0D
 ui/curses.c               |  14 ++--=0D
 ui/meson.build            |   2 +-=0D
 util/oslib-win32.c        |   4 +-=0D
 7 files changed, 101 insertions(+), 179 deletions(-)=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

