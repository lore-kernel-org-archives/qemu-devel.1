Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505E9207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SfX3BJrE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l2E06PDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505E9207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0kHT-0006MK-JI
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGG-0005A6-HH; Wed, 29 Jul 2020 07:28:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGD-0001pI-N3; Wed, 29 Jul 2020 07:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596022124; x=1627558124;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=09Sug5rhgq2mVtUmLaTEhfJ4XjhXcBB789dfYCzShRg=;
 b=SfX3BJrEUrWqVt3mDDDWiotcfAXLEoaH/W1uhdVFzl39Cf6cK3xg1dZJ
 /zDOnXMBO3fBZO5seV8rI5FVAodcq9wl1sMRZpAtawDeN5P1AvuTCwv0r
 RUk6uwElVRF2/Xd2jIGewQKWeHDi9aDLJe2n3gQHVO0qft9rTgEMqAR3l
 NlVQm5DPfQRBvhlvcm7IvkJa251CI9vmA2bVmgDuNz4OjRt2Jvd++tJu8
 t+SS1lDr7zAEBOJgoYOkp67z5ulaGyE4b2JTgYx0Ux3kxj5mMre4lOBN4
 DPue0o5B/y6Wx9IDS1GCdToJWU+Hga1V3L6SZDE20FUtBNHJzyUUINit+ g==;
IronPort-SDR: gVWHxKC3DkDDV4OlAWGFgsWYXSm3MO2JDyXFEW3m1EWF4MlALzQi/nzZjV5Vs1jAY+/tx+MrLa
 Eq0jp1bA9QwcQmQYWkZnL66S/Cs9zWPhnPcKGpszYqknPPoCgMscKkh8Qc6jIUSbfCe2GSOokI
 h5yv61FdYRqTNQt2XNp3ZOvVK29NPgRV6/aqvT8i5nr1qQNhXgt6Iw2sHXcEX2ySCCagfpeD3b
 9PQiLlPCE3cLmsTnAYlGInvlDlIbyzqyYZsew+EmiYJdoTa8+eN6BxzWcrHhKNQRfaTmTXGiEh
 yPg=
X-IronPort-AV: E=Sophos;i="5.75,410,1589212800"; d="scan'208";a="246734962"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 19:28:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE0tE+l9q6Cbq4/JuwHGkxqkbd9v3gGmy9NyA4luVNTaGjOFFOarimOnk1mTxa594/1HdXf9Cwv4420V352elOv4EQ4hpCAiEz1cFTgQ7M6t5ZixhiV5hsvtUY5Q8ymiolgxQFQ4T7UuN9frkyxQy9wONus8AzrAI869GEFeynOf8n9/xuJ1gGbS6Hmgh7w1hTVzn4Vw56XnKHMUDZTNgbLH3vCXBwwkmE+6dzxmQMMg8CRqLt9KyP6GU32ShH2Ig3TzWI5lGggxnuDIlRTEOWJeUjy3vFwHYSrQMgfPqVIpi+hfNIXdvl6XN6jcieLC+1P/2xSL6EeMfVDJyuAdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaLtO+T8woIydig2aHLfQVEUicrPHwYCWUsIAafoxfo=;
 b=I7TJh8pQ8Bv/BVgf6C7AxNay4SwfOlMkdRtRLnwLRyhbNV3Ia0WeoLsof+vO0f0DrO0XdronW+XdPfbSY5Mt5nOpISvqbuiHSXerKjeU89fL9O7nIrt6vrU6+MycqZ0QD5/lAFHQEz6y7QviVf8oqfGoc6W8xYNCVLXuAGX2AcH9SCG6CU4aAC+vQsR4OAkw+zaK32BZ3X736IM2/MG2F1t1iREULR67keIbzXfFcJDFEo7YKPIsffHYdinnjXhcTJmJuf7QAc/kLcGAvhIoohzsI6WGhyzu26CUIQ/TUDCqH+K5jAe9EKFa5mR9ngaxxcXttSrlxppGfIFXLuRdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaLtO+T8woIydig2aHLfQVEUicrPHwYCWUsIAafoxfo=;
 b=l2E06PDNHCVRYR2fddzMLgQI6lEgtlXZxJLoTBqCc8K5elE/vatbV2VeOUFJRD9/JnZpWa/FrtYHeSdv6AaLQ7HwCtEe/j53syuaSxkNaiSD+g9mx9B/gueK4xlm/mxzXyTtJsckA2yxYmYAR0rkNcjBZNH+wcLSanoC3tOhrw8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5753.namprd04.prod.outlook.com (2603:10b6:5:167::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 11:28:30 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 11:28:30 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 0/3] Trapped instruction encoding support
Date: Wed, 29 Jul 2020 16:57:58 +0530
Message-Id: <20200729112801.108985-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.183.175) by
 BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 11:28:26 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.183.175]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c61dc920-9027-43e8-0cc7-08d833b284da
X-MS-TrafficTypeDiagnostic: DM6PR04MB5753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5753D631960285C86B300D008D700@DM6PR04MB5753.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MVnN/4QD5Tr+MWdxGeLs5BHBErSMj9e2W/rX0Z4jXPb3DHtBZHYqv5ctdP4P0irdAf9b/rjTnQ45/qZ1oiIoh1+hmpSGCk4tDumzcjWrYk1JsBZkc7vapfy/G7Odot0DOtUB0QvX4ZxR9pMrw52Zi2aXTQOdTl+bF4jU5Y0dTCREg7ow2/2+4qYI9ANRu3ceHXKKYTkHb/ppnQdhnt3DYoDCOp2Zuki3z8uUq6pP4GSewf2brN3XG0hqRxYxoxMmNIr24by1b7h/FkWLAZWsPoWzQD55cNTed20CvDhybefRoTSYf6iFRIRwgZ4+YGobGOS6fNvgSZaCi/DCWt7Ram7faPUjyAU0/iEjtwDEmWNuSGS6Slh6qzErZ/aT8S5Ecd0X7h647Ca2rdujfZ/dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(4326008)(36756003)(956004)(2616005)(52116002)(8886007)(110136005)(2906002)(83380400001)(7696005)(55016002)(8676002)(44832011)(186003)(66946007)(316002)(26005)(54906003)(16526019)(8936002)(86362001)(966005)(66556008)(5660300002)(6666004)(1076003)(478600001)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MAoPsobMM/7mPHPFD3dfISB4d24PZylukaIu3BO84VAoyY/x40vKcgUx7d5MmY0BxeDvjXPHLBMVC56GIhaobSU/AYxA90FNhxxIFMIYNBj6iZk2eF4s5LdRZxmqXnGUaGpvnOVDWZ8vOWoSo3QLOjZQtYKO7Ayu4M8M36eQkLdodrv3R0PNJ7RYtihi+MSTxzNsrGWanPjLumUPf6pDAXC/cvcFYqJkudTV4e4IOYFCUUP/xg4wxeoQw6Rbirh5uTUsq3WrzySevIH0y0inNM2yrUm32Ho36aq3vHqbLZFIccbaE1FvBVQlb1g7aghJZgjT0cxETOvxK3+OE9PINRdMH+haBnPxGpPaYmNXnrDRnfyl1noRfDKI2H/6VOZHnAoqTEnLorZY6Ae1YZtXO6MnfV0kbqg4Quz3wXmevLmfh2HrkgKfDvMzxNrS5CVwPDLe/lGprpoHbpvmVFFj0f8doLi0gCUrG6ZKlMSycdjGG2ACUD2BJ+DEq2kAgIlc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61dc920-9027-43e8-0cc7-08d833b284da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 11:28:30.3270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEqWLQjDl07fjclQy52nte/8MkEbn19cYlXjiqvDqAnenGb2gAozrAfyg4sTEdjaFXoCbbxjj+gX9NuOKE4Xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5753
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=47218c038=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 07:28:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With RISC-V H-extension support, a RISC-V implementation can provide trapped
instruction encoding for almost all traps/exceptions.

For illegal/virtual instruction traps, the instruction encoding is available
in STVAL/MTVAL CSR.

For load/store faults, a transformed encoding of the trapped instruction is
available in MTINST/HTINST CSR.

This series implements optional RISC-V HART feature to provide trapped
instruction encoding in appropriate CSR.

These patches can be found in riscv_trap_insn_v1, branch at:
https://github.com/avpatel/qemu.git

Anup Patel (3):
  target/riscv: Optional feature to provide trapped instruction in CSRs
  target/riscv: Fix write_htinst() implementation
  target/riscv: Update MTINST/HTINST CSR in riscv_cpu_do_interrupt()

 target/riscv/cpu.c        |   7 ++
 target/riscv/cpu.h        |  11 ++-
 target/riscv/cpu_helper.c | 172 +++++++++++++++++++++++++++++++++++++-
 target/riscv/csr.c        |   1 +
 target/riscv/instmap.h    |  41 +++++++++
 target/riscv/translate.c  |  14 +++-
 6 files changed, 241 insertions(+), 5 deletions(-)

-- 
2.25.1


