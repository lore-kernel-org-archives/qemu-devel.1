Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760AAECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0A7206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0A7206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTCp-0005Aw-Nd
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHTAy-0003cc-S3
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHTAx-0007HH-KI
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36686)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHTAx-0007Gw-FS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C77576520
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 13:35:46 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E057F60127;
 Mon,  7 Oct 2019 13:35:42 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] edk2-next patches for 2019-10-07
Date: Mon,  7 Oct 2019 15:35:35 +0200
Message-Id: <20191007133540.30623-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 07 Oct 2019 13:35:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9e5319ca52a5b9e84d55ad9c36e2c0b317a122=
bb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2019-10-04 18:32:34 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/edk2-next-20191007

for you to fetch changes up to 037973bb0d2b1a3c8618ccf41caa4da3666588c3:

  edk2 build scripts: work around TianoCore#1607 without forcing Python 2=
 (2019-10-07 15:14:15 +0200)

----------------------------------------------------------------
Improve scripts relying on the EDK2 submodule,
drop Python2 dependency in EDK2 build scripts.

----------------------------------------------------------------

Laszlo Ersek (2):
  edk2 build scripts: honor external BaseTools flags with
    uefi-test-tools
  edk2 build scripts: work around TianoCore#1607 without forcing Python
    2

Michael Roth (2):
  make-release: pull in edk2 submodules so we can build it from tarballs
  roms/Makefile.edk2: don't pull in submodules when building from
    tarball

Philippe Mathieu-Daud=C3=A9 (1):
  roms: Add a 'make help' target alias

 roms/Makefile                  |  3 ++-
 roms/Makefile.edk2             |  7 ++++++-
 roms/edk2-build.sh             |  4 ++--
 roms/edk2-funcs.sh             | 17 +++++++++++++++++
 scripts/make-release           |  8 ++++++++
 tests/uefi-test-tools/Makefile |  5 ++++-
 tests/uefi-test-tools/build.sh |  6 ++++--
 7 files changed, 43 insertions(+), 7 deletions(-)

--=20
2.21.0


