Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A9C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280F82070B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="n7f6cDtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280F82070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX0xc-0008Ji-9z
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sL-0007pr-Jq; Fri, 08 May 2020 07:09:06 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com
 ([40.107.92.74]:39649 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX0sG-0002E3-N9; Fri, 08 May 2020 07:09:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvt+kxsFgMYwSqD/BP59BO8G7298MTBE3sNFkobSR8fPKCNEElfoqxHXt1vM1z+xUJiR+i1cf3mDvy65zzyWtvvElFu9up2tdIYdd/dP5Y+yS5C0aLJN+GvdghbBan2tN2k9RebN1L2/jmANVRjv6CO2mfwE5N5GPjFmDhA85R69Y+cbN7ulSOMaL4NyOl3ayvoXQNr84f6ul7W+RCtUByX6mh8sgTyxZVlUvyURs5KEPoiB5guai1qa56QEjSCJHI500xGaOYRNmHjYo2wq3gE97q3WBn8rG0NiUF+BJ8bwx0hhFAkz7JKWC0TTDic/t89AbVDxe6B/F9Y0hYukTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8J0kol0uvD/ivFgXZAUxIM3+tJzCNSHKcLdt20ReCE=;
 b=GULmRZH1LbY3NHPAvWRIeD6U22vVZ9D9ZfLxBB/QLL4ICSwwEDdZsgr0HlcJEeNQosCr+romXVVZVR6K3Aku8SSYkuvId2nqFOZnw8DHY5Lc4Fu+jrkPAoLFjpdVoS3ousNGkXdbPGv7eBjNjgQFy6SHVMBmNzpAqVABfZXyoRfiWprdfbtfd1QgcZdjgC99jIU1N8mpRlo4ge29EcgwX1fereTSWVZnduzxLLZy0I/Dmjyy/dxhHinBYL1S7r2d9R7lxr+G3TIiApQOrBr+GydDR0jj11HhhqOZz53EtNxAy2z3cwQAxcKPekUdWW+mN5j8NOcHHi1hL4SbKfqtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8J0kol0uvD/ivFgXZAUxIM3+tJzCNSHKcLdt20ReCE=;
 b=n7f6cDtIjg7Y+DpXidSQAz0sGlRlajxvxmlwWTN1GpYRvkKgfCflYSq3q2GlfWzo6/x407e3P50yNCsdODNypBCPrwmo+Sz17YdV90JCmpKVSib8mr3SXOBN/SajdC4XXduRWc4/+ZS6E5G4q4R0pRvvtySdKuRrga9g2blZAdQ=
Received: from SN4PR0501CA0123.namprd05.prod.outlook.com
 (2603:10b6:803:42::40) by SN6PR02MB5215.namprd02.prod.outlook.com
 (2603:10b6:805:67::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Fri, 8 May
 2020 11:08:56 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::21) by SN4PR0501CA0123.outlook.office365.com
 (2603:10b6:803:42::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend
 Transport; Fri, 8 May 2020 11:08:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:56
 +0000
Received: from [149.199.38.66] (port=36216 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s1-0002U7-2Z; Fri, 08 May 2020 04:08:45 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0sB-0005fT-SJ; Fri, 08 May 2020 04:08:55 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8sEb021300; 
 Fri, 8 May 2020 04:08:54 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0sA-0005eg-Ey; Fri, 08 May 2020 04:08:54 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 6716813C042F; Fri,  8 May 2020 16:31:02 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 08/11] net: cadnece_gem: Update irq_read_clear field of
 designcfg_debug1 reg
Date: Fri,  8 May 2020 16:30:42 +0530
Message-Id: <1588935645-20351-9-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(396003)(346002)(39860400002)(46966005)(33430700001)(5660300002)(26005)(8676002)(426003)(2616005)(6666004)(4744005)(8936002)(70586007)(70206006)(81166007)(6266002)(82740400003)(356005)(478600001)(2906002)(4326008)(110136005)(47076004)(186003)(316002)(33440700001)(336012)(82310400002)(36756003)(42186006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb4ddde-abd4-4326-5ddc-08d7f3403364
X-MS-TrafficTypeDiagnostic: SN6PR02MB5215:
X-Microsoft-Antispam-PRVS: <SN6PR02MB521514AE7A25E4EE71A04B25CAA20@SN6PR02MB5215.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:185;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2zXKJwXxSfgkas9Ez+gpmHrf721bSDvURTqPYbILKdso0doPzPiyfaErHiKY1PbEsJmHzflv4LW7wb4Ew5bv+IkW4b2+8G5ErdrPdohvIyTO+Ir1X4QyNSGQUEtA4k0p+Vo8qrPx3GoSBWv6Zg7dcFE0LyGGVxq2ERjDtgE3WjzYdc8kSez9JWKU1+cuCrrIydTMKUrcgrxriVh1WvOHHYh8p903NokMVDQhDr0++A12zzG0ZVd9NWuVTKS4TPEK2xtqJvg5ctoyyvyBq33TZLrGX9c45u2hLMYtqa+cUYYz/FyJGHNiDAohbAue0N8VWRuzN9y8vbg9+zWTCMyJriBEqJOcFyOCwvKcKOvomnDFTVQX8ByBko55gsltsMw5nSYUoNGT+ksftKfOK2wWJPDfxA4tP9DaDBpypJI1Q8Eq6JwcH1hlnJu7ssQnOLzQLAbDf/iRgcOQRi6I/1Zkhid57ycOwkxHCCjryOTqG9gW82+Vg+9+DotMfHTwj5ZDIB8lEezOjP7XClZNOKxanTeLwATGjQJ4HWvTjJ94yGRYAVPJ/SzBnqCqvm0AGxaTdxCKc/6DBmFI/HCFVRvWg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:56.1566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb4ddde-abd4-4326-5ddc-08d7f3403364
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5215
Received-SPF: pass client-ip=40.107.92.74; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:08:59
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
index 45c50ab..65b29cc 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1344,7 +1344,7 @@ static void gem_reset(DeviceState *d)
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


