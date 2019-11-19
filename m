Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DAAC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A8022432
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 19:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="rPGKHich"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A8022432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX8qW-00012i-V2
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 14:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1iX8pp-0000YM-Bf
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1iX8pn-0008I6-NH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:06:44 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:19369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1iX8pn-0008HV-Dc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 14:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574190403; x=1605726403;
 h=from:to:cc:subject:date:message-id;
 bh=PYXD3LMVpdTJrs53IfRJalXicG3S5UDu4I0R342xWBI=;
 b=rPGKHichijC2nBm/v7tRe7SXa2zrAJplVIMc1Ig1w0lJfJscLVo5T4wG
 UZRMPkEoTthx2CMIvhsw2ZqLnD8X+T7QMcl7bog3xibPYQCf+H/1P/Vh9
 rbzaTNFn8T0vr2g8LJm/EF8Bso0usi9r8m7bxNASw/Sj2HvEa6jrnFLMA c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Nov 2019 11:06:42 -0800
IronPort-SDR: 7Ft8vCzXgxrt/OaPaalXolbjA73IJB2P4Z0BFs2vNeKG4FUGazWvuAL4/AR08fHe+wzF30grm1
 fhmbYuCh91pq6oAhPfpbVkS8hiau9vzMvqWX0m+rDnTIsygwI5jsIG52lye1hciZqafqZs1MY9
 vZctmH4PnJC4Ha2Nsw0BhorTWWmjlscaiE+Sd9Kwb+i3PriDEcY9Nk3gEwjuS9I47YdKBLkG5B
 CidSnp9x29opQcWnr5M3LdMtXDjbbtSohhlMShdcPkg2ZUJGc8BkpjHoJRfkIAAy2PMyoOC0hn
 xqw85I3yNuoTaU5YbLSsxqF/
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 19 Nov 2019 11:06:41 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id EBD1BFFE; Tue, 19 Nov 2019 13:06:39 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: riku.voipio@iki.fi,
	laurent@vivier.eu,
	qemu-devel@nongnu.org
Subject: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
Date: Tue, 19 Nov 2019 13:06:28 -0600
Message-Id: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Taylor Simpson <tsimpson@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
---
 linux-user/signal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62..ce3d27f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -72,6 +72,14 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
        over a single host signal.  */
     [__SIGRTMIN] = __SIGRTMAX,
     [__SIGRTMAX] = __SIGRTMIN,
+#ifdef TARGET_HEXAGON
+    /*
+     * Hexagon uses the same signal for pthread cancel as the host pthreads,
+     * so cannot be overridden.
+     * Therefore, we map Hexagon signal to a different host signal.
+     */
+    [__SIGRTMAX - 1] = __SIGRTMIN + 1,
+#endif
 };
 static uint8_t target_to_host_signal_table[_NSIG];
 
-- 
2.7.4


