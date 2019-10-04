Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708EBC10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAC520700
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hJ+31lck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAC520700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGE0A-0006eo-Br
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 23:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGDzA-00068I-Fs
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGDz9-0008JH-Cd
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:10:28 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56505 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGDz5-00088f-3Z; Thu, 03 Oct 2019 23:10:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kvy15zhRz9sPq; Fri,  4 Oct 2019 13:10:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570158617;
 bh=6BzysK04Egnj4VKoHR3IxJqfPZVBBXwQCCXvuB1yqd8=;
 h=From:To:Cc:Subject:Date:From;
 b=hJ+31lckGHqwbdvDTm47x9QoXTsNuvXT6qeVH+0oXb2I0AerZUn0qIHvS9Xo8HCcs
 9pgMe5FK3eeUDyIPQYkfmgKOsi4MW8U+Fr3pt3GP//BWN3dpQh3VqwtaaZv+V+aZN5
 DaT/f1eLiT8pWDIQYAq/9gkP45GiqIQP9rilKUZA=
From: David Gibson <david@gibson.dropbear.id.au>
To: i.mitsyanko@gmail.com,
	peter.maydell@linaro.org
Subject: [PATCH] exynos4210_gic: Suppress gcc9 format-truncation warnings
Date: Fri,  4 Oct 2019 12:55:09 +1000
Message-Id: <20191004025509.3012-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

exynos4210_gic_realize() prints the number of cpus into some temporary
buffers, but it only allows 3 bytes space for it.  That's plenty - I'm
pretty sure that existing machines will only ever set this value to 2
(EXYNOS4210_NCPUS).  But the compiler can't really be expected to figure
that out.

Some[*] gcc9 versions therefore emit -Wformat-truncation warnings.  Fix
that by allowing more space in the temporary buffers - these are on stack
very briefly before being essentially strdup()ed inside the memory region
code, so there's not much cost to doing so.

[*] The bizarre thing here, is that I've long gotten these warnings
compiling in a 32-bit x86 container as host - Fedora 30 with
gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal x86_64 hos=
t
- Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/exynos4210_gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index a1b699b6ba..2e5e47f9ec 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -290,8 +290,8 @@ static void exynos4210_gic_realize(DeviceState *dev, =
Error **errp)
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     const char cpu_prefix[] =3D "exynos4210-gic-alias_cpu";
     const char dist_prefix[] =3D "exynos4210-gic-alias_dist";
-    char cpu_alias_name[sizeof(cpu_prefix) + 3];
-    char dist_alias_name[sizeof(cpu_prefix) + 3];
+    char cpu_alias_name[sizeof(cpu_prefix) + 10];
+    char dist_alias_name[sizeof(cpu_prefix) + 10];
     SysBusDevice *gicbusdev;
     uint32_t i;
=20
--=20
2.21.0


