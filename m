Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531AEC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277A2206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277A2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHTFZ-0000Nq-QO
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHTB3-0003hv-Nw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHTB2-0007Jo-HX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:35:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iHTB2-0007JP-Bz; Mon, 07 Oct 2019 09:35:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F8ED18CB8E2;
 Mon,  7 Oct 2019 13:35:51 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94431600C1;
 Mon,  7 Oct 2019 13:35:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] roms/Makefile.edk2: don't pull in submodules when building
 from tarball
Date: Mon,  7 Oct 2019 15:35:37 +0200
Message-Id: <20191007133540.30623-3-philmd@redhat.com>
In-Reply-To: <20191007133540.30623-1-philmd@redhat.com>
References: <20191007133540.30623-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 07 Oct 2019 13:35:51 +0000 (UTC)
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
 qemu-stable@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Currently the `make efi` target pulls submodules nested under the
roms/edk2 submodule as dependencies. However, when we attempt to build
from a tarball this fails since we are no longer in a git tree.

A preceding patch will pre-populate these submodules in the tarball,
so assume this build dependency is only needed when building from a
git tree.

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Bruce Rogers <brogers@suse.com>
Cc: qemu-stable@nongnu.org # v4.1.0
Reported-by: Bruce Rogers <brogers@suse.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-Id: <20190912231202.12327-3-mdroth@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/Makefile.edk2 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index c2f2ff59d5..33a074d3a4 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -46,8 +46,13 @@ all: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$=
(flashdev).fd.bz2) \
 # files.
 .INTERMEDIATE: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashde=
v).fd)
=20
+# Fetch edk2 submodule's submodules. If it is not in a git tree, assume
+# we're building from a tarball and that they've already been fetched by
+# make-release/tarball scripts.
 submodules:
-	cd edk2 && git submodule update --init --force
+	if test -d edk2/.git; then \
+		cd edk2 && git submodule update --init --force; \
+	fi
=20
 # See notes on the ".NOTPARALLEL" target and the "+" indicator in
 # "tests/uefi-test-tools/Makefile".
--=20
2.21.0


