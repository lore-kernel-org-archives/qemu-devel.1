Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68262C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B36D20797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B36D20797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSED8-0006aG-FY
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBW-0004vM-PG; Tue, 13 Oct 2020 02:53:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBU-0000Dy-UO; Tue, 13 Oct 2020 02:53:22 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3DBd-1kT2av35bR-003ePW; Tue, 13 Oct 2020 08:53:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] Trivial branch for 5.2 patches
Date: Tue, 13 Oct 2020 08:52:58 +0200
Message-Id: <20201013065313.7349-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uIZSGJka0sLXeoNUzhf3XdpAdnHsBRNj813yKbvyQSuLUuB9PqF
 +F+3+LGmHpdsQavaUtqmv53QWTaoNESQm4I262vCAFomB9rfXG/MFDCoh7cCsTxemKKj3oL
 yeIdgFnhse6iRW3ekVbhRL0fD7YR/DdJv246oxxS98o7tBUH7bXKqqasQx/WBb17Y+BQ9FE
 OMWGb6XXrQYsNISULqCzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pvObdF34zO4=:LODujIsST7wDaZk9BqnKeu
 cyWvANP91NvUOIOcS8mHUa+kJznuWtt+k6elgS5BY4+peuO/UfCuoM7T/m5/oN963ksBrYocM
 hl7EoXzOySUaaGCd73QtIIkZvoKPF4zXYB8wvM07fmplye8z+0XO0y92ArkCDYkNTDKF2OGSP
 KVwlia79vyQqRtHaJAl1LgpePxjEM+/llie1U9T0Kw/3hQW7eT3PDVcaYxsaR+oo4E/4zr1vO
 UKgYMtE50Y/LgDFYaGCdV1X+rqj9GOwOHtBK02bJr1HWFlYff/XwyJ8RI3/PEJgz+jv4dtegT
 nzcaXIbRYEv2DF9udn2WdiBmdw9nsU3DJcTfd09wiWNoGltwiZsFpDbdKEogpY/tvoHDx3GQg
 HlKHSh46ee7STDM1RISaXfakZm1q6ax7E8zO5T7vLvnwZWv6lbeAi59z3BR7LlRwZZvdnav3b
 z3uqeXCGwR8De/x5Jw/WnTETb/dVK/I7OnkwvwrCo0vgiqGcXZkG066RvxM9F5XTbpUaFA5p8
 kQHyaL5X0KKlL4YS9lnkd1KmaKymCrc4s/PUS7V9Nr7D9PpZFwn6QwAQqEn92EZq9lW4l0Gaq
 MDJvxoQnl8HjsSSHNt57g2icYhXt1uPl9gcBx9r4IanRyUV8wGUUbWTpv+5r5V7Js8LypU2dO
 JkoK0bk95Mag32EGHoe36eyn7NaEPQmhwr2QIgKq7oIpx3oDA5WNjFnmYXO8x16piId2Y4oSb
 vYpDhU1Uy1/DIGr5pOdCrfAAx7UOTPG0twWeRPe4UvkpGfmccHjX9UHMVrk6i6UMkiXxZgAfH
 7oRnO5zDcHQfIK+lZy6mo8ouZP5JZhf5zr/XUotTAozOvUYCQAnK2lbtBXh1NKZfb4ybUVR
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2ef54=
:=0D
=0D
  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-10' i=
nt=3D=0D
o staging (2020-10-12 11:29:42 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request=
=0D
=0D
for you to fetch changes up to ef3a1d9fc36140f8933fbced70ee21fd9740b33c:=0D
=0D
  meson.build: drop duplicate 'sparc64' entry (2020-10-12 23:11:32 +0200)=0D
=0D
----------------------------------------------------------------=0D
Trivial Patches Pull request 20201013=0D
=0D
----------------------------------------------------------------=0D
=0D
Christian Borntraeger (1):=0D
  vmdk: fix maybe uninitialized warnings=0D
=0D
Elena Afanasova (1):=0D
  block/blkdebug: fix memory leak=0D
=0D
Greg Kurz (1):=0D
  hw/acpi/piix4: Rename piix4_pm_add_propeties() to=0D
    piix4_pm_add_properties()=0D
=0D
Julia Suvorova (1):=0D
  hw/pci: Fix typo in PCI hot-plug error message=0D
=0D
Laurent Vivier (2):=0D
  hw/char/serial: remove duplicate .class_init in serial_mm_info=0D
  goldfish_rtc: change MemoryRegionOps endianness to=0D
    DEVICE_NATIVE_ENDIAN=0D
=0D
Marc-Andr=3DC3=3DA9 Lureau (1):=0D
  mingw: fix error __USE_MINGW_ANSI_STDIO redefined=0D
=0D
Markus Armbruster (2):=0D
  qemu-img-cmds.hx: Update comment that mentions Texinfo=0D
  target/i386/cpu: Update comment that mentions Texinfo=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (3):=0D
  hw/block/nvme: Simplify timestamp sum=0D
  softmmu/memory: Log invalid memory accesses=0D
  target/sparc/int32_helper: Remove duplicated 'Tag Overflow' entry=0D
=0D
Sergei Trofimovich (1):=0D
  meson.build: drop duplicate 'sparc64' entry=0D
=0D
Thomas Huth (2):=0D
  hw/rtc/twl92230: Silence warnings about missing fallthrough statements=0D
  tests/test-char: Use a proper fallthrough comment=0D
=0D
 block/blkdebug.c            |  1 +=0D
 block/vmdk.c                |  8 +++---=0D
 hw/acpi/piix4.c             |  4 +--=0D
 hw/block/nvme.c             |  7 +-----=0D
 hw/char/serial.c            |  1 -=0D
 hw/pci/pci.c                |  2 +-=0D
 hw/ppc/spapr_pci.c          |  2 +-=0D
 hw/rtc/goldfish_rtc.c       |  2 +-=0D
 hw/rtc/twl92230.c           | 50 ++++++++++++++++++-------------------=0D
 meson.build                 |  2 +-=0D
 migration/dirtyrate.c       |  3 ++-=0D
 qemu-img-cmds.hx            |  2 +-=0D
 softmmu/memory.c            | 16 ++++++++++++=0D
 target/i386/cpu.c           |  3 ++-=0D
 target/sparc/int32_helper.c |  1 -=0D
 tests/test-bitmap.c         |  1 -=0D
 tests/test-char.c           |  2 +-=0D
 17 files changed, 58 insertions(+), 49 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

