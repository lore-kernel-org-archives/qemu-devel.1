Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1F8C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4FF206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 22:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4FF206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNPxD-0005cO-Ud
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 18:49:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPvN-0004lB-EC
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPvM-0002WE-4F
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:48:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNPvL-0002Vr-Uz
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:48:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 388F73086275;
	Sun,  5 May 2019 22:47:59 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D94516BE1;
	Sun,  5 May 2019 22:47:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michael Walle <michael@walle.cc>,
	Jordan Justen <jordan.l.justen@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <paul.burton@imgtec.com>, Roy Franz <roy.franz@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org,
	David Engraf <david.engraf@sysgo.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnoij@jcrosoft.com>,
	Stefan Weil <sw@weilnetz.de>
Date: Mon,  6 May 2019 00:47:37 +0200
Message-Id: <20190505224737.1028-2-philmd@redhat.com>
In-Reply-To: <20190505224737.1028-1-philmd@redhat.com>
References: <20190505224737.1028-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Sun, 05 May 2019 22:47:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/1] MAINTAINERS: Add an entry for the Parallel
 NOR Flash devices
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505224737.--CjxwszjvxVxOEt9ghD2z7GDAF_Kmoj6SLgYtfdxfk@z>

Step in to maintain it, since I have some familiarity with
the technology.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66ddbda9c95..633f6315536 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1391,6 +1391,13 @@ F: include/hw/net/
 F: tests/virtio-net-test.c
 T: git https://github.com/jasowang/qemu.git net
=20
+Parallel NOR Flash devices
+M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+T: git https://gitlab.com/philmd/qemu.git pflash-next
+S: Maintained
+F: hw/block/pflash_cfi*.c
+F: include/hw/block/flash.h
+
 SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Fam Zheng <fam@euphon.net>
--=20
2.20.1


