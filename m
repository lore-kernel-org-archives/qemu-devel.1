Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BD0C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B3F206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pJQJ+GzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B3F206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWpG-0007Jr-T7
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSY-0001VK-2j; Tue, 12 May 2020 11:04:42 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com
 ([40.107.220.54]:6258 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSU-0002eM-Nf; Tue, 12 May 2020 11:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh3+qZPkW9BRK7+sMhi5AEoXfP5/8GrV3vH71q2DvfO5Rp//o1Hp4OGkVMZ77dNTIi9Qipj/bPe2b91esk7g2n2FUlbqHksOxCP8Ej21zqzBMF/vE9QuvvkoiPuGeDz9EHat9AKS4e7GWEJfg23zXDgKpuqdGrlYf+mkZh0Uv1BE/odRRC6GyBYh2UybuMqQ1D9LsPWHCajI+tbVaiQjIb/2bnQo9d/CqFrgO3rUMh7uKhH3xwCTIW6O5dN6uCEHiTQqxvJoUPkKc+P9sY4y1H+A8oP7/NYA0zAxUhiik2ecqHrbwo/S8MTlQt7EkZ6jKkU4jJXc6kRnuDhGvb6DfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPzayAIrjbZxrxN/V/svz7IymftTs92VdxBYGrhN34w=;
 b=g1vSarLSREG1c3VXtAhlGCi8qdTjRnj50AaQqxZfO/ZZ+6Pq3a1IwQGalsz4iA8udr6TV93uvZXPWIfpL396yem90bDUwZQ/daOEYF/ayUnjRa0YwA/t9oY9xDZoAm6UcS5TBXYimw2k+poBjLaS6J/QVUTFEoGXqQ7QrwDy7saypM7r7Ry25fUuYAKuub5P1Wo+HnviB0W+1jwMQQ2M1Qhnx1Gm4IJVOeOr7aiDDOZWzvV51fL4Maf/mFnEzxaKwehJm1k0fZtw9GE9tPFvQkX/jYHqn07fI0U8cZNWISVHuwDv0KUe1h4lZM2+gkJ84MAMmcF5WukowOl6mqGAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPzayAIrjbZxrxN/V/svz7IymftTs92VdxBYGrhN34w=;
 b=pJQJ+GzLpevHnndt6xGBOxT1HA3cqdjtJfad5LnB4lIge9eFkFZzbOt9vAGM4bel0ZmFdE8jpMiK5oA+Sy+YAUJXBfmH34qfCliTBaZ2Xql3Yg2Wp67YUEfaNFVei+MwA1zwAD+HH5dFYzAvUiqfHsMow76yQPH3WJezBjBP4RU=
Received: from MN2PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:160::22)
 by DM6PR02MB5306.namprd02.prod.outlook.com (2603:10b6:5:41::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 15:04:35 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:160:cafe::5) by MN2PR13CA0009.outlook.office365.com
 (2603:10b6:208:160::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Tue, 12 May 2020 15:04:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:34
 +0000
Received: from [149.199.38.66] (port=48847 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSA-00045g-3P; Tue, 12 May 2020 08:04:18 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSQ-0003og-E9; Tue, 12 May 2020 08:04:34 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSP-0003oB-PV; Tue, 12 May 2020 08:04:34 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 6194213C0189; Tue, 12 May 2020 20:26:29 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 09/12] net: cadnece_gem: Update irq_read_clear field of
 designcfg_debug1 reg
Date: Tue, 12 May 2020 20:24:51 +0530
Message-Id: <1589295294-26466-10-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(33430700001)(2616005)(6266002)(2906002)(426003)(336012)(70586007)(70206006)(4326008)(356005)(42186006)(33440700001)(81166007)(4744005)(26005)(47076004)(36756003)(8936002)(5660300002)(186003)(110136005)(82310400002)(478600001)(316002)(82740400003)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85224c29-8bd7-4ed4-8f74-08d7f685c858
X-MS-TrafficTypeDiagnostic: DM6PR02MB5306:
X-Microsoft-Antispam-PRVS: <DM6PR02MB530646A5A6B9023C2D954920CABE0@DM6PR02MB5306.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiELMi6I99NXnEUDTZ81YxzFwgAJYWDOwPy6+TD+0dChDuKPfBYL0R+l4A7hSdKYW+pbZ3ViZMz04uqIX044l4rUmfSiEGfm8LMqc6Q+0HtZ4KyeGZPh0rfaFHSn1KRajVtk3PvoMuGvcDdIFkjw2q2Pu+ELZh74s3FunqMQS/pVkgp/jnDfUPdWGWWhUaUFE1weM5sWp04gDdFXggmTdF6vmt+pmf6EXS+mooro4yxkO1oM7BHlWz/1Lc1Wn2yQeOSKoqnOoFl7EWUQaH4U6vF5mvsPtymMf22K3HAUKxbOqojjYwgidg6SNwVggUDlbZb+x3Fe8+c3k+peo0jPUCqErX+SkfPO8Ksy6kk+NzAvKROEhtK0wTxWAhbvSHmKKnRdRJUG9quEg71Av1euEVCvgtR3eKaONqUbUfiHhVkof5HuhqX8mEsWEBGrcA0O9j2MjymnWSjb0IYJqFAc6LGg+OsVfYH8DjKom88OYrZmdb+bpeYPwGpmCueZhrmJ/SS54TvRXI3L8PKQ/1PEr/fXUzpHWo61BdNyJ0tyUcvCvK20NRd7wzq5aL0lsk0OW1qUasDC3PtkCEsIXJ/c8Q==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:34.8404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85224c29-8bd7-4ed4-8f74-08d7f685c858
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5306
Received-SPF: pass client-ip=40.107.220.54; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Advertise support of clear-on-read for ISR registers.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index eb02946..3e7b32f 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1371,7 +1371,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_TXPARTIALSF] = 0x000003ff;
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
-    s->regs[GEM_DESCONF] = 0x02500111;
+    s->regs[GEM_DESCONF] = 0x02D00111;
     s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
-- 
2.7.4


