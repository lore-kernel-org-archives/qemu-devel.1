Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E545CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 04:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D810021872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 04:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ltm+oM+n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cPD2RvNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D810021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNrEO-0007DC-0M
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 00:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1942c9cee=Anup.Patel@wdc.com>)
 id 1iNrD8-00069m-U2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 00:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1942c9cee=Anup.Patel@wdc.com>)
 id 1iNrD7-0007kU-Pu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 00:28:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1942c9cee=Anup.Patel@wdc.com>)
 id 1iNrD4-0007hC-5I; Fri, 25 Oct 2019 00:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1571977702; x=1603513702;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=kb6Ec3iKXa+ThjZfyTOuV9olQdKV2G5T7WoPrvsThXc=;
 b=ltm+oM+njtiZ3Qw/YncCVO0LDpLhA9I1Q3y4fMyGilfEFgWcwnTSBWmR
 6cgfurooeT1xZBKlkubwIlSmBAJY6VTYeTan4TguVMlRb2INGMAtSHYLW
 VCq9mphZ+JpiKK7F4KmYSVqcHk1oVv6kStrwV4n6vEt9gX3V4+DfiHZfD
 lSs8aecTS3alQmkZAJz6qMxYjZJ12iCvzZERo/+y5aC90ziqDtsI8CQ6e
 PHHNa1/687D7DIczDWQDlcPrfWUMdoVi9vJsYxBPLlGmwWPUgLsGil28M
 qhNda7PytGGgul+e+SXXms0e1vsd4KRnh2A/mhV9xF3EkkhqJXDPEZBsv g==;
IronPort-SDR: +TCv5bMo0olRhQeGQZV/8CrgKItJlNQpSSRIqnI1qbsjzuyvot8PHaH+CVfqvLB95/A8QmiMbu
 3WwYPr/NPxJNDVUWHzRUf2bauHRH4J0v3YpvioIhQcK46tzJH7MN/W4K5VHlKHjUAfe0p7FBJV
 qJeLMwmZRCBwGpAHXVrxW8PZXLsXgA5zY2yUSogzEaB+T8dDPLoaP684PD3YWdFrtigE/HiUgf
 riWGyubGKypy1r+EbTwSVdcJuJRXfOQpUhPTLsscBiKp1r6JoZbODfCoISK0eK35HvUe6lH12/
 KsM=
X-IronPort-AV: E=Sophos;i="5.68,227,1569254400"; d="scan'208";a="121323203"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
 by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2019 12:28:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5raFvjSHs/JQTJ61iikMaa2aquSv4yHuu9ovlaMrdJXuxAzqNLV3XCM1y90/sjXbNMclkbpBNPwmdCsusY79ob2vLyWnmYXZ1ltlYN+JgOJZZiRlDFyqrZHJFguC2S/FrKVDGFK4skV+/AVi/x6kZlW7lzU8LVngQMVIO3K4MzXedVWgdSQ7pn7EV9FjXcfxE0Q8L9tcvSdXQhFdiJ21twCl0wfR2cZMUr8aFxy7nJzi1sZsuOz55hwDxAqJRlYSQtZMV6ZZQKdTGNH/B1/lEEhFcBKPhphV9cAvb9bgnhikBKnI+czOuDu8EOfLWW4g/ardQaLVgETwvrLbqSqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxNiSMYmbUIlu51Xi1+P6G7/ELVAxKzLU0crkRJRnmI=;
 b=Du5vxQ2Y6bkIJRqkC/2sXNP/CURiP1FyOlelcPOqxP77FEIYrTmEOBpMZ4WiYqK/fP7aXFYEhQDSEX4krEdaXJRPy/Y0EQoW96KshscpeqNl9Ddzlr1hx9ObcU9hiNfGTMVCfs9vQNW4l7EAx6COSVl2hx4Ml0fPrW9zYpiiP17XV21qQGrM9KP+iaNcgoKxLlNKuNItbBeCbbT3LyDuNsqMJdf3ba5GBzBjPW6NeM9jS9dU6a1STB93jrzUZ8J9d5GNBaFp6gWwTuCBIVsR1Q4PUH149g3qzF77TUadMSuVVyPH9JM1gDqJZ8k09ADqCRyPs+qvPLdi5L8+BsVn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxNiSMYmbUIlu51Xi1+P6G7/ELVAxKzLU0crkRJRnmI=;
 b=cPD2RvNESpOQCw72qT7g0W4ctkKCpG6AqToHIKubRI1Le8jxoVFGlLQG31Opc41NPb9mRNcpAbNf1237SPgQmDN1DOdE2QKXyutCC08Ea624CTgcQtJ7FjSpSviob1Y3DJAFzB09W6IS5cEAqRYVWpqqrQxcquZSujw/Nw1nYI8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6048.namprd04.prod.outlook.com (20.178.249.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Fri, 25 Oct 2019 04:28:13 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::1454:87a:13b0:d3a%7]) with mapi id 15.20.2387.019; Fri, 25 Oct 2019
 04:28:13 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v5 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v5 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHViuydEEnSF4Bqf0SmjlhpX/ptcw==
Date: Fri, 25 Oct 2019 04:28:13 +0000
Message-ID: <20191025042734.69244-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::20) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.51.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5080b2d5-a98f-4c97-b520-08d75903bfbc
x-ms-traffictypediagnostic: MN2PR04MB6048:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6048AAF75CC852E90E2EC55C8D650@MN2PR04MB6048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(14454004)(50226002)(476003)(8936002)(486006)(66556008)(14444005)(81156014)(6512007)(6436002)(6486002)(81166006)(4326008)(66476007)(66446008)(64756008)(7736002)(52116002)(2171002)(66066001)(99286004)(66946007)(305945005)(386003)(102836004)(6506007)(478600001)(256004)(25786009)(55236004)(186003)(36756003)(86362001)(54906003)(966005)(71200400001)(8676002)(2616005)(3846002)(6116002)(5660300002)(110136005)(2906002)(26005)(1076003)(44832011)(71190400001)(6306002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6048;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JpsKKb12MF9yij+UJ6M4IMp+tIFQIs1I8rQrMa3cCc8Siy0+lMIIyBnboWBS5KskXR4544l+X2yrHPll7h1JN4BgVfTWFZjk0m+De1rj67yZALq/Uon9Q7nDnv5TOtlshtYvPHDs5Ew2JuPy+jIVvq8kn+OU47DUf1RcsrOlqrc1rL1QCFiOOVrE4tEJlCs4EmpbK0ncXgjs03lkh2abxCHM54PA8LKkQWeJ6T86KdgRnq0cDzuurtT0RAnP7qssKB9fBE7bHJGTRd7CX0Z6eEd/CUq8Uorm0pxE+AhITCPir8l9uI887V2ACh79G6V2hrXmL9C7izp8233trPvrlDnRkmxWKe0u5aKdVQmdqLdBcHWu6zoENVrT0/wEH2Jzazkhq6cBbZMLK68gc/woSkZOQF/D2LAhHIlIU3U1k/PVMvua7G+DP9QPNKm42La+LLralIebGtV+k8Er/roJsDfaCtf9lfvWq/rbv5PP0k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5080b2d5-a98f-4c97-b520-08d75903bfbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 04:28:13.6991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QS3N7Kxb7WRpEgtOxb4xhfBhyb9IchZbvaCqtEFdzeBmXj3L2J9zKi/F3qpc24eu77iAY4fScxcKHLkHEk3nHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6048
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

Changes since v4:
 - Fixed typo in trace event usage
 - Moved goldfish_rtc.h to correct location

Changes since v3:
 - Address all nit comments from Alistair

Changes since v2:
 - Rebased on RTC code refactoring

Changes since v1:
 - Implemented VMState save/restore callbacks

Anup Patel (2):
  hw: rtc: Add Goldfish RTC device
  riscv: virt: Use Goldfish RTC device

 hw/riscv/Kconfig              |   1 +
 hw/riscv/virt.c               |  15 ++
 hw/rtc/Kconfig                |   3 +
 hw/rtc/Makefile.objs          |   1 +
 hw/rtc/goldfish_rtc.c         | 288 ++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events           |   4 +
 include/hw/riscv/virt.h       |   2 +
 include/hw/rtc/goldfish_rtc.h |  46 ++++++
 8 files changed, 360 insertions(+)
 create mode 100644 hw/rtc/goldfish_rtc.c
 create mode 100644 include/hw/rtc/goldfish_rtc.h

--
2.17.1

