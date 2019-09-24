Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C16C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A772214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o28BcAN1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JGGq3PGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A772214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgRZ-0000YF-Ny
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPI-0007Ii-S1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPH-0004fR-OQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:42:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49315)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCgPD-0004dU-Ux; Tue, 24 Sep 2019 04:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569314565; x=1600850565;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=cGEOwFwyerf3/zVSV8rjJq+0gKpKMNQoTHE/DGWVWT4=;
 b=o28BcAN1f400SNGwQHCja4MkQwPC0iY6RveUdskEDN7eh14F2Rx8a6TV
 18hToRUrqbkblEl+VJZowaPRb4cEv62eRht6OV+MiTcD5tQdFggiNbpcC
 LSECl1NpMxnFtHH3oDSB0Vjfw5SHc2IwRP0rP/9ch/IP67Z9mM2vTP0bs
 1YIHiq2yzzxFiHn5aMOVA3D05+2yKSux++mU0ZsV7E5mTVV4aMCFw8+ZT
 5X3XLrTS7D4U7SEDtfYk7wqN7Bl5+C8IG0PuBlFA0lni2Wm+TdbcJuqNQ
 aXQdKXfYEmbRlc8pgORiFvoQCCiN6uKCPaFLbyg1O9bB3gSmQxcrr4b58 w==;
IronPort-SDR: 79lajFWK1P4iV7Gu5KyVlHd02urFEuVqDkgLciLWeNLD3dsmv4tdyrUIghb3XalzMlpCsNGPqH
 hUjJMuo/4gyq/Roqn1tVlUdTcTn1bMt2aEIjcGQSCo/KqqIsGOT0M3axIGSARMDq/v+kMNcr0s
 urFE/ibGoHx977fU2ePvdYcUE/6pfNvgFWncFp6RDTrRdRhD8lAJ73xoRJBku8acwVp24xnWbQ
 /y2aUh4L6y9DMJUGewGv9D/TgpCVhavBjfR1wGSdqoxa0ePwt0sEIeFWx3RZmk//ODTfrkYYn8
 QWo=
X-IronPort-AV: E=Sophos;i="5.64,543,1559491200"; d="scan'208";a="119740806"
Received: from mail-by2nam01lp2053.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.53])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 16:42:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKWhYOfbWKDWGUiictWqiTN9dPz0Ja4RjHknK8ySRpkkbWFowG7bLzbZkYqAC66huJ724mTjg8otLQ526rOS8vOMw9pKkDF9rL4xs5VZeqeH00a4v7hAgLzc8gQjf/8p0ACB8+TBTavNnY6f02NuH0LwGt8tM8qzE0R/WG470uN1W3KkUU3M9ebVlqw8Mus4sw8iFklih42kr2wyf1CXpvnFoMbszAYYd8GrorIgiWvVh7sUcFn3WXigOHfpkE78SNC/LrSIwThYMiEzN8PF0kQlqqYv4JB4R9G41NLitiYDQ/e+rbJ+ZiThTkvOrevxduHMRqJY3bjBX4cGjHaYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBGFFMAigjclfoFf/15lmk1RqcTHgVhTLnB7Apd/Rd8=;
 b=gLRLyPQm3r+2ej/A14YUTus8Vh9ms/nIJ3fWSNF5o6wepyqMH6vREz9vRjsHpgPBexQb8uY4r4W+KekHZ1Tu2DckGFWv1sAD4ZxDEelnlJy851aa7S44PZHae3h82qQ12tfJlNTA7hNg2awjklx2Upm14rB9rcSFz+OT+KgPbI3CjZRfC2wx/LHaHmhjAwMUVh96cZJ7VDMctUwYgE4SgMVs1/BSaDbr+o/mk4QzEybFNnUwI8TQW4iaghDG6m+4mUGBlPYi+/pL2zP3KFS3uDYGaDw89AaQJt2KVV3wiUQNc6cWCBTGspwElP4cVM0kl61tx/aLRNEoMsZV/+p8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBGFFMAigjclfoFf/15lmk1RqcTHgVhTLnB7Apd/Rd8=;
 b=JGGq3PGEXMtTXfmDkom73yx024/pqUR8AZf7GqcW2xdaYkwFDlrdDNIIvHd96g4nmp8uprya+Cm24oQKXBn56v8kPnsFgNJpot/ZLup+fErBj0GfmG3E9TkoatMrqF3cYeigDUfVquDKX2ABwqJNhEY3+nMJVTeEeUAdgctMESM=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6957.namprd04.prod.outlook.com (10.186.147.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Tue, 24 Sep 2019 08:42:36 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:42:36 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Palmer Dabbelt <palmer@sifive.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVcrQDVebPiIecyUaeeiRl9lWtHA==
Date: Tue, 24 Sep 2019 08:42:36 +0000
Message-ID: <20190924084201.107958-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::29) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71e99f5e-b186-402f-1bab-08d740cb2613
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:MN2PR04MB6957; 
x-ms-traffictypediagnostic: MN2PR04MB6957:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6957E278C5B5AE70AF5793638D840@MN2PR04MB6957.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(189003)(199004)(66446008)(2171002)(5660300002)(66556008)(25786009)(99286004)(86362001)(14444005)(50226002)(966005)(44832011)(66066001)(1076003)(8936002)(2616005)(6506007)(54906003)(4744005)(256004)(305945005)(81156014)(478600001)(6306002)(8676002)(81166006)(3846002)(2906002)(6486002)(71190400001)(14454004)(26005)(71200400001)(7736002)(386003)(66946007)(316002)(52116002)(64756008)(4326008)(186003)(6512007)(6116002)(66476007)(36756003)(110136005)(476003)(6436002)(102836004)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6957;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aIWxmOt8uj6JRw2QAFD1/5eQB2PJIifK0GmVib1w9m+Qe7c+Pb4FgMqM9at66VymdeD+yfWpjt1iYmL6kHVqsMbmSa8hKRxPcPARoyWMjRp/oRKBHwqd05PIktzOoe0zzlN8Xm3e//88DD8CM9MP7iHXJ46l+F27krJTQgM3elz5KLzqK0Hxbjl1mofmuDiLMPK18nHX8ynspYcL3Bjr1h5Bqf1Z852LzXeXgs1njS1qrsCs/92x9MFwjrPOQYSEjAscmPhKQ6BkrqBxMz37lWSgp8F5j4rfeA/d4At3jIeMzeEufJq6SPmCNiimARUR5RV4gHy6JPoPlJfcnmeSpgwagLdbjERqIP1FCqR5bBMvLVCn3gjO8oUY0uJumxONI/kpPpCA5COqXyliay44ZlT6y0qdaTo/mdJCDJzt51YVhiyqypTLPoNV7Q8mxqJnUSZFZVmkoJiV4uCSHIjWdA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e99f5e-b186-402f-1bab-08d740cb2613
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:42:36.5944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZ9PfPL0TCrGB8pKNf13UIYzK238+GgeirNbwELlx+QiE9vcwIBSAJKFRMprVeGzLmGYOUio9JJ9P9Z0tZEQ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6957
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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

This series adds RTC device to QEMU RISC-V virt machine. We have
selected Goldfish RTC device model for this. It's a pretty simple
synthetic device with few MMIO registers and no dependency external
clock. The driver for Goldfish RTC is already available in Linux so
we just need to enable it in Kconfig for RISCV and also update Linux
defconfigs.

We have tested this series with Linux-5.3 plus defconfig changes
available in 'goldfish_rtc_v1' branch of:
https://github.com/avpatel/linux.git

Anup Patel (2):
  hw: timer: Add Goldfish RTC device
  riscv: virt: Use Goldfish RTC device

 hw/riscv/Kconfig                |   1 +
 hw/riscv/virt.c                 |  15 +++
 hw/timer/Kconfig                |   3 +
 hw/timer/Makefile.objs          |   1 +
 hw/timer/goldfish_rtc.c         | 221 ++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h         |   2 +
 include/hw/timer/goldfish_rtc.h |  45 +++++++
 7 files changed, 288 insertions(+)
 create mode 100644 hw/timer/goldfish_rtc.c
 create mode 100644 include/hw/timer/goldfish_rtc.h

--
2.17.1

