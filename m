Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ECCC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E06206C9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0hqDjgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E06206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO377-0008W8-16
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2Rr-0004f7-Id; Thu, 01 Oct 2020 13:32:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:34701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2Rp-0005DB-Uw; Thu, 01 Oct 2020 13:32:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id k13so5248383pfg.1;
 Thu, 01 Oct 2020 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mx63Gw3pO3Gs0HPOi87krsZJjwOs0SaCSfVW17FzaIM=;
 b=Y0hqDjghlMJ37kvgLs2pF9l6+r0o4jE73xlk2UqG3Ha4fwgJNzXNwC0wBkYCJZ95y0
 LJy9kukMqMJk0b+dozDkUsv8F+IVwr4d3ctanKys6avh00rguCrW2xUG2WXIQKpodDSc
 wJU367Y/U5NPaEhsyCd6szXmEr9/WT+U09NoqD2pL3vYS3i2x5CbvQ3KwIDXp/J4Y7N5
 5tEKXkovUsTqs0jNeLbURir9Tq8y+tFuOhgkHVAZ5shtdBe/ObONYpGJK2qkFy9eicFV
 dHVSVwY94IwH7oHtotyB/lnUPh68Wp6QidONIK1hmKjEF3zRwrv5k68JLB9s9ZZwA9A0
 MTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mx63Gw3pO3Gs0HPOi87krsZJjwOs0SaCSfVW17FzaIM=;
 b=tH4kPwSTLRdZxv0Y8gL+JRgoDWUDWAxWuoCB0rUrfsAp1M2EWn1Qk/+tWiM7O+NSTn
 H9HxKj4fxgi8XU7sEBqXtKr4R8f16kY/J6kwpnJHZ9n2NGp4j2xtB2zS8cMaZmVthPkU
 PU1ojenGTzZF2C/9gng+wgXPwf7rW/n7n5kMpyxourWX9IsURZRpZIiwp+g0XXkRPDGj
 q5Q3lwacjGxUtw0W/K/ZHSV4CKOGtvT0YycmL5Wy2hkt2aiOiRmtymaD6Sx5I8/0/zmA
 90Vf7mWYVWvY15MeHbTdHiUzJtSxW64grM8Vawxq/EbwKZ3NphooMdmJGTrFRR71GRUV
 gozg==
X-Gm-Message-State: AOAM533I2kTeyPXkFl48zZY+SGdXqX+prPQ4S6I5JaHLIGbc5ujZBDtz
 W0wyvcMlE6sFmdj1Efw9B+J5/II22aXmhg==
X-Google-Smtp-Source: ABdhPJzZ9kHKBIsmkfwDeb0hgp2OcM9817JULgP8tt3etNELAIUR18qX6yCBVoJ+opZyGZiqKfNt+A==
X-Received: by 2002:a17:902:b685:b029:d2:1e62:4cbe with SMTP id
 c5-20020a170902b685b02900d21e624cbemr8239526pls.58.1601573568339; 
 Thu, 01 Oct 2020 10:32:48 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id b20sm7253767pfb.198.2020.10.01.10.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:32:47 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/4] Fixes curses on msys2/mingw
Date: Fri,  2 Oct 2020 01:32:26 +0800
Message-Id: <20201001173230.829-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x435.google.com
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

And also convert related configure script to meson.=0D
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
 configure                 | 42 ++++-----------------------------------=0D
 include/sysemu/os-win32.h |  4 ++--=0D
 ui/curses.c               | 14 ++++++-------=0D
 util/oslib-win32.c        |  4 ++--=0D
 4 files changed, 15 insertions(+), 49 deletions(-)=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

