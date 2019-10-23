Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5813BCA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 06:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212E1214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 06:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LgBf9YBF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TAfSyMK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212E1214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNAHo-0003WR-24
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 02:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=192d452e1=Anup.Patel@wdc.com>)
 id 1iNAGT-0002IG-6o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 02:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=192d452e1=Anup.Patel@wdc.com>)
 id 1iNAGS-0004rg-1q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 02:37:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=192d452e1=Anup.Patel@wdc.com>)
 id 1iNAGO-0004mI-1h; Wed, 23 Oct 2019 02:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571812616; x=1603348616;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=k9e7P2ba8d3jSmt6uTKIogq9CCsN1t3c8xXyv75xIHY=;
 b=LgBf9YBFORg4m0mWskY7JFdOTJ17RGIbwFOyZUvNhl5NB8XN4PcwXdrk
 8hlgIV2GKUQk93bdmwAlMOA3lzaHZPA/vYI9h2NyguBOL17jjkwU0Oktl
 LJTsa7d4t94XDfmukezcqRMiW/OO5u6vzkxG3V08zN/d9XhpR/aPO2zcI
 BroaB/xiUtPbTQM/IXroywCwMm/balV74SsDdZmr3doyX705tEqijORyH
 cEgpG0kSRCqiDmtYDomxLkuF/+3KZveMLeErvjWr+CLvIWMTTwjqCd/C4
 iDTXqX8+jUCF0h7wlioCWdYPwqzuaNLmnwA+GWf8TB/4j1cY84vzu3xwO Q==;
IronPort-SDR: aPxouPEAc4Iq0pLnDgeCu64R1w0vEk+imhhQf5Er1iWn8L2OpJqEzcTP+HMji7KSCPxGYknmwc
 54IduAf2V7NH9RkORsuqa0XDR02s7HufHbc/8LesGJsGgAV8nkIzZyOKX8mpSxheZTmFCbq5Hd
 8zP1mWYKGOnNAcODVxbYWugrL7iHgy4nLo+RBXVrlvpY6f2AEtNYHtY1EYoE4FqZ4UQ+T7M/qc
 qN9vBaRDTjT/h2nBzWcFDNjxgInQ3Zjnp8D6LFZaLJQyvx2w1j939K/RiAjI7AIH7AGCNEkwLv
 4DE=
X-IronPort-AV: E=Sophos;i="5.68,219,1569254400"; d="scan'208";a="125553536"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2019 14:36:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zikt5u+IYNBQecGtrgEsrlOZ5U4SCzOTcGsvMQvWS/sYry95uUBHyFItSmr427JTBU+yjKKtmEVF6f9aW4P6Fbf5TviLjggWTJX8ZDkH3xh2tHDSCRQsQaaXm7hiImnuGmEVnuV/QlHQ2Qqp4wE62sOcw2n7N+U+144NS86n96az2Y1vd17TvL30z9fQMiANMrpvL902gUlNMGSSafmGlL++GIg0qvv1WoPIJy3aJkJGI3LhrHrESdpUoeDN9CgbAc3XbkGuWdrGpmmnhphGsri0/z9oO2cnfnZB1Gf9ucpfsibRpQvaHXssDCMNsuQeq58d6rSSfvuIWAt0J/RvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/D6TBRFSN+I3Fyk8YyVx9TTcXOnUZmE2l7vYpxB+9I=;
 b=VeiIS2buMUMMHeX0NcP9z0FeCLzbXIs7ITGJthg2Wcxz+h3J/E4fR4soZK3VKVcV3jvU5x0zE8RmDr9E49xX7tR3V7xZbBedPMEvivnW15zVtBa1qAg+AR87UTZorqxL4d3kc1RdM8ud64IwbeJuNx394spfWnIOpQR9u/DbpNZStGIU3MyLYg/kQrwhgen+OOCF1HnsiCW0bd1D3wA1vhuX5fq8Xp9x1lzxS8a+MfYqsSvfASjk9Kc0Ax/gDkzlrCehxI12UPzOLAqw+KUjMuKhSg2YY+iv/3gLqoct+MQFOCFIG51xJbQy1R3haWIKe7qyqWexHJF6U3bylBKyhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/D6TBRFSN+I3Fyk8YyVx9TTcXOnUZmE2l7vYpxB+9I=;
 b=TAfSyMK1Yg/jCQXlp96pR4TXrYGA32sdfeMY1Hbtuvw82ocQfwPdP2OYPvWfqk8kCuQR+llmj8+5uz2WDp1W9KKq8zhGHa9NI/IEMRMO5kpaaxBnl+bJSTnpKHt49dTR1CVquPFxzsd6XMzcTUsas1+mNwzd83hoUg7/6RoBlvE=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5871.namprd04.prod.outlook.com (20.179.22.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 23 Oct 2019 06:36:48 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 06:36:48 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v4 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v4 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHViWw/BWZDFHJxK0eUKIsxb844jg==
Date: Wed, 23 Oct 2019 06:36:48 +0000
Message-ID: <20191023063620.35104-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e34bfec-b8f6-4712-a66d-08d757836145
x-ms-traffictypediagnostic: MN2PR04MB5871:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58712E6CDE0C34A070CC245C8D6B0@MN2PR04MB5871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(8676002)(2906002)(26005)(486006)(50226002)(2171002)(86362001)(6486002)(476003)(25786009)(3846002)(44832011)(36756003)(6116002)(6506007)(386003)(7736002)(186003)(305945005)(2616005)(102836004)(4326008)(14454004)(99286004)(6436002)(52116002)(478600001)(966005)(6306002)(81156014)(66066001)(6512007)(81166006)(54906003)(71190400001)(316002)(8936002)(66946007)(1076003)(66556008)(110136005)(64756008)(66476007)(14444005)(256004)(71200400001)(5660300002)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5871;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzN6cT8kE65uZusdj4rKZ7SIj5O3KIgmxLcbqRmh5BnXge7FImsPEqKT6p7MiWw0aXQzMZuJg+HcvQP2RuVjtIsiQzMew/Uqd1/LK67QKdWPZC4Gniil86U+3eE/xMtMAkjOm1WTgeKZwQQkdzDzYfzSufhmd/1+azoajel5WSlxL/Xc35I04dsXbyAOo/9D2RiLgd5xtWEd9Bn7qY2PgawnCSyFF6gLz+DxpOTJlZcRM0WF+2kfVTBNZu7mwPIfS0mjcXuYRmISmRV7ODdrrWdPSM6THijos0j7D0CB2uP3DFfNvEW4flWXL0tyutMyvATFVfz/ee82dMCswfA6GHeOo1EylKun0SvGBNmDm4lZWHw+rMUc/Zj/Av9H+UH6x+4GWpMjBYnPW2d9HTD5KYgnaNYnZePix/VFR3j9P8VlZsoulB6mjt7NxPyqxUTOYPpX6L5RW2nGc1wG3jr+jmgr0KG5aUf09GBM2KQixTY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e34bfec-b8f6-4712-a66d-08d757836145
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 06:36:48.5398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSZEdLWyfMsYCgOp06Hh6EVWZNorislvLQeQsLjGGS31MRe5lMBz8/fFYTZt9ISImVCg0DrNICN9EyKrrlyz9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5871
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

This series adds RTC device to QEMU RISC-V virt machine. We have
selected Goldfish RTC device model for this. It's a pretty simple
synthetic device with few MMIO registers and no dependency external
clock. The driver for Goldfish RTC is already available in Linux so
we just need to enable it in Kconfig for RISCV and also update Linux
defconfigs.

We have tested this series with Linux-5.4-rc4 plus defconfig changes
available in 'goldfish_rtc_v2' branch of:
https://github.com/avpatel/linux.git

Changes since v3:
 - Address all nit comments from Alistair

Changes since v2:
 - Rebased on RTC code refactoring

Changes since v1:
 - Implemented VMState save/restore callbacks

Anup Patel (2):
  hw: rtc: Add Goldfish RTC device
  riscv: virt: Use Goldfish RTC device

 hw/riscv/Kconfig                |   1 +
 hw/riscv/virt.c                 |  15 ++
 hw/rtc/Kconfig                  |   3 +
 hw/rtc/Makefile.objs            |   1 +
 hw/rtc/goldfish_rtc.c           | 288 ++++++++++++++++++++++++++++++++
 hw/rtc/trace-events             |   4 +
 include/hw/riscv/virt.h         |   2 +
 include/hw/timer/goldfish_rtc.h |  46 +++++
 8 files changed, 360 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/timer/goldfish_rtc.h

--
2.17.1

