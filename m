Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B1C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F8720748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pOT8KQdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F8720748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLg5o-0001Pj-Gu
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyO-000819-1f
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLfyL-0004Di-QF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:36:27 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLfyL-0004BL-Fj; Tue, 07 Apr 2020 00:36:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xF3K5Jxhz9sSy; Tue,  7 Apr 2020 14:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586234173;
 bh=+YTbPZLfCsxMNou5Bg4nfM5AXDAq7RSGrtjC4w0Uvm8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pOT8KQdfssP3T3Kkca9A/XY06HpXeNQhsLIuajTmz9MUl3q2vXbNPh+1Y+9D60tQV
 7rtelGHe8gEML1MgM3Fw7OWYay00uaERz9cSxguBUFThd2Rv3XPpi5WH/xY8nyOJXx
 JyIUUZZLJf+NdvYwbJU/woMKEbLL+DQhCJ7D9lYk=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 09/10] pseries: Update SLOF firmware image
Date: Tue,  7 Apr 2020 14:36:05 +1000
Message-Id: <20200407043606.291546-10-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200407043606.291546-1-david@gibson.dropbear.id.au>
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This is a single regression fix for for 5.0:

Greg Kurz (1):
      slof: Only close stdout for virtio-serial devices

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 965008 -> 965112 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/README b/pc-bios/README
index f54c2743d0..a5a770f066 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -14,7 +14,7 @@
 - SLOF (Slimline Open Firmware) is a free IEEE 1275 Open Firmware
   implementation for certain IBM POWER hardware.  The sources are at
   https://github.com/aik/SLOF, and the image currently in qemu is
-  built from git tag qemu-slof-20200317.
+  built from git tag qemu-slof-20200327.
=20
 - sgabios (the Serial Graphics Adapter option ROM) provides a means for
   legacy x86 software to communicate with an attached serial console as
diff --git a/pc-bios/slof.bin b/pc-bios/slof.bin
index 40499a1451f4f63f79f64f2457ae62b08d7d66eb..80bbf91a186c7eec76af3ae6a=
f50c2c841a77579 100644
GIT binary patch
delta 4653
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
k
z6$C$|a1mQrOwKa11>A4Q)uaW2Z0UpO8*&xz9fdJwhW5KJ$arO|?h83P|16FsMO;=3Dd
zM2}dXf%r?-9Dd~ku=3DfS43%&=3D|`KC2B%U8qOV9kd<unx^_4{UD>Y%6W`Zx7VBls2?%
zYxS45wl!|s(WbN(D#<&zFl?D;O;L^hb|o2ML!WhJ*`s$nru>fp^^J|CPwWWzTO0hP
p9c|LR;C;}FAD+)x=3DYi5=3DwW!zntXFt8b#?ef>xG%7*BrmE{4a5VBOw3)

delta 4787
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

diff --git a/roms/SLOF b/roms/SLOF
index ab6984f5a6..8e012d6fdd 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit ab6984f5a6d054e1f634dda855b32e5357111974
+Subproject commit 8e012d6fddb62be833d746cef3f03e6c8beecde0
--=20
2.25.2


