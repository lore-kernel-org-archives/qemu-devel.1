Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEEDC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A6F2173B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iArIePef";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vq2kFoe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A6F2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGno-0008Mk-14
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmw-00078T-MM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmv-0003gD-IA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:35:38 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=20673f3fc=Anup.Patel@wdc.com>)
 id 1iSGmt-0003eB-8i; Wed, 06 Nov 2019 03:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573029335; x=1604565335;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+4DVSZF1OwyKe+oveoGbmdIZHMMAa7gf6OZSpH/u0Js=;
 b=iArIePefouyrnwWJ1QUhptZx9Z6un6O2K2IOS1//1/OutvTLIVlKqNh9
 V9H5gxvlSQUKaYAk1wtERm06rPek9ezPfqcvb2QZ244ZM0hj7Bkx/qwSG
 7Z5ipFXMHeQFBaFz/NMmLN6dPHx18LD02cuOsjgaDcYm75E3TJdLDgO5J
 KuNjUv9Ss8m39p9+TWGh7thJZiKDx/3DuhWwCYZSV2gu9WLPajImP2vvJ
 woAbiKd6sUdjVZ/Lk+vcKIyWiAs4XKQjHSEBLMMCAwb4qA20lF+I3/QkD
 lkAsSVfHfF3Bt7vwNil0vH36RBnkiBLu19hWs2YTZwSDqTvLO+HY/8g+j Q==;
IronPort-SDR: DEjqxRY3t4pkACCh+zBQfbkOCW6y9sLSij0fb0ueB+H7s1IJ7yqj4nxIyzjYBY/hRVTAeqZwhg
 XrYNapQwzGID/io+JhCPBgNLEsL9bYPaV716JTHn/is1D3ifi/hTzS31ltG1XDhzpKoIlFqk2+
 mebz8YYg27yc1yPgc8FHjIwzI2tWUAz0U4kt5DhJbw7t38qDL3ISQ9PfDHNzBlldUeElTFXtDS
 yPzR7zQMyiK0xEfZMQhSKictB3pAScArFGHmSDE6Pqq17vfaGvAckXNWwIkBWFhb4wRQlQEpMT
 yqU=
X-IronPort-AV: E=Sophos;i="5.68,274,1569254400"; d="scan'208";a="122270235"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2019 16:35:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/Y6S6FN9AriiYmd/BOfijWqcVeUUPixmLXrZopTU7ZouyC+e6fWG5OLoenrGeCPY3NN/+XsfowH6x+pgJ+noVflpHBHroQbzBs3tC+17c6HvluMXMApf9GQcd3x+wnmMwUE5h0Xuf7ubhUTGpaoiMkiZlOnvJuU12ksMHJvkIXsEwOVVgNQlGHJKsaLX0goNzDdCLbab1o56WTDURMSvCu4h573InrzXbguXJIeBYvGj/Ko5mGsoRLn7jPYWof0F6Jp24mBTKdc17dRYDlrSWB1cV7HW2DXe5rtAFrtSJF5vnhXR2OPqM7KRASPtERH56ftO9paj1e0lJVAQ94OFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4DVSZF1OwyKe+oveoGbmdIZHMMAa7gf6OZSpH/u0Js=;
 b=RjxcCJtfnOaV/f8ywwjdUX7h+Vb7LIA+kSgP8OjHQgVVGoOaLKIh0y8PVPREQ7B5art1NmnGZAP73SrEoH98jkIZu5IRTO4OexWEl59iPR0G8rF6raZ3FyUR06V+u3iPY2yWX871ybS99X4MQ25HydKzIMxMlpQtgCNl7uQvJGv7PX1yZdBpN5drtPrIWocAQbTD6K1IAmMXWgjh5+SgtfMdwrltiFvMMkVPN8FRyXoEkfffD6bhEvEBAyw2B+VqiEJMv7PvNX3Xf/CPBwUQYVo0Th5fE6MqBza9QHKP4+ikCh72hS/gm3Hq2mhTCzmGwAqUMzKnHjFPUjjL/VBbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4DVSZF1OwyKe+oveoGbmdIZHMMAa7gf6OZSpH/u0Js=;
 b=Vq2kFoe0iinS4aKJp445l3yfYq71BWNPb10gXsVOBwiHI9CCT9w9vc/KvZQzU+56B0dKkttP7pScZkaVbQxbgLUdiNTLkWqoKUA29QKtFB3eGVPVnbYaNigT3MBs9vq8RWHJtI5acuoluASD9dGkcb1401ZVbB9d6QVYPod7t1E=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5885.namprd04.prod.outlook.com (20.179.23.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 08:35:31 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::b181:29c4:fcfb:7a0a%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 08:35:31 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v7 3/3] MAINTAINERS: Add maintainer entry for Goldfish RTC
Thread-Topic: [PATCH v7 3/3] MAINTAINERS: Add maintainer entry for Goldfish RTC
Thread-Index: AQHVlH0mleR+BnFa/k6clymwqwz2yg==
Date: Wed, 6 Nov 2019 08:35:31 +0000
Message-ID: <20191106083444.41113-4-anup.patel@wdc.com>
References: <20191106083444.41113-1-anup.patel@wdc.com>
In-Reply-To: <20191106083444.41113-1-anup.patel@wdc.com>
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
x-ms-office365-filtering-correlation-id: ab87034c-f7d6-451d-710c-08d762944889
x-ms-traffictypediagnostic: MN2PR04MB5885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5885A62E80905D23618043768D790@MN2PR04MB5885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(6506007)(386003)(1076003)(44832011)(478600001)(71200400001)(186003)(25786009)(256004)(54906003)(66066001)(81166006)(81156014)(8936002)(4744005)(7736002)(476003)(71190400001)(99286004)(50226002)(11346002)(2616005)(446003)(86362001)(486006)(26005)(4326008)(316002)(2906002)(305945005)(66446008)(110136005)(66476007)(2171002)(64756008)(66556008)(52116002)(5660300002)(8676002)(6512007)(3846002)(14454004)(6116002)(6436002)(36756003)(6486002)(66946007)(102836004)(76176011)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5885;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYLZA7/aFS6ofD6Y6RaI/ElamrXPy1aWAFGcxIZ6HhDhqmX5nKDL+L7SJLMIM0pnNjX3KcPNN1DbEuuIQzxCp0FtOP2+A3vniumiKYoPOOPtHVs3Q0GGyPCIiaAntOVNyZXgUS2MPbMB9gzTTD6GUmioMUFuaEERqVTa0MnY3VlFQTJgHxPZHWzOCfwZ4ZQq6wuAcHt3iECXySHGJlaf4s415R8uW848PZ5G2ANKFKWqRHqeXjXR3jzMI4H4p0tDGRrhD3ZltxdBq0Dj7vyCkS4224++FFYdu2vL2u5ygClBXaS1NMR+3Hm4g2N0Mh3S1wXlbV+Hno5/kTn5IdtqtdH0tHemmv9lNgRgJkP8YraKd/t8nxNdGebyUQdN3mmhd3EUYnvuJmlGKVny72yrVorp8pukHBY+zN3ywk6fygnkXGJhvmYvKVzBEjrAdiOY
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1B0453EA95C91A4A8EDEBB5E4CBC776D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab87034c-f7d6-451d-710c-08d762944889
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 08:35:31.2790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xq4LBBwo4VlQH6yjIfXmtiLyjVmQV1jKJiDFu/3xSYdZLM4gwWnqqqWmUN5qW9fSyviwYU+eSuScodVrxaxgSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5885
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

Add myself as Goldfish RTC maintainer until someone else is
willing to maintain it.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2a68555ae..492c0d1baa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -558,6 +558,14 @@ F: include/hw/arm/digic.h
 F: hw/*/digic*
 F: include/hw/*/digic*
=20
+Goldfish RTC
+M: Anup Patel <anup.patel@wdc.com>
+M: Alistair Francis <Alistair.Francis@wdc.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: hw/rtc/goldfish_rtc.c
+F: include/hw/rtc/goldfish_rtc.h
+
 Gumstix
 M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daud?? <f4bug@amsat.org>
--=20
2.17.1


