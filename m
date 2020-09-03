Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8692B20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TT6IsSfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8692B20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrpj-0001DP-Ce
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmV-0007tl-PG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:52785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmT-0007kP-F1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149269;
 bh=iT4Q3QIiZyy40ihhg4Ko2Brtk1nIuCu1PMhwJ/hpyOU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=TT6IsSfAzVKlYuEgmHSxxO6zQZgHNFYhikm9YMgWaiKUhVGm/5csWcxRcy+fNygfl
 bQ/nkaXZc6vcB4mTn0C9kcp+e1HVHW7Qd7XjodzHPHCFLtH7hklsCLN9tYYRMc3gRZ
 4Li3LcuTMI9Snv2981gFfu9Xj7dnGVAo7xTwLYxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wLT-1kBw6A0ZZL-007U4b; Thu, 03
 Sep 2020 18:07:49 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 00/10] hppa power button support,
 graphics updates and firmware fixes
Date: Thu,  3 Sep 2020 18:07:36 +0200
Message-Id: <20200903160746.27491-1-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1vwyasTcwHJaG6yDyQ33qv8Mwz8nST/b39sgd0EEt3S3TPI5fYS
 hALshO6nxIA5JBnAaeEwqtE5rOCOi8Y6HTU7xoCss3r8BSGVwbWmL3E5UVG7HAKu/cIMC1K
 iG470WL8dLg3d42AVuEaMSgkPr/5BCB+8xfkTzmF0pU9ItEkPkA/vLHZMPzrkJc9xvcuk5E
 f0n0Yi3VMto7xO0gxwDhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DsJscsk/WGo=:DQPW17XXiP+iDEFXPndVBx
 4AJJ1ihWEB3N2IcDtat9H+Q6TTXx9hPci7Q5OTvMxxx6O6qfJhtJ0HeN1PU4GAzxjblkXZE7r
 iepsFEnI1VvbB4MlSO5TW0ewqDdB3IEUyLjgQOt9kyHXedytffj7/wZdAJXUtQPmngSPkhqWT
 XZyVfI9vbeBjs7a4/40X0Zhh+7vsqpFIQ6zQHGSt8umgk9Cv6u80cxfjytvPB4rgost/0GWP6
 sQNMpltO5+R5fw4nt39oN6I0bYxrcVR2ilugFFD4ZxU+CdyoqcJZvFkI7z6rAstSqIcVsSSTl
 z2cu3imL/CroInRzxWtSRCQHzR7DXYhaixIe2da+AGtqK+OS4wn6F0w6lsj1dcE8Pvaob27gJ
 OTTQ9xgkSx1/YVu+wpVBU7YWAEJjGKFd6C64lrlQNNiOLMwrfhx/GOvhZTcdZOhSY7Zh3tiAM
 6eARGv3/iUHNu1XTr0nqdlfWbmnQNhJ/iXMVpyNEgO59c2BmmmyX9jvL3jeeQ4zdozKRyOVB7
 /VWYVw8NWa2oYaGN8g6p++KaXSgtK/jNmqBPeBkO099R2MJ59xO5gr9Tbd5tabMn73H5bcLKV
 kE6mKylDJDi1MKBkyTOLpz1j0WDIcZq048IM2a/29XOUkatxOPM4iwze5WpLVcA1ndaHUTvqt
 SDRH5E7H6+91knLuKEadb/K1srnKns/J3bQ3de3V+Ci9EWnCHanD5Q+Wu9vy+XEp3hdBnferS
 u3L61Xt5wxThri3PaeqkN+Tn/y2RVFuS8vjq/YQ0TSkzQQetJWMqD2H6tUvQaies+8UE3OIzX
 PGJdWVnCxnjbFsK6/9qTXUBj4fjRtydbr1QYHvugS/bynEz+Q3Lf+FSfcczn2jYggQnIXBxxu
 ETCJOOJjza7ft8J1ctKQ9bQhxNRuijCsm66hdSAWpGqfFioo135ClUGv1HJoe+VIQM7GxIvFu
 HD/LKoaLR8gURgSTabNeNe4QWHaXgmANgSRcRdl/GHFs1dJJzBIRxBNOxy4nmCxGNwfv67gAi
 /YlDVWgxio+S2TEzy2evuHuvWjLmQTEQEmvmMcoNWRU1UPTtm+fk3LqAt+PzhqrY6JhQBNKos
 hux4SgxWDKdu7D7UkNkv9SUhhGSHjQkk/rQtLPUmLAqgsYhK874ubZVHYClh38XwZxVip40YC
 rdUjP55cLeonUJ+XRb3wynoXKNk8QGqShCV956mGd09W0QP0/5m5La/VIYFkgWsKI0XvSaPKn
 LTzgbM62d6dkJneyz
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

hppa power button support, graphics updates and firmware fixes

The following changes since commit ac8b279f13865d1a4f1958d3bf34240c1c3af90=
d:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200827' into s=
taging (2020-08-27 13:48:12 +0100)

are available in the Git repository at:

   https://github.com/hdeller/qemu-hppa.git tags/target-hppa-pull-request

for you to fetch changes up to 32a2b033f0a406c0dd4cc7375367ee63cc36789a:

  hw/display/artist: Allow screen size up to 2048 lines (2020-09-03 17:30:=
04 +0200)

=2D---------------------------------------------------------------

Helge Deller (10):
  seabios-hppa: Update SeaBIOS to hppa-qemu-5.2-2 tag
  hw/hppa: Make number of TLB and BTLB entries configurable
  hw/hppa: Store boot device in fw_cfg section
  hw/hppa: Change fw_cfg port address
  hw/hppa: Tell SeaBIOS port address of fw_cfg
  hw/hppa: Add power button emulation
  target/hppa: Fix boot with old Linux installation CDs
  hw/display/artist: Verify artist screen resolution
  hw/display/artist: Refactor x/y coordination extraction
  hw/display/artist: Allow screen size up to 2048 lines

 hw/display/artist.c       |  43 +++++++++++++++++++----------
 hw/hppa/hppa_hardware.h   |   3 +-
 hw/hppa/machine.c         |  56 +++++++++++++++++++++++++++++++++++++-
 pc-bios/hppa-firmware.img | Bin 783192 -> 785696 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.h         |   5 +++-
 target/hppa/insns.decode  |  10 +++----
 7 files changed, 95 insertions(+), 24 deletions(-)

=2D-
2.21.3


