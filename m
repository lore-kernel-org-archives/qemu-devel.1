Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7546EC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E532217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EEFaP/2C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kSoboXq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E532217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpT6-0002dw-AE
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2824cb5c5=Anup.Patel@wdc.com>)
 id 1itpOD-0007ME-CC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2824cb5c5=Anup.Patel@wdc.com>)
 id 1itpOC-0005Gg-9W
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:00:01 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2824cb5c5=Anup.Patel@wdc.com>)
 id 1itpO4-0005BW-Vj; Tue, 21 Jan 2020 03:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579597193; x=1611133193;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dzsTx5gyNZRgxb+htVSB2Yz4b5USLTopFiJ8tJv2Fyw=;
 b=EEFaP/2C5Cm8Kozr3hiXljBgCexOdT+bO4pARPIx3G+Ogmr7xYAp2A+V
 L+2Z4Q9nWMvo8yIRvYl40Skmd5aqxrfoJsZvbAcReZREwcAFJxev/qqva
 0sZpqbJbsP8mMPIKwOw6R8cIcrdd42Jn1oNUNAk/CGOH3Xn/GrNU2oWOg
 FDy2O65vV71ki+pxBd9QhR/a112V/xp3hJCRBEKMnj7ZZoNqQw22BxFuY
 Cru1vz12XSXm3qTGOOgAqJi+RBIdtLGB7HRG2AW4hn8QhdQG0FgMJW6NY
 92z5vk5YM0kg7zeetd80uPsqvS/QtIvKukI8bwvCeVQQDCkYi3TerQr56 Q==;
IronPort-SDR: Hib4evyOD28im8FZOMNaCdGf3gVLWD5W+R81R+sqcIPNIdtAe2XW4gymZJXBBMqp8LwCjnnhXJ
 8nZkAdugwyD2p4S8yHM+xcs7QRrZLeH7QvTFkUvOkvAk1SBEYPvwF7HSjYazl8FeDgd+jyGyKt
 Ik4sLOKXLxqeI9VwCGZ2PXRT07t/t3E+sl4zWlO3bXpyrozl1uBF+ryV20IbYS6UqmoGnQKWlA
 aiwfdp2a7DvDeSONiDi7EonQalkTat5DpCKV0ODIzdhmB/SEfXkyZG34RdM9lCug4h5bXklpWB
 Tc8=
X-IronPort-AV: E=Sophos;i="5.70,345,1574092800"; d="scan'208";a="128672486"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2020 16:59:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D29KeEbuHFZ/KAFb+nuTVzC7ZyISUCL6KdD6nqaLdgjH4RLpDIRiVkDqQ7Xl5I65v6h+qq1UoVLMFs3xrRfIrOfvasJF13t8/n2eSCzCGmWMslX+vNYjH11d5vPV4UJ4s9e3nt9R1ofBO+O08I6+u5sF9dcXohbuk+TNoyWmqH6OUshxC0t65toFwlsh4ZyDerQhRsEbPpuP+SE4YoI16kOe09Sn78RtMOvFbxCN2zNsdQV6M+ttb68l5LoTXDFugDdBYZcKCdh3Ig7c+dmgFQ6ea2rvFLRwBskHkaTw6vprBKiSlC89FYj9SI7Gw9p8P25cEbs/gb6QZafHfgG0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyvWTYg4qOm6nNV0p4rwDCAcl9FKGyJw6kcfkB6wyho=;
 b=dhZnDR3SyiL/sqqtkjeFlGPgOvpOVd5mtVGixkH/nb1p7/TPnjA7S1yyDejxF8sSlrPDfhj7Wbwh8Gg4O4enkDnASs9uJTrAYsqCL+6+bT68yWxD9SYJylJpiGnkx9s0bfnhl9UHsXzpapUs2yUe5hDuBoMpRb1+wwr79SjqcnP/byxmy4COf9O72UCfeY2o+KNIU6VhyxcmKR9+rfXKW7pavUdNDlGppk99qmTylrYDAyi2bYjx/IKgcTIeIHuf1Kc+jgiFHu7PLYJ+V9Lz0t75b25jZk6jTqEcy9ymb3N4LkzyWc4xB+9KbQ8m2kof3VgDQ/zK5ipo6AOG57j0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyvWTYg4qOm6nNV0p4rwDCAcl9FKGyJw6kcfkB6wyho=;
 b=kSoboXq6KDZeeDzuXkPg8cPMx6ydMrWBexL6dSVVnj+myzB75gzafhgKWulfgndfGYzcucMhw9GZ+/W5So67HxwgOE3kGOupNqIj0HPeXcFq4gMC4MlY/V9OBkTXrdnOzoJ02pqG0luJ8RqmzyjvOiyufpTxZSRqiHUgWhB1rB4=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5839.namprd04.prod.outlook.com (20.179.21.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Tue, 21 Jan 2020 08:59:49 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 08:59:49 +0000
Received: from wdc.com (129.253.179.161) by
 MAXPR0101CA0061.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 08:59:46 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 2/2] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
Thread-Topic: [PATCH 2/2] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
Thread-Index: AQHV0DkijRuvAOFZG0uvmL2QGRQvLg==
Date: Tue, 21 Jan 2020 08:59:49 +0000
Message-ID: <20200121085910.28834-3-anup.patel@wdc.com>
References: <20200121085910.28834-1-anup.patel@wdc.com>
In-Reply-To: <20200121085910.28834-1-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: 439cd281-1185-4682-036b-08d79e50452a
x-ms-traffictypediagnostic: MN2PR04MB5839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5839B3E3862670AA843E71018D0D0@MN2PR04MB5839.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(186003)(16526019)(8676002)(478600001)(8936002)(81166006)(81156014)(26005)(8886007)(2616005)(956004)(55016002)(2906002)(1076003)(4326008)(44832011)(110136005)(86362001)(52116002)(7696005)(71200400001)(54906003)(5660300002)(36756003)(316002)(66946007)(66476007)(66556008)(4744005)(64756008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5839;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Qf8FPf/VasmymZASw5A1zA3t/boFJpLVGPPignO+NYlV6lU7BqjuGw8+r9EOdPOuNXSny7tJfnIpBl+s8chavy5vp96d/p+ck1yPGsx+IIuisVp/jvSUpBDPZq9aOh+YZqCBwa5a9KURYjvMo4LgrBf1l8llY/PS9jilIP9PQA0s5s2YGGEOKD5rfHne2H2YDJXqJDb/ckdiE1cPhTAZNAZxfaHCLGQKpsHVDuK+QKne1/ujU8HubaLOKrHX2A0WoFHAGi/HDOAlfcRE00RfBYjzjty1viWJFQvcSz/7A3heJJa4JZx79rObFtNsDqo6DWufdEHEF46BPQy9eZnHDh3Ac6Yt0TzG8mMcUkow0Dd96YhJxknjy/qi/7ZrcXRL8zmjv7FzBPrfqV5s+gLsWNe6ijBNFAFTZqMfw2yd4fLtDdHFN0xsQGSHpjV72bM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439cd281-1185-4682-036b-08d79e50452a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 08:59:49.6774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hynvMFEa3DupihapMACzNRdVlILfOpOM+Apay4sPOkyloDm42KKivzUfQgGAxlEY3EXAZCb0dftPozZuRi4MqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5839
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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

This patch extends CLINT emulation to provide rdtime callback for
TCG. This rdtime callback will be called wheneven TIME CSRs are
read in privileged modes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/sifive_clint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e5a8f75cee..805503dc27 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -236,6 +236,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr si=
ze, uint32_t num_harts,
         if (!env) {
             continue;
         }
+        riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
         env->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                   &sifive_clint_timer_cb, cpu);
         env->timecmp =3D 0;
--=20
2.17.1


