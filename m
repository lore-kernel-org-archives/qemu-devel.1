Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCCCC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AF320879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AF320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWjZ-0001mk-H0
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:17:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWRx-0003DN-R8
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hTWRw-0000Mw-Ov
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:58:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60453 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hTWRw-0000Lj-Gz
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:58:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 5BCBE1A4165;
	Wed, 22 May 2019 20:58:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 4357F1A2160;
	Wed, 22 May 2019 20:58:49 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 20:58:31 +0200
Message-Id: <1558551522-24147-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL v2 00/11] MIPS queue for May 19th, 2019 - v2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit a4f667b6714916683408b983cfe0a615a72577=
5f:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' int=
o staging (2019-05-21 16:30:13 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019-v2

for you to fetch changes up to 9a89468145b8a3e53e508992f54061427c52780f:

  BootLinuxSshTest: Test some userspace commands on Malta (2019-05-22 20:=
10:46 +0200)

----------------------------------------------------------------

MIPS queue for May 19th, 2019 - v2

v1-v2:
   - fixed missing invocations in patch on ST.<B|H|W|D> that caused
     clang build error
   - added a patch on acceptance test for Malta

overall content:

   * Improved usage of object_initialize() and object_initialize_child()
   * Added an acceptance test for Malta board
   * Better handling of memory pages (flag PAGE_EXEC)
   * A set of fixes for emulation of MSA ASE on big endian hosts
   * Better handling of 'div by zero' cases of MSA ASE instructions

----------------------------------------------------------------

Jakub Jerm=C3=A1=C5=99 (1):
  mips: Decide to map PAGE_EXEC in map_address

Mateja Marjanovic (7):
  target/mips: Make the results of DIV_<U|S>.<B|H|W|D> the same as on
    hardware
  target/mips: Make the results of MOD_<U|S>.<B|H|W|D> the same as on
    hardware
  target/mips: Fix MSA instructions LD.<B|H|W|D> on big endian host
  target/mips: Fix MSA instructions ST.<B|H|W|D> on big endian host
  target/mips: Refactor and fix COPY_S.<B|H|W|D> instructions
  target/mips: Refactor and fix COPY_U.<B|H|W> instructions
  target/mips: Refactor and fix INSERT.<B|H|W|D> instructions

Philippe Mathieu-Daud=C3=A9 (3):
  hw/mips: Use object_initialize() on MIPSCPSState
  hw/mips: Use object_initialize_child for correct reference counting
  BootLinuxSshTest: Test some userspace commands on Malta

 MAINTAINERS                              |   1 +
 hw/mips/boston.c                         |  25 +-
 hw/mips/cps.c                            |  20 +-
 hw/mips/mips_malta.c                     |  17 +-
 target/mips/helper.c                     |  13 +-
 target/mips/helper.h                     |  16 +-
 target/mips/msa_helper.c                 | 191 ++++++++++-----
 target/mips/op_helper.c                  | 388 +++++++++++++++++++++++++=
++----
 target/mips/translate.c                  |  59 ++++-
 tests/acceptance/linux_ssh_mips_malta.py | 229 ++++++++++++++++++
 tests/requirements.txt                   |   1 +
 11 files changed, 817 insertions(+), 143 deletions(-)
 create mode 100644 tests/acceptance/linux_ssh_mips_malta.py

--=20
2.7.4


