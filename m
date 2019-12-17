Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA4C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1F42072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8IuKC2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1F42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5qW-0000GX-1L
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5Cx-0002fr-Dv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5Cu-0002i2-G1
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:15:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58743
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5Cu-0002gC-1K
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JDQlI9YtfdQWY+I/b1E9Nm+m+EWu2E/yN3bQtYZuyYw=;
 b=G8IuKC2BTOR+U85jbEUZasNzbwJxcIkNFECd69hM073NOkS0+8qb5BngwoMNa9VP+CZOto
 aIuUfjdqTnmXB9FCM4Qhq96NptVrBK2wtlGLNhqr5D6owOJSEUbBDju99ZGVwDlCCxpv9e
 a4oauFFSauBdMC/cLad5/dUJHz52EPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-c7bC8MFwP1SgaQoVffIsDw-1; Tue, 17 Dec 2019 00:15:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA0DB107ACC4;
 Tue, 17 Dec 2019 05:15:33 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2B619C4F;
 Tue, 17 Dec 2019 05:15:24 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/15] Python queue 2019-12-17
Date: Tue, 17 Dec 2019 00:15:06 -0500
Message-Id: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: c7bC8MFwP1SgaQoVffIsDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 856ffa6465ad38a31603223eb057a253114ceaea=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191=
216-1' into staging (2019-12-16 13:04:34 +0000)

are available in the Git repository at:

  git://github.com/clebergnu/qemu.git tags/python-next-pull-request

for you to fetch changes up to e42cb9678cee7ff7c28afe7917c1002d6d8fdc0d:

  python/qemu: Remove unneeded imports in __init__ (2019-12-16 18:39:51 -05=
00)

----------------------------------------------------------------

Cleber Rosa (4):
  Acceptance test x86_cpu_model_versions: use default vm
  Acceptance tests: introduce utility method for tags unique vals
  Acceptance tests: use avocado tags for machine type
  Acceptance tests: use relative location for tests

Marc-Andr=C3=A9 Lureau (2):
  analyze-migration.py: fix find() type error
  analyze-migration.py: replace numpy with python 3.2

Philippe Mathieu-Daud=C3=A9 (2):
  tests/boot_linux_console: Fetch assets from Debian snapshot archives
  Revert "Acceptance test: cancel test if m68k kernel packages goes
    missing"

Wainer dos Santos Moschetta (7):
  python/qemu: Add set_qmp_monitor() to QEMUMachine
  tests/acceptance: Makes linux_initrd and empty_cpu_model use
    QEMUMachine
  python/qemu: Move kvm_available() to its own module
  python/qemu: accel: Add list_accel() method
  python/qemu: accel: Strengthen kvm_available() checks
  python/qemu: accel: Add tcg_available() method
  python/qemu: Remove unneeded imports in __init__

 docs/devel/testing.rst                     |  18 +++
 python/qemu/__init__.py                    |  24 ----
 python/qemu/accel.py                       |  77 ++++++++++++
 python/qemu/machine.py                     |  70 +++++++----
 scripts/analyze-migration.py               |  39 +++---
 tests/Makefile.include                     |   2 +-
 tests/acceptance/avocado_qemu/__init__.py  |  24 +++-
 tests/acceptance/boot_linux_console.py     |  27 +---
 tests/acceptance/cpu_queries.py            |   2 +-
 tests/acceptance/empty_cpu_model.py        |  12 +-
 tests/acceptance/linux_initrd.py           |  15 +--
 tests/acceptance/linux_ssh_mips_malta.py   |   5 -
 tests/acceptance/machine_m68k_nextcube.py  |  21 +---
 tests/acceptance/machine_sparc_leon3.py    |   3 +-
 tests/acceptance/ppc_prep_40p.py           |   3 -
 tests/acceptance/x86_cpu_model_versions.py | 137 ++++++++++++---------
 tests/vm/basevm.py                         |   2 +-
 17 files changed, 284 insertions(+), 197 deletions(-)
 create mode 100644 python/qemu/accel.py

--=20
2.21.0


