Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B59920719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koqC/p9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B59920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPY7-0006EY-DA
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPUQ-0003D6-Fu; Fri, 02 Oct 2020 14:09:06 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:45005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOPUM-0006xz-MZ; Fri, 02 Oct 2020 14:09:06 -0400
Received: by mail-pg1-x533.google.com with SMTP id 7so1276914pgm.11;
 Fri, 02 Oct 2020 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QJl7ZQW0s2HSJ0U+n722WdR4NS8GCtqaPbGBDictMWs=;
 b=koqC/p9cqze0nvWp1LbaQVln6mC/rXDtn0st6tD5rd3QjKpI8U0s4FQoCKsBEZKHOO
 dPirB94U8qPq2e15t2c+ArJThPnBjs2+s/0V4S9HJTHM7s1WOq/yc0K7OR89rLysu7r7
 dedjpq3w9fucfVUHuA3beZLYYyLRPoFPNFnA4cBZ7sVqfJ1/+mR+HBurjAbUf8zsmoWj
 H8U07Jb6YbIWLZm9kEqBySqezMifwhP0TdK5dMdZQMKZB+ZTI0pjfJ62TDTcOUjA87mn
 UvVYPalvIDjMpPCio1OivX/cNhsD6Zm8lXS3/IRxbowksQ/MrDxg3JWIyCmusecPjmrd
 hAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QJl7ZQW0s2HSJ0U+n722WdR4NS8GCtqaPbGBDictMWs=;
 b=EyBbR3YbHlUeYVQq70xsNF4gthvpKvNp3/sIGERyX/kI8z/G6wk+rpHQZQWAXyWzcE
 bRdySy8r4jgzN0DIfRUb23QSTbfm2vlOFVEJTUH/GBGBwX/LnZaHSyjR+3BtBW60+quh
 59ijcXQEvp9yFesN4ZuGoL7FPfKH4CJbCM7ULP61SRQGauH+rU9gDq7xpHHZq834+rA1
 gIhHhCBeAyv6eEZOZn+pirxKp94WNAlHtB9ZOTAxXJA1LQ72EvUfzZ+1wXtl8KYntUcM
 kgRZbUmw36Pg5aGhMRE1RZJ5DIGb3T+kVTk5ZJwymxzg+dVt86A22JIDhtm8TYFvWonP
 KRpQ==
X-Gm-Message-State: AOAM531c+QAU3r6kdvzmE2VWdYEf82L2JamSSPREWpYLVL1hmSzq4/cJ
 4Jad7NBSDxuQhAQT9zIzV/Ty0JuKWlbnB0uL
X-Google-Smtp-Source: ABdhPJzN8WDADCwiSOz1tMnBcSV46zgnubghkmo06Pr+hHaSGFgecIqN17fB1XCGqg5V7FCMU28K2w==
X-Received: by 2002:a63:1162:: with SMTP id 34mr3250828pgr.329.1601662135827; 
 Fri, 02 Oct 2020 11:08:55 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id o23sm2166567pjw.32.2020.10.02.11.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 11:08:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/4] Fixes curses on msys2/mingw
Date: Sat,  3 Oct 2020 02:08:37 +0800
Message-Id: <20201002180838.2047-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x533.google.com
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
Yonggang Luo (4):=0D
  configure: fixes indent of $meson setup=0D
  curses: Fixes compiler error that complain don't have langinfo.h on=0D
    msys2/mingw=0D
  curses: Fixes curses compiling errors.=0D
  win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE=0D
    are defined on msys2/mingw=0D
=0D
 configure                 | 47 +++++----------------------------------=0D
 include/sysemu/os-win32.h |  4 ++--=0D
 ui/curses.c               | 14 ++++++------=0D
 util/oslib-win32.c        |  4 ++--=0D
 4 files changed, 16 insertions(+), 53 deletions(-)=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

