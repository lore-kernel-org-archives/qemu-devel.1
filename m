Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320FEC742AB
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82F8208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XYjNjp/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82F8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlp0T-0007O4-3Q
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48729)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlozv-0005Mg-Iy
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlozs-00041P-KO
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:25:35 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33089 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlozr-0003up-7a; Fri, 12 Jul 2019 02:25:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lNFn32JCz9s8m; Fri, 12 Jul 2019 16:25:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562912717;
 bh=56FmPBhQ1PezxOfZZ7bVPBARsCPC4g/I/bUZQNxklEk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XYjNjp/a3Nu4yjww7pM91hOuGsTPpqNqYfjnRhyaYRWZm4W/4Gqs9whj9zqSBAuR5
 eHfR2nRWrnPrST8L5oE8SfGhsM8M+t5Dt+7SZlt8Jbr6elJ2dkQAOiX0tBc8M4fuGQ
 M5U9+UcEPEEVoY0DGiXN56B1tFU2L5tkADoNkrDw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 12 Jul 2019 16:25:08 +1000
Message-Id: <20190712062509.31370-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712062509.31370-1-david@gibson.dropbear.id.au>
References: <20190712062509.31370-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 1/2] pseries: Update SLOF firmware image
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
Cc: gkurz@redhat.com, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This only has a fix for ipv4-after-ipv6 booting problem.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 926392 -> 926432 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/README b/pc-bios/README
index 180795a55b..0a17f3ec6d 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -17,7 +17,7 @@
 - SLOF (Slimline Open Firmware) is a free IEEE 1275 Open Firmware
   implementation for certain IBM POWER hardware.  The sources are at
   https://github.com/aik/SLOF, and the image currently in qemu is
-  built from git tag qemu-slof-20190114.
+  built from git tag qemu-slof-20190703.
=20
 - sgabios (the Serial Graphics Adapter option ROM) provides a means for
   legacy x86 software to communicate with an attached serial console as
diff --git a/pc-bios/slof.bin b/pc-bios/slof.bin
index 65db1a6e579839cfd05da7f71c246fa0251c2fc0..2def51471772b6091bc5dc19b=
3bb136dddd201b2 100644
GIT binary patch
delta 9795
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
k
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

delta 9852
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
OpC7wS^Q(S%?tcM>id`81

diff --git a/roms/SLOF b/roms/SLOF
index a5b428e1c1..ba1ab360ee 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit a5b428e1c1eae703bdd62a3f527223c291ee3fdc
+Subproject commit ba1ab360eebe6338bb8d7d83a9220ccf7e213af3
--=20
2.21.0


