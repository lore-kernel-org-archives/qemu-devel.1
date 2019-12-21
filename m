Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A52AC2D0C3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561232070C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtRkV59z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561232070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iihpP-0003U1-G8
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 11:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jhogan@kernel.org>) id 1iih4H-0008Ce-KF
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 10:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jhogan@kernel.org>) id 1iih4E-0007V2-2v
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 10:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jhogan@kernel.org>) id 1iih4D-0007NS-NC
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 10:53:21 -0500
Received: from jamesdev.lan (jahogan.plus.com [212.159.75.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 858372072B;
 Sat, 21 Dec 2019 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576943599;
 bh=gHGpBtJi5CUKFgCeCIUVDpYnQjSt/JoZIFtgSOX3FqQ=;
 h=From:To:Cc:Subject:Date:From;
 b=RtRkV59z5FeMKslEfoPBDxNWmUsMgvI0vE3gcgLt3X1N6MqKcKT52xO0BA7QUeM5c
 oIL1Jx1YgujjCCeY0VF/hDUGrfKTPiC9e9GcaVZyFJwAqRIM9YKZXIfWCzuMGaL58z
 B8RK8Ct8UuX4oCDymThA7DdN+HNqiFyFWnuBZ7L4=
From: James Hogan <jhogan@kernel.org>
To: Aurelien Jarno <aurelien@aurel32.net>,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
Date: Sat, 21 Dec 2019 15:53:06 +0000
Message-Id: <20191221155306.49221-1-jhogan@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
X-Mailman-Approved-At: Sat, 21 Dec 2019 11:41:18 -0500
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
Cc: James Hogan <jhogan@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I haven't been active for 18 months, and don't have the hardware set up
to test KVM for MIPS, so mark it as orphaned and remove myself as
maintainer. Hopefully somebody from MIPS can pick this up.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: qemu-devel@nongnu.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 740401bcbb86..a798ad2b0b8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -363,9 +363,8 @@ S: Maintained
 F: target/arm/kvm.c
=20
 MIPS KVM CPUs
-M: James Hogan <jhogan@kernel.org>
 R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
-S: Maintained
+S: Orphan
 F: target/mips/kvm.c
=20
 PPC KVM CPUs
--=20
2.24.0


