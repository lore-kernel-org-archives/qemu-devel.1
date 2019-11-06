Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E3C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88452173B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YfqvruNJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ULNWwctu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88452173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGnR-0007q4-R1
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmc-0006kr-7s
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGma-0003Wi-Up
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:35:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmX-0003PP-4h; Wed, 06 Nov 2019 03:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573029312; x=1604565312;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=MNMQh6n///rZAoZAVRRjR9FMMNUqjlIL/EpJQjgLAJ8=;
 b=YfqvruNJo20c2nzIRO3QSItqo6VbpabmrBfRvpcKB6Wk5pzPZ1tQY8vL
 r6+D/iL4kP+RvvlGW57oSYPYb3ndMtdhGlHmdcP+l2pEXs4PSJrCVNkXE
 xuF/r/F5hxtjoTxLdMhyhFDvhnuS1fn0Vk3/Gns3ircuNf47b5bQ3r7dZ
 xMj7BkLc0UbeV1/78mj6GZ4WBet6A72SpXhiM+giA23ZOiNE47b0cJF6f
 L8a0KXzkOEV9kluAdjW0f8o6O1xkEqlF8A7/k5lEhyiRk46qDJW20uhq+
 LSxOx4Rr8EdZ/zPzAO1io0PDcTaFfry8s1rfJ2zgkL9X8Ewm5GRJKX0g0 A==;
IronPort-SDR: 6f7KfoD2+sHckKlCnFxdj2zzh6SqwUx2NHjI+1jDUYihwB/Sfb5ghhv6DFV3v7L5SCKCBwEQRe
 RrVswi35o8f9OFf6z8MxJ7924SNRuJhZ8gbW6HMGbHY8IF+laM2L/nhp2ORhIwHlBgVm1RaNmq
 Mc+hZbLF/ysmtXBwg17fxMrkvHPsKfRNu394Xzkn0uMbwIwIARcD2/TKkggSpX4ROaOjA6zfud
 fsicetirA+Q3IaIPI//wlsNnrLvwn+EdVr63ExmspJDQVUgWUXCXttsOlRxQQ/r4O1/1VcdwPM
 k9k=
X-IronPort-AV: E=Sophos;i="5.68,274,1569254400"; d="scan'208";a="122270215"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 16:35:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eip/95EPiVf3v512DjO9Vim8H8S2vm3L5WbZPsCxMyptxgXcrSEo6SiNFHIsAKT93KBcwSwNQn1SPuN0D6BjI6iN3rBWS9BQWNy2dUEiCGObbSTBzy+yyZ365PVOy2zC9s6wJBhBNLi+460MEUS9wF3WEFX/Kf9pjkEgLGTqIBaCBtH52HY5YL5zDAkh246Y8lZb1T+fMRkoAGZR4OOg2EjYJVL1skWbtf7Q19Azp49AVEuqG1KMvZ5hZ2Ro7D7vOBitsr/XVEZoMr0IdiiKS1naUOmzdxRmys8zmIe+qngrsnbWv+LjYkv1I//BAYXqZmhuRNG7G3UI7ZvQD0Qn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esm9YOMtbQ9QYWDoS++w6v3cOBQrMbHjC8CKhP/pftk=;
 b=NGQhMINLguHnKysBj8yvgIgi3BdTZ7gWpQDNMEEr4bi+EZKEweeIao7Ij0QaGPslxtpTva+IuCqS317ekbtWZn0tjLrsRdHUfel2Js6K7oMpiMWQ1gQ3pGoibWDEh07nF7nt6zd8DOl0xRkrKtZk/gVgRih3NqNyn+9tuYgwQ0U2ymHoBRLozO8zy/bXyXjEIJ/WWUiKMxaOoEt86AfjN0iDvzBbmSGtLNu908WS8dyi3AxUmbPIHKJY4yjWl/j4tp+Eo5920QWNP2Jo7Mga0BPUstPeuiW2IwrAcLaUMbwZHxxraoVq1kUdHCFT7V0sVvC7m+/8ILI4ws2o90uL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esm9YOMtbQ9QYWDoS++w6v3cOBQrMbHjC8CKhP/pftk=;
 b=ULNWwctuDcCkRIusPoJWAC1H/+SEl24Yrbo2/f3YQ9yYxKybFW/GJSqHSkkdCdvj6EM1maH1tHRcFY6QERE9LmxpU6E3K2WVRQgVoxHDWmiVukKEz783QzSD2O7BKoWTiIh8tQty009cdHZD1BbUfOhnIQ6SLU32NvSnKOsBGcw=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5936.namprd04.prod.outlook.com (20.179.21.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 08:35:08 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 08:35:08 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v7 0/3] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v7 0/3] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVlH0YZp18v5N/rEuwbe6k262aGQ==
Date: Wed, 6 Nov 2019 08:35:08 +0000
Message-ID: <20191106083444.41113-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::33) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83a20a2c-01fe-44a7-a288-08d762943b10
x-ms-traffictypediagnostic: MN2PR04MB5936:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB59368C9475CEF956C5A1C70E8D790@MN2PR04MB5936.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(14444005)(25786009)(3846002)(6116002)(71190400001)(99286004)(2616005)(6436002)(8936002)(316002)(476003)(5660300002)(1076003)(71200400001)(6306002)(8676002)(6506007)(66066001)(386003)(110136005)(81166006)(4326008)(44832011)(54906003)(81156014)(14454004)(186003)(6512007)(50226002)(52116002)(86362001)(478600001)(36756003)(6486002)(256004)(966005)(66946007)(66446008)(64756008)(66556008)(66476007)(2906002)(102836004)(26005)(305945005)(7736002)(486006)(2171002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5936;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eohR1/lwLpcLHTKIC9x4AZZUFB0JpwIKdWGukSc/tVDAWzCqIJ5auwIQKzX4cd//5JxW+xYffyEgaKqHv/lToXLp+4rvc2Q5JnJ0G3ukiIS/pMxauoTJXlKgEFzIhG3tk07ylf60mtOln7xTeat7NnBAUi4igwnngOdfFgSxZCJxn/h/rFD8riaDpxRezlvhHnkEx67iA/HBnBpZUgb6UaiMO83EipNZiVCn1RqLgCb0l6tImghuOLYZp9usoQUJgzlDO8kljkLPfT3u3ckNKeUlKUwOvy6PV8iD4crNdQSHsEABT+IGDofMQrcCZUrgoS4qzx2cN8OUyb8y2MWSNTyhl3HoU9OsagRWIrst6C4pgra/5PWCvA1dRWioueG+Wm6Ja2sWpdfnPh4g9zZy+z5PwHlFj9fZQdE6WMKVx/Vor0oCCBYSFE43OueJEtCKKNnVswvY1lcLjn5CC1Cfe7RXkJNinmCcnnqtFGshjzw=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D86687CB2E1F034D96162D6342A6C01A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a20a2c-01fe-44a7-a288-08d762943b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 08:35:08.5040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6/J5zwqrSOzvcAb3TgaXzlZydBnpVfPFzZXTIarskF1hyeUv2prLDh7xn/66b59wLp+SifFUKgXd5Ik8DM6vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5936
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
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

Changes since v6:
 - Rebased on latest QEMU master
 - Addressed all nit comments from Philippe Mathieu-Daud??

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

 MAINTAINERS                   |   8 +
 hw/riscv/Kconfig              |   1 +
 hw/riscv/virt.c               |  15 ++
 hw/rtc/Kconfig                |   3 +
 hw/rtc/Makefile.objs          |   1 +
 hw/rtc/goldfish_rtc.c         | 285 ++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events           |   4 +
 include/hw/riscv/virt.h       |   2 +
 include/hw/rtc/goldfish_rtc.h |  46 ++++++
 9 files changed, 365 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/rtc/goldfish_rtc.h

--
2.17.1

