Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA8C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C2B2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d3Xx0BCn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fbQxiagg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C2B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyod-00041c-HN
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynV-0002Pc-3h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynU-00017m-Q7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:07:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=379c65f89=Anup.Patel@wdc.com>)
 id 1jSynR-0000s1-OG; Mon, 27 Apr 2020 04:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587974842; x=1619510842;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=ksntG8hessQCfmDp6D68c6HkRE2++OJ4v9sY2H4EXYs=;
 b=d3Xx0BCnw8J+fDB8v0PedhM5JMnT3veF3zdrv2zRonZMyMQH9rO5KJqo
 OPbyZsR6bMNFd1l2FZcmfGqE2C7PHnZZ/iBMPbmEqswsTPX+fR0ozceQj
 TORGfsj9ex6q6tKDeeNaz7GLXR+SPpalK7xslURiJ1FP7B1POzXcuvM8a
 CgJbIVBFSfU6QB72E1UwiYu+3/V1h3SdN3BvKuHNAeFp52837Fc2NQKPp
 JMLKJw/iExP4lWqd841DZM2KexLeAyh5oYMpMM3IPDyVw7bt87RBSIb1X
 uo08z499zZQm6+5U7NO7QUc6mHvPEBzHA9HHUro8y1Diffqjvm7iv+B/M w==;
IronPort-SDR: Z39EfUEzAqoZKLkw3y/dCVEq+FYfY296ZdNPv/1RmBTin05tZ8cCWM/xT6P5e0ryQHl5i3mhg8
 Ks8x6FdL2R0K9TBjjflSNdjmkwRe95XXE/XanOOWDULZvRKY1IX1ncOtHE3htt9cXWFLSd1Boo
 R706TnhnYdIeTqCCPVvsyZ/I9lyOYVJYorCah19Is41tlxp94Mh2mlucXRldfZ0RHIJcxgXnlz
 0i70LtZ0eVMpPU76tbbX2k7GXrqVw5I41mnzoiMq8MRCS2BWJphh9XTUx3QcSWkteE67tmtJ26
 Kv4=
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; d="scan'208";a="137668048"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 16:07:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiWRqB3t8fCr7XV2FA5zxjeFyZxd/ru+7JpyRi2VxlwU8u5daUOKiui82vdpl5EX8xf7EWAeBLeYXPW5FueVwqResXctHS95vZ2Q/wx/cLHMqFimZlRnfDiIHAN+Vo55L4zt98zJaTEm526TOc0JukHvPzp6O+GMyJ55GkQokv4cJzM3XwSfaQoPNkCzMp2YA4YOUOkYyWRJ725zLsKDCZUWeGYH5kKpe2X2T/RL2giTXHe410wDpzE8JWc6ZNpuJJYEjpZowc57Nwl/DwWvZKCd/l4E4SJ8P4bNeKCZ85YmRhOBpqe2Pmur0pdzDit9Z2h0E9NxQR6pRbofKo25CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSKmhkZ21+5jLV3bcBdB5WAQo1ubblSbqzQ8yJ5geqc=;
 b=Yjna378JCqELjBqZFCAbh6Dva+dQLYFw6/bBTJcdcRuk+Ajak/xggzwy5e4P0r2M8MSjapGy4jbOB5ERrYVhvUc1BCvOZG/LfWuXoEih3XCvUfwci14IMI7ULoX1v6923OVkEHU36maMwge94B9JRAWvhyacziomcvx/Iw9x6tMC4+A68cE8wto7y3tBIlMt5e2Vggkto+hhD7HfYavMVadUGvASggs51e1DiuTM99TzEEg+ANUCDjT3pwcA0iyNNq24n+e9nKyv3udyrjNa7YJ0EX+clfzu9Aat0Fw0x61zAgiDjPQAulf3iMwNcySVEurgB9uuBfaJn2CS9ZCAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSKmhkZ21+5jLV3bcBdB5WAQo1ubblSbqzQ8yJ5geqc=;
 b=fbQxiaggvD+KUXybMKwIAU9WSJMlx2/83n7zYkBK9sjJ8W3UZ++/hlX0i28D0nlBVf9b0owfEYPxwwvvM1JTco1MhqpcuQb1F3Ic7LxGs+UEW/RNq0exLmFn1n4J83p9pgwWEUrBnYWqV9BE4FQ7DagpDptdNQhedC3hlH7ClWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (20.178.225.224) by
 DM6PR04MB5241.namprd04.prod.outlook.com (20.178.27.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 08:07:14 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 08:07:14 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 0/3] RISC-V Spike machine improvements
Date: Mon, 27 Apr 2020 13:36:41 +0530
Message-Id: <20200427080644.168461-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::24) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.31.156) by
 MAXPR0101CA0062.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 08:07:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.31.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56b4a85c-1c57-46a3-dfd5-08d7ea81febc
X-MS-TrafficTypeDiagnostic: DM6PR04MB5241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB524194957FB6C0093695F65E8DAF0@DM6PR04MB5241.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(55236004)(16526019)(6666004)(8676002)(1006002)(54906003)(1076003)(8936002)(81156014)(186003)(478600001)(316002)(110136005)(44832011)(86362001)(5660300002)(8886007)(4326008)(26005)(2906002)(55016002)(7696005)(52116002)(66476007)(66556008)(2616005)(4744005)(36756003)(956004)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hx8593/i8Of5eBTJPlhJ898+4GirJ6CF1BEF47EIBM4ACUKCaDbSm8H6mA6oywSlTLvvUXWdZ2cVQ9Yv6ACmOQ4ablNCSQcCEBABlXUHaqz6Wk3hdbIpIaepzu3BT4/YJ14T4WpPNA2tdAifyWBVloSVdviZ0nen4R3To9fbra83es+UcTj5ACHxHPDB73XhueoLV6Y9XiIRUuZ1uDiqJcYHGBdFVYAUSfrYLKPpXjtms+xi/frt0B11gXBS78IX+LZMHTsKylt7EreWKO65C6E6HCo2xbdGvs6xTX4LqfbOPyqzVlMwoq61TZQI6th1kDA6UQBJtGhYtauC0wSu94VQO0WuDNy5e+Chh+TD+5Ca6b73M+r4z5FmWkVKKnz+aAuJc9LisBRRjpP6TLV5Sm+xfOLlBy3SMoqbj3hFJ3WZkWElYE/5HaVwrszQ7tfh
X-MS-Exchange-AntiSpam-MessageData: 2jnSkonXUlHDreSJIy2+5SziHz82h++Qxi2x46qyBVjvn+Negfc4TRFENzYdp+ske9eutk7NYcxfH25/HebX4Rky5zbFvrKRfTwEDzDKm6VgmssPf0+kxqGT0iPgq4AOFGr7L4BKkJaQwIVfzZzHKwjeixU6sClIW5/TIVEo/+6f2Ifhp4C9pvJlhppNFUE/g0VBaWW9M7LlUcSQ82OgVOZHFSfgoISJQxc/ZH6mx4TEk4K9IUNSXZtcUKtBlOqmCF8Ud9dgQaQmzejeN94Q7xo1/u10nQ1UyTV0AjNuZHb/P+EZBwSl4kWw0O+fds3QmU+hOnbYkdNx4aa0RgvdYlmNR5fxHEieGlCHlTMx5wTDwVk4rH+N6QkU4y7wfrrKXRAI1RYkVVtSIw6u9ifvoyTf4n9L4km4nGE4uSbUwe/bXKbYtnbUx9+qFbvFVE3tToUxH3rejsyWToHdRQA7vZCgSPi32QEOrIMN0A7Y3rWbl7vwc0rP4gh1z7/6SgSL5KeBlM2wY5XYJMgK/TsKwVv9F1ecuhvSCXA7lrn9mBLyX0J0FCEYi71T3I01HFdAbli8IgNCUeGTSTHGjj0481Umujr8kX14GajRDra2WIwcWKZx7lNsqDMW0AxHgytbr1AFvilvRLUfqUq1ntQeax9S6ASiBSWyyeyLEDAx7n3yjX06SeF2sZIyemI9AsZBKUigQdxCRfyrd46hyYednGrB76L5Ed7g+Jel+DuuQyiKz+IRgLWiuZQTUm7JhMY7RgNWpX30mgbrG2jo2qkQFqaZranXF1AY7VUkLkAK0TA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b4a85c-1c57-46a3-dfd5-08d7ea81febc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:07:14.6233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqc6LrIDzowqDqG0A47BZ3aKM7poLgSts65XB3oijwjPNErhxKJ+3SEpssWUn/TaGGSysHGJYCPrAf+AnGTmnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5241
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=379c65f89=Anup.Patel@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:07:17
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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

This series improves QEMU Spike machine to:
1. Allow loading OpenBI firmware using -bios option
2. Allow more than one CPUs

Changes since v2:
 - Rebased on QEMU v5.0-rc4

Changes since v1:
 - Rebased on QEMU master (commit 2ac031d171ccd18c973014d9978b4a63f0ad5fb0)

Anup Patel (3):
  hw/riscv: Add optional symbol callback ptr to riscv_load_firmware()
  hw/riscv/spike: Allow loading firmware separately using -bios option
  hw/riscv/spike: Allow more than one CPUs

 hw/riscv/boot.c         | 13 ++++++++-----
 hw/riscv/sifive_u.c     |  2 +-
 hw/riscv/spike.c        | 26 ++++++++++++++++++++++++--
 hw/riscv/virt.c         |  2 +-
 include/hw/riscv/boot.h |  6 ++++--
 5 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.25.1


