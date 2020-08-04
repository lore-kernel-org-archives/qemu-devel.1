Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F89C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61FF2075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Gr2REQFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61FF2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xne-00042Q-Of
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVU-0000ts-2q
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:53823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVR-0003Ag-Rw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596549657;
 bh=R0Hb8M7pmF1ijch563syPdR4d8bZs1Ry14IVG0OCA5E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Gr2REQFw9y/29zF+XBDv2xXfrihmjfUIE1EyAqGukaH7b79pNl2sQnVCILUKWBO47
 tVVrfCLouPBRcdeQBDziCfGujmrE9Md5GaS/Q0HqsQs0myh+8av2s0uQcG0bHHs44D
 JazzHFWLaPNeyyTzpU7rT1Dtk7/LR6xHN1ailp10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1kadM32k3e-00c60V; Tue, 04
 Aug 2020 16:00:57 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/8] target-hppa fixes v3
Date: Tue,  4 Aug 2020 16:00:48 +0200
Message-Id: <20200804140056.7690-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ie1spZuBvZbZfAe7/z+qM9hOWAapUan2KLxA7X2bn2tUrRvBO70
 1V1fXkZEYZf2aJEMKb4mEgzSJ3tQKJcZCiofVlDw3lr19v4pKxp6o+Ul5/UsP7GQL8fwD3G
 Lbd4lw+wKgQQVht0WsVrmcMILDJSommDq3qDfEOmogb+qq79bp2p5BuXzdZgtiT9aacmy7C
 kGl9hginIlPAep1dMjzVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GbNUTOqUXeY=:E9t/3ygf4kuQDbCz4zvY7m
 GRL/3B1Sw4qk2w1fHwgJu0m0axHd8SPJguqhWxu3uYhotduRC+84MhhrSsuruNls+9QhsE2K+
 n7J0y7nljtkYjc/A9U8WbowgqVyNpGatbQ6K0xky1aZmQtNNwiUIeIVDZPSfFZpIo3w964Cuw
 QLmWaExLphtReYoDnUvqAbv9zHtUdPQXd0FeHPhZkFY9Niy7ultZFlUHZxh+b7aSTTlO9niD0
 oBotH9WCzod24XluQJnu6Bbic1b3KxaTVDl8aGoUiPNtFDG6DoWyfuspKnl4hYOkwUDXH7opr
 MZsNH6TMRfXMHleAduH4RDDTTArYmc/att4dIME/xXCREOzp2iJ4yjNpTN9FcuREjjlsegK6j
 64HMQ9OyzLHsmWKHrmOTnt2ivJnA5DzM0onHb+cuWQTblLO3u3N7v0a2JMUpLO2keGqpc9MMS
 uBv6/UjpfudXyLFOIoMOY4gWyhd++OKE1ROrMm5p0cRChMKvJ1+14JaNxvYAI/Bj+5RfhNyj6
 YHLwiYcATHWGngWFLu25MYyGNdT0uR/qKg9FjLwMmCaPJNEdHf+WurnIQWw9d4Sl0atDAla6t
 5sQdT7bsVWKfi+6jHsuvG4L9jFf35Hgf5AxtZaZXohPa07gV7wECIHTkX8VXNo2BFXiGkrPNr
 WnOW9yzAt54o18gsXPWnluR63hd/lRakoTl0voGPLxW23kNBQtHunMPXkrdFVqVF7ojk51dcQ
 dODSzRDnae080PGjlMZCpSj/VGqxgnH2g1pSz30NU4bHWDh5aR5gDF0xGbAiidOS3SCTPqymp
 CwqF3+8+QUazgkYJ2c/Ur80bfzzDIwDO6/Kkgu35b+foJq+1pavFif6eetK0TOfLpfUbcT7NT
 f3G7dWtiW0RCoxwMxSr6a4wIlL8rIBnaWfiLl3FFp0d3PKFMVqhnMe7+I5CeEQrHsnJrkCMsp
 Dr3nses78pnSP2haF+jeEJnsDNJxukrpb/Z0h+BIVHh5nF+8CTkhIN6pjPt479nLx7G1zpsgT
 1Kgwi2KisMF0/kKxcH7g4p7NhSqH/Pi4paj5p13hozwIsb58IfV2oeWSLgvt+p5XyBfBo/Dxq
 IDPH+erdtlTYjskyRIx3x+6qsroVnhHSeAM7LIN3cRVMbyS3fdNfrxqbZOYzZfYn8/rP+j8Vz
 v5I/tV0WsHp6pW4zEWzj1vynL2zHWkHGZIb7NYlNqyLbdrPwsoCi4ONLPEoAhiZonQ3d5QtkV
 WA3pitRp8DOCLL8P5
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 09:08:36
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

A few late fixes for target-hppa:

* Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian

* Fix the SeaBIOS-hppa firmware to boot NetBSD again

* Fix quite some artist framebuffer out-of-bounds accesses

in addition the SeaBIOS-hppa firmware now includes a version check to prev=
ent
starting when it's incompatible to the emulated qemu hardware.

The patchset can be pulled from
https://github.com/hdeller/qemu-hppa.git target-hppa

Helge

=2D---------------------------------------------------------------
Changes to v2:
* added more Acks by Richard Henderson
* added more artist framebuffer out-of-bounds fixes by
  Philippe Mathieu-Daud=C3=A9 which were reported by Alexander Bulekov
* fix NetBSD boot

Changes to v1:
* added Ack by Richard Henderson for the first patch
* revised out of bounds check based on Richards feedback

=2D---------------------------------------------------------------

Helge Deller (3):
      hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
      seabios-hppa: Update to SeaBIOS hppa version 1
      hw/hppa: Implement proper SeaBIOS version check

Sven Schnelle (1):
      hw/display/artist.c: fix out of bounds check

 hw/display/artist.c       |  18 ++++++------------
 hw/hppa/hppa_hardware.h   |   6 ++++++
 hw/hppa/lasi.c            |   2 --
 hw/hppa/machine.c         |  22 ++++++++++++++++++++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783144 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 35 insertions(+), 15 deletions(-)
=2D-
2.21.3

Helge Deller (5):
  hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
  seabios-hppa: Update to SeaBIOS hppa version 1
  hw/hppa: Implement proper SeaBIOS version check
  hw/hppa/lasi: Don't abort on invalid IMR value
  hw/display/artist: Prevent out of VRAM buffer accesses

Philippe Mathieu-Daud=C3=A9 (2):
  hw/display/artist: Check offset in draw_line to avoid buffer over-run
  hw/display/artist: Refactor artist_rop8() to avoid buffer over-run

Sven Schnelle (1):
  hw/display/artist.c: fix out of bounds check

 hw/display/artist.c       | 118 +++++++++++++++++++++++---------------
 hw/hppa/hppa_hardware.h   |   6 ++
 hw/hppa/lasi.c            |   9 +--
 hw/hppa/machine.c         |  22 +++++++
 pc-bios/hppa-firmware.img | Bin 766136 -> 783192 bytes
 roms/seabios-hppa         |   2 +-
 6 files changed, 106 insertions(+), 51 deletions(-)

=2D-
2.21.3


