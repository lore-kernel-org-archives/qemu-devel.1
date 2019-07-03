Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD49BC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74D19218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="bAvb+qYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D19218A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hilzE-0000UF-Ay
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60401)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hilyk-0008EL-Cz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hilyj-0007yl-H7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:35:46 -0400
Received: from mail-eopbgr700123.outbound.protection.outlook.com
 ([40.107.70.123]:64736 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hilyj-0007xo-6T
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erd0g1wwmdYyH14yRxVd7dWUObYK5HQlCTssb5NbDJM=;
 b=bAvb+qYbZynrbZJGDHiSlBkfh7afzHTGByudWbSYzpFD43LuokIiOzy/E7uZCuAREStZLl7vC22tLz50PsBaxX8lwaVwc80U5uZ6bmxCtLbxFVNnh9SYF2pDvzXxLPd67zqR9IjmkhidiQTQEoIfeinKCfh4C5KZQJ9D1FNd4Jw=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1460.namprd22.prod.outlook.com (10.174.85.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 20:35:41 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7%10]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 20:35:41 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Thread-Topic: [Qemu-devel] [BUG] Inappropriate size of target_sigset_t
Thread-Index: AQHVMdW9rYddusddyUKgOhYBGFbH+qa5UVsAgAAGRr0=
Date: Wed, 3 Jul 2019 20:35:41 +0000
Message-ID: <BN6PR2201MB12514AFCCF1CDFB8E4E341D4C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <CAMo8BfKhc9vFa_w_zzdGvbC-CTu4qa1JEv7GB8jJZ2uxsLn_nA@mail.gmail.com>
In-Reply-To: <CAMo8BfKhc9vFa_w_zzdGvbC-CTu4qa1JEv7GB8jJZ2uxsLn_nA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac7da1f9-3821-44f4-67dc-08d6fff60436
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1460; 
x-ms-traffictypediagnostic: BN6PR2201MB1460:
x-microsoft-antispam-prvs: <BN6PR2201MB14604EB44162749FD61446ECC6FB0@BN6PR2201MB1460.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(376002)(366004)(396003)(346002)(189003)(199004)(3846002)(256004)(74316002)(6116002)(54906003)(76176011)(33656002)(71190400001)(6246003)(4744005)(9686003)(6506007)(316002)(53936002)(55236004)(55016002)(102836004)(7696005)(99286004)(2906002)(71200400001)(68736007)(76116006)(91956017)(66946007)(73956011)(6916009)(8676002)(186003)(66066001)(5660300002)(25786009)(7736002)(52536014)(476003)(229853002)(66556008)(478600001)(305945005)(66446008)(66476007)(64756008)(81166006)(81156014)(14454004)(1411001)(4326008)(26005)(8936002)(446003)(11346002)(6436002)(86362001)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1460;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wUXFdxf2Q8xmMfDEoxzGFul54lvqo7vU1TBgpQqqU0bLE0A1R8eNxkJNh2ZeEuJOW2o9i6uVtpwtgZes6ac7vJlQAf/RLWHmihqqZh4blLm6DdbyQJ+VkNW58NCilG7YDkWmSvD4RoApbVSUxTjBMUquG1/QuUXGsE55o44bV/fpVAxNAH/A3LfJQiy7oUm0oL3k8Yhaa0vubmxXMGaueL1NUTmDG6sKa1922cXytPqu+KQ4e7zpO9bUzSnfM9dbw/f5RT5V3DE16hSPccuEAOPKuDzVLFFQkI7V/uEpUPXrDtchv3d5FoL38lhOENKM+y3ypVjopE6IgCWTLv+eflKWxUV/QbzcLpsz8YrrpGOflqWLbv0Y9joy9h6zaZzEkeU1ZGHmRx+F8i9svCvt73it/criuAuUfmIHIEAbMg0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7da1f9-3821-44f4-67dc-08d6fff60436
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 20:35:41.6765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1460
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.123
Subject: Re: [Qemu-devel] [BUG] Inappropriate size of target_sigset_t
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
 Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Why do we need a byte per target signal, if the functions in linux-user/s=
ignal.c=0A=
> operate with bits?=0A=
=0A=
Max,=0A=
=0A=
I did not base my findings on code analysis, but on dumping size/offsets of=
 elements of some structures, as they are emulated in QEMU, and in real sys=
tems. So, I can't really answer your question.=0A=
=0A=
Yours,=0A=
Aleksandar=0A=
=0A=
> --=0A=
> Thanks.=0A=
> -- Max=0A=

