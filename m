Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8143CA9ED0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793BF20848
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 07:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VEO78GkN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y/91jVdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793BF20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRAkz-0001CY-3n
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 02:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjR-00083B-Ty
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjQ-0003oz-Mo
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 02:55:29 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20340a2d7=Anup.Patel@wdc.com>)
 id 1iRAjM-0003mw-7i; Sun, 03 Nov 2019 02:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572767724; x=1604303724;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=gSOWHtsfXc17rTBiYDJKGzCaSJkWE7Cschv90HlJKqM=;
 b=VEO78GkNz06PYf/zMV6teo0dfn9XH41vFNW/lvi+2eW4qTYFOZHLiED9
 tC5VE5Vj5QrKQOTTVc9KyuteX7cp8TuUB3MDokC6y6daVOnhqdO9U8lkM
 8+ngzKvBeI/zO81GXvs9mhv40rIVjrhFiYXzKVnxCL8+cryu4vGg6h6Og
 iPaanWdZmLEhc6UVMJ7vAvYblueDWBtcAtOq+PPE0VAPOE0cuHCx86LMR
 dd8Ox/WFPHHAwuDPs//Zw4MW07efBeTdXvEdefleq+Dw+oe830YnMXnjv
 AuHlCF1ZRLTr1B/csEaQfqUTOMFOutP946btz2wKxjseaFCTNGcgeAgjg g==;
IronPort-SDR: hJXUSb6C68An9BnOOp9B/kLa+BJV+SdxuYFlh3PiqdZSKF9N1oW++aipRQPi27WYYe0kuQAb0E
 jr8ooi+6VhH5SiIUScl3EEPFpQ9y4tw/hHdaPdPHK7OxXY619EVl4Mpfe8Lva6uPvFYxN4c/uA
 EN68DTWBULJSG07KSdB+u0Qa6ptE+QHx2nyHFSygzLmAP9v+RlxW99uzjXy7y4NaPqFdf1rYf3
 jYFxBl5Hr+VkiEusxT++lt0T+rJaUwPF1yLYE67Eo54QBuxPmoDESAZrms9DdrpUZ/pDn++HWx
 0IQ=
X-IronPort-AV: E=Sophos;i="5.68,262,1569254400"; d="scan'208";a="229198996"
Received: from mail-dm3nam03lp2057.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.57])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2019 15:55:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOULt/zpfNsRWaYnae20D2GnFLhxvd6ZBKF+gkYAaPpmrBmq9aG1FQpNLbYEQ41gUrBXFCpJgtV9B1VOGIv604Rb7q+mpQx7lSTdw6JdGYvsTmQWA6vpQB6yp1hVvVulAuoUiBSYV+08F6QqkwR4BSxBa71TMkvFXob2/WbNEw8LMo97Y877E+yM7PVXTh8SNVsGhS9IeYEMOMmOmD1ggk/fpAGS8QpYXYpHUyvwL+Wv+zi8KThYCQDajEkvnQUX01+Ybqs2CRSwXihqcu27UWZWteL0G+mov4G/bZ4q1PuQoE4/qp/C4IIc/rpG52g2iN/OdOwifRfX5oEu72FSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfD56q7Yfl15GbzNY9T+d+UI1XU3hFRzvzQY06aOrzk=;
 b=QMxShcd5bhYJLR0bAg89tXQpILo4jpRMZl1lSoIZILYPQVMvBSUs3eWWsd/U+0enEGCnEWkPwnbPzMhVeE2LPubiXLrd3RJ6+jaTHXadqEfDRornNnizV1SbYn/bHlqY+89ZRxC4fRDu+cLelNCPlQlCu+d3sCK5Xo2jOOKDdYn5cFgzO6gDN+U4pNoQEBPnqulTfU8RnVAHLci5zQ7wHRIeAGD16tKXegsTOYHxNu+o9q0dIh0iYIgTywTDXp/SvuCytMQZRy4kVJIahTamZX4pHt7v2uDiz/z/yIJlwIFUqtfU7BUHnyx+bIDMs8wZuzgwY1Qygrb/j+FPJN6AvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfD56q7Yfl15GbzNY9T+d+UI1XU3hFRzvzQY06aOrzk=;
 b=Y/91jVdvSgHLL3cbqtNXAq9UPDrsOM1if4UkiYlazANEHiTXwNMzziGESJw9y5V1NhZ5uRt/SvFzwTupzCY8B0Ah+FGFnr9vLgwhaSLlqO9GbtNkS/tvkJN9frIm9SumBPGwgD8rX9mX10xrchFybYS/u9diQTeqIPNTUgsY/dU=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB4635.namprd04.prod.outlook.com (20.176.106.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Sun, 3 Nov 2019 07:55:16 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::dd8a:a9c0:97c5:cd70%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 07:55:15 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v6 0/3] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v6 0/3] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVkhwHtaMdVeAHgEeQqW1cWu5BtA==
Date: Sun, 3 Nov 2019 07:55:15 +0000
Message-ID: <20191103075353.86497-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::20) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.18.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62d03ee1-a35b-4d50-7b57-08d76033299a
x-ms-traffictypediagnostic: DM6PR04MB4635:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4635080096A029FABB33E0F18D7C0@DM6PR04MB4635.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(71200400001)(55236004)(4326008)(305945005)(66556008)(71190400001)(6116002)(3846002)(14454004)(102836004)(36756003)(256004)(476003)(110136005)(14444005)(8936002)(7736002)(99286004)(54906003)(81166006)(386003)(316002)(2616005)(966005)(6306002)(25786009)(26005)(6436002)(50226002)(66066001)(6506007)(1076003)(66476007)(478600001)(2171002)(81156014)(8676002)(9456002)(5660300002)(6512007)(64756008)(52116002)(486006)(6486002)(66946007)(44832011)(2906002)(186003)(66446008)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB4635;
 H:DM6PR04MB6059.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bz00w1RQaat03UCdgwknzUOYvwp5Qjalszny/zt5djKg6e0ZM3XBFT6/Cvl1mxyCp3036N8n1XSFvKDjiqDf7TjCsPuI0H+Ihm3FgJTA9Mr16+OBtmyJcywUBtEcz9nucYyUQoTyJ84WhBtLAbjbjF/p8f8GmML5Q2nxfv5f9Ei7Ogs05cDZgvX2wWmFmpStUCEur40V5IsmQPOCSdfcxB6m28nFKWOQ/gksIiCX4hm+7edA2YyxN2L1/wOgucxnNjG7CweeMuud5E6O7w1H1TGoRrj8JxGY8Kndq2J5wRW6e9KIcYrOX/CgDMVmfiiRPbceLPMHnsV/KHGRB5+CsJ+hgE9cleV7fJLCNqvWlUnjPUnMcLSCW45MjhV2Bt3//uUodhmaseyUs3rJmnDvaRTqxRL+6Y7xYGQYRZlzpJ1aB5fzZYIw6pzSxD9vx6kfB18U0J5f1o0u85IQyCHNVXCGyJ64nIhOG4B21bRkbEA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d03ee1-a35b-4d50-7b57-08d76033299a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 07:55:15.7630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yz7XHUpLoQST2SJuZgkkUeV3J++wZAGMf9SeheNQ5LiiPubLEH9gIcY4o5nmJknDV2Yzp0owyrf4a+QcS5Xbwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4635
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

This series adds RTC device to QEMU RISC-V virt machine. We have
selected Goldfish RTC device model for this. It's a pretty simple
synthetic device with few MMIO registers and no dependency external
clock. The driver for Goldfish RTC is already available in Linux so
we just need to enable it in Kconfig for RISCV and also update Linux
defconfigs.

We have tested this series with Linux-5.4-rc4 plus defconfig changes
available in 'goldfish_rtc_v2' branch of:
https://github.com/avpatel/linux.git

Changes since v5:
 - Rebased on latest QEMU master
 - Added maintainer entry for Goldfish RTC

Changes since v4:
 - Fixed typo in trace event usage
 - Moved goldfish_rtc.h to correct location

Changes since v3:
 - Address all nit comments from Alistair

Changes since v2:
 - Rebased on RTC code refactoring

Changes since v1:
 - Implemented VMState save/restore callbacks

Anup Patel (3):
  hw: rtc: Add Goldfish RTC device
  riscv: virt: Use Goldfish RTC device
  MAINTAINERS: Add maintainer entry for Goldfish RTC

 MAINTAINERS                   |   7 +
 hw/riscv/Kconfig              |   1 +
 hw/riscv/virt.c               |  15 ++
 hw/rtc/Kconfig                |   3 +
 hw/rtc/Makefile.objs          |   1 +
 hw/rtc/goldfish_rtc.c         | 288 ++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events           |   4 +
 include/hw/riscv/virt.h       |   2 +
 include/hw/rtc/goldfish_rtc.h |  46 ++++++
 9 files changed, 367 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/rtc/goldfish_rtc.h

--
2.17.1

