Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CEFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9BC2070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 05:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="hAAfJz9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9BC2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqral-0001EP-VD
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 01:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqrUL-0007YQ-Ui
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:10:21 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:44826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqrUK-0004nu-6W
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 01:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:From:Reply-To:Subject:Content-ID:
 Content-Description:In-Reply-To:References:X-Debbugs-Cc;
 bh=2Wla39cdK9mumnaDKwkP1jgAmQnnO/KjBRrZF9lr1eE=; b=hAAfJz9JmqM1sraLIbFBFLZ6W+
 HAILlgLSI07q4ub6AfPDF6yLSRaJVTkJNFH+pjOSiIYa/LYnSoivx1rc5SVjBId8uQUyIrNl7KmDM
 G2nVYm2K+ZhxFAUS79ZckTF6M+uG5Ysl2YdyeuPjJT9W/l0Gx+r62hsXNfeF21/GTqnbami6QcfI5
 iMUNwTsrbCTdWvllX2ivc0GCCeEG+BW0bCvntzr044hkyIoB3UjnbbJAWeJFGQrrH/s+0uGURGewr
 dH1yj4QTtCYQcRVJXTB/0blRfrZrzUn7zeTYYmUOSkzu49A5ZY83ypZCdRL95jOrQJLBPHkgJL8/1
 w6SN2k/g==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jqrUJ-0007Jo-2N; Thu, 02 Jul 2020 07:10:19 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
 (envelope-from <aurelien@aurel32.net>)
 id 1jqrUI-004jQg-EQ; Thu, 02 Jul 2020 07:10:18 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Remove myself from FPU emulation maintenance
Date: Thu,  2 Jul 2020 07:10:13 +0200
Message-Id: <20200702051013.1127897-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..0535e043f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -130,7 +130,6 @@ F: include/sysemu/cpus.h
 F: include/sysemu/tcg.h
 
 FPU emulation
-M: Aurelien Jarno <aurelien@aurel32.net>
 M: Peter Maydell <peter.maydell@linaro.org>
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
-- 
2.27.0


