Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492C0C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEF123787
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyb5OGwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEF123787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIw7-0007Lz-Pd
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIqw-0001Ln-TU; Fri, 18 Sep 2020 12:03:14 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:41393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJIqu-0001zx-VV; Fri, 18 Sep 2020 12:03:14 -0400
Received: by mail-pg1-x534.google.com with SMTP id y1so3727953pgk.8;
 Fri, 18 Sep 2020 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QeBnjb1q1hgtSEdwnecjk3xUUXCWDRHjOz4q4A5pXKo=;
 b=fyb5OGweXnxgKi88JR08OKCEZkDyIWMdEJXAnWOE9vD5EBopbsCSEccH8+fExqYHps
 v2ln/i/PqWBhecfgtHjtDloUcwaf2xm1o4IBkk2p2whMlalhqXvwIKwDpCn74cWa63NE
 LbkxiGpnR0fa1rogMjZVEDXtp8KSmbRxmfAO2xSVydlcahxo3v8/S0GbcSfK6JoPtzVj
 6IaJSx6FarWb9W9o0/LNu8C3H22b9Tjv9TJf/0t3muzs0TfagIcHhfGhGTKe8M1CHTXc
 nKpcGcp6Qz6LQjvSQjrFxJohWyobK/fs6zuZrQN4rrhJkTSZYGgEPtk2Tt9fp8Usv96q
 dy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QeBnjb1q1hgtSEdwnecjk3xUUXCWDRHjOz4q4A5pXKo=;
 b=jpYGGRuioeMaJ4i6ml7MTnpqxBNI6Vhek0GdG2dauWlKw869FYgFOv4dB8Kq1oJ/x9
 0MKJUiyh4b9ApRzWG9SdL0ZDpg/ca1S0cCYle16TQDEEVuM7tjptXmb9ZZCzrvGo2RNp
 G/OH3n+Yfx7QkcBUKhX2TXs110Or5iloYyTYIFBuFx7bkUwCLDwsUDrd8xd5FAhYun00
 3SB8Dr8HFdQc3Sfm/I8s66eKn63urv5JmpqX1fMGUltfVTsQwlpxRl9kI9rGq+3RypKR
 cP2U4ZKMp8XoBPeVYUhTUFpnktzK2tKrHazrMoQ+pD36rWhFBXFz18dy7ilBYfWbDBVI
 ebLw==
X-Gm-Message-State: AOAM531zBhkaVHfRU+9QepAyiR3AsGHamqpim70UaNBRxy+H2jFjmK3m
 nRGQzYViuo8E9wA1X3niGMgxGpadiR16Hg==
X-Google-Smtp-Source: ABdhPJwB0uCkhSwaEm7atnpdPqayvGEPVflEZ2/Knb/+4qjRP7/4ze64U5nWhMwqYDyj5+AxAekOKQ==
X-Received: by 2002:aa7:8512:0:b029:13c:1611:653e with SMTP id
 v18-20020aa785120000b029013c1611653emr32587656pfn.16.1600444989941; 
 Fri, 18 Sep 2020 09:03:09 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id z22sm16889012pjq.2.2020.09.18.09.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:03:09 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/4] Fixes curses on msys2/mingw
Date: Sat, 19 Sep 2020 00:02:46 +0800
Message-Id: <20200918160250.1141-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x534.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And also convert related configure script to meson.=0D
=0D
Yonggang Luo (4):=0D
  curses: Fixes compiler error that complain don't have langinfo.h on=0D
    msys2/mingw=0D
  curses: Fixes curses compiling errors.=0D
  win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE=0D
    are defined on msys2/mingw=0D
  configure: Fixes ncursesw detection under msys2/mingw by convert them=0D
    to meson=0D
=0D
 configure                 | 155 ++------------------------------------=0D
 include/sysemu/os-win32.h |   4 +-=0D
 meson.build               |  80 +++++++++++++++++---=0D
 meson_options.txt         |   4 +=0D
 ui/curses.c               |  14 ++--=0D
 ui/meson.build            |   2 +-=0D
 util/oslib-win32.c        |   4 +-=0D
 7 files changed, 91 insertions(+), 172 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D

