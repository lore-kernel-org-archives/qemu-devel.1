Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EABC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8F6206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8F6206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7HO-0003fp-JE
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zT-0005rV-K3; Tue, 01 Sep 2020 10:10:27 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zR-0003yK-Pm; Tue, 01 Sep 2020 10:10:27 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mv2tE-1kUmOf3Bi4-00r3s5; Tue, 01 Sep 2020 16:10:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 30/44] hw/net/xilinx_axienet: Remove unused code
Date: Tue,  1 Sep 2020 16:09:40 +0200
Message-Id: <20200901140954.889743-31-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n+vFiyHYyYBQqQfH6cYkSjR6+cxuqFt5Hp+vTdtSzSMNljrGceV
 3i8MU/Kt/Ke/8vIGr3QSRDFuJ8dBVdaLuAJFGrsFSoQJE2b4YeGdWlchQQRnvcfIUbqgqh1
 uzmYh1/F1FqSIvlHOjnRSmzx5vVEoleHAOo+RN8fD5LemhsGY/VgOKD9KKXbdPWIIV2/E4O
 xfBgMQqvvE4c5fs8578qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ieP0z49afpw=:+o2uGUoye/c2L4x+d/FpJt
 UekgvLNw73+PzFQtQp6K5yBgxLlmqTJvF6bwv7bCbywF6R/3AlMyrva+nnpr8pw4NqJ7dvdmO
 mgpbVnubL8l0hx94FSwsTOwu/+6FmUutSBQGRfRCZEGhSsUuu4hac3cmOz3j5jtrzBMNrt/HT
 RRFrsnY8wrfxC0R+mzpD160h2OR49bEK5LMh+jyuLtkgazPgMHiYxWtuNKdzPjqv7PGKOqKSI
 uJTokeLr6u7UOWJzICQvGWOLwDHZcZ5/ZIh2DOkpdqnO7K9dhcST99Dv4Q7H00dDxtalAtNlr
 qqmmLI/R4yUY2wRMldxiX7iVhBpDKFiTdQdl0yMAq2N+1gW3d3f85xBMo8tk39nD9pMKWyuMi
 8oojV3MrDw7B//ZsXHFCUMl6ZL0KlrqXO09P3BMhPIhY9gtiZLF8vIZcyom6TjOqf9/X+Oq1A
 NPrUu2bDUZFFl2HbUurIl41CMWzQsK9PD6xcmktldgqygQsbv9qskL9qnK62Tv6xVmhhThVGz
 TJV8UHulJbwjlhwg955IuU3QgJ2hPkTZ2yGNmvDFv0c5B7GR7uSM4GehDpbaSPduN9gCbz6+o
 PeAHrAhsv4kElOOYp952hnVWZT9TOyGxPTR1FOMsnY+QgjqdprAcpJp0Q3ukYhftQMT3Yr/B+
 5D14l+Jz8C+6Hu5KnTcavxml2Mr1ko4gCoQZh6y++pmPJzMLmNsh2IhRJ8A88LF/3tAbXqiWp
 DH1FOpwxkRew0r7l2z72Basbowa69rb4dZLo2lwwfGh2rtMuKNBIuBDvC2Q5XSAYaI5tyyHBB
 bw4DUdfupS+zf0UT4B0MQ6YEdpoXJMl3vyW2jmunnuUIrDzwgRNP1sowIN69K880DPoMEIb
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Most of the MDIOBus fields are unused.  The ADVERTISE_10HALF
definition is unused.  Remove unused code.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <20200814133007.16850-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/xilinx_axienet.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 1e48eb70c9cc..2e89f236b4ab 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -54,7 +54,6 @@
      TYPE_XILINX_AXI_ENET_CONTROL_STREAM)
 
 /* Advertisement control register. */
-#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
 #define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
 #define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
 #define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
@@ -169,28 +168,6 @@ tdk_init(struct PHY *phy)
 }
 
 struct MDIOBus {
-    /* bus.  */
-    int mdc;
-    int mdio;
-
-    /* decoder.  */
-    enum {
-        PREAMBLE,
-        SOF,
-        OPC,
-        ADDR,
-        REQ,
-        TURNAROUND,
-        DATA
-    } state;
-    unsigned int drive;
-
-    unsigned int cnt;
-    unsigned int addr;
-    unsigned int opc;
-    unsigned int req;
-    unsigned int data;
-
     struct PHY *devs[32];
 };
 
-- 
2.26.2


