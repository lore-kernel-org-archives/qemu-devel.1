Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B307C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B4522208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B4522208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGop4-0004KQ-04
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonj-0002Xw-11; Fri, 11 Sep 2020 15:33:39 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGong-0000nO-NJ; Fri, 11 Sep 2020 15:33:38 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtPzy-1kWZpT2vnS-00upci; Fri, 11 Sep 2020 21:33:34 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Trivial branch for 5.2 patches
Date: Fri, 11 Sep 2020 21:33:12 +0200
Message-Id: <20200911193330.1148942-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uf1ImHGN3hTCyItTuo1NSRy+QQeqZKpPch5ylqEbMnYLi5mncEh
 /phlRp2Peq37BptkEMxOeOX4Q0UB+xGrm0Xqrki/ekT9Zyql9WxNbpvG3Ht4b0hURQzc/MN
 KkLvSdWQvBSnlydZxZ4kzdLmJOuwbHuCsizZmpy6xDnJ0Y+wo3xOC5nDAJMuEAPL9dQbE8f
 B1IzdaYrozXGwzqM/8aug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p3sUHaW7zsE=:7+ynzq724ge7URL9KWOMuF
 1kGRGrwe/9WHiE7nzReq1eDB7iJdiuKtdkrHGrZeMNiqEK/HRMZYzPyQn+Uh8Ozl+N0PpqC2J
 i3jtNAGKyi+NNaRQn20A+97ZwKQHBEFr4HiJ6yeMDwnvEngeeW6xZT6MAT3vW4bIv2dLicA1e
 qcoDQxBhtiIP4lf7RemVigJko4mXXpTTUnvnSH5juxirtXdx9shiHD0ZnzRW4aWyFBYDCJ4FX
 2YFN9S/Et/dvbaMx15kBFrgDB2ixTIWnqU4qoYf7wyHWRr3oDT/geH0pZZ215KBir/4TiKiVu
 IBzS7zlA6aHOrImDOpNKfgDymekkJiJgJHCIqRwz68Aeih59H1jwYL3DsTgx6UVmeB80ihGVO
 kyb6yZmIoOg16tW8j2ouX417OFi6M/NdnJ25aHMQwMycrTHMUdYTHleTyDbkcX8A1CahzwzHE
 9sMo44+9wjW0Ru7hEUmxBHNATVKLHyLiJTUgGamCsBuEG03SdeyGuXjdDS5JrAbIX7jV6eqhQ
 cG5Diz6y/fdtIn88UlVlxEo6HNRR99RePoQBmfqeuNLR+KgZRbeSX/7jNdF7bh+IKbMz5yW3o
 g/Z4rnl0B5Qo4nTPJg+thLNFLy1OCgk5cYxPO93V+WuReol3iRWmthCip9nXIBd0a1Kxf7L7G
 KEENJTmIH5MEIteABiXO8v8s6io6xkGo3kSX4i6jjcAZfP8jHjv73yJLv1/5jKHbKc8lcYEyO
 Jl5hh3PblczWzdoKu9ZVNeLP7747mZXuEiRcBnD7ZXyqgiHHs/i+/Af2ekXyBCigN3drhivuT
 4GpGnq1mJAYiUaaVDNeDgi4kxHAMbyNIhSGrWVBWqgejpQ+IIqL+8b1dBHNIn68L6yq8AZx
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:34
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-pu=
ll=3D=0D
-request' into staging (2020-09-08 21:21:13 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request=
=0D
=0D
for you to fetch changes up to 8821e21414468b1810f0ccf38bcbfa5c0bd1d56b:=0D
=0D
  target/i386/kvm: Add missing fallthrough comment (2020-09-11 21:25:59 +02=
00)=0D
=0D
----------------------------------------------------------------=0D
trivial patches pull request 20200911=0D
=0D
----------------------------------------------------------------=0D
=0D
Greg Kurz (2):=0D
  Makefile: Drop extra phony cscope=0D
  Makefile: Skip the meson subdir in cscope/TAGS/ctags=0D
=0D
Jon Doron (1):=0D
  hw: hyperv: vmbus: Fix 32bit compilation=0D
=0D
Pan Nengyuan (1):=0D
  test-vmstate: remove unnecessary code in match_interval_mapping_node=0D
=0D
Paolo Bonzini (1):=0D
  kconfig: fix comment referring to old Makefiles=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (10):=0D
  hw/mips/fuloong2e: Convert pointless error message to an assert()=0D
  hw/isa/isa-bus: Replace hw_error() by assert()=0D
  hw/acpi/tco: Remove unused definitions=0D
  hw/gpio/omap_gpio: Replace fprintf() by qemu_log_mask(GUEST_ERROR)=0D
  hw/gpio/max7310: Replace disabled printf() by qemu_log_mask(UNIMP)=0D
  hw/net/e1000e: Remove overwritten read handler for STATUS register=0D
  hw/net/e1000e: Remove duplicated write handler for FLSWDATA register=0D
  target/i386/kvm: Rename host_tsx_blacklisted() as host_tsx_broken()=0D
  util/hexdump: Convert to take a void pointer argument=0D
  util/hexdump: Reorder qemu_hexdump() arguments=0D
=0D
Sergei Trofimovich (1):=0D
  meson.build: tweak sdl-image error message=0D
=0D
Thomas Huth (2):=0D
  hw/arm/pxa2xx: Add missing fallthrough comment=0D
  target/i386/kvm: Add missing fallthrough comment=0D
=0D
 Kconfig.host             |  4 ++--=0D
 Makefile                 | 10 ++++++----=0D
 hw/acpi/tco.c            | 11 -----------=0D
 hw/arm/pxa2xx.c          |  2 +-=0D
 hw/dma/xlnx_dpdma.c      |  2 +-=0D
 hw/gpio/max7310.c        | 11 +++++------=0D
 hw/gpio/omap_gpio.c      |  6 ++++--=0D
 hw/hyperv/vmbus.c        |  3 ++-=0D
 hw/isa/isa-bus.c         |  9 ++-------=0D
 hw/mips/fuloong2e.c      |  5 +----=0D
 hw/net/e1000e_core.c     |  2 --=0D
 hw/net/fsl_etsec/etsec.c |  2 +-=0D
 hw/net/fsl_etsec/rings.c |  2 +-=0D
 hw/sd/sd.c               |  2 +-=0D
 hw/usb/redirect.c        |  2 +-=0D
 include/qemu-common.h    |  3 ++-=0D
 meson.build              |  4 ++--=0D
 net/colo-compare.c       | 24 ++++++++++++------------=0D
 net/net.c                |  2 +-=0D
 target/i386/kvm.c        |  5 +++--=0D
 tests/test-vmstate.c     |  3 ---=0D
 util/hexdump.c           |  4 +++-=0D
 util/iov.c               |  2 +-=0D
 23 files changed, 52 insertions(+), 68 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

