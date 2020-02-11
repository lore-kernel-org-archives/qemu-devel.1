Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93760C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0E120714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaIYgJsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0E120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1VsU-0008Ld-HX
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 08:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Vr0-0007YU-7R
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Vqy-0001w5-WA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:45:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Vqy-0001vp-Sn
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581428728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IzIp1s9Bnmy8J/2t3Wh08UI/uQGMQgtx2fSxMdVnCyE=;
 b=OaIYgJsZJbQkX+O3x44xZ4UpNa7Wcp0FM7LrYyWb+GlgCBR1OU6qcrDkHG4L44xEl1Ojao
 yV30UzoaeewRGvINYEVVsraM35PIV3HtHCBdHSpHzVLjebUEcVNh7gDcb/9Yih19sWrYSH
 5/rVTLU+JayE9Cc0Gm+M/qaKAYoA0EI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-8n8r9VplP0yaKrR6wTVfiw-1; Tue, 11 Feb 2020 08:45:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A74C785EE86;
 Tue, 11 Feb 2020 13:45:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-48.brq.redhat.com [10.40.205.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA615C1D6;
 Tue, 11 Feb 2020 13:45:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
Date: Tue, 11 Feb 2020 14:45:04 +0100
Message-Id: <20200211134504.9156-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8n8r9VplP0yaKrR6wTVfiw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use NetBSD content delivery network to get faster downloads.

Suggested-by: Kamil Rytarowski <kamil@netbsd.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/ppc_prep_40p.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index efe06037ba..6729d96f5e 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -34,7 +34,7 @@ def test_factory_firmware_and_netbsd(self):
                     '7020-40p/P12H0456.IMG')
         bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
         bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
-        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
+        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-archive/'
                      'NetBSD-4.0/prep/installation/floppy/generic_com0.fs'=
)
         drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
)
@@ -67,7 +67,7 @@ def test_openbios_and_netbsd(self):
         :avocado: tags=3Darch:ppc
         :avocado: tags=3Dmachine:40p
         """
-        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
+        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/iso/7.1.2/'
                      'NetBSD-7.1.2-prep.iso')
         drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
,
--=20
2.21.1


