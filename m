Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F2FC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCBF214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="etUHRYg4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NeH9htpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCBF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkk8-0006da-Qo
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkc5-0000Xv-1l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkc3-0002v1-0r
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:12:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCkbv-0002pB-TT; Tue, 24 Sep 2019 09:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569330728; x=1600866728;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=sOZDNnFj2RaXKg4BqQV4BM1YNOfwyp6dIUaP+YfiUOA=;
 b=etUHRYg4bKrGcO8oxk6MIwVfnKn5On6uimcOYjMNFIXx2nGGiRMlKheb
 ZUTtv5oMQfa+oSDpgyGKbPfsxFHvbPapx154CP+r7Y59IJpshx5YVIMKn
 7fj9oxRkofOn4cYG6E8uyKkvn3+ol+CvNen+hR7OQaOtB7YR1dMUHl+BE
 mGlAwuwCgldYtRHoj8deHQ08/XxQaY9Kkb8V2Be6xEesDP42Ajg15Cam7
 8BzqfZ87Mo5Ro7/rVBKOMTAHLw2B9d6tCscLGqqBA0hPjsIPhO9Zi8KX0
 thQfKDrh9fgbfuuEm5BPBSyecum+jlEMHJT56bVRmQsnDeUKHVAS1rBSv A==;
IronPort-SDR: MoLcxNKp6uYD385kCBGmFj94FQd3ReAXrPRVQFC/sIZvUuMi77I6QvvCiG6Dw4lOwKJTRpovKX
 OV6ax5ddKIcb2EGbtfBKzyChfbpex8bix+TWe0LCUYTW/i/2LUQkxcPh3uxDiA8LpQZyou8zcy
 OHNa7Mb0ck9VB+9yNXgXflLMBbttjLMFA02dDW/te8Dd85Qs+TAYeFa+h8YicvM4kpw40FY7+N
 nc6A4korp5wn7g16/mDMMf94KjlbNxvgpQtQoyEej0x7GhB/XJIsjX/7ZNSgSqgAqZPphbYDKU
 YRw=
X-IronPort-AV: E=Sophos;i="5.64,544,1559491200"; d="scan'208";a="118970940"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 21:11:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n28XsGHExklmLfHyp33hBqyw3X3+Kgikui9BiW5HlYDeRRxFPxyJscsnXSZumULQlkQZdh3OZ6iAXb6cUqhMuYUmu/DZgAXhF65fPrRWa/Vg9NGOo61H5AMB/JBOAJtzHsbnXoDtNGnlHz46jrptvv77AcDuM+heRK+SKmKKYPYTW5757B7Hw2vh8ByGv8EciK0GNbA/EocuMImgUADVHtJQuFM5jEM+SD6IfLZful7QNwqxdy/eozJegSROJUXuGaa3GoE/jWgT9tO0d2dx6OTpVfBV5KwL+AQWAOPsEdj6p4yMGisIWi3KRAmKTpzeZmKNTNlZxyUMixoFsU/6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFMTf9FB4jd7cxmHM9GoS8TqjRe4+/7fDWsZIr79Nb0=;
 b=GPKwPxBlPa8uRwyInYUwDbuID0ju/h1WhZsI07GkXH4KaJqXg7BJQ4PKUJVPtsIwHi63sdqGhomAmqIyvDfXMJ8rsLaVVqiN3P0DlozXrkh7iTzTNsqCw8Nm8LKupY2dzEW4rwZ06IzeK7FZ8+WFsk5PCS3V/82+ulsJ4PipITmhAVHIY0VoXc8QgS5sz2KyQxxy+rYVPwO9kQKEx6qoDj2abAwmYtbHQj2KdcSn3qFbrnP6G2x2PLNhzY15lTIhOCvwtU//BlhYP9seTvDTshLyuwEaXSW+Si3WSsO1lGuA+DH28vbB0n9QmDiBrH+p+QJX3231ueTe0iYZnMdGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFMTf9FB4jd7cxmHM9GoS8TqjRe4+/7fDWsZIr79Nb0=;
 b=NeH9htplXssFxZiP9pTu0Fot2svh9g1kFFY3tCa8wcRu7zFZQoq7fYgdw12AkhvloxVRwOiW/8Tx+4xOE4ZQUOqkJ0XNV71FsOW/qiApU/4PetIKKRJGxRh3aRFLRCg3M218TfAdLVDe+7L7PV8RzBj8hDfIkQzYBrW5y9ONtPk=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6318.namprd04.prod.outlook.com (52.132.168.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 13:11:57 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 13:11:57 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v2 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v2 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVctmkW8P3iH8gtEirKQ31pP1PTw==
Date: Tue, 24 Sep 2019 13:11:57 +0000
Message-ID: <20190924131131.118155-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.51.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c08830f-ab2e-445a-daae-08d740f0c6dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6318; 
x-ms-traffictypediagnostic: MN2PR04MB6318:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6318B708AF3606ED21B392568D840@MN2PR04MB6318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(8676002)(25786009)(476003)(305945005)(8936002)(81156014)(81166006)(6512007)(36756003)(3846002)(6116002)(6306002)(6436002)(5660300002)(110136005)(54906003)(44832011)(71190400001)(71200400001)(2616005)(486006)(316002)(256004)(66066001)(7736002)(14444005)(6486002)(50226002)(6506007)(66946007)(1076003)(14454004)(64756008)(2906002)(186003)(99286004)(102836004)(966005)(2171002)(386003)(52116002)(26005)(478600001)(66476007)(66556008)(86362001)(55236004)(66446008)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6318;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KX8cgI2ut+PdDZn4e76d6FS+Krnd9YCcZrab07hjOUQHOAgYEHf99Y0AZ5LHn5FxqqwYifUOdsyh3dIUOV51ibSxtn4UPiamHt4vybpgIwHwjePSFuynkXvyxaN1mDd9xZwpaRUBLosaekFJmXbJAK4w/YJ6rf6dYxxZgvQZ09ZUwArv6FI/o9gRZl3rYuLf50gNJ25jm5M3b5vHTnyMT6lcP/ut6Mu3Smq5dU67+zNhoHVuuQdDJS4ufBBaBDu+Xq1nH9d3JzScV+eNRgtrDn6/DQhUb8cah5gjI02doILjqhludjdo7PiUYva6Gm42IKXzmx2z20KMEA/nWpRaXiFU3PvRGYBA39wncZmw0tguHRB8J9Fwf3v4nuzxlJPB7uw32CkyK6h0mouzWm6rlDQu3aGQsAfvmpMJL6ZZ6rwewhDSKOLOJKN+V7EHFNL4E8ovuyXiQ2p6Trfc5vXWkw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c08830f-ab2e-445a-daae-08d740f0c6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 13:11:57.4292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFMCvPFs4E8gyloNZuqzsEOZib4ZLSGy4BbrvnexMkKAHg7xB1s1GTszNWnYM4i7rZ09Mcd0w1SzXwJKb1xVdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6318
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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

We have tested this series with Linux-5.3 plus defconfig changes
available in 'goldfish_rtc_v1' branch of:
https://github.com/avpatel/linux.git

Changes since v1:
 - Removed redundant object properties from Goldfish RTC emulation
 - Added vmstate for Goldfish RTC

Anup Patel (2):
  hw: timer: Add Goldfish RTC device
  riscv: virt: Use Goldfish RTC device

 hw/riscv/Kconfig                |   1 +
 hw/riscv/virt.c                 |  15 ++
 hw/timer/Kconfig                |   3 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/goldfish_rtc.c         | 278 ++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h         |   2 +
 include/hw/timer/goldfish_rtc.h |  46 ++++++
 7 files changed, 346 insertions(+)
 create mode 100644 hw/timer/goldfish_rtc.c
 create mode 100644 include/hw/timer/goldfish_rtc.h

--
2.17.1

