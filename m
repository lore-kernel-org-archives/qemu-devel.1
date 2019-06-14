Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FF2C31E4E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CD821841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CD821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbspV-0003GG-14
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 16:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56325)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbsjt-00078e-Mm
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbsjs-000738-HD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbsjs-00072N-B3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:23:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EDCAD3D3C
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 20:23:49 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-141.ams2.redhat.com
 [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8D65C1A1;
 Fri, 14 Jun 2019 20:23:47 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 22:23:33 +0200
Message-Id: <20190614202333.19355-7-lersek@redhat.com>
In-Reply-To: <20190614202333.19355-1-lersek@redhat.com>
References: <20190614202333.19355-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 14 Jun 2019 20:23:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/6] pc-bios: update the README file with
 edk2-stable201905 information
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refresh the "pc-bios/README" file with edk2, OpenSSL, and Berkeley
SoftFloat release info, matching the edk2-stable201905 firmware images
added in the previous patch.

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1831477
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 pc-bios/README | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/pc-bios/README b/pc-bios/README
index 807d95dd5418..180795a55b8a 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -55,9 +55,11 @@
   variable store templates built from the TianoCore community's EFI Deve=
lopment
   Kit II project
   <https://github.com/tianocore/tianocore.github.io/wiki/EDK-II>. The im=
ages
-  were built at git tag "edk2-stable201903". The firmware binaries bundl=
e parts
-  of the OpenSSL project, at git tag "OpenSSL_1_1_0j" (the OpenSSL tag i=
s a
-  function of the edk2 tag). Licensing information is given in
-  "edk2-licenses.txt". The image files are described by the JSON documen=
ts in
-  the "pc-bios/descriptors" directory, which conform to the
-  "docs/interop/firmware.json" schema.
+  were built at git tag "edk2-stable201905". The firmware binaries bundl=
e parts
+  of the OpenSSL project, at git tag "OpenSSL_1_1_1b" (the OpenSSL tag i=
s a
+  function of the edk2 tag). Parts of the Berkeley SoftFloat library are
+  bundled as well, at Release 3e plus a subsequent typo fix (commit
+  b64af41c3276f97f0e181920400ee056b9c88037), as an OpenSSL dependency on=
 32-bit
+  ARM. Licensing information is given in "edk2-licenses.txt". The image =
files
+  are described by the JSON documents in the "pc-bios/descriptors" direc=
tory,
+  which conform to the "docs/interop/firmware.json" schema.
--=20
2.19.1.3.g30247aa5d201


