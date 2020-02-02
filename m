Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFDAC3524A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D1720658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 13:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cEpKronJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fgqc/+ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D1720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyFXP-0001Xf-U6
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 08:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFWU-0000Sy-RC
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFWT-0003wu-Or
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 08:42:50 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=29495a510=Anup.Patel@wdc.com>)
 id 1iyFWP-0003tc-88; Sun, 02 Feb 2020 08:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580650965; x=1612186965;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=1zhTVCCwaWRmB+TcpTz4Vfw8SxXfFOYlyMao/4XUixw=;
 b=cEpKronJreC8e+a8KCPVWyH0zF/QyUTeKgbnR9tnkG84vXlJvpzcexeH
 0OGsk5Xy4+feFiLGqSp5ehbS663pE5+xubCMzdGMZV6QZVloos9iRXNCx
 ZIVSxghyBPXArV7nPu0p9jDduQJj7sFkHSC82DRISnRhGVNGAVG2EWSV0
 K9TiFsbzuev9QBwAEWPve69JprAM2IoH3YhpaCkn30PPRk9y86m9aWj66
 F6n4Y843GQryukCOiTeFvZ8Nv9NuOcxfFGGYFAcw6MmXlErmOoycBntwK
 5sucpGb7xrQ0WqvuzNkQ3O2HisRb3I1IEzEXvHHgC9LHlMKuT73Cuah+J g==;
IronPort-SDR: Zsyz/t3YHqgBPgupFYXHh+3/BRAtpAVhso0t9z7t99x7y9qa16JBlgctZsMBQMPOlWIuLqmIvD
 s01TlwNF2YNaWP9v/h6jb7pMG0PJOW0bnQjjKZUpi2fBeCppnuIfkoKZ974VI+Aq2IEUt9aejU
 gQan4p9kKMULzf8xX7Nx8affmaIX5WLHDl9C7bnjyX3j3r6pMpcg81xFPsdlBQg3ofM8qVTjGz
 8gmq9GeeBneqpEYFfRBPIvxfapsufDD5PAPSBsS/eGgdN3X0kvC9/12Rcl24nf3l9dIw6XIbUU
 h6A=
X-IronPort-AV: E=Sophos;i="5.70,394,1574092800"; d="scan'208";a="128929959"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2020 21:42:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTojw8b5C2HjLdPAngyS057iHpy+5wE218hwCiTHKqtxRO76bbmGBMWaFu4bpaSWd6b4F2DxOmajltb2oV++OIoNATy55et6HRDsAPJuAT8EmQ6ow9oj9c7TcM/JSuRU2D1uoQJTHcDhNazkhEi97XeljcKQBbnNt2cYDeir26ZvE7X3HkRL8fpfAzbCNedYU/ago9XP2HaOJg7AN/0v7UL721DeT/G0Quxk/zEmawkD9EgcP8nfT+xWRd9Ef0HArpQh/JlKDqMiEHAF2VNSTTPumUuivp+1NQokIe5cROUpduNizjBWrEtwb1MjzxMtuYKJ1fQ6g8fOtbQL4IMkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBlVwI0ZnIaiiAOtqyTlm/dWFzGB7thFu6Kxtx5HTXc=;
 b=X0BWHyghwh5p/R3JU2P4BtQGXvPOEsPH5rNSSlDZSO4N66oSFUoMyNJdTp/IoosaYgkYuc7+eS3mB5QLips3kaNE1kcmH1bXH6WPswY/6oMQU4rpRGUe3d1e8gptajdV9jmJQ7mo7+N56841rnlK82fp/A3Spae/dwUjhFPvyWRpRiW6AYuhjtaa49dWdbOBbFj3g7Tf4eU7x7ueS2caR7kMVuFmdyJKLl3x8oE1l2GgLRHnC61KZHC03as5yPb8cFDXlV9SnalOV/iTexSPwtzxR86LE3Yo/hqHl17oF9isEnzsbuokNnFNXbJOzwnGaA6EKNRqQaJ0o0fvWUsfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBlVwI0ZnIaiiAOtqyTlm/dWFzGB7thFu6Kxtx5HTXc=;
 b=Fgqc/+kapXYdoZasEJPXK/cpguwScO9lrUHSofekRmbriknILzgEspgJAZpMRVV0VcSF7tkB6vm1yuS74gfbxPBQEAc7Yq67q2rhTD7jsn7JtovY29v5l48jOc716OWiM0wHJ/TtMpdpyuqPkBcOOb6pUDVTcYiwBR4IBsTrQrw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB7038.namprd04.prod.outlook.com (10.186.146.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sun, 2 Feb 2020 13:42:35 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2686.031; Sun, 2 Feb 2020
 13:42:35 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 0/2] RISC-V TIME CSR for privileged mode
Date: Sun,  2 Feb 2020 19:12:15 +0530
Message-Id: <20200202134217.14264-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
Received: from wdc.com (217.111.249.45) by
 AM0PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:208:3e::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Sun, 2 Feb 2020 13:42:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.111.249.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ae1cdd8-e93d-46ba-4842-08d7a7e5c2cc
X-MS-TrafficTypeDiagnostic: MN2PR04MB7038:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB70382C816CF3ED1DEA1919B38D010@MN2PR04MB7038.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 0301360BF5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(26005)(5660300002)(186003)(316002)(16526019)(6666004)(956004)(2616005)(44832011)(36756003)(8936002)(110136005)(4326008)(55016002)(1076003)(54906003)(66476007)(66556008)(966005)(2906002)(55236004)(478600001)(66946007)(7696005)(81156014)(81166006)(8676002)(86362001)(52116002)(8886007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB7038;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //wgrzc33xoRVIGilde2mwml/imwTUBAiXzknueJdRWCOlSaIWQnmHdxsTDXtDyyp+jQzoaE6PdDOmaoW+JMoOXv1igld9XUasIo2NvP6vugvw02gf/bxhq70gdWDWOJeWs7YBSealmdV+EiQuGqC4g9LFHHf1HYI/+ScjYhAO5jS3qxuvJ9pI9M7mGF0S9JWjvRpYbZy6LwEdxR/Z/ud9nhQq1hr1YAi6BeM/DMDKOReV5g+9QY4iMdy2rB31pxv98ROCA5g7aTaFtlydzwrf7AlAaHNY/VJQFjUFa36al1Ae6I9iVbdyuEYFQwu6UNCBm2hPkCFsvYpPDJ/LSf1M9L9ObCgYxDNS17E2gloRjiRDh2jbHg//rGVN7jRRRXs7RsKqhXvPPKPHYc/HpuNQSXlF5tVFpm3PKQfNnPkfLfIc9oZpBHDOxerS1v+tl3zdrMEbk4/4wCpYTR5fbQkInkaBnD2Vahu8DlqIgtcpAqbl1nI1paxRAmK3KmZNfDmypLzH2HKd8SQxJcOqljsQ==
X-MS-Exchange-AntiSpam-MessageData: JUdK5hEEKSG5gYrC8IdqmFURUolAGTraKv392sIda2SBt3tcCFnRdEHqJNVgF9ohe/Fn38jnVh2bh8AeJ5/jtkAO2NjnYNQ6flsztkQUJsKDtYQ++c4Y7Yk8cmb+cou0H/i3biYBHLGig1kSZwd74w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae1cdd8-e93d-46ba-4842-08d7a7e5c2cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2020 13:42:35.6240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV7jDkmFkPXSR+uXf/elpR/wa8SdP72qNjrpgkBct3mpCU2i5vmfOPc5aHxWIbmRuE90Z3Q44kSpuoz4p68ucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7038
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds emulation of TIME CSRs for privileged mode. With
this series, we see approximately 25+% improvement in hackbench
numbers for non-virtualized (or Host) Linux and 40+% improvement
in hackbench numbers for Guest/VM Linux.

These patches are based on mainline/alistair/riscv-hyp-ext-v0.5.1
branch of https://github.com/kvm-riscv/qemu.git and can be found
in riscv_time_csr_v3 branch of same repo.

Changes since v2:
 - Register CLINT rdtime callback only for QEMU RISC-V virt machine

Changes since v1:
 - Use braces for single-line if-statements

Anup Patel (2):
  target/riscv: Emulate TIME CSRs for privileged mode
  hw/riscv: Provide rdtime callback for TCG in CLINT emulation

 hw/riscv/sifive_clint.c         |  6 ++-
 hw/riscv/sifive_e.c             |  2 +-
 hw/riscv/sifive_u.c             |  2 +-
 hw/riscv/spike.c                |  9 ++--
 hw/riscv/virt.c                 |  2 +-
 include/hw/riscv/sifive_clint.h |  3 +-
 target/riscv/cpu.h              |  5 ++
 target/riscv/cpu_helper.c       |  5 ++
 target/riscv/csr.c              | 86 +++++++++++++++++++++++++++++++--
 9 files changed, 108 insertions(+), 12 deletions(-)

-- 
2.17.1


