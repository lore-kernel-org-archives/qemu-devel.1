Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AADC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E8720721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rD3S5L4o";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bjha+79J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E8720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIdS-0001CH-R7
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcF-0007eg-MZ; Thu, 28 May 2020 09:30:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcC-0001CO-EH; Thu, 28 May 2020 09:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590672633; x=1622208633;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=BnQ3q2+e7mPmBM/f1coUm4kOu+HmJqGGbwultwmM0Fo=;
 b=rD3S5L4ocGgOf6Xrn8sp43Zw8xh+2r79vBC2pgo5/sndazzEfmnksdI5
 tG9jQxAz+BFi8RLPtquNIlurfNapGf1TnUoB0FSPBQ+/VNU7bdBvcVAi0
 jI7i6kQyi1ajPsKRFdu7dd+iQ+91ohfMhGGACJj6pPF26wH5Igcy1BZvb
 etWbZGJL85k8ciRkj3pZ7SWMMVMBOaZ1dX/L1mPEKJqhn6kC/n+72BZ1I
 84tld8Wws9v4bDMtOQIYlBMrjbxgvgG0Zd5o5rmhCA+DHrxBVEatXBiF8
 AmvquuSeLo2/T0xB45pjBbG6dZRS2iG7okJc9ZV/oNLuKir8lTUIUm6Zr A==;
IronPort-SDR: opbIqh1DVBnmNltJGb1fzZ/qdP83ZKqn27HouqpTbQvwYw7mILD34kAD/e3jd2i2Cp8qTN2LTL
 8KC3Ex6c/A730ut0JqB5UsRlcXzJdsiRy8wEQRmfpl8Eceql2m7u1GI2PndI1W7mbiKVhMYaG9
 pEirZMr2KPGYc0la/YEN+zNbI88vMO1F39HlmeumC7bDAK/Kbj5ZJ6hIj0DKrxP5OAy88KGTtn
 1gPvnQ81oyF/Lt6JmsvBCy4a4Eao/tNgrLzoFVkHRN79/Jfvst7pQ56UreEi0u/Njs/hVM7nkv
 TjU=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; d="scan'208";a="143036548"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 21:30:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEFcScpL+++x0DO+7Xwm09iFBcAuYzsiMNMrbz4j2mXBJqdnEgY+CF5Zm9ZZxRPRSyYdQqXqx9mi7Zi6E2Yrr/mKsvifc0dy6eYuvaTI7Ds5IxNh8UGfzZEVmYmhwMCi49feA9V4P9C5i1VbgG7N6iH5i0FDlal93Ed4xoH0Lp44SXKNDZlUU39qOGKysZd2Bplv5k48v+quyEWM8xlQe3wHMri1lVnK55Nu0+yj74vhdBGZRcoQW+EfHjmgvrU7BXRvlhPx17ChAq9/jtM1xVNzHNj7CzWIy5Ibka6oEcpeL1eu5yVGEF5KYm70hTR17Dm2GvHYAcSKrrRPTyO7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+RZb2zC6g+iyHQADbSoYWgZCBdv08hHZkrd/d3kkQo=;
 b=Ibk0le20yCe2vhfDxfhulZ6bqlLj57wxqNMisxECpOhgFvLdp9bWccn7MCCDRii51FkojWS2isUgDkz7hMQuNyVcGqNft69lGZ6Qg/jDiS8fOn0FKX9Snx0SE4FqiNI2cb3LR+YQYtdG6CD1BiZlTQvWXtEBG6aMdioX3cLnGqklPl/Cz7lM3B7tBnrmilYyRUfG/e/fa5JiQGqQGacCqg7CtSxrzHbtl4Kt8DURbW/pmb/ox0uoWTv4aZXOEuqy1EbZoFKTYlHQfrOzfYOPKW9Gou4NtNIyr7OiVzcNzUY4CQocgvmzkScl/27vO8eRxrvZniskl5X8EEN9kVK6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+RZb2zC6g+iyHQADbSoYWgZCBdv08hHZkrd/d3kkQo=;
 b=Bjha+79J+oIOTi6SnjD1GkFA3giha39FeHlw31l9PTly+EQwS/8dfbR8R2RToJswERejmKOQzSCxL/1NXoNvsxhQboxkHvYRZAgN2oW4wi0bkW0zzfUOmfhQ+Q/eJFQ38yysw5/8PfF9Ydrk6FblhKuipPaIV99Brg3dTUM2qK8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6204.namprd04.prod.outlook.com (2603:10b6:5:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 13:30:25 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 13:30:25 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v4 0/4] RISC-V multi-socket support
Date: Thu, 28 May 2020 18:59:55 +0530
Message-Id: <20200528132959.47773-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::36) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.63.107) by
 MAXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 13:30:22 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.63.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a0808b5-a50c-48a4-d678-08d8030b4744
X-MS-TrafficTypeDiagnostic: DM6PR04MB6204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB620431CEDF7E064BA87FF0BC8D8E0@DM6PR04MB6204.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYoyZGZjWBlMzUKSA+KNY11KvVgy982qTlg5CmQ0BefcgE2tbKEHL7S2YFCrgh/I5NYdfjEDdsC+FhRufmcKwXcQwpjkkHgzB3tJdb1za9NGzNAgnx8i7Ridc4m+lXD38V5v1LTAjQ9wZ7bMuTeCfePvNgMNBYSbCVkZdXJQ4SVqrc3MzmCYKOVL0mly34eNqzjaaKuJL1mbZIuH6HWjSaVXSCWSdPhDW5UoC5kQ2y0K9sANzPTdN9byYMZSbdqY06fIKT6ZZPolkTC0VsP6PzeN/IzzRJz3+eFWlCBfLu1rIDchLTgl+1P6cIp8uDNtnLGTnPqwamVYIAyaBiJDdRG3zhbZIlJohjsHFxpm8JwEMLVcErPyUoqgsJmjWvNa8wPJuN+l00G35jf3PfK3bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(956004)(26005)(55016002)(44832011)(478600001)(55236004)(2616005)(5660300002)(966005)(7696005)(16526019)(52116002)(186003)(8936002)(8676002)(1076003)(86362001)(8886007)(66556008)(66946007)(66476007)(316002)(83380400001)(4326008)(54906003)(110136005)(36756003)(6666004)(1006002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AQlJCp496PDvMgspsG9Sq24cdKlUWiVBJ1NewcRYbB3q0fWSqztjlvb8Sn9cKnfPmfP3bfWPwN1YoafU8lHX79DdqNyFFgFDm3Ndco4CO+emu1de5fNNZm5NppmjY0ldhy9njfVWirIvKEbJk7keAu4mjZo62XR+eK+flsTlnRHHzpwPqfYpBXFhsZOH08Y+P0U9OmowZls1Eu18A9qlIrAcu7w0yN8CNFWnGCTlrwiDPQbL75MsgOnresitd+iwcuaAnQ5kAfO2rpz4fv8QuzQwEf94Hsi0NPmAsM06OaGjFJ7LqqBseP6xNLzwwk/FcraT8Wol0v281p1pneN4A7LkAwKH/k7qRNs2AVifJLpJ6mzAqyaEVIWIbh4SGL1EJiN3W1FyaeJ/kedDVkpjQGhaIg4Mo8RBcxUdvdGZhWWau20ED/Bv1vZjdf9qr1kEgZhddethPLTDHfQjFSTyWbsk83BL9Av2dHVfztm54P0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0808b5-a50c-48a4-d678-08d8030b4744
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:30:25.1080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFJvfzzEwSW2YWOG+QHC4Souc1Z7laBT7mCMEpSpc2Dk731mUaBCKbUAXyThyMvJIdmvicE9LguCybvcVds4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6204
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=41059f22b=Anup.Patel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 09:30:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds multi-socket support for RISC-V virt machine and
RISC-V spike machine. The multi-socket support will help us improve
various RISC-V operating systems, firmwares, and bootloader to
support RISC-V NUMA systems.

These patch can be found in riscv_multi_socket_v4 branch at:
https://github.com/avpatel/qemu.git

To try this patches, we will need: Linux multi-PLIC improvements
support which can be found in plic_imp_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v3:
 - Use "-numa" QEMU options to populate sockets instead of custom
   "multi-socket" sub-option in machine name

Changes since v2:
 - Dropped PATCH1 as it is not required any more
 - Added "multi-socket" sub-option for Spike and Virt machine
   which can be used to enable/disable mult-socket support

Changes since v1:
 - Fixed checkpatch errors and warnings
 - Added PATCH1 for knowning whether "sockets" sub-option was specified
 - Remove SPIKE_CPUS_PER_SOCKET_MIN and SPIKE_CPUS_PER_SOCKET_MAX in PATCH3
 - Remove VIRT_CPUS_PER_SOCKET_MIN and VIRT_CPUS_PER_SOCKET_MAX in PATCH5

Anup Patel (4):
  hw/riscv: Allow creating multiple instances of CLINT
  hw/riscv: spike: Allow creating multiple NUMA sockets
  hw/riscv: Allow creating multiple instances of PLIC
  hw/riscv: virt: Allow creating multiple NUMA sockets

 hw/riscv/sifive_clint.c         |  20 +-
 hw/riscv/sifive_e.c             |   4 +-
 hw/riscv/sifive_plic.c          |  24 +-
 hw/riscv/sifive_u.c             |   4 +-
 hw/riscv/spike.c                | 385 ++++++++++++++-----
 hw/riscv/virt.c                 | 634 ++++++++++++++++++++------------
 include/hw/riscv/sifive_clint.h |   7 +-
 include/hw/riscv/sifive_plic.h  |  12 +-
 include/hw/riscv/spike.h        |  15 +-
 include/hw/riscv/virt.h         |  13 +-
 10 files changed, 746 insertions(+), 372 deletions(-)

-- 
2.25.1


