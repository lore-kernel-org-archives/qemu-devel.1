Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D3FC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A328224692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=stephanosio.onmicrosoft.com header.i=@stephanosio.onmicrosoft.com header.b="KArKeU4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A328224692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stephanos.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hp0-0006rA-RT
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@stephanos.io>) id 1j7Ho0-00058L-B5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@stephanos.io>) id 1j7Hny-0006HR-DV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:58:16 -0500
Received: from mail-eopbgr1280139.outbound.protection.outlook.com
 ([40.107.128.139]:21227 helo=KOR01-PS2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <root@stephanos.io>) id 1j7Hny-0006Au-3E
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:58:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/tnIiNOrpNfBcuBJVujbVDNFAX3jkvcJojWglGxoJP+gGxck1DU/qcmbENbN70jghZ3h/WUDTWfq8iHOQwo291LwwY7p0cpTU97pWWxxNx1lCRBGD2+z7huMlZvxBGswbtlfJQSn/gYs31LuuxV1AsYjjwQpOyOAzGL3Vfu8OmaDrmKHariiG2DwhfCY3+yjIsBaqy892en4FlmfSJUeSiU+zIZkwBF5RjPeHW8JoStBEO90u+mWpoRSTAv+fl52mNkSNUUQyFViGhvmCnUk4JQsdMLAv1yw4Lwvow6+wWRFLyhnH5CBaeVaK7L+YRS21oxHXJKFzj2P5TxBoysdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXXI0Wqkc32VsFx4A2W1Rgcw7u7UIwelH9NPSf5UGXk=;
 b=n9d6uUipD4UirEJNkm9UDKK2CE5e045vQ/ToWhHTjv3Vuh6ADEbLyzvyQ0bHlvlKwNHVkgzLGmFDO7jcwoSz1xXn7zAD7y1nzZQZTkGLCon1eWDzW327//ekJHMS0X3t7IKOsOs+z7xwxwRqu6IYxrG37YBu67uVcozUoozJHadLlXbrdpiWSHtOlC3Z/4sxkLlPnBBJiYuOCzzHf1mCtKHYuVJpCst6SQG/wrRy5x3J+9PMC+1r0lMlQbX5aepSaxbBuDUfueS1bL2ACjQXUbGjRTdre7lV5sDrikoX0SYs2j85WvvovNHff+H6+HMfYxRClgHyfMGU4AoQ82EMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stephanos.io; dmarc=pass action=none header.from=stephanos.io;
 dkim=pass header.d=stephanos.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stephanosio.onmicrosoft.com; s=selector1-stephanosio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXXI0Wqkc32VsFx4A2W1Rgcw7u7UIwelH9NPSf5UGXk=;
 b=KArKeU4zvgjCl1d7I4mbcNvqEWBehl1gEtL80n1FhqU8/9IzikgfuimQv1du/EgmvHyAyODSt5b/JO5N0brTJRcVKiCulyzSAQIZ3TjQWTP2Rpe0xbD501pOZ2QlefDRsqm5c4KKJcnsv+mKUxi+3vDCvDxZBW5579HIVD/5xzo=
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM (10.174.35.136) by
 SLXP216MB0160.KORP216.PROD.OUTLOOK.COM (10.174.35.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 11:58:08 +0000
Received: from SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b]) by SLXP216MB0285.KORP216.PROD.OUTLOOK.COM
 ([fe80::d10f:962f:91d7:b1b%8]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 11:58:08 +0000
From: Stephanos Ioannidis <root@stephanos.io>
Subject: [PATCH v2 0/2] Support device reset handler priority configuration
Thread-Topic: [PATCH v2 0/2] Support device reset handler priority
 configuration
Thread-Index: AQHV7WQ0RM0L7s/8kk+c0gUOwocqOqgu71Bg
Date: Thu, 27 Feb 2020 11:58:08 +0000
Message-ID: <SLXP216MB028549666E28EDD5840A6525BDEB0@SLXP216MB0285.KORP216.PROD.OUTLOOK.COM>
References: <20200227115005.66349-1-root@stephanos.io>
In-Reply-To: <20200227115005.66349-1-root@stephanos.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=root@stephanos.io; 
x-originating-ip: [1.214.196.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f92bddd3-67b4-4f6c-41c5-08d7bb7c5004
x-ms-traffictypediagnostic: SLXP216MB0160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SLXP216MB0160C0D0554FFBAA0CC2B409BDEB0@SLXP216MB0160.KORP216.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39830400003)(189003)(199004)(186003)(26005)(4326008)(71200400001)(9686003)(478600001)(33656002)(5660300002)(55016002)(2906002)(54906003)(316002)(7696005)(4744005)(66476007)(66946007)(66446008)(76116006)(66556008)(52536014)(64756008)(81166006)(6506007)(109986005)(8936002)(8676002)(81156014)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SLXP216MB0160;
 H:SLXP216MB0285.KORP216.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: stephanos.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3LcaQbV8AGHh834QuRSpT6+/+l7z07Pvh85CFJWGCZV/Gcj4Cxyekecs4ZzkbcFNvNtctH87eprXHfND3feUvtuAhOkPw/v1zflvNSJWMzpKt3G45hNNCgczGZ05tTww7JNVOC2Iyb5i3ZsZ5RC8NWGa9uxUt75H1G2VkYpQOWqvuaC2T1FauSKXSnz+a2r8Hyc9r0J2LffM5lKsHvfNyRgfLLa/djYQ4gAdxnZyZoa7TiV1rdzo8qmnshSwihFTFXgPe4J5BBfasvwQ+ffgv1N3Qg0XdJ3DdWvTEE/KMMlf2MYSHOH6GRhLmTE2rAGb7Ry69YfKzB2lxNLd3gqK3ooGnNhHcpqX1eApLXGehTtUailc2ML9z+imWXKFmgm8TC+vQN90fYF2DZxq/FLHozPUo+/bYWTtEFzL9j/JZhJSadXzEiA18iwdC29MDX2n
x-ms-exchange-antispam-messagedata: NC1vReAg2ytf7+jF/RaPGE1OcYFOzBlMxcrfYXydbems+0CJTxdqByhC8/yciB/lBL1CMRHwPLvjk6ZMsKqRa0S3tlwQcpXSCbX6fKpt/dDs97oM/kvzJDC+FPtC9YiD3waDdQuXjfc7JMD3VmsKUw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: stephanos.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f92bddd3-67b4-4f6c-41c5-08d7bb7c5004
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 11:58:08.8519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c98113d8-f05d-4479-8605-bfc8e93dc16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ct6Bf/pFc7xCIkmO6d6N3kB7WGk7jRo+tq40htfFVWPic9J70+BpPZVq2A7i00phMxFv8K+tS/bSXaAQ4H4jiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SLXP216MB0160
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.128.139
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
Cc: Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds support for configuring device reset handler priority, and=
 uses it to ensure that the ARMv7-M CPU reset handler is invoked after the =
ROM reset handler.

This fixes the STM32F405 boot failure issue when the kernel ELF image has t=
he text and rodata sections linked at the non-aliased flash memory address =
(0x8000000), which is the default configuration used by many toolchains.

Stephanos Ioannidis (2):
  hw/core: Support device reset handler priority
  hw/arm/armv7m: Downgrade CPU reset handler priority

 hw/arm/armv7m.c        |  3 ++-
 hw/core/reset.c        | 32 ++++++++++++++++++++++++++++++--
 include/sysemu/reset.h | 24 ++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)

--
2.17.1


