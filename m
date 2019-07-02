Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCEC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561E120989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561E120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNxl-0001nj-M0
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50346)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLl3-0002uU-A2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hiLko-0007pZ-7I
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:35:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59807 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hiLkn-0007jL-OF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:35:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 4D8EB1A2180;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 343B31A1DD1;
 Tue,  2 Jul 2019 18:35:33 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:35:16 +0200
Message-Id: <1562085328-5126-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 00/12] MIPS queue for July 2nd, 2019
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

The following changes since commit d247c8e7f4fc856abf799c37ca9818514ddb08=
b7:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190701' into =
staging (2019-07-02 11:48:39 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-jul-02-2019

for you to fetch changes up to 698c5752c4e618dc17b4c78dfa566896c7bce5ef:

  target/mips: Correct helper for MSA FCLASS.<W|D> instructions (2019-07-=
02 14:20:42 +0200)

----------------------------------------------------------------

MIPS queue for July 2nd, 2019

Note:

  - a checkpatch warning on updating MAINTAINERS should be ignored

Highlights:

  - introduced limited Kconfig support for MIPS machines
  - updated "machine-none" tests
  - cleaned up translate.c and msa_helper.c
  - minor MSA emulation improvements
  - updated MSA tests

----------------------------------------------------------------

Aleksandar Markovic (7):
  tcg/tests: target/mips: Amend MSA fixed point multiply tests
  tcg/tests: target/mips: Amend MSA integer multiply tests
  tcg/tests: target/mips: Correct MSA test compilation and execution
    order
  target/mips: Correct comments in translate.c
  target/mips: Correct comments in msa_helper.c
  target/mips: Unroll loops for MSA float max/min instructions
  target/mips: Correct helper for MSA FCLASS.<W|D> instructions

Philippe Mathieu-Daud=C3=A9 (5):
  tests/machine-none: Test recent MIPS cpus
  hw/mips: Explicit the semi-hosting feature is always required
  hw/mips: Express dependencies of the MIPSsim machine with Kconfig
  hw/mips: Express dependencies of the Jazz machine with Kconfig
  hw/mips: Express dependencies of the r4k platform with Kconfig

 default-configs/mips-softmmu-common.mak            |   7 +-
 default-configs/mips64-softmmu.mak                 |   5 -
 default-configs/mips64el-softmmu.mak               |   5 -
 hw/mips/Kconfig                                    |  30 ++
 target/mips/msa_helper.c                           | 260 +++++++----
 target/mips/translate.c                            | 497 +++++++++++++--=
------
 tests/machine-none-test.c                          |   4 +-
 tests/tcg/mips/include/wrappers_msa.h              |  16 +
 .../ase/msa/fixed-multiply/test_msa_madd_q_h.c     | 216 +++++++++
 .../ase/msa/fixed-multiply/test_msa_madd_q_w.c     | 216 +++++++++
 .../ase/msa/fixed-multiply/test_msa_maddr_q_h.c    | 216 +++++++++
 .../ase/msa/fixed-multiply/test_msa_maddr_q_w.c    | 216 +++++++++
 .../ase/msa/fixed-multiply/test_msa_msub_q_h.c     | 216 +++++++++
 .../ase/msa/fixed-multiply/test_msa_msub_q_w.c     | 216 +++++++++
 .../ase/msa/fixed-multiply/test_msa_msubr_q_h.c    | 216 +++++++++
 .../ase/msa/fixed-multiply/test_msa_msubr_q_w.c    | 216 +++++++++
 .../user/ase/msa/int-multiply/test_msa_maddv_b.c   | 224 +++++-----
 .../user/ase/msa/int-multiply/test_msa_maddv_d.c   | 214 ++++-----
 .../user/ase/msa/int-multiply/test_msa_maddv_h.c   | 224 +++++-----
 .../user/ase/msa/int-multiply/test_msa_maddv_w.c   | 224 +++++-----
 .../user/ase/msa/int-multiply/test_msa_msubv_b.c   | 224 +++++-----
 .../user/ase/msa/int-multiply/test_msa_msubv_d.c   | 224 +++++-----
 .../user/ase/msa/int-multiply/test_msa_msubv_h.c   | 224 +++++-----
 .../user/ase/msa/int-multiply/test_msa_msubv_w.c   | 224 +++++-----
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   |  32 +-
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   |  32 +-
 .../mips/user/ase/msa/test_msa_compile_64r6eb.sh   |  32 +-
 .../mips/user/ase/msa/test_msa_compile_64r6el.sh   |  32 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh |  16 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh |  16 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6eb.sh |  16 +-
 tests/tcg/mips/user/ase/msa/test_msa_run_64r6el.sh |  16 +-
 32 files changed, 3297 insertions(+), 1229 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
add_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
add_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
addr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
addr_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
sub_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
sub_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
subr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/fixed-multiply/test_msa_m=
subr_q_w.c

--=20
2.7.4


