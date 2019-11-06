Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D596BC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F5B2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aZZilzFr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c/gjBUfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F5B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJwX-0005Yz-Oh
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvZ-0004Vr-Qd
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvY-00060X-KC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:56:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSJvR-0005x4-9v; Wed, 06 Nov 2019 06:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573041417; x=1604577417;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=UGNS1GjvSr0a4noFz37xnPLHT7U2Us1mvzZrIa/wrpo=;
 b=aZZilzFrtHDZZkE22EPuz8Vox8uw9ZqMGpjs3es2sMXMsfxRVr+7+R57
 8Zlh2Gwo8/cdjsc7/+GKAiMKY0HMYdW0VtvGb6OmM18lKG+icg6zf14f0
 g9kE2pR6k/VeyMPgKK6QDIKCVgrXru5AeIao6YvuocGd5gFZO30rDtzNj
 ysSOwo3L/FLchH8c604/O0mn8n1+Eh/qcQYFC1PNj/Wym5fVfPwZeR1id
 q4eNhlvLAODAmVqf7BrzMZrJ+xDIj1AkQeEsLmEiWHMFI53Zz7v8Dff0q
 FqC8g7jFtBtDRD2aQGJhkcNi9s6DDPRHcJVNNlJWpKSUKzAOBidGQ3jcX w==;
IronPort-SDR: qwIzHLu8Us8SgUC+WpQyujWeDb64RRgz83j6Rvzk8WVZWXlo2HY2hm0oPJ7Dz5zeB7vdpDbOOQ
 sf2HxVkzUK4L7O2xxErcclBdbnwm6ApjQzJj1gM1wTWIVc9qCt5Xn242evd5RmD0NgspKKBrpf
 zR3Qv0icT3VGfYb9w9oZDatYJtWpo+aVzlbZlBlDRSRTslxcctBuaNqV8QQ0IZH2MeuXP4hPNe
 nFD0PWbuxCif/Ou2dNCNmry7sPz9NvUI0FeTopxlf33dtbiKs+ZcNb9slgS9P3cEUO3ndDp8q8
 s0w=
X-IronPort-AV: E=Sophos;i="5.68,274,1569254400"; d="scan'208";a="223466566"
Received: from mail-dm3nam05lp2059.outbound.protection.outlook.com (HELO
 NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.59])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 19:56:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEghQEcDTByETQTTszlt6scW1vbUWV/zGbJEpXzk+eLav7JZOfjTDu4Vi0S1HaAjA76TnLWRo0rh8xvPsrn4z4i20NMR5ihwmx346V3LW/1kbIWHVlNeGsiI4s2KeBgk8AJKd6SDMGWZjZq0xhdbugShSvt6474UcauN8CqmPCfB3T3ZHZemzwCT2KDzQLrDhmBklkACm4fAOHPBATzkWtbzMpkNDH8yReXeK/vL4orm1PDQtiT5rbdorRtJQmRFYb0n61a8z2zpcikuKFXZ26cqhUNcHHH9vhBhzCu554jHf+3ypEB7C/ys9XqpBztduVCVL9QKlajtAfJic2C4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnx3QrcUMrmD8c4gy4rGRYiGvfxXZKaFNTooUTo/cAA=;
 b=gd8uuoJ0Brm0yIwFNtk4j+b+8h9DT+Fsjmn7AAH9kXBwXlap//gUoQJsqIom1vTEHma1DckfMKOmgUmrmZ8uG+siqm4BMb9hPiFu/+UlbP7efbooeLWmRr32q5uWlgYxCbDo4eeZAkzOxIcwRZ6pEyJS1zMc5KrnelmUvp08oTlxD1RIG96S1viNdkZ5zomvgv/lKLq1OJpGYsg2roWk/yfyBTFnH0k9Nu4XHPW2yRgXm7+0q2768bsc3gfmB1/lJn0OS+QSJkVOSbR3sbTH0q/9mU7PFzlCzk3dL0b5E1pKzC0TEKjq/HHgLtSgM4m8cnJa8FV+SiOfkgCBz4jI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnx3QrcUMrmD8c4gy4rGRYiGvfxXZKaFNTooUTo/cAA=;
 b=c/gjBUfS7xWMR14SFg4BAiN6RsMCl//tpSqiuTXJZTCjfwCN4qk0jtIYq49i4Q5OTX5Rfbs5i5r26moGkjHzQ4cx1V+fZFJFJVzlQr2kn8j50JiDEeIPkXG1S4gPv6aWbq6ZH3lTJ/+tbYRZ4K9kdsE9GY50HSXqBNMEsxFWrYI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6080.namprd04.prod.outlook.com (20.178.247.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 11:56:30 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 11:56:30 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v8 0/3] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v8 0/3] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVlJk5QWSiwaJ8T0uQpXkwEVoJdg==
Date: Wed, 6 Nov 2019 11:56:29 +0000
Message-ID: <20191106115602.74299-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::11) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.25.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ea980d1-b2f8-4057-f38c-08d762b05c1b
x-ms-traffictypediagnostic: MN2PR04MB6080:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB608050DC7E26F8D108FACC0B8D790@MN2PR04MB6080.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(9456002)(2616005)(6506007)(99286004)(52116002)(55236004)(102836004)(186003)(36756003)(66556008)(81156014)(8676002)(26005)(8936002)(6116002)(50226002)(476003)(256004)(2171002)(14444005)(386003)(6512007)(4326008)(44832011)(71200400001)(71190400001)(6306002)(7736002)(966005)(2906002)(5660300002)(14454004)(6486002)(1076003)(3846002)(486006)(66946007)(66476007)(64756008)(110136005)(54906003)(81166006)(316002)(86362001)(66066001)(478600001)(25786009)(66446008)(6436002)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6080;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nB2hx95JHy2d31JI2EGcdV4l0cxDSPxY45T9Im36DeUPQXJgAAeitGoXFhSYJUxsSvGZ93SL99KqV+Yq0I/wrdowt1bUT0uQF37a4w2mpJHuEdwmw8aldy1Yz1ovBLjkOqlelNwAMItlfV+m7SPFP98+IJYd/WttcscjucTfp5ALXUBZ+cYdLH8er5QF2eB1OVLI/8fQAjuoSb6SLuYRsqL3D3upcJ4QpmrzgKSRxvvpH/J0KrkDwQ/g5oaPW9MfpVBizdDxTRWcYogeqgCBlPjUa7xvjHcZfBJRLUaozjKUgSVa6Kz2a3ATXJosolWhRz7lAtfzvaogr5QCQNKSs3Xg+kd4rFqUHDZb38g1lJmj22jfK84XAkd0Px6OyOW2Ba8086b8DnXrVNlASHSj3MlLV306IHMMhX7KRBTTSvNO52MRiZQJ2PCHPPD6Xys2sA/GQkiGDWyggNkJH65Kk0SYpyQ/JsEiTVZwgzhB9I8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea980d1-b2f8-4057-f38c-08d762b05c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 11:56:29.9264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2s5LWcqi8LJVbP+nF7U8CfVdC2FUhb8ro5GsVW/VWgY1sD7iLqCt+B8LRLppBSuXmL2l1eaODZ3OO315BNwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6080
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Anup Patel <anup@brainfault.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Philippe Mathieu-Daude <philmd@redhat.com>
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

Changes since v7:
 - Fix broken "stdout-path" in "/chosen" DT node of virt machine

Changes since v6:
 - Rebased on latest QEMU master
 - Addressed all nit comments from Philippe Mathieu-Daude

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
 hw/riscv/virt.c               |  16 ++
 hw/rtc/Kconfig                |   3 +
 hw/rtc/Makefile.objs          |   1 +
 hw/rtc/goldfish_rtc.c         | 285 ++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events           |   4 +
 include/hw/riscv/virt.h       |   2 +
 include/hw/rtc/goldfish_rtc.h |  46 ++++++
 9 files changed, 366 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/rtc/goldfish_rtc.h

--
2.17.1

