Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AB324680
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZK9vV2+v";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OK72T6oF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AB324680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEF2-000770-Bp
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDe-0006AE-5D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDd-0005Tb-07
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:30:46 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDY-0005KP-Hw; Wed, 22 Jan 2020 06:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579692660; x=1611228660;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=kumvxpS6OhnR8//va6auAZ+BQnz+w3U5moRGq0JguFs=;
 b=ZK9vV2+vf7wz0Hn1oecvG0Bf9olt/6uqNVgdM6LDSxugr65hYzhEKzVe
 goLHUHwvB9DVy1wMVZkPAI8KTk0QHpPrbSInFI/WkixrSYNeDfdPcs+RK
 V+P4T3uAlrNmklHJCV3Hoe9wFSrbg90k1KD0FaKLJaTdYnDT62bEL84dA
 ywmsIsVA0l6YiU9ZTOKVeA95xvy5J5Wk+0gtDJRmdM5wA5OK2k5YacKY8
 WiZDiGlf+gBxsNxfH5Q3ohF9YkzKtbw7ows32bDAx5kaoS0zm8dNn7d0r
 D0If/41uDryczfOPgUOLyVtxbQOxmj95UF7K+2CJP0GbBrl1tJ1up6pwW g==;
IronPort-SDR: wD70EDJMEIO9x3geLM6pMrVXHC2WbOPKAqfdPmGM9BTnw309n2kCkhEJfYyPsmqcGUK33O4Tl7
 SEwF1LRhgNn9FrHWSeGEXQYzGrx+dRLr+vfBEqBhpCkTTliBQUqVkUe4v9q0dj20NFnhu9ZevO
 04eMIbL1kR3mYgn+LigoTR7vTRa34u82cxBA5nY4XpQUU7ZaijRiQaQvmEC3vllOqKnRCxl3Wf
 YXbUsvedObntK9xEhsozJACruG+c4JsEDlyKj6TD3Gs94S+aYWxHBbZ0TsR7j5kxyL+Wj/Jlqu
 WpM=
X-IronPort-AV: E=Sophos;i="5.70,349,1574092800"; d="scan'208";a="229843238"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2020 19:30:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbyqypatiKbHMHPPuhijDkznFkGL3CdlSkpKXLbuILMTQDcOxt+hSTatfLxLaq6DO94czpQDfEXzJSB9jYV+Fx5I6xzaDceVUOP+Y1klNb9teoiL57il3zbTHZgD/uzjHjs+4I7wW2jWbbr4jdSfN77Cnyvw8j6A3WOPQy4M1Li09lLrB6PPAg0aBaRNPMEtGpQ3/9vgJhiN7+ZA09SbVCJkY8aW1QSRmPAlh6ASXz+PXHJkPp4A5AKZXlGMCZKrdHrby6leBQ3hVIW18vh6qzQHzEJJbzsQUFRMS3uPg9aMqoxPvc7KtIXDf2SrpPzV2YgaB2bwGcTC9ZdDBpwcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY29GzshNgGUU26z8HXjhcbG/jJ4F5xsZlA2r5RjfFQ=;
 b=PGhbwKdR/bschzylFkjiymg+WeCfiZB4EKgpCYjk6XUowzDCA7PTy5vfRSs/eLJQe7IQo/6jtc+xBicbAmuZS7D0M2RWUYgvQ1Cjs3LtL8s8LAGogqIkfWBvhKq3sl4TC0hwSQdw2C1oil1oapzsJMrqIw9Fee+uEIQ261kJr33EqeVShJQ39bm6ZtZBdUjLd8PPeXH+xdJORZino5YQDFm+tPWWP521khVlV6aCOAyTXFcUS5yxnCbgNjZxeG73pWuDTjLytDhhFCqq2qxsEDTzX7JcSAtdlUNmJ5Y+Y3B1BZymBSGePBtt0y5HpWgvKPK7nS/823WD/16ODbhxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY29GzshNgGUU26z8HXjhcbG/jJ4F5xsZlA2r5RjfFQ=;
 b=OK72T6oF4YNrgy6H85nHn8iI460/c/63Rg54mcNWB/onxYaIZlQX61rfnrKIzhDlNi4wjvsZA7vbMUFI60wWGWA4ie+iW3Yda4pnM+xqBWk09yVN+uQiyqwV/uCX8Z/vaY7qlm3FhVsNeEo84ySZSDZaNrzJ1/EOVV12fv01lE8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6767.namprd04.prod.outlook.com (10.186.146.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 11:30:26 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 11:30:26 +0000
Received: from wdc.com (106.51.28.174) by
 MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Wed, 22 Jan 2020 11:30:22 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 0/2] RISC-V TIME CSR for privileged mode
Thread-Topic: [PATCH v2 0/2] RISC-V TIME CSR for privileged mode
Thread-Index: AQHV0RdX0HwYM7nGt0SpiQO0radUkA==
Date: Wed, 22 Jan 2020 11:30:26 +0000
Message-ID: <20200122112952.94284-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::32) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.28.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7a76630-1bb5-43db-38e2-08d79f2e7a05
x-ms-traffictypediagnostic: MN2PR04MB6767:|MN2PR04MB6767:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6767768E24C268862C935C998D0C0@MN2PR04MB6767.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(478600001)(8886007)(36756003)(110136005)(4326008)(44832011)(54906003)(316002)(55016002)(2616005)(1006002)(86362001)(2906002)(186003)(71200400001)(16526019)(8676002)(81166006)(956004)(81156014)(66946007)(66556008)(66476007)(55236004)(66446008)(64756008)(26005)(1076003)(8936002)(5660300002)(52116002)(7696005)(966005)(4744005)(20680400001)(32040200004);
 DIR:OUT; SFP:1501; SCL:5; SRVR:MN2PR04MB6767;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aT+HgEqIBkh+Sdlb/toeefuI7PAPEkcTs9bjrtzcNW8JsGZTfqr4AkKHklAJip4PzfVY8CvmiDJCrpMv1ew0XlbM+DukTmk1a2WyhsOfh7q5jKXbwz8vV5f3OW0UUchhRa5jbQ20uHRIzsu5WasO2BMNJULC9VPMz5CKW9tqqnseGfMM4MVfIBr16s4VBpqPQsol4T59+3CEXloBtn9txM7eEC21wLCVNFXeYj1/rF8IWj09HkcxlP1fNluq+zYbVVHdZNPS38Vyohq3DsfUB0zbbuYgIUeIWzjzThyvx6wPVyipSOVDcVpWE3WB7z1J4Kb9ZfYPq9AiuYIVFA+AM7smWpO3yyBQOx06lR4TrSOd9qlkXA6V1zvrmKZRqSNO+4aT9HBl29acqyXEBygeWqNryPFiStdpn1Bmj16VZXUIFX1qT1YqF6FwtylERUXZD0+3XY57tJI22Q8wg2KN+vCxJ+KfHY9CB0L2VbJzFtOMGyuvUhu3HjvG1zF2KQm9Kx3o8ZVm922ZgHIcK3/np2mzmjr5sCatVwznrvmFGzdu8/3v2tx/up5ZQLn3DJl8dObWeMDr8mZXcM/WNEW8kDGDHvb733UYBEgX2r4D3wkwVAOdvwTJ5J9hx3JLkrcFLW2yR82sbGaMXtI8KdXs67SUHFQSrnT7YEe86G9LJkiMQBX1Qk/YvYs3DpjA1F3h2puO3u27dMBOYbVrMGQYKZ/zSaJFvyUb+wyW5Q30uU6iDfjX/oMu7cSKK/1dgAdpxED4ZxKDlXs3uPmQF53Z26glReruitbVKzhxeciVkV4GvhO+0E1eGe9s8vOksQCEB9bWjKOitp6+84/NoSpYHQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a76630-1bb5-43db-38e2-08d79f2e7a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 11:30:26.5596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5KW6tmfzzfDZH218zcqMKSFaMBe5J+Qvys01F97/3g7jH2Y9FJZLhL1pTmDl2qPO3ZEDp7JxdZ93ox5VIDdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6767
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
in riscv_time_csr_v2 branch of same repo.

Changes since v1:
 - Use braces for single-line if-statements

Anup Patel (2):
  target/riscv: Emulate TIME CSRs for privileged mode
  hw/riscv: Provide rdtime callback for TCG in CLINT emulation

 hw/riscv/sifive_clint.c   |  1 +
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c |  5 +++
 target/riscv/csr.c        | 86 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 93 insertions(+), 4 deletions(-)

--=20
2.17.1


