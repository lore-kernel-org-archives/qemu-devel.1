Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MISSING_HEADERS,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D89C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A3C24691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="YJbGXb1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A3C24691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HMN-0006jd-6R
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j7HK3-0004F0-Pq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j7HK2-0002JL-OI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:27:19 -0500
Received: from mail-eopbgr1280101.outbound.protection.outlook.com
 ([40.107.128.101]:30592 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>)
 id 1j7HK0-0001zN-0E; Thu, 27 Feb 2020 06:27:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKq1RNrpvKw1Fq2N+2n4GjF9ktCGbln7fSQBbQKQTtdkjqjcFSitAqvmbg4uCnif02tXUiEPt34MocD1kDIJytHWElxMoO9I5eaXTAYxq3obUnBK6rDMdLg8QFsITx7B/cet4f546AhYEpc1nBmioRC/szBP5p9HBg3pshAEZRMKqn/MIRGw/st5nEs4sjkVYunJQkak02mH8chqukEzjSV3gsNE2m5JIWCA2Rx7EIXCTy0SN9u//ZhXuCvb8aXnwxsoVDI6zRRDFXxmUqXXgCkHzxTWuaQrzoUP8ZL8vP6DARhruB6HHSPfTiII0By3GwAFPCA5ZXN362psMY5cSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow0FlfI6mqJho6v+kQ479IpbDkXfBlVrdY42XHlMWBI=;
 b=JTzQbnQf7Jhn0Hlh01lHLeLIOi/dSpzBwkhrktekR4BZVld6mDaw5IUQImEYWO8tLvlYmfRNuv67rZWDCLEiR2yKY9PyLrNz5ht/8LuBZUWKtOo51xuxiKrAQlp9s/DYtfhHk5M5Qx+1UB9ameNI62LhWnhqvettEpVqKVMQDJUxHpddbqzIwPt+oShEbM7Qvympg6lL716hUXSp7oxYVos1/HpXsjdFwAJwGVb7Rw1P1ayyDodO0s+WCNo2B5qtxPde6pc34SRfJoeNKuvHRqH8sWoc4LpP+uFFs00EL/MdMRgGKsqytQN4wVh/g0IiGQWJkxC8XXzmyqam4vkfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow0FlfI6mqJho6v+kQ479IpbDkXfBlVrdY42XHlMWBI=;
 b=YJbGXb1INYY/SXQrojwnehDRkR60Lvxutt5LP1baxUY9recdCWHLxh7oohF5NzzjefE5IZGZdwYZDpa7s2sPYq6te73zW79K2GJjA2cBPVMexytlR3Qe8x7Ou2OgkqFIK9MTNmSEdlLyVJ9eRBg7/miS2JR05EmAUd+a2m7q2qQ=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0031.KORP216.PROD.OUTLOOK.COM (10.174.39.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 11:27:11 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 11:27:11 +0000
Received: from DOMINUS.corp.kimin.kr (1.214.196.86) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.11 via Frontend Transport; Thu, 27 Feb 2020 11:27:09 +0000
From: Stephanos Ioannidis <root@stephanos.io>
Subject: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
Thread-Topic: [PATCH 2/2] hw/arm/armv7m: Downgrade CPU reset handler priority
Thread-Index: AQHV7WDamNGXYjwsUEm9K1g4p+T2pA==
Date: Thu, 27 Feb 2020 11:27:10 +0000
Message-ID: <20200227112617.66044-2-root@stephanos.io>
References: <20200227112617.66044-1-root@stephanos.io>
In-Reply-To: <20200227112617.66044-1-root@stephanos.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:9::8)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5a23963-5b5e-4f05-5988-08d7bb77fc7a
x-ms-traffictypediagnostic: SLXP216MB0031:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SLXP216MB00312180BE62B09C889B2237BDEB0@SLXP216MB0031.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(346002)(39830400003)(376002)(396003)(189003)(199004)(478600001)(16526019)(6666004)(4326008)(64756008)(66556008)(6506007)(109986005)(86362001)(54906003)(2906002)(66446008)(26005)(1076003)(186003)(66476007)(66946007)(316002)(2616005)(81166006)(71200400001)(956004)(5660300002)(52116002)(8676002)(36756003)(81156014)(6486002)(6512007)(8936002)(36456003)(42976004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0031;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWYO4gQIr2y19K0zXGZItOpmAAROlo9lJtFQgiIGO9mXwTnfTkWqK0xSAAPCEiqZOhenD5yXpsHa0dbeze/3ppFNEBW0oJXKVrhagEsmMORGYH09z2lp5KeKQnQmohS+L4z+EBKDMssuhAiI0NJ9bJqqrfmdu+bQ/pW0lJ61LGYRnJiKWZV3cx1Qrenj/M3m7CtgKKXX8P49VFRmBbtqsXeVBJgeie5cQ85j6BL1AcD32+PWUf3tn15zS+XOWg/vbeEpTP/8mXPbBcoFZd6e1xKjv3Pq0vNMffe/NKzkAAKbJjKtBbqOLvE5ub6vhpGFoi8wEi6cdkebK7wUWZEchZBhwragWCrYqNb3OnQzPkkgqfzZyCEXqn1CInqUQs6IgraLQ/Ii8lw5BsfqJyWGxQpjVt3HPxqwtvnoHRgGHafpppCQqfDmb5/BwSRcXaALNxSVz8o0npwx6so813JZz8Fo+n8o8QwNzDHE4+SpyXIkqtH6IDMOc70H+sqW9gvYHws3vciiUnfUoV9FSi8FFA==
x-ms-exchange-antispam-messagedata: CvBObwq0Lwcc9II0LN/fW0N7GSduRbeqTfJibRLclRsceSabHnZ/ic49YTGXjEDkDSuHC45t5W165rr8qplRXmN1ckD0EJCIGwbigzYt0msh985N8GR2cge9N6o5qiMIen5hHYl8EOwVsa2rJGBhWw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a23963-5b5e-4f05-5988-08d7bb77fc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 11:27:11.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iw4AYUkIIiW5Nk9jPQmEsYPVorXz8pqFR+10p6FNZGAdC8jjBdfmqNIbH0bVBowmqddzzBJKgp26IqmV4XkeVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0031
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.101
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


