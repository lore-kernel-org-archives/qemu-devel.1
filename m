Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F272CC4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0A321927
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G4iJXJz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0A321927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vyR-00080G-TG
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j6vxY-0007SK-94
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j6vxW-0007p0-OF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:38:39 -0500
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com
 ([40.107.237.61]:6035 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1j6vxW-0007hI-EV
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEbG3HrcHbaBTPJaJIN2+Xh60/86yMdtlFYhjzEAohSNRyEe5Mv9Kq84Eh6cPyLTniVMROoFQH90e9OMXf9ud8dmS9LdtWUXhTrlVSN8Kh7heDu0RN7Iggv0T3KY/2bgQi2LBGH7QoyHrCcwjgtMHCAhokbSXvuxh9pSyxYKtBoGmWAQZeWeXkUJ+uFOxxn79Qi+0w+V35yqE/8UQ5okN6EZVe/z19a4I5uDk/2haTPH3/MiWNoYaXzFjBkQtwII0HNaMUqKze4HmD4IaNvpWgce4e1LS2c4dCvpXUUQtxNhcXvva5Rv3GYx/eNx/HaNs3dIMadCfcBx3FUaVo6j9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/9vZFYY99EQJp3ch4psNK4UgYMbvlT/qDAANJwH+hg=;
 b=h98sB/kePGIosIu0+RAVTX2hBAQZdd54+kFEtzs+38HXSlA9Aq79TioQGgXM/6ka8ejURkWyG6u3Wpy3bYu0Xvm5MkSFtVp+3p6S8KuEfGM+qgEf+bSpdLQlXnkO4CzI01lI94D0XeXmE/dTQXHlt7i/t1numF4Rk39N7OUsPjUM0NviBdniTLNvmzsu3UpLwbEXdlSuAl0i3vUsydGSDYlrioSIbF8enGnMaF3uhTWSr+RC42vY1mNcLi5vcl236R6G/M4gT/z9OWBku8fYLZWS0qLQ0w+Tl6U9TLodQWIQ+ycCOIviv7lRAIHT/7deQ5JRn4fN61tvskcT304gcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/9vZFYY99EQJp3ch4psNK4UgYMbvlT/qDAANJwH+hg=;
 b=G4iJXJz4blQSMeW13pDZhOznfJe8kERucR3kjnCyAXEmzOZQnjydqPUeAEZBlasfkoQtz6Us1J7/PMe7IaUji6N8R6O1csCDLlJAia0DLcecUg/SgoL5YLXsPRrzTrMX6Dmkk7hQakIzyQDSWEHUcdZZ0Evv483xtVGsgCJyZLg=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (2603:10b6:208:111::23)
 by MN2PR02MB7055.namprd02.prod.outlook.com (2603:10b6:208:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 12:38:35 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 12:38:35 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Implementing IOMMU support for SDHCI 
Thread-Topic: Implementing IOMMU support for SDHCI 
Thread-Index: AdXsoAgJBAmayeg8R/u0QxshP3edDA==
Date: Wed, 26 Feb 2020 12:38:35 +0000
Message-ID: <MN2PR02MB5935836FBB0AC02F56278FE3CAEA0@MN2PR02MB5935.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb443f9b-3487-4795-c2ae-08d7bab8cbf5
x-ms-traffictypediagnostic: MN2PR02MB7055:|MN2PR02MB7055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB7055696659EB9C7F6F979CF6CAEA0@MN2PR02MB7055.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(76116006)(6506007)(86362001)(55016002)(9686003)(4744005)(7696005)(8936002)(52536014)(26005)(33656002)(8676002)(81156014)(81166006)(71200400001)(186003)(66446008)(107886003)(66556008)(54906003)(4743002)(110136005)(66946007)(5660300002)(4326008)(498600001)(66476007)(2906002)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB7055;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QiUxd1MTYDJNZ4VM/g97p4IIV0/80nx9FblgX9StYkf/6tEQ4txmOCiBTKfLsgHxTWPgzHZYXVQ4bmyX8hTAoeTL7hPmDcGhcwAQQcfRVT8CPLCRFlJwURNkwCRaLqoUtq/wLM7AM7eUZHE/WuTaCAtMf7zxOhb7NQkzyMb8srlnk1r8uiSm2bjaC6361B9FfGFZ4f4oAFQ3vm9Kp3scvK3HJJFJfkHdP1/vWwfLQTZI1LFrGkSs4EmbQ93OvqDOsZNwr4AKD9IrXuEpmoNi+H0VA3vcLw/kRZYTzrzKZgPb0xD2u1uks9TX53qQc2eodhiZEUsp5qkeNK7qDScTB+HgdsknQOc1VBGg//c9ohXIgmiBna8oDbd4tJfOvlYsXw+KnNQjwwvqpUIkJSMbQrgHP2cg+ISsZoPl3x0m7JFUvrvHv3Cv4EEw0z0WHmH9
x-ms-exchange-antispam-messagedata: XBXG8IT82NxsNybtSeyCIVZg65mxF2IDlzT2ATusDNLErXpEqBuhtiyj/Qca9EiiMhHrsF1JvYrqV3mzroJBDgf3aTAj6tMoko10RnpVgikjnUlowJ1oY9tcf2O29Jo+/AN9il02oomfa29NHQhfFQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb443f9b-3487-4795-c2ae-08d7bab8cbf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 12:38:35.3405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbJQ3YSWh7/YWN5BNDYr0Us81/5fLzc2SBd7pn2ymDuSDUgeF4GrwXmYJBm8RVR8+E7kX5UUIXWlL6OadjKjaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7055
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.237.61
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
Cc: Edgar Iglesias <edgari@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Poalo/Peter,

We are trying to add SMMU support for dma's used in SD controller on ZynqMP=
 boards. In order to do that we need a clean way to assign MemTxAttrs to ea=
ch device(i.e all devices which connect to smmu) via "object_add_link_prope=
rty/ object_set_link_property "  functions.

But in order to do that, first we may need to convert MemTxAttrs as QOM obj=
ect. I just need some feedback, if its advisable to do so ?

Thanks & Regards,
Sai Pavan


