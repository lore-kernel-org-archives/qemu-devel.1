Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A531BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6397820705
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bi3XDkPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6397820705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibetk-00054a-JF
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 01:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ibesf-0004Vv-Cz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ibesd-00016o-Th
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:08:21 -0500
Received: from ozlabs.org ([203.11.71.1]:53979)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ibesZ-00016B-8u; Mon, 02 Dec 2019 01:08:16 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47RF621gLzz9sPL; Mon,  2 Dec 2019 17:08:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575266890;
 bh=USu8JlsY/OzHA2YhXxTPxDDMZBunzRsn+270mXy38Zo=;
 h=From:To:Cc:Subject:Date:From;
 b=bi3XDkPwIZaOws/HGq/oT54ob58swfTjE0sP4YauSYuvixDLssPVIE1tKsGEYBcMJ
 TcWo7VfXn6a1tbmIzSpeW44GVJQYIZBwLMVJhCGTzM4LoTpcrnMQExbq2XR7JCzJCt
 mcZ+GuU/2FAVchKJPlHlrdjXqvsBtUQzN/lAns/Q=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PATCHv3] exynos4210_gic: Suppress gcc9 format-truncation warnings
Date: Mon,  2 Dec 2019 17:08:06 +1100
Message-Id: <20191202060806.77968-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: i.mitsyanko@gmail.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

exynos4210_gic_realize() prints the number of cpus into some temporary
buffers, but it only allows 3 bytes space for it.  That's plenty:
existing machines will only ever set this value to EXYNOS4210_NCPUS
(2).  But the compiler can't always figure that out, so some[*] gcc9
versions emit -Wformat-truncation warnings.

We can fix that by hinting the constraint to the compiler with a
suitably placed assert().

[*] The bizarre thing here, is that I've long gotten these warnings
    compiling in a 32-bit x86 container as host - Fedora 30 with
    gcc-9.2.1-1.fc30.i686 - but it compiles just fine on my normal
    x86_64 host - Fedora 30 with and gcc-9.2.1-1.fc30.x86_64.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Peter, up to you if you squeeze this in for qemu-4.2 or leave it until 5.=
0

Changes since v2:
 * Moved the assert outside the for loop using a trick suggested by
   Richard Henderson
Changes since v1:
 * Used an assert to hint the compiler, instead of increasing the
   buffer size.

---
 hw/intc/exynos4210_gic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index a1b699b6ba..ddd006aca6 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -293,6 +293,7 @@ static void exynos4210_gic_realize(DeviceState *dev, =
Error **errp)
     char cpu_alias_name[sizeof(cpu_prefix) + 3];
     char dist_alias_name[sizeof(cpu_prefix) + 3];
     SysBusDevice *gicbusdev;
+    uint32_t n =3D s->num_cpu;
     uint32_t i;
=20
     s->gic =3D qdev_create(NULL, "arm_gic");
@@ -313,7 +314,14 @@ static void exynos4210_gic_realize(DeviceState *dev,=
 Error **errp)
     memory_region_init(&s->dist_container, obj, "exynos4210-dist-contain=
er",
             EXYNOS4210_EXT_GIC_DIST_REGION_SIZE);
=20
-    for (i =3D 0; i < s->num_cpu; i++) {
+    /*
+     * This clues in gcc that our on-stack buffers do, in fact have
+     * enough room for the cpu numbers.  gcc 9.2.1 on 32-bit x86
+     * doesn't figure this out, otherwise and gives spurious warnings.
+     */
+    assert(n <=3D EXYNOS4210_NCPUS);
+    for (i =3D 0; i < n; i++) {
+
         /* Map CPU interface per SMP Core */
         sprintf(cpu_alias_name, "%s%x", cpu_prefix, i);
         memory_region_init_alias(&s->cpu_alias[i], obj,
--=20
2.23.0


