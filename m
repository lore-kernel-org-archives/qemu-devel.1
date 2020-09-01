Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07085206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07085206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Nr-0008VR-1h
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zb-0006Fv-Sw; Tue, 01 Sep 2020 10:10:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zZ-00041C-Qm; Tue, 01 Sep 2020 10:10:35 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N0X4e-1kY3eO2yOa-00wXVp; Tue, 01 Sep 2020 16:10:25 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 40/44] usb/bus: Remove dead assignment in usb_get_fw_dev_path()
Date: Tue,  1 Sep 2020 16:09:50 +0200
Message-Id: <20200901140954.889743-41-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fde0JeXMtmvEuG6BD+FGbBr2ZW7adftAP1LOT4aUDPUX5ab2HO+
 RLIoJfCid5/jFRFUEPKiZvqKrA1w7OfiS3b8t3Ii51b4wOehEsxki0FNyywxqr0lp4dTrYS
 9mbnfwvWo90EMi359IUOxb2xa16QZgpSRdw5ZQ0bbgdW8NjxjUnn9xO2dLPs9Nh4jR+buXS
 yJGsJ6gxiTNDzMDmyUu5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wYIVgo2wF7Y=:DQaAn1e4j/icgNtKwXPzm6
 iiaBkeBweCMqVLaQ6+Ba0cl+vZb+UCQhifGw4qo2tKiyQLH0ID5n89O3q0w9ErQECU9mZdeck
 FSUyea/BtFZDAFgDieulLO5JJKwHPrpXt9RUZKMt2r/oM2QRxZ2oKTqwKPxoDyOmKWxZnjeK4
 bQlzSsp1xaLUbTBmX+96mOrzBBnxIc/2tKJ6cTVFb1v689t9p9RQ9dC4XGT7CpE3Np5FDlo5A
 isnO6ezfPP7+01KGfSW9pD/tRVat1SY2MHynQtJLox5rIv8RA8MLMXNQbG10+CbDLpbihHQ11
 syyU+lxUgqlyUmGOI28T0vHZxr+jnfxoJjJlkvXFJ/MArLAm7mP+rYejXeSxCpkgsF2Ua5/RK
 PCylaQ9oBahzXfvlWyWFPdqcI6J44cjB4jKJtcAUocAYtt1EIr7ncEX9HhruC5Tixl1dCwFVB
 BwE21wjC7UBmArnIme7+i1uYinLMcEU7afw+lkAVxE49ML/8w66rs+WKu9ehKRA8T8RkGjVyY
 7vP4obr5PR0whXGBRDaaKxz6obsHTeqG/ffn0+uxLUo7VOdwuzCqBgCZRFz60qwQhd0P0v0Q8
 ljC98uqC0UZVXoPQLM/WhJQHtT8lVx7Lw9//+b/8EItWpbqVRTQjknYK9swSyNa/7Bw+Qz/Uw
 kYeh5APB75tCFLvNloFQvm9hgq7+gKkD3B5f8R1OJIgifiHpHQehIQTvwvfmWUoE8uAxV5Scj
 MLkhLA+l2wVZjr6GlXZEOnmnB0jgIl0GP81/P3DlL0r046wfloDq/09uWvlkZaVjuMwN+r2Gc
 R6aa4XxV4xLQ8kwePcTG16pOtms7lDo4Zogt9MI+ET95XoWf4LmrJSS15r0yXKRqV7hT0L+
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
qemu/hw/usb/bus.c:615:13: warning: Value stored to 'pos' is never read
            pos += snprintf(fw_path + pos, fw_len - pos, "%s@%lx",

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200827110311.164316-9-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/usb/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index b17bda3b29ef..2b1104145157 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -612,8 +612,8 @@ static char *usb_get_fw_dev_path(DeviceState *qdev)
             in++;
         } else {
             /* the device itself */
-            pos += snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
-                            qdev_fw_name(qdev), nr);
+            snprintf(fw_path + pos, fw_len - pos, "%s@%lx",
+                     qdev_fw_name(qdev), nr);
             break;
         }
     }
-- 
2.26.2


