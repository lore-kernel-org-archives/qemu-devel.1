Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB3DC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1160221D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1160221D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGouv-0006eY-5w
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonq-0002iY-TJ; Fri, 11 Sep 2020 15:33:46 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonp-0000od-5h; Fri, 11 Sep 2020 15:33:46 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfL5v-1kiRmY32Vf-00gt6v; Fri, 11 Sep 2020 21:33:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] hw/net/e1000e: Remove overwritten read handler for
 STATUS register
Date: Fri, 11 Sep 2020 21:33:20 +0200
Message-Id: <20200911193330.1148942-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sf2oOc/V610s/ecndz6lKV1wa7DBCekol9y2GpdW4qy79KRGsGA
 P4HbYN2xNqrnT4JCb9+PPSgoiKP3nUYqFMw8sfJQ/7o3VxmjBcxopN1ESKI+2vVjVfa3n22
 cuah/XcWonczpm19y1xphitMMHLIvfGVR8Mz+klSixHHcr9ThfIKaPUh6ZwdtIm+ISRLlxv
 IvaCQKbLMAGgWlc1Tx0Rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uhy+ph77yhM=:8CKwEN7xgbgoPhuGsCWcET
 vnNymzpcp2x+RCsejWFGQgH6UonEG6zbPl8b+V0Sfg3RmcHPgRhV/IygYlvbxaSpdceCKwrR6
 WTteGS3MPOmGyEo+G7eW+VlKZ3mAMVVLsvjgS5IbzcKjsJFBEO6uJZsuJxe5L/iqcw0rx9ss1
 JwTsHP7CQ8+exKse9YF6HHSCCc9jAHADuEdU2qcBAd79TfPACmpNbSGEimxVtrW/5y5EM3z/7
 Vf1tpNp3KUEiq0ijh4bKODa6f7squxQw2N9ifPABA2U9BrlYW0jxY5A1yhsXMPygnfb9HLkHX
 slC+W7qgB7x7rs5qOoHUoaQynNrn1LlbCMzXLwj/+lV7QxQT+cFEfNij6BuOBa9qTNiV5yCYp
 GMIYq/HA/cVoYS1ilp/ZKzSr/Bk2kwQlxIbiUh80NXJoG6ROCy1138sPlgI4mAD/65S2AV3RH
 D3bEg4m8IYQYvhmEjKZOorGCRi/1cKV7ZYu4DW00BpfkJWpzciDI9B7ZDYh9VAPPOzvIPFG4W
 f9d4IL3SOGPUDhxCk4wo23xm5H9ufZVK3I1j+6n01R/HaA7x/k6477jTIDer1EO1h2tSIR8E4
 /NBypvAol/CHuCmDxCgs9ToqmTavhH8d1XVmVzbBJU8JWWN9hPNQxCuZs0Toj4zD+1V9eHZ4D
 G3paFfxzHcaYf31mF2FvGhkaKZ5S5u1ob+sFtLWbYHob8geqP1Ac8EKbD/csMa3dUDTPg/9xx
 iRcokHOzDt/0cHYrhieVMldtOfFhw5YbQ1yx0JeIOOFOWKW/93cfQZ0hCjbZuyd/66yonXK2v
 qaNkLTFgHPWQRjZoUK4mxlh+K85w5pqi+5MfLJC0ETEX2XPdDoPFd8biRQbYGeKmcNjLWF1
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:34
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The STATUS register readop handler is initialized first with
the generic e1000e_mac_readreg() handler:

  2861 #define e1000e_getreg(x)    [x] = e1000e_mac_readreg
  2862 typedef uint32_t (*readops)(E1000ECore *, int);
  2863 static const readops e1000e_macreg_readops[] = {
  ....
  2919     e1000e_getreg(STATUS),

Then overwritten with the specific e1000e_get_status handler:

  3018     [STATUS]  = e1000e_get_status,

To avoid confusion, remove the overwritten initialization.

6f3fbe4ed0 ("net: Introduce e1000e device emulation")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200904131402.590055-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/e1000e_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index bcd186cac524..5170e6a45633 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2916,7 +2916,6 @@ static const readops e1000e_macreg_readops[] = {
     e1000e_getreg(TSYNCRXCTL),
     e1000e_getreg(TDH),
     e1000e_getreg(LEDCTL),
-    e1000e_getreg(STATUS),
     e1000e_getreg(TCTL),
     e1000e_getreg(TDBAL),
     e1000e_getreg(TDLEN),
-- 
2.26.2


