Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48681C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C57E20775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LyS+44Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C57E20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrw8-0005Km-0S
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmj-000844-Gj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:37305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmh-0007nk-1l
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149271;
 bh=HFMYYgXi0LtEZnRIqLZyX2/D+EQ8XXykoOKUAb4kocc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LyS+44Kj2Cew70ZmGp2TxG2YZ3xaGt8kKvcmjbIAwIGfJ73Ytm+56DCUa0slHC6NK
 ECSZIIs0/1deOwuIwgXbyn0FaNsgIPofchGoGEXAb1IPdMJdVnW/dF9yplWB67P6ER
 pI95R3EWS6WId5PWEiyLURX8+8vBSCT1kxLkFCYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1kfsWX3Rln-011jOL; Thu, 03
 Sep 2020 18:07:50 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 03/10] hw/hppa: Store boot device in fw_cfg section
Date: Thu,  3 Sep 2020 18:07:39 +0200
Message-Id: <20200903160746.27491-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bivg9Pxs5zk9pXYAPLswhcJtZ1lRxLKkdS7u3fq+2iCNNuigm5d
 T+F5ZkVfD/xtaPh7KkupzZtE/kKlRdWKR+V1BIP1UieOX2gKFqkYp6jcepdvwXbT2p+Dhri
 /fv5CI4N3Nb9G7VJu/SrJhcWWzHI3URtRW8r7q0cjh1Hkk4ImX5ycUmnc6QadCNaX8ja+eB
 D3Gf6VlVhJ6pHDuZFbleA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aA9qzjkvhi4=:hWRHk/V+3iJz6mBvaXSSec
 o8VrVAhFF+UU3EII+bDzeh0D1Rf5m6PTYg/2cfmFPnEacnRr8NthT7D41tiQWVnQtKnd818WE
 olzgIBoGMnThNJa0GFuEq6AjYD40OyXnw9EYExoYoiDty+oyeh5EecmuHo+hsii4+LLr3xtdf
 7eMaY7I7i8S2gKrNnhwvgA5TyxXId7wBP/772DXBS7oVOzkP9jlhtniCSybBTEv1lnjL4eZsQ
 8Im3Q/7wk/SZTc/YXuSAsZc1ZZFOQel1gEHTq7MDUkCUULWj6AM6H5LVsV2o1XaPhgzOdvvKE
 1fhncdZ7cURAmbqXcrk+bcntnooNu/pK2BcAnJpTAQ2tknCAxZ6/MkZBarhXt5ylkN7b6nveZ
 /+ahOzngdXrwg/59zRQZdY/2FkJEpKkuFYZeVIVFLApoaYxyA4WXX5HQNBUqlMAvUsr7kQ5u3
 4cv5Xi9MCGQKP8s4TJ8mZeX3y0lboHqRNPkyO8Ow2Ag2A8Yu0xR9u7ORNX2+pVWJOH4ThNutl
 ACQCZCXwiquHX+tF3wjC3M/KSbiHCaSYeow+9NbmfCi2BkIIhFMoVSCc+rb07iTYubBjq8UXM
 35pYFNQoaRcfcM36Qusutupf9FevyD4yPWSPn7bL5v49SbAIYZ5UE/M98QcfAnd1Du1cMovCH
 ktldtw1vT25mYx/0bonQO4WVttlFT4YJuJX728RLzaigFkpJa2dyHSGmgS+b7hgCQqBvo+FwV
 VK9dztuqlXkWPpmGcWh4U7/I3NKI4cA2mB3c5xyIaDkfN7Px1GX+cgAqxrBtJir23s+n3233i
 WY78Wc4Mte6NeUET60sgQNkHTabAbqqTTWg+d7zJzgLWXtpCAf2/T0sO+3lDRkgzObltyQbuq
 dUnFgtC4JF4EDDwA9u+GlMkMKdODj5Yj9DLpKI7rU1QCKT9Q2YQ1KXnY5sNmez7Oin+T2Rp9O
 2xL/EM5cB1jkfAb/S1o3C+PqAvLI8yyW0koLsdb9WAEqbhrqKy2ab2Cxtwa7oXVhlpRfWc7uq
 kSODfMiNvTme9+Db12Ei19C/OEIBp1ij5yUe2oTyDIaqqyb3N3VC/ou1VSOM9AebHBcs/MBy0
 BBaRvf2PLq816kQfuKcRhzrVB/XRFOMEtB6qY7xfy27gGc/QVD0pAYPBP4Nw9KdqFqpkBt8NA
 L0XRkk1KVTq33OmBX6fPY/VKi8iB2UJOMfA3XgxVssVxJLMDs4eO6re+fmSdwHhzyH3lZ+7mH
 O1tzOVNDjs8CbEFYB
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e9d84d0f03..4b35afc9d5 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -58,6 +58,12 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t=
 addr)
 static HPPACPU *cpu[HPPA_MAX_CPUS];
 static uint64_t firmware_entry;

+static void fw_cfg_boot_set(void *opaque, const char *boot_device,
+                            Error **errp)
+{
+    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
+}
+
 static FWCfgState *create_fw_cfg(MachineState *ms)
 {
     FWCfgState *fw_cfg;
@@ -80,6 +86,9 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));

+    fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_order[0]);
+    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
+
     return fw_cfg;
 }

=2D-
2.21.3


