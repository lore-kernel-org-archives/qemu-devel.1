Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E1C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDC6206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDC6206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56251 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ief7q-0006V6-RG
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ief4I-0002VP-Hh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ief4H-0003BT-Hp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:56:46 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42195 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ief4H-0002re-Af
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 07:56:45 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E081F1A212E;
 Tue, 10 Dec 2019 13:55:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BC86E1A1EB3;
 Tue, 10 Dec 2019 13:55:39 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/5] MAINTAINERS: Add a section on UI translation
Date: Tue, 10 Dec 2019 13:55:15 +0100
Message-Id: <1575982519-29852-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575982519-29852-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1575982519-29852-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: peter.maydell@linaro.org, philmd@redhat.com,
 Aleksandar Markovic <amarkovic@wavecomp.com>, aurelien@aurel32.net,
 hpoussin@reactos.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

There should be a person who will quickly evaluate new UI
translation, and find a way to update existing ones should
something changes in UI.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b3a88e..ac686e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2715,6 +2715,10 @@ M: Daniel P. Berrange <berrange@redhat.com>
 S: Odd Fixes
 F: scripts/git-submodule.sh
 
+UI translations
+M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
+F: po/*.po
+
 Sphinx documentation configuration and build machinery
 M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
-- 
2.7.4


