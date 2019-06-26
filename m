Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4882FC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C852133F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C852133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6dz-0006EP-84
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NG-0001KI-Rg
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NE-0005t8-EK
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60629 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg6NE-0005nM-1e
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7AAE01A464C;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 5ECE71A20B4;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 13:45:33 +0200
Message-Id: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 00/17] MIPS queue for June 2016th, 2019
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeac=
de:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-=
2019' into staging (2019-06-21 15:40:50 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-jun-26-2019

for you to fetch changes up to 5a6a1fabfcbbdf7808aaa8e906fee86ed6eb37e7:

  target/mips: Fix big endian host behavior for interleave MSA instructio=
ns (2019-06-26 13:25:56 +0200)

----------------------------------------------------------------

MIPS queue for June 2016th, 2019

Note:

  - seven checkpatch warnings on updating MAINTAINERS can be ignored

Highlights:

  - cleanups and fixes for Malta's gt64xxx PCI controller
  - cleanups and fixes for Jazz'src4030 DMA controller
  - improvements of MSA TCG tests
  - fix for big endian host interleave instructions behavior

----------------------------------------------------------------

Aleksandar Markovic (10):
  dma/rc4030: Fix off-by-one error in specified memory region size
  dma/rc4030: Minor code style cleanup
  tests/tcg: target/mips: Add tests for MSA bit move instructions
  tests/tcg: target/mips: Add tests for MSA move instructions
  tests/tcg: target/mips: Amend tests for MSA int dot product
    instructions
  tests/tcg: target/mips: Amend tests for MSA int multiply instructions
  tests/tcg: target/mips: Add support for MSA big-endian target testings
  tests/tcg: target/mips: Add support for MSA MIPS32R6 testings
  tests/tcg: target/mips: Fix some test cases for pack MSA instructions
  target/mips: Fix big endian host behavior for interleave MSA
    instructions

Philippe Mathieu-Daud=C3=A9 (7):
  hw/mips/gt64xxx_pci: Fix multiline comment syntax
  hw/mips/gt64xxx_pci: Fix 'tabs' coding style issues
  hw/mips/gt64xxx_pci: Fix 'braces' coding style issues
  hw/mips/gt64xxx_pci: Fix 'spaces' coding style issues
  hw/mips/gt64xxx_pci: Use qemu_log_mask() instead of debug printf()
  hw/mips/gt64xxx_pci: Convert debug printf()s to trace events
  hw/mips/gt64xxx_pci: Align the pci0-mem size

 Makefile.objs                                      |   1 +
 hw/dma/rc4030.c                                    |  21 +-
 hw/mips/gt64xxx_pci.c                              | 494 ++++++++-------=
-
 hw/mips/trace-events                               |   4 +
 target/mips/msa_helper.c                           |  24 +-
 tests/tcg/mips/include/wrappers_msa.h              |  96 +++-
 .../mips/user/ase/msa/bit-move/test_msa_binsl_b.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_d.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_h.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsl_w.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_b.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_d.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_h.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_binsr_w.c  | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_bmnz_v.c   | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_bmz_v.c    | 214 +++++++
 .../mips/user/ase/msa/bit-move/test_msa_bsel_v.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_s_w.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpadd_u_w.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_s_w.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_d.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_h.c   | 214 +++++++
 .../ase/msa/int-dot-product/test_msa_dpsub_u_w.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_b.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_h.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_w.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_b.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_d.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_h.c   | 214 +++++++
 .../user/ase/msa/int-multiply/test_msa_msubv_w.c   | 214 +++++++
 tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c | 149 +++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  |  64 +--
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  |  64 +--
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  |  64 +--
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  |  64 +--
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  |  64 +--
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  |  64 +--
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  |  64 +--
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  |  64 +--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c |  64 +--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c |  64 +--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c |  64 +--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c |  64 +--
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   | 627 +++++++++++++++=
++++++
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   | 627 +++++++++++++++=
++++++
 .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   | 627 +++++++++++++++=
++++++
 ...t_msa_compile.sh =3D> test_msa_compile_64r6el.sh} | 561 ++++++++++---=
-----
 tests/tcg/mips/user/ase/msa/test_msa_run.sh        | 326 -----------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh | 363 ++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh | 363 ++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh | 363 ++++++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh | 363 ++++++++++++
 59 files changed, 11201 insertions(+), 1210 deletions(-)
 create mode 100644 hw/mips/trace-events
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_b=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_d=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_h=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsl_w=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_b=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_d=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_h=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_binsr_w=
.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmnz_v.=
c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bmz_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-move/test_msa_bsel_v.=
c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpadd_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_=
dpsub_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mad=
dv_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_msu=
bv_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/move/test_msa_move_v.c
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.s=
h
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.s=
h
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_64r6eb.s=
h
 rename tests/tcg/mips/user/ase/msa/{test_msa_compile.sh =3D> test_msa_co=
mpile_64r6el.sh} (77%)
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run.sh
 create mode 100644 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh

--=20
2.7.4


