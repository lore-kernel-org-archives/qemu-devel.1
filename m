Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0FAC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73589218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73589218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DWf-0000g2-Be
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2DUf-0006Xr-61
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2DUe-0003N9-7p
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2DUd-0003Mp-Vr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:20 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAORn-1jDRcq3OOJ-00Btl7; Thu, 13 Feb 2020 13:21:12 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] linux-user: add missing TARGET_SIGRTMIN for hppa
Date: Thu, 13 Feb 2020 13:21:04 +0100
Message-Id: <20200213122108.965455-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213122108.965455-1-laurent@vivier.eu>
References: <20200213122108.965455-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YfOIAiU/LjNkBiZ3cPPuh1vObMf3Wv0zYFURKZ1NvR0fNa2PHdP
 KLvXX5BAbFbyazvl0/iJV4RtkQKrK1lpXH/xC9CG8pGZWujIM3vv+hytl12fPM8GAxQ3c1t
 7q7V0uQZyefn29axRzNPNAmaMqeroVG8nf7tqsfI8zA0wW9E+4j7e5jfW4sXQKGQttawt5p
 Qn9cEbc9NSNtK+Y+scHGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xOwFN2M/zUI=:69c3wmChX0RFLQr2vRj/4e
 ZiNM8n01Cp0ykPrX7XCR/9tTRDl02LqxyLDCWztExqNARjvym6sKB4WL6qFYrw8dB2tTKddL3
 hsptHf05VmiQ3UCJ0k9nC3hudLKYVrfbdEwUDNEjQgSZP42t/BD6QTXUcLAi4HKwU7Tr81Vk3
 GWymoVJGn8JiWJJ077/1jHZJq1wZxAApobQVDQR6Vwz0KxlGcOOIIEdy3ZIDMtxFl6vXI1BHY
 FKJibgDAxsGr4W6K5RvdoRTsEqLcqJ4Q8D1xtxYySZ7zI5MszyGzDGXhGQF/KKRHxKQBXj1KD
 tka2bhYbLYgTQXg0ALw9QQHUULBqihWr/VTZ0+7f0WMbl9zY8yUHD7yeAXUkEwvGbu2HiYhnn
 w87SF3KL0tnO/QoTMGUVdoDNubtwUCZQhIe2luVfgCjDoO3z/sVts/esGDZGTLMgqP+hw5kXQ
 1VZzJxuPB/MuY5FGz4H+KpV8tse8cueAndwrXZFgtyrgK7aV9vfHq/ycjzQWEQ4scrb1JJhnx
 T0/5FtYTly/BXs29vSZnfkZLDj+3A1XGMYVx2pZIq4Yqdok0SMMfb1b4JeLJLmCn+vZPX7Yh4
 gOuyg+qm07XcConQapmuP4ynCwc8QfiX/KBmbMYWP4zyMjAbz+nr+47MHh4HuxYIoFsMB/nNW
 tLuOqp6FwushmShKTZtn1H3bCNkf6K2rGsjmvDHAtjnVLrqy3/F1klNEv9K3VtyZwRH3KRKPG
 mBJW0vuezaUUaSlesqAZdjGU1RArNxL603CwAO/eEGa9VZBDWSOe8oie8BMB2a/I1Xh9BMmAk
 sr7kEo1fy0tIM1blS/o9kGPMjdRcOSTQhMm3tuQptqDBb0pYLQykGIRYkMlpEFXD4NxWlVV
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
 Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This signal is defined for all other targets and we will need it later

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
[pm: that this was actually an ABI change in the hppa kernel (at kernel
version 3.17, kernel commit 1f25df2eff5b25f52c139d). Before that
SIGRTMIN was 37...
All our other HPPA TARGET_SIG* values are for the updated
ABI following that commit, so using 32 for SIGRTMIN is
the right thing for us.]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200212125658.644558-2-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/hppa/target_signal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index ba159ff8d006..c2a0102ed73d 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -34,6 +34,7 @@
 #define TARGET_SIGURG          29
 #define TARGET_SIGXFSZ         30
 #define TARGET_SIGSYS          31
+#define TARGET_SIGRTMIN        32
 
 #define TARGET_SIG_BLOCK       0
 #define TARGET_SIG_UNBLOCK     1
-- 
2.24.1


