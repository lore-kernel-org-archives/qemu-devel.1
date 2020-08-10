Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD2BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F91620729
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Vx7d+QgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F91620729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57qw-0002ki-Bn
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nL-0000vz-PK
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:24:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:54733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nJ-0008En-Ji
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065884;
 bh=M9fljgFaxLpDPesDaOO2JMfubfGaiDiCLqbN8svY3sI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Vx7d+QgYACmmQ9CvdnA3931hjWYncPi+iXH3AT9tRzVvpFLMkAwcSVEHoEKcZW279
 FGRy8Q3g5yiBzY3zwfqvqOgAXL4VAyJa732clGU3eboUzSYubBdjPAI8S/auy8Q3qN
 qIbamBLx2RVvSU58tt0Kq4CRq78Xp6GqYEwOYE6s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1kd69p1AZ3-00hKnl; Mon, 10
 Aug 2020 15:24:44 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/12] target-hppa fixes pull request v2
Date: Mon, 10 Aug 2020 15:24:29 +0200
Message-Id: <20200810132441.16551-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HpfW3MNfXQUYG+3sY2abnUMXTJIFEwQ/doo2H7h34D19zTCSVFS
 JeVQLCIzjGXKOo8XMRcupDhK0lQZ4aUGa8JihwmyH4CnP2vwatjo2iLkvg2VjQllN/9FmMl
 ymiywpMVmMAEPAdD0Y8Eu6JT52WKrk94z19gP38uD3py1Ekj2no0pEa3BXWSjBrfu6efdr8
 tdBg7oIyGLChyHAURuaRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VHTzt/v4tns=:LvOwSgXVJ0VtY2zgSryTKQ
 /vWOv+6EMQu4yJro1XOy6A8DM+OXApA7GUhZ2Ke69ip4x+pg31wV77EAWuNkVTqhafeftUKPX
 k4DOKRkBhrQ9ng3CfDM6JjTnXTbeRAFcgmmA2OPheerZMJdg0qlYqfLjqtu6JT0foHI022Sph
 g3dFuLvXtilV+NOofPgTYh6JG+a0d/68WifIwwAqW/6WJarN4Ma7lwF/or3JdhS+pLlpz+7GN
 douILxLW4F9A/3u/6ky2cpCfXlxCPe8148/lf2YXKe2kAOXLi+mlZG5rpa4E7YVtUGoKG+7Sr
 PK82gaOtjYnwhLc+fBjC5splQ8U+pMo5rGDoraFg0Wj81HydDbim9Nn/ucf0hD28E/uPv7q60
 wOhwS99uyUXujIc7se49u6fOJEgFkxqYjuTHZgCrUE7jYktF9LRFUgb9sAy4biS8Gl8IQfN2V
 sTwnI4huC7RGMPoHWaSHrx8HH3ANPI7kwD5H7dWt8YwxeQx9LxYqyj8Px+x46JG6U6TM9FQR0
 aoKoaWqmTZ26fkS6Om6zsdL7XKWusHbcWE2OKFy4cWFEVg9FH7gymBZGDiEirrx+I8Fbj0HsP
 UCosfHkGP6DhyywzjdQxmeVQ722GYJxqMB2BihUCwlYygWdookHRo0mTZrQiwb5e20H5Z14ZV
 5nagU3/wZVULFfTaJ3gSoxgr2Uk44rvhDOpzym2WSQSef5hyfCQCIwMCdjRk/MUp5u2pdl1kM
 GCeC6tSU7BMQDpyoKo46JGFQxGnfH605HpQQkD/sH6IhuA5qTCEy/y3yfSE/oe2NGg9rzpt1a
 npEp374Xi3Ios9eWf42JCCCu9dNsN7YA6UauMfBGsEOrp3Re/R5ATMCXmgLRpH9HpxIrSW5YN
 maCPyt8ApG05kL2Iyl59P4DNmaOSClZOD88U94U9uU9vwFQ8tqbjAlzSFJwJ5UvNYf1uzzR/s
 RyUkczB1ZGi3bnYeNLofUhw8IXKmEDyvlZBgK7bsEzD1sltfcPCLyC4TEdWvQR7vTYbuTKFqx
 R8K+HYqjZVr33n8jXv2Hii2sOiL+o7T/3cHbW1I9syQ9MTGnTPPZBAaJa5hOsuL4sl+dJQpzC
 IBv6zuZ6WuWByErbm/GOSL+Ju0WvtGDBRCq5noJUoYBKvWbF5KaJwr/TQJzLWTCYWfWbt2TTK
 1JQeN/1f7MX0lPhezVVW/xXFGHEptgMdHe5iC9ztW8sRyaKAtrAB/7pfG5c95x2241VvUAvk9
 v1lsBIxJ88bG8LVDt
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:24:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please pull from
    https://github.com/hdeller/qemu-hppa.git target-hppa
to fix those bugs in target-hppa:

* Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian

* Fix the SeaBIOS-hppa firmware to boot NetBSD again

* Fix many artist framebuffer out-of-bounds accesses as found by Alexander=
 Bulekov

* Fix artist memory access bugs due to commit 5d971f9e6725 ("memory: Rever=
t
  "memory: accept mismatching sizes in memory_region_access_valid")

* Fix various artist screen updates when running dtwm on HP-UX

In addition the SeaBIOS-hppa firmware now includes a version check to prev=
ent
starting when it's incompatible to the emulated qemu hardware.

Thanks,
Helge

=2D---------------------------------------------------------------
Changes to v3:
* Fix memory fallouts due to commit 5d971f9e6725
* Fix graphic rendering bugs and screen refreshes with dtwm on HP-UX

Changes to v2:
* added more Acks by Richard Henderson
* added more artist framebuffer out-of-bounds fixes by
  Philippe Mathieu-Daud=C3=A9 which were reported by Alexander Bulekov
* fix NetBSD boot

Changes to v1:
* added Ack by Richard Henderson for the first patch
* revised out of bounds check based on Richards feedback

Helge Deller (7):
  hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
  seabios-hppa: Update to SeaBIOS hppa version 1
  hw/hppa: Implement proper SeaBIOS version check
  hw/hppa/lasi: Don't abort on invalid IMR value
  Revert "hw/display/artist: Avoid drawing line when nothing to display"
  hw/display/artist: Prevent out of VRAM buffer accesses
  hw/display/artist: Unbreak size mismatch memory accesses

Philippe Mathieu-Daud=C3=A9 (2):
  hw/display/artist: Check offset in draw_line to avoid buffer over-run
  hw/display/artist: Refactor artist_rop8() to avoid buffer over-run

Sven Schnelle (3):
  hw/display/artist.c: fix out of bounds check
  hw/display/artist: Fix invalidation of lines in artist_draw_line()
  hw/display/artist: Fix invalidation of lines near screen border

 hw/display/artist.c       | 186 +++++++++++++++++++++++---------------
 hw/hppa/hppa_hardware.h   |   6 ++
 hw/hppa/lasi.c            |   9 +-
 hw/hppa/machine.c         |  22 +++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783192 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 148 insertions(+), 77 deletions(-)

=2D-
2.21.3


