Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_HEADERS,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3185FC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA782468F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="Qs+d50mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA782468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HjV-0006xU-M9
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j7HhX-0004dd-A5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j7HhW-0002vR-9M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:51:35 -0500
Received: from mail-eopbgr1280119.outbound.protection.outlook.com
 ([40.107.128.119]:30380 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>)
 id 1j7HhT-0002Xq-KC; Thu, 27 Feb 2020 06:51:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frc/yp1U8s53NOGQS3ZPV163R/3C6QddBtytZliOiyrBFoHjiFlVvW2QkDTCXF8DJ5Xp26g5oUDgYu+cOefyaSpBJplYr+2SjN0C5yom+jXHlX7YqgI2uhQ/B/1askBLJfQPdV1pHLiF5cSFl2OFalqHnSfNdpM5SJlQ4LPt7htxTpevujf9RqkrZ1Dw/68avAel7CV5nxgE4cG7/QGdq34n4XZ4PmGhBH9lF99JbCJShH0/25UAFzCxyjcnmKGKPA46PZ4nHtB2Az2TYunXOnCKqMbaPtTz+SjqewOBStzWzc8jnZeYtB25P82DL9GIt8SBnw1DJ9mIMOEVBuiVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow0FlfI6mqJho6v+kQ479IpbDkXfBlVrdY42XHlMWBI=;
 b=gM12JiSee1cc7C9Q/ZwkliHu/xsueNkjEuDlaqJW80lOIVdIZ5V+iVp+X0ceuF5MuQqUr9xaxDLnJKdLC2z7tjlbBrkrc1zCun62LnfCRAbOwwLT9mllW6ihiW0qC4LApUZ/nwHiJcxy18r0J03K7eOg+9nBCpe70sHGiZ+SI1Xce8Ew2jBargaG3VSwCcu9BwSHiunA8SjxkDIl1z0PiovIcQesAuZYW3xmemSSjxZ+iA9b/A/lXy1RSf5KY47oAhTwBJWxKlR7X1wR664oDcfARMlB8OUVbP3dM8GPaW6xDtTIo/BtiVLjBi9/dX4nM1FuV85YRS0AdBYSt5dZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow0FlfI6mqJho6v+kQ479IpbDkXfBlVrdY42XHlMWBI=;
 b=Qs+d50mHsHFIyufuoZ/0i+jktWM/QtjgzaonzFxijXYyuLCznJR5tlOLFKixGjJhJWhmZ0tnJKYbKHB6gMDf1c2TvCjVauIs3T6qsUQ5ZkTUdcB3AxTOxsYpoKGYneQ7IayTe34FUP9AgCO2KTr62HPeW8LzgfsR+X8gAy+60Jw=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0351.KORP216.PROD.OUTLOOK.COM (10.174.41.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 11:51:28 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 11:51:28 +0000
Received: from DOMINUS.corp.kimin.kr (1.214.196.86) by
 HK2PR02CA0191.apcprd02.prod.outlook.com (2603:1096:201:21::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 27 Feb 2020 11:51:27 +0000
From: Stephanos Ioannidis <root@stephanos.io>
Subject: [PATCH v2 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
Thread-Topic: [PATCH v2 2/2] hw/arm/armv7m: Downgrade CPU reset handler
 priority
Thread-Index: AQHV7WQ/RCF2oAiXBUCnUB+VwCKjkQ==
Date: Thu, 27 Feb 2020 11:51:28 +0000
Message-ID: <20200227115005.66349-3-root@stephanos.io>
References: <20200227115005.66349-1-root@stephanos.io>
In-Reply-To: <20200227115005.66349-1-root@stephanos.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0191.apcprd02.prod.outlook.com
 (2603:1096:201:21::27) To SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:9::8)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 864a5210-f431-4280-e84d-08d7bb7b6170
x-ms-traffictypediagnostic: SLXP216MB0351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SLXP216MB035158FC5893AB2DB31E2F6ABDEB0@SLXP216MB0351.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(26005)(316002)(54906003)(956004)(4326008)(2616005)(36756003)(109986005)(2906002)(478600001)(16526019)(186003)(6486002)(81166006)(8676002)(81156014)(71200400001)(8936002)(1076003)(5660300002)(86362001)(52116002)(6506007)(66946007)(6512007)(66476007)(66556008)(64756008)(66446008)(36456003)(42976004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0351;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/xM858PiLrxabv6ZAFWlAdMA+vtNs/G70G7Mb/OSHPhRWkZd24qcgBB71+CKc2LbxBH3ewPAjVGZltVmOu9BL6l1F/WFSaGOnupG5TtytF+vfN4O103a48TPwH+annrM2DDI/vG/Z7VVEgXB+oN7bPHmTUWZFGYpcsD78+QcPO0ab1rWQ95yYFB8+HGnytW574uMKT+l9TP6KeWOnv+0RIFrbF41YmgH3pU2hkJtzwKKovUmUQYmEK6rpxO+YeyxGJGNBcmpt3jN5eLG5yw+ZBNVj7P+QYpiXopF/HoHsZWXaIPONpVEJLHZcSmFZo9lPOAr0DmxvEgoAL0JD/uwDf3TWgx0eiEbDW9lrpT9pZP+IdOmlwZSzPEIycdTmLEGD0oYgehfkooxiHhbPrDiNFwiL7NlkCnRB22skPIUXYh+5PvtcGN2xciKdinqSfQCS+BilJ/mzM81PDjCslQFK9OcRfVoXt7VKz9tjnTjCS6MRDOr//NhVELRs5UoGRIEm/nY+p2UHtALv2nwKuLpQ==
x-ms-exchange-antispam-messagedata: btNrkfSqEB7iYePsevFIC2uVmKrULyHXhWdRHjjP7FPkfoP8U8b0i2KiuBzkfsyvssYLmm4PThqHWuTPrwDjTSlVJtVTnnT05xnFwX7tYDpT7huZCSsjsi4osDNPMD9Ic/xKtxjniTszH3kUVfqu6A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 864a5210-f431-4280-e84d-08d7bb7b6170
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 11:51:28.8344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzMtDlS1r6ZXdFrEn70aQdMZl4PAN8OF8mM+53BHzzSCRpEDjH1YdI+cE2MwCtLxPKLZ1cNGXhlGgUHp0NDOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0351
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.119
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ARMv7-M CPU reset handler, which loads the initial SP and PC
register values from the vector table, is currently executed before
the ROM reset handler (rom_reset), and this causes the devices that
alias low memory region (e.g. STM32F405 that aliases the flash memory
located at 0x8000000 to 0x0) to load an invalid reset vector of 0 when
the kernel image is linked to be loaded at the high memory address.

For instance, it is norm for the STM32F405 firmware ELF image to have
the text and rodata sections linked at 0x8000000, as this facilitates
proper image loading by the firmware burning utility, and the processor
can execute in place from the high flash memory address region as well.

In order to resolve this issue, this commit downgrades the ARMCPU reset
handler invocation priority level to -1 such that it is always executed
after the ROM reset handler, which has a priority level of 0.

Signed-off-by: Stephanos Ioannidis <root@stephanos.io>
---
 hw/arm/armv7m.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7531b97ccd..8b7c4b12a6 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -352,7 +352,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel=
_filename, int mem_size)
      * way A-profile does it. Note that this means that every M profile
      * board must call this function!
      */
-    qemu_register_reset(armv7m_reset, cpu);
+    qemu_register_reset_with_priority(
+        QEMU_RESET_PRIORITY_LEVEL(-1), armv7m_reset, cpu);
 }
=20
 static Property bitband_properties[] =3D {
--=20
2.17.1


