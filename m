Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBDAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4551120772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4551120772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrS6r-0004yU-G7
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrS5x-0003l4-KX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:15:37 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrS5v-00010E-9u
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:15:37 -0400
X-Originating-IP: 82.252.130.88
Received: from localhost.localdomain (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 145A91BF205;
 Fri,  3 Jul 2020 20:15:27 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au,
 f4bug@amsat.org
Subject: [PATCH 0/3] Add ability to choose MDIO phy number to i.MX processors
Date: Fri,  3 Jul 2020 22:15:14 +0200
Message-Id: <cover.1593806826.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.183.201; envelope-from=jcd@tribudubois.net;
 helo=relay8-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 16:15:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set adds the ability to select the Ethernet PHY device number
for the i.MX25 processor, the i.MX6 processor and the i.MX7 processor.

Note: the i.MX6UL processor was addressed in a previous patch.

Jean-Christophe Dubois (3):
  Add the ability to change the FEC PHY MDIO device number on i.MX25
    processor
  Add the ability to change the FEC PHY MDIO device number on i.MX6
    processor
  Add the ability to change the FEC PHY MDIO devices numbers on i.MX7
    processor

 hw/arm/fsl-imx25.c         | 7 +++++++
 hw/arm/fsl-imx6.c          | 7 +++++++
 hw/arm/fsl-imx7.c          | 9 +++++++++
 include/hw/arm/fsl-imx25.h | 1 +
 include/hw/arm/fsl-imx6.h  | 1 +
 include/hw/arm/fsl-imx7.h  | 1 +
 6 files changed, 26 insertions(+)

-- 
2.25.1


