Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F58C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026BE20657
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 16:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026BE20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57297 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUw72-0002f5-3H
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 12:35:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hUvx3-0002p2-9G
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hUvsi-0007Nb-VJ
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:20:22 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35904 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hUvsi-0006sb-NZ
	for qemu-devel@nongnu.org; Sun, 26 May 2019 12:20:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 4B3A51A4B8C;
	Sun, 26 May 2019 18:19:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 308581A4800;
	Sun, 26 May 2019 18:19:16 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 18:18:59 +0200
Message-Id: <1558887551-32137-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 00/12] MIPS queue for May 19th, 2019 - v3
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

The following changes since commit a7b21f6762a2d6ec08106d8a7ccb1182991452=
3f:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-05-24 12:47:49 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019-v3

for you to fetch changes up to c47c336e870585307f1e2371ea85a6256a05022e:

  BootLinuxSshTest: Test some userspace commands on Malta (2019-05-26 17:=
45:02 +0200)

----------------------------------------------------------------

MIPS queue for May 19th, 2019 - v3


v2->v3:
   - removed two patches on object_initialize_child(), since they
     became part of another pull 1-pull-request
   - added two cleanup patches
   - added a patch on fixing handling of semtimedop()
   - amended patch on acceptance test
v1->v2:
   - fixed missing invocations in patch on ST.<B|H|W|D> that caused
     clang build error
   - added a patch on acceptance test for Malta

highlights:

   * Fix semtimedop() issue that appeared after kernel headers update
   * Added an acceptance test for Malta board
   * Better handling of memory pages (flag PAGE_EXEC)
   * A set of fixes for emulation of MSA ASE on big endian hosts
   * Better handling of 'div by zero' cases of MSA ASE instructions
   * Clean up MIPS' cpu.h

----------------------------------------------------------------


Jakub Jerm=C3=A1=C5=99 (1):
  mips: Decide to map PAGE_EXEC in map_address

Jules Irenge (2):
  target/mips: add or remove space to fix checkpatch errors
  target/mips: realign comments to fix checkpatch warnings

Laurent Vivier (1):
  linux-user: fix __NR_semtimedop undeclared error

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

Philippe Mathieu-Daud=C3=A9 (1):
  BootLinuxSshTest: Test some userspace commands on Malta

 MAINTAINERS                              |   1 +
 linux-user/syscall.c                     |  24 +-
 target/mips/cpu.h                        | 209 +++++++++--------
 target/mips/helper.c                     |  13 +-
 target/mips/helper.h                     |  16 +-
 target/mips/msa_helper.c                 | 191 ++++++++++-----
 target/mips/op_helper.c                  | 388 +++++++++++++++++++++++++=
++----
 target/mips/translate.c                  |  59 ++++-
 tests/acceptance/linux_ssh_mips_malta.py | 230 ++++++++++++++++++
 tests/requirements.txt                   |   1 +
 10 files changed, 922 insertions(+), 210 deletions(-)
 create mode 100644 tests/acceptance/linux_ssh_mips_malta.py

--=20
2.7.4


