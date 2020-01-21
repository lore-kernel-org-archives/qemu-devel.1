Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A2C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE3D217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iNLJyaWP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uvyiCuGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE3D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpPi-0000Au-4j
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2824cb5c5=Anup.Patel@wdc.com>)
 id 1itpO1-00071t-7Y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2824cb5c5=Anup.Patel@wdc.com>)
 id 1itpO0-00058j-1v
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:59:49 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2824cb5c5=Anup.Patel@wdc.com>)
 id 1itpNv-00052I-E6; Tue, 21 Jan 2020 03:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579597184; x=1611133184;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=Tlm0ImV8eIuzFbEQvXaeXRpyGZGdrpzsXb9GkgRHMss=;
 b=iNLJyaWPy7oxlKD/jyixmItj0V/c+Ybn8XcqELpT/tvpjNqmotwZKRrM
 ib4Hx8T4+1EqRSg+0cnZT6YIl3ZPZutU672mQj7FN7Tv9CvQ+JgjMzbMi
 qEjm3ZrBJzRIwfe25FQTgr2huHUhea7eSeUevmB6ku/OEYII6X++092KG
 3vFE5lEcdCdBy7I9s8WFEPf0/nj1El2SylumTiYbAyvRwtNmssPKQRXSl
 Fi3qsoEWRjCe7yQjZOWlWBGQPKy1SaCM73BZNWEo9x6Jf3S7SxYiGLVFN
 brWku2y2m+AKn6imm3c9/88MPPsIVqKOMHxLW8so8v49BgIi8oyu6pCTV g==;
IronPort-SDR: CxGPbuNHlNPpbD5p8knFxp20KvlfLMGhH0OL8VlWkGjSeZqxEpCiMjj00sTXQ5f6zJOrT/sWtZ
 e7VV4CDuzTTpbT8il13vHS6WI4ddY43y/+gzwsTddzpoJYKNdyKOul5ioYiXKIbYF8nWcjadR+
 tbPdykQ2OVpCjaG4W4PswY8Ul3C79UE299t1qo7CwLpK9vUOiUhK4C94MvU0R9VmmwCsf8369P
 NulN84QGV9Y8Ix6bM+Im8pIZVJGeBzj/FQFAe2T1/kHOVMmxVkphDKhYQM3TIl4chX3PQOYApP
 nl4=
X-IronPort-AV: E=Sophos;i="5.70,345,1574092800"; d="scan'208";a="132437023"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2020 16:59:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4oDFS+sMSZEWfy3j1140LDufn3tNKUo6EBdoqyXOSkqODAWN6hnNt0iBv6LT0DbWLc2eu4pswxcIEyKBOTPgu5iJfTaybM1meCkVeXfdfBkQK+8oeABb01SVOa0lswG7ELofcReBku38g8TKTS/KsE4cPbaasqX3SL0NckLqLtl/mQQwd/A8F5uA4FbCzfu7OgnGxF2zLULVJssGUXLxGeRoZ6sI82jRw9DzKuvVri6pELD+/hQJPO8tTBB24RL8cBZMhW1IyZjJ3f4pyXuwjTgjb4cYVcSK87c26ldKReWQ9+GxIc8hNg01qijjmfP7kT3fGrl4zt7Oofs/Z9Tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSvCstKqJhvm1PUbS/1LmS0cpXEi6lr0bODGzILJXaM=;
 b=RveX3u/PdngZnEbYuna6UQM5SGXcCuP5G5Anfbh0AHot6AapVsVHZW8O5Gkou6MYAEYYjEkct8BWtFq089wh3KUMDw7vWGz3hEw8tXZSNSyR7zme5/2TQ434u5ke3t/tpf720oN8AKu2Ag9ZlN9gK9gXFbd2q3zSReeQ71Ot4Vwhv1QiH2TGwN2Px4Uegutnc8Kquz0WWvJ2eDKaHVJDV26OimaObumeGCicZUu+sUfuWUHaQDZX2FuRTwI/vLl/CYxJNHvdsae5IuO4Of8X4gT3VY26AJvZB5aN/FA0Sfddtk7f6c9ajvxwLTdwQ2KFRhJ4I9LGqsg4WF43ingicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSvCstKqJhvm1PUbS/1LmS0cpXEi6lr0bODGzILJXaM=;
 b=uvyiCuGfosrnrFpzj0GYvte5MpCeQBBtee7OytsQR7XeAGMupuikJIvBIAacIMt85OJGBJo/N97J45+ZVsqaqq0ClPP42/6NDq2pKWTntp85ukef5Q0zjuovFmxDUn858v1WHlj77fiYx3yKuU8CShuHxEsdr6NJpnzrl/ckqxg=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5839.namprd04.prod.outlook.com (20.179.21.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Tue, 21 Jan 2020 08:59:36 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 08:59:36 +0000
Received: from wdc.com (129.253.179.161) by
 MAXPR0101CA0061.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 08:59:33 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 0/2] RISC-V TIME CSR for privileged mode
Thread-Topic: [PATCH 0/2] RISC-V TIME CSR for privileged mode
Thread-Index: AQHV0DkaO9M7k6us1ESwit6CjZ6jNA==
Date: Tue, 21 Jan 2020 08:59:36 +0000
Message-ID: <20200121085910.28834-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::23) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6384103-b819-4b4f-6281-08d79e503d33
x-ms-traffictypediagnostic: MN2PR04MB5839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB583910D61A1253716AC1F6F08D0D0@MN2PR04MB5839.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(186003)(16526019)(8676002)(478600001)(8936002)(81166006)(81156014)(26005)(8886007)(966005)(2616005)(956004)(55016002)(2906002)(1076003)(4326008)(44832011)(110136005)(86362001)(52116002)(7696005)(71200400001)(54906003)(5660300002)(36756003)(316002)(66946007)(66476007)(66556008)(4744005)(64756008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5839;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7kPpHSA6XN7nVtJh6FxQ+YzErwy+3apRDBJx47wwOxNC2KSsgIxcUvz2Hhhe+5+NCuNnMP//kSBHGGN4Pv4s9W8wj+vieAY/RpYndR5RQ5o05bKbaK3hVWIqIX3FLSD7DMwhZ+qhSaHiuSPQem/Gl+7Cg7pFek+BWakrtLnpRnZDPKgKDUAhvgsFb6+bf8CEL7hOeB5QTidUjCOE0TUOmVvL1+9OgmwznrpUZ0bHVl4j4TMmmr2Qpi/1PjiIcgIX+/EQt6XW8TQ5ToA+woQ7cM22P6d5Q4bSdRBVLSAmNn11skq45DuD0QH4oUQzq1qDCnwGBxqrZvZnIv1ALFnpHtU42rLjPgchW8mfz+07uHq4HEOSMmTRMOXZgXWvN6wBO5wNQf60wZ6yvgSEmbxbHAZg+6MVi7VUsaJ6x84LyxPt/CNb/VS5vH9AzyHRJEW/TFRFkFu/q9oTI4+KRv5016REEbAumCrO/chZqS1OHAZJbs6yy8EDXHPLQT7LfLhJrumLZLIYYlTJ8bgNtXlDg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6384103-b819-4b4f-6281-08d79e503d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 08:59:36.2031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQCQ2vfME+7/kwZDFL6gphvxpEsLcqwvXS8zgmQWSumhsUcn7wilj6bL5twibUGWqeK2mJBUIMHYcBMCNnB/jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5839
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds emulation of TIME CSRs for privileged mode. With
this series, we see approximately 25+% improvement in hackbench
numbers for non-virtualized (or Host) Linux and 40+% improvement
in hackbench numbers for Guest/VM Linux.

These patches are based on mainline/alistair/riscv-hyp-ext-v0.5.1
branch of https://github.com/kvm-riscv/qemu.git and can be found
in riscv_time_csr_v1 branch of same repo.

Anup Patel (2):
  target/riscv: Emulate TIME CSRs for privileged mode
  hw/riscv: Provide rdtime callback for TCG in CLINT emulation

 hw/riscv/sifive_clint.c   |  1 +
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c |  5 +++
 target/riscv/csr.c        | 80 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 87 insertions(+), 4 deletions(-)

--=20
2.17.1


