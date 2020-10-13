Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A4C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AA42080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AA42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIrY-0000Xj-4Y
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpb-0006uU-Hn; Tue, 13 Oct 2020 07:51:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpZ-0004wr-3c; Tue, 13 Oct 2020 07:51:03 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdeKd-1jsh1t0lqj-00Zffy; Tue, 13 Oct 2020 13:50:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] Trivial branch for 5.2 patches
Date: Tue, 13 Oct 2020 13:50:38 +0200
Message-Id: <20201013115052.133355-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:62wsWN1o18RzL8ps23bUarLZNBlXaxY5Xy592iG7fo8ed9yqyME
 XHjp87KS1CQi9wIfgxG7E6wrxxd4ozpKEoSYp161JWXO1OmJ6oHu2EeMCFAZGD1YFQ3OIaG
 T8EP5vli0LCMzeZYCUlCnErEgf4fgVUzjsdKt9jFcD/oLwPjx2HHrqRGVwQ17n9/0fpyKnT
 D4ns/1fXyh60JNlB9L4UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZqIZ1HLLfZ0=:Xrm1YVwUnWXn+HgYN/35GS
 XNcgfY08Hs1Xed1VsmqruRlcKMbCDvbjjkNScSN1TlNFIWNNZscS9Qd8rw/eWdusf7bIBtHKj
 sxUwoGlJWmbbwMkI0VpvUhVQ7p3jidkuWZHewCbY7FX1j07cq5NwSUmJ4NGe6T0t5xtHxW5EC
 j/3fPwdZDlTGxxU0E3KKQPgEgTZqzyBgmox09faGVjLEQHv6IQeh+iXRT3vijhI0a4okvEu8w
 7YOnK8/+W4+RJS4gDNgK4dS77/LXOmonLWvhmmQBE3eI71O7LBwMFm3Iz53xGA3e/Eud0yMqG
 nHXZ6zu19K6n/OWCzU8OlFuJ8jXVc3IwRv0rBMH9bO3vS1d5QoxnQifnOP0tqugRz4gg5l78q
 yd9AoqplyGzJWBMqQ01DsHENfV8OJGTE4S7xUV3lK87xnAXoKC3FAj5pRuqweFJwf6nOKA+2J
 k9ByFl1EyidZiU6mjG0KGlH1Mn5YzHkgdu+A2a5QubAQz9xZtUKv0A6a+Um90dI1b5hLl0iTm
 NHsd+i37ZoKhFaq1az9n3edK/tXwK8KTQw7wPzDF+w1aVXRGDrj94dulfNPWvGTXo1toAmcsE
 3jEwQrc4+OTiy7M6TyhhJ9xM9QGOBBwzGZsTAW3AU5egG6WFiII9bUJYVwsQs3ZYf1Ohn2TML
 ODYmB3k2xfUTpApBO0kRvIjAk0NenSggVhay7EFM/L5Oj+EUExP483dmPdYCYQxJ+pUO3nGQl
 aOvh6oJj7I0CYrCAWH+bTV82bJevhm8FM6rMfBIoLzQyFwpiDCJi1i0XMgYAH1ozDnTAdKBnq
 DFqIltnwieoQMieSVwtoVxYpR4+oPmW/z1iFvky1AUUsYKlslTizczLeiN0/uoyecvDAR+t
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:50:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
for you to fetch changes up to 6125673eaf711247405e796604204bb7d74090f4:=0D
=0D
  meson.build: drop duplicate 'sparc64' entry (2020-10-13 13:33:46 +0200)=0D
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
Thomas Huth (1):=0D
  tests/test-char: Use a proper fallthrough comment=0D
=0D
 block/blkdebug.c            |  1 +=0D
 block/vmdk.c                |  8 ++++----=0D
 hw/acpi/piix4.c             |  4 ++--=0D
 hw/block/nvme.c             |  7 +------=0D
 hw/char/serial.c            |  1 -=0D
 hw/pci/pci.c                |  2 +-=0D
 hw/ppc/spapr_pci.c          |  2 +-=0D
 hw/rtc/goldfish_rtc.c       |  2 +-=0D
 meson.build                 |  2 +-=0D
 migration/dirtyrate.c       |  3 ++-=0D
 qemu-img-cmds.hx            |  2 +-=0D
 softmmu/memory.c            | 16 ++++++++++++++++=0D
 target/i386/cpu.c           |  3 ++-=0D
 target/sparc/int32_helper.c |  1 -=0D
 tests/test-bitmap.c         |  1 -=0D
 tests/test-char.c           |  2 +-=0D
 16 files changed, 34 insertions(+), 23 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

