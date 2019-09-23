Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63019C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3558C20665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3558C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOc5-0000Rv-Nr
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCOZq-0007Hj-8x
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCOZp-0007Wt-1q
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCOZo-0007Wj-TO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:40:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C56E1302C066;
 Mon, 23 Sep 2019 13:40:26 +0000 (UTC)
Received: from dhcp-17-179.bos.redhat.com (dhcp-17-179.bos.redhat.com
 [10.18.17.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52C7919C58;
 Mon, 23 Sep 2019 13:40:20 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 0/7] Python (acceptance tests) queue - 2019-09-23
Date: Mon, 23 Sep 2019 09:40:12 -0400
Message-Id: <20190923134019.8548-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 23 Sep 2019 13:40:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4300b7c2cd9f3f273804e8cca325842ccb93b1=
ad:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-requ=
est' into staging (2019-09-20 17:28:43 +0100)

are available in the Git repository at:

  git://github.com/clebergnu/qemu.git tags/python-next-pull-request

for you to fetch changes up to 2fe6f4d9babb957244676fdf23b9a7ca2323034b:

  Acceptance tests: use avocado.utils.ssh for SSH interaction (2019-09-20=
 17:13:41 -0400)

----------------------------------------------------------------
Improvements include:

 * Relaxed error code pattern on machine_m68k_nextcube.py
 * Better naming and separation of tests in x86_cpu_model_versions.py
 * New checks on guest side on linux_ssh_mips_malta.py
 * Use of avocado.utils.ssh, and thus "/usr/bin/ssh" for SSH
   interaction

A Travis-CI check for this branch can be seen at:

 * https://travis-ci.org/clebergnu/qemu/builds/587665790

----------------------------------------------------------------

Aleksandar Markovic (2):
  tests/acceptance: Refactor and improve reporting in
    linux_ssh_mips_malta.py
  tests/acceptance: Add new test cases in linux_ssh_mips_malta.py

Cleber Rosa (5):
  Acceptance test machine_m68k_nextcube.py: relax the error code pattern
  Acceptance test x86_cpu_model_versions: shutdown VMs
  Acceptance test x86_cpu_model_versions: fix mismatches between test
    and messages
  Acceptance test x86_cpu_model_versions: split into smaller tests
  Acceptance tests: use avocado.utils.ssh for SSH interaction

 tests/acceptance/linux_ssh_mips_malta.py   | 159 ++++++++++++---------
 tests/acceptance/machine_m68k_nextcube.py  |   2 +-
 tests/acceptance/x86_cpu_model_versions.py |  22 ++-
 tests/requirements.txt                     |   3 +-
 4 files changed, 110 insertions(+), 76 deletions(-)

--=20
2.21.0


