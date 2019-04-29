Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708BAC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447EE205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447EE205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7tL-0005eA-DT
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:08:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyqx-0004vT-Qt
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyqw-0003QC-VR
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:29:23 -0400
Received: from mail-oln040092255024.outbound.protection.outlook.com
	([40.92.255.24]:6038
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyqw-0003Ow-KT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:29:22 -0400
Received: from SG2APC01FT020.eop-APC01.prod.protection.outlook.com
	(10.152.250.57) by SG2APC01HT231.eop-APC01.prod.protection.outlook.com
	(10.152.251.148) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1835.13;
	Mon, 29 Apr 2019 05:29:17 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
	SG2APC01FT020.mail.protection.outlook.com (10.152.250.219) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.1835.13 via Frontend Transport; Mon, 29 Apr 2019 05:29:17 +0000
Received: from PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3]) by PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	([fe80::d5cf:d2af:3aea:e2a3%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 05:29:17 +0000
From: Alistair Francis <alistair@alistair23.me>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 0/5]  Add the STM32F405 and Netduino Plus 2 machine
Thread-Index: AQHU/kx98lxpsFcXPEO6CkIYnLWicQ==
Date: Mon, 29 Apr 2019 05:29:17 +0000
Message-ID:
 <PSXP216MB0277275ABAB6858751227C2ADD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0083.namprd07.prod.outlook.com
	(2603:10b6:a03:12b::24) To PSXP216MB0277.KORP216.PROD.OUTLOOK.COM
	(2603:1096:300:a::18)
x-incomingtopheadermarker: OriginalChecksum:4344F94F421F530330C84692A83D2BD39EC109CB0DD852495B599C9E5D21BB0E;
	UpperCasedChecksum:D2EAB23E7D37661470319283C12C52711F7214C02B5FC2E9A08AEA43FDC1E7BE;
	SizeAsReceived:7373; Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-tmn: [fxKJ+OzIh6f9qwWM8Y2heMKkxeIFP2yVcHJ4rIjKbUTExHB2ksLJHq90u4+XWdL7]
x-microsoft-original-message-id: <cover.1556515687.git.alistair@alistair23.me>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);
	SRVR:SG2APC01HT231; 
x-ms-traffictypediagnostic: SG2APC01HT231:
x-microsoft-antispam-message-info: THN5Vg+tnOWQo8N+sjir461t1oWrC8zSseWwedchART/yPTLHxTJsWV4Gg2cl7W/1Pda3Z/dT+BceY3nYG4MqPqNw/qzJhiZZ19VMOXXd8sTICngR6Dt7+LTHPZ2FL5H8+cjzXS/ddjZmzhT62MKD4LEcn0sSMrvgTtW6NI4UPn4pZWG3aRcmEzjfo10qkJi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 742fa9be-f221-43c7-12fe-08d6cc639f98
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 05:29:17.7161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT231
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.255.24
X-Mailman-Approved-At: Mon, 29 Apr 2019 11:06:13 -0400
Subject: [Qemu-devel] [PATCH v1 0/5] Add the STM32F405 and Netduino Plus 2
 machine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429052917.ucUgI9w7JFvzEx5qt6h5ubQoWlfxEmNLvKVO7bu8zQ0@z>


Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
and machine.


Alistair Francis (5):
  armv7m: Allow entry information to be returned
  hw/misc: Add the STM32F4xx Sysconfig device
  hw/misc: Add the STM32F4xx EXTI device
  hw/arm: Add the STM32F4xx SoC
  hw/arm: Add the Netduino Plus 2

 MAINTAINERS                        |  14 ++
 default-configs/arm-softmmu.mak    |   4 +
 hw/arm/Kconfig                     |   6 +
 hw/arm/Makefile.objs               |   2 +
 hw/arm/armv7m.c                    |   6 +-
 hw/arm/microbit.c                  |   2 +-
 hw/arm/mps2-tz.c                   |   3 +-
 hw/arm/mps2.c                      |   2 +-
 hw/arm/msf2-som.c                  |   2 +-
 hw/arm/musca.c                     |   3 +-
 hw/arm/netduino2.c                 |   2 +-
 hw/arm/netduinoplus2.c             |  77 ++++++++
 hw/arm/stellaris.c                 |   3 +-
 hw/arm/stm32f405_soc.c             | 292 +++++++++++++++++++++++++++++
 hw/misc/Kconfig                    |   6 +
 hw/misc/Makefile.objs              |   2 +
 hw/misc/stm32f4xx_exti.c           | 175 +++++++++++++++++
 hw/misc/stm32f4xx_syscfg.c         | 275 +++++++++++++++++++++++++++
 include/hw/arm/arm.h               |   4 +-
 include/hw/arm/stm32f405_soc.h     |  70 +++++++
 include/hw/misc/stm32f4xx_exti.h   |  57 ++++++
 include/hw/misc/stm32f4xx_syscfg.h |  62 ++++++
 22 files changed, 1058 insertions(+), 11 deletions(-)
 create mode 100644 hw/arm/netduinoplus2.c
 create mode 100644 hw/arm/stm32f405_soc.c
 create mode 100644 hw/misc/stm32f4xx_exti.c
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/arm/stm32f405_soc.h
 create mode 100644 include/hw/misc/stm32f4xx_exti.h
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

--=20
2.21.0


