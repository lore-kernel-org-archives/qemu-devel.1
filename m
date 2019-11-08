Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0044FC6195
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0C32067B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0C32067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT9mz-000516-N9
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iT9fy-0006ED-MP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iT9fx-0004RA-D9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:12:06 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50481 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iT9fx-0004Hg-6K
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:12:05 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 43A6E1A21BF;
 Fri,  8 Nov 2019 20:10:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 173681A224E;
 Fri,  8 Nov 2019 20:10:59 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] MAINTAINERS: Adjust maintainership for R4000 systems
Date: Fri,  8 Nov 2019 20:10:49 +0100
Message-Id: <1573240249-6966-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573240249-6966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1573240249-6966-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, aleksandar.rikalo@rt-rk.com,
 alex.bennee@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Change the maintainership for R4000 systems to improve its quality.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a49381..62e7d6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -957,8 +957,9 @@ F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
=20
 R4000
-M: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
+R: Aurelien Jarno <aurelien@aurel32.net>
+R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
 S: Maintained
 F: hw/mips/mips_r4k.c
=20
--=20
2.7.4


