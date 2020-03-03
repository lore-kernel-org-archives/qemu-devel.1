Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B4C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28A72073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZM6jv7aO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UbI5XZye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28A72073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j989b-00048H-7g
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j987B-0001L6-Ke
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j9876-0006cf-Pw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:01:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3240045c5=Anup.Patel@wdc.com>)
 id 1j986z-0006Us-2X; Tue, 03 Mar 2020 09:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583244089; x=1614780089;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=35Q3OluQCBU3ICFwY+MRvYIXy9GZFJ6ogwmGu/sx0/k=;
 b=ZM6jv7aOA9ACXFL74crc+9CLoJfj94atk9qSMLbI+XRSgETh8FtTD0md
 JxoMAPUx6g5T3MKgIP31nbNwaLoORngt+X4AxhBYGwDXntcEOQgog5NKb
 HRh8gVoGkv+T+wshGKk7yccvQawgxWAr9UghrbUDRJxQrxfYA2nDw0+Ly
 jyHZFD8MB85A7CGtihVfLHCg0xZvUcmhr5ufgt3SPJou8Ku9ZOXrVNJHH
 I+ZWjajpHWNiu2QlGaMzXKHKEspLzCQu9c6h295tRDPR9A8aKv+zISuqU
 nuNcqCoSTPUC5SwX6WW5kIrC09oqC9Hp2w0JJasm/SQu9RzYupLJYJUKQ A==;
IronPort-SDR: fX6jXZVyI2bM70D+9KjAc2doTC7sIj3GZ/qd3Ar2/ls330G7ESK4F6LJzPG5EimvVIDbBCf2Wz
 FMGVWHlbdCRKKkr7158VKxj1WjMPR+eW9x2fiACHW2GLQQLCPk7ot4t4S+HQPUAz2kp+M8zBFz
 9BmYEUsGaseY/LF/Tr7je0KZA4aO5leR6LrmQ/3WwUj2sWBtxqQG0n3UDRj+3yWIMosK93QkF+
 XE/Lbe9llO0GMNZzwOE1lHS2z99GBBt3ReoC90D1EZTMuwA65AeDfUvXkjIllaMM+5CA9qaETM
 cWU=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="132719445"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2020 22:01:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd1iEBa9dgIYJSEKglGEnncvtgtDeHfnQP0p5/+vAYsEhM56xvVK7ZbWtDwHSfcZH/6gIee//ZIa5FOa7djiqGUKdNcKacdDAv4wgCU75b6E6YuQRrHecQMNSTlF45vQD7Mu91Y0JQLWk63kK3dFPr8ayrIWOHtyqaiV7Ahvk3M62r3rK3VtJd21AgBorP9CBmSPerEBnS+c7bMNpQ3ChQi6mn+iqD8eHc7MuKvqa2B5D5J6as6hXAJTcD9loXHCTM2KjAHIEfkgQifwFL8leVUpwkXe9RRIVb2kio5OJ1yorNslMkXxtOfVVL1tuqWYHBOeWmGVd/R+w0OAJd47zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcgcTNraO0UrtJ4IFoa7WJaDFkllD61d/YYHSIQPpuE=;
 b=m1ZA1RDAgNrEuMyAH6QawuRTMxX3qqgDLsTdT5UTs9iu6jDIoh6b3UAjr9a30feROPU0uw7bT3Hv62NFDu8sdoRj/wdKiKwQL3nXaBWiobSYjY5t1JGkfPdyswY6hmxWS4+iCDqYs+4OCcrZuebRGazy3v4jV1aGsWXSQynze+28mipQp7+kSmQDGS50QqRZp7mee+SfyeJZNr3NHmwjTsxPRKPmlBOwZZ2pDEoum9jSJsWSsa49jH39DqgPihXpJbdj/sPm3PSrB8ro6v4vy8b4XNH7juz9canAB1jS56VzsHVPCqeFl7Eqdjh5tcDl5QK4NOM18pVxe1K9VcK9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcgcTNraO0UrtJ4IFoa7WJaDFkllD61d/YYHSIQPpuE=;
 b=UbI5XZyef0/uHxncGZRKRz06QnIj5Y0skD8EzWEvKZBRkjsC6IwdE1nuomHvd4e168v2jMAKloDGimaLnHNX8VgVa9vJ+IJVbXtHG7WMj0begCqTtIbWZPJMinR7pCX1l7rQ+QKCXttEct8o0NH7oAEUFaQ6Dcuq/nIC3EdejMI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
 by MN2PR04MB5949.namprd04.prod.outlook.com (2603:10b6:208:fe::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 14:01:21 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::159d:10c9:f6df:64c8%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:01:21 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 3/3] hw/riscv/spike: Allow more than one CPUs
Date: Tue,  3 Mar 2020 19:30:37 +0530
Message-Id: <20200303140037.85311-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303140037.85311-1-anup.patel@wdc.com>
References: <20200303140037.85311-1-anup.patel@wdc.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::13) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.61.196) by
 BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 14:01:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [49.207.61.196]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fca2158-6c00-419e-700b-08d7bf7b5a44
X-MS-TrafficTypeDiagnostic: MN2PR04MB5949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB59490230628AB012097B69B88DE40@MN2PR04MB5949.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(2906002)(2616005)(1006002)(6666004)(55016002)(26005)(54906003)(110136005)(8936002)(81166006)(81156014)(52116002)(4744005)(44832011)(7696005)(956004)(186003)(55236004)(16526019)(8886007)(66946007)(478600001)(66476007)(316002)(86362001)(5660300002)(66556008)(8676002)(36756003)(4326008)(1076003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5949;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNcQyTAbgMF5GzxSYw6uI5jKNHNT+xe5mzPQfvGZTJ2Cbk/yCTT0FvmORqWU4qnDNa0BhE9rhiHDzGZWN/op+73FiHsww+FRnrnhbKdD5Gp+fgm25dCtNbpM8KZUbN0akyqhPhxkvsa+ppro5bB+ZGS+WpHtn9z3rb2k2RcaTxTNHqaRNTTAueUdzVqoqpS5x9iUiww0OXSIlx/zwQNGXyldO5BTl3uk4E3Z1FS0rEdOXt5oaohsyPl5L4/JdAG5LJZO/vBQmjnzIymtSZ4NZ/5dwhBAe6P/rXoCCOcJyVBm35rJHCxNC5l6xHLLOP3X0OLpHCgb8iC+0pmuuIAAlDXDtMqRnB3rgVJ+zDaEjyHVzx+Cd1ei4z78EqdQIyqi/TO7Q9vrZGqETC05Wt9+0KKXIFPzwRDR82ufOznk/O6TEhyiVimFigv/qplKdKca
X-MS-Exchange-AntiSpam-MessageData: /oQCj1rXSEBOVu5YUNxmuiJz2+4UEo/CCDG1ql6oA5SW/+cS5qKgucPZ5Ik4f4XF4PSqp9H9Y/kT/AGu+4q7nijnPIkuIOg4QFLcBL+UKXkQngpAdzfzLiRvPRMQ2xtN/y6XdYPuavM3RakBL9nZhA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fca2158-6c00-419e-700b-08d7bf7b5a44
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 14:01:21.6969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqFDrM2JOEzTmKd2NPL72XDUx234dAYvc9Z78NS/NoG656l9lf2tSPnQowGOj6iAAh5Jy72ZuHelYXl8M/ASfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5949
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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

Currently, the upstream Spike ISA simulator allows more than
one CPUs so we update QEMU Spike machine on similar lines to
allow more than one CPUs.

The maximum number of CPUs for QEMU Spike machine is kept
same as QEMU Virt machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b0395e227c..1799b9291c 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -472,7 +472,7 @@ static void spike_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board";
     mc->init = spike_board_init;
-    mc->max_cpus = 1;
+    mc->max_cpus = 8;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
-- 
2.17.1


