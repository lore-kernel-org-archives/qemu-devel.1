Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70000C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BE720850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BE720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38677 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEy5m-00040I-8K
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:27:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEy4X-0003Td-R6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEy4W-0004Ps-Vc
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:26:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEy4U-0004Ny-AD; Fri, 12 Apr 2019 11:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87AD020269;
	Fri, 12 Apr 2019 15:26:29 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEA431001E7A;
	Fri, 12 Apr 2019 15:26:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 17:26:19 +0200
Message-Id: <20190412152619.23542-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 12 Apr 2019 15:26:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800 and
 n810 machines
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
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412152619.oZ3M-StJA5424bbZU1aser63zRg8_CHzyhJXFqF2b_g@z>

These machines depend on the deprecated bluetooth subsystem. In case we
finally decide to remove the bluetooth subsystem, we likely need to
remove the n800 and n810 machines, too, so mark them now as deprecated.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/nseries.c     | 3 +++
 qemu-deprecated.texi | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 906b7ca22d..66e50b850c 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1309,6 +1309,9 @@ static void n8x0_init(MachineState *machine,
     struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
     int sdram_size =3D binfo->ram_size;
=20
+    warn_report("The n800 and n810 machines are deprecated. Please use a=
 "
+                "different Arm machine instead.");
+
     s->mpu =3D omap2420_mpu_init(sysmem, sdram_size, machine->cpu_type);
=20
     /* Setup peripherals
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 2219386769..4de7452fac 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -145,6 +145,12 @@ This machine type uses an unmaintained firmware, bro=
ken in lots of ways,
 and unable to start post-2004 operating systems. 40p machine type should=
 be
 used instead.
=20
+@subsection n800 and n810 (Arm) (since 4.1)
+
+These machines depend on the deprecated bluetooth subsystem. When the
+bluetooth subsystem will be removed, the n800 and n810 machines will be
+deleted, too. If possible, use a different Arm board instead.
+
 @section Device options
=20
 @subsection Block device options
--=20
2.21.0


