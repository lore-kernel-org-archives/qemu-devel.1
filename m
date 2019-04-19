Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7019C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 18:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D2A205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 18:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="BV4Sy+8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D2A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHYXB-0003gs-Qy
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 14:46:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hHYT9-0000hE-Ot
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hHYT8-0005sc-PJ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:42:39 -0400
Received: from mail-eopbgr710132.outbound.protection.outlook.com
	([40.107.71.132]:51200
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hHYT8-0005rw-Fe
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tQbXQV3+HyBK7O8l1AttHaD5+MsyKHE1PZ/GIq70WAU=;
	b=BV4Sy+8ZgSXDpKds3e9RyGDgCAa/yftuSMX/32+Ts7XAVYzrK0ml/oBbgneQ168w5ps+V5Vix6FAv7y570t8kcPRTWukEq9UGgyBdELIKp5kofBzTEuWMAuxi8/la1t74guPXquXSlCsIQTQebFrqco3pwdXZgxV/otx0IQJVmk=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1700.namprd22.prod.outlook.com (10.161.152.144) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Fri, 19 Apr 2019 18:42:35 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1813.013;
	Fri, 19 Apr 2019 18:42:35 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Jules Irenge <jbi.octave@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 2/2] target/mips: realign comments to fix checkpatch
	warnings
Thread-Index: AQHU8jeIZRvsJkOP6kytVugQJ6d2qqZD2sp7
Date: Fri, 19 Apr 2019 18:42:35 +0000
Message-ID:
 <BN6PR2201MB125179A24CF0A8DFCC280A6FC6270@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190413202818.13622-1-jbi.octave@gmail.com>,
	<20190413202818.13622-3-jbi.octave@gmail.com>
In-Reply-To: <20190413202818.13622-3-jbi.octave@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7874f3c2-be5d-4654-9aa7-08d6c4f6ca83
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1700; 
x-ms-traffictypediagnostic: BN6PR2201MB1700:
x-microsoft-antispam-prvs: <BN6PR2201MB17003B77A68945BFFE4B13CFC6270@BN6PR2201MB1700.namprd22.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(376002)(39840400004)(366004)(136003)(189003)(199004)(186003)(446003)(9686003)(14454004)(6436002)(33656002)(558084003)(6246003)(26005)(97736004)(66946007)(316002)(102836004)(229853002)(52536014)(53936002)(91956017)(73956011)(478600001)(6116002)(25786009)(110136005)(55236004)(3846002)(8936002)(6506007)(54906003)(68736007)(5660300002)(81156014)(11346002)(8676002)(55016002)(81166006)(256004)(476003)(486006)(7696005)(74316002)(4326008)(71190400001)(76176011)(305945005)(99286004)(86362001)(71200400001)(2906002)(7736002)(66446008)(64756008)(66476007)(66066001)(66556008)(2501003)(76116006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1700;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YK4JpYo7hQu/cGGvyyAS3E55v1Ye7cPuQKPGEgzMKgSRuvVHbGYH6QTWw1rwCyXLzPP0gCdwP0p7dSrU6feQ6n5XCPOQAlELZsfx/z7DWolBSeI4P7rYFgn2xUXsT3FlW+/i6NNmc3SZSmYatXeN5lTSqIYUSZTaQ8xJulC5OYZVgA4AWxLchArJxluGb53d4ZhEwPtnoTtFZ/ZvO48ykBoEtF4yzq1lyf/e78aFE6/oNhXBjH2ru+mGsb9pd3yUvQejz+tjczRF/ot0LXYePyWAeEPtwabTaAp3vCSAfGuWBzKc4WB5wnany4sK1dW6LPhGFGGPsnPWPkfjadPfiaIsaC/MHwJTiZGUdabLIbjunDqhU4Mkq5wWmDX1qli1LysW+tdhQVtLibcuI8LwBEGWkj0VRRVAms0aLeNnM8I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7874f3c2-be5d-4654-9aa7-08d6c4f6ca83
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 18:42:35.5953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1700
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.132
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: realign comments to
 fix checkpatch warnings
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419184235.IzbM42qrRchuaSSnsHKYGBZOWyitykMZUbY813-S_7o@z>

> From: Jules Irenge <jbi.octave@gmail.com>
> Subject: [PATCH v5 2/2] target/mips: realign comments to fix checkpatch w=
arnings

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=

