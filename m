Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E7C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5273520740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey9AcVbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5273520740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBot-0000Sx-EY
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZBo3-0008QU-2q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZBo0-0000Fl-Ka
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:41:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZBo0-0000FS-AG
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574678479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dCRQP/z3jy7adrZ70T+bVSNDPJX0ONHURkfCURA390o=;
 b=Ey9AcVbSF129XujhueEGy3tguSo2eZCH+S2PmAzKkcf3rasBjegx97rroK7PZKiOUY+oaQ
 +wDF4JvI02VICj6WWTdQvsh/tQN9iQHGaJbMbMlIqXab1aPHK/XgP06hdyrTnYzKpf3Jqz
 Wxf3gqky+sT1O7EYzW0F7PnuqknC7QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-C56pADOrODi6rZjZqo6slA-1; Mon, 25 Nov 2019 05:41:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DCA8184CAA2;
 Mon, 25 Nov 2019 10:41:17 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 744E65D9CA;
 Mon, 25 Nov 2019 10:41:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
Date: Mon, 25 Nov 2019 11:41:03 +0100
Message-Id: <20191125104103.28962-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: C56pADOrODi6rZjZqo6slA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The r4k machine was introduced in 2005 (6af0bf9c7) and its last
logical change was in 2005 (9542611a6). After we can count 164
maintenance commits (QEMU API changes) with the exception of
1 fix in 2015 (memory leak, commit 3ad9fd5a).

This machine was introduced as a proof of concept to run a MIPS
CPU. 2 years later, the Malta machine was add (commit 5856de80)
modeling a real platform.

Note also this machine has no specification except 5 lines in
the header of this file:

 * emulates a simple machine with ISA-like bus.
 * ISA IO space mapped to the 0x14000000 (PHYS) and
 * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
 * All peripherial devices are attached to this "bus" with
 * the standard PC ISA addresses.

It is time to deprecate this obsolete machine. Users are
recommended to use the Malta board, which hardware is well
documented.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qemu-deprecated.texi | 5 +++++
 hw/mips/mips_r4k.c   | 1 +
 MAINTAINERS          | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 4b4b7425ac..05265b43c8 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should use=
 'scsi-hd' or
=20
 @section System emulator machines
=20
+@subsection mips r4k platform (since 4.2)
+
+This machine type is very old and unmaintained. Users should use the 'malt=
a'
+machine type instead.
+
 @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
=20
 These machine types are very old and likely can not be used for live migra=
tion
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 70024235ae..0b79ad26cb 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)
=20
 static void mips_machine_init(MachineClass *mc)
 {
+    mc->deprecation_reason =3D "use malta machine type instead";
     mc->desc =3D "mips r4k platform";
     mc->init =3D mips_r4k_init;
     mc->block_default_type =3D IF_IDE;
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..3b3a88e264 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
 R4000
 M: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
-S: Maintained
+S: Obsolete
 F: hw/mips/mips_r4k.c
=20
 Fulong 2E
--=20
2.21.0


