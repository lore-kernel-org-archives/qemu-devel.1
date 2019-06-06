Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44205C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B98420673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B98420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsWp-00086A-Cd
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:34:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUm-0006kS-LM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUh-0001zH-16
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hYsUV-0000wk-1S
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0DE13082B69
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 13:31:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-196.ams2.redhat.com
	[10.36.116.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2193168411;
	Thu,  6 Jun 2019 13:31:32 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Date: Thu,  6 Jun 2019 15:31:08 +0200
Message-Id: <20190606133110.13754-5-lersek@redhat.com>
In-Reply-To: <20190606133110.13754-1-lersek@redhat.com>
References: <20190606133110.13754-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 06 Jun 2019 13:31:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/6] roms/Makefile.edk2: update input file list
 for "pc-bios/edk2-licenses.txt"
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(1) For TianoCore Bugzilla

      https://bugzilla.tianocore.org/show_bug.cgi?id=3D1373

    the majority of the edk2 tree was relicensed under the
    BSD-2-Clause-Patent license:

      https://spdx.org/licenses/BSD-2-Clause-Patent.html>

    Edk2 commit f53de8aecb12 ("edk2: Add License-History.txt", 2019-04-09=
)
    added a new file called "License-History.txt", describing license and
    contributor agreement changes over time.

(2) For advacing edk2's OpenSSL git submodule to the 1.1.1b release, a
    more up-to-date ArmSoftFloatLib instance became necessary, on 32-bit
    ARM. Therefore, the embedded (and by now, obsolete) Berkeley SoftFloa=
t
    library was replaced with a git submodule of the same, checked out at
    the latest release ("3e", plus a typo fix on top -- commit
    b64af41c3276). This was implemented for TianoCore Bugzilla

      https://bugzilla.tianocore.org/show_bug.cgi?id=3D1845

    in edk2 commit range b6cfa686e42d..371e7001e8d5.

Include the edk2 project's "License-History.txt" file, and the Berkeley
SoftFloat library's "COPYING.txt", in our generated
"pc-bios/edk2-licenses.txt" text file.

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1831477
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 roms/Makefile.edk2 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
index 6a19498d0738..c2f2ff59d5b1 100644
--- a/roms/Makefile.edk2
+++ b/roms/Makefile.edk2
@@ -17,7 +17,9 @@ toolchain =3D $(shell source ./edk2-funcs.sh && qemu_ed=
k2_get_toolchain $(1))
=20
 licenses :=3D \
 	edk2/License.txt \
+	edk2/License-History.txt \
 	edk2/OvmfPkg/License.txt \
+	edk2/ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3/COPYING.txt \
 	edk2/CryptoPkg/Library/OpensslLib/openssl/LICENSE
=20
 # The "edk2-arm-vars.fd" varstore template is suitable for aarch64 as we=
ll.
--=20
2.19.1.3.g30247aa5d201



