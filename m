Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DED7C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1E9206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="CeB20qbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1E9206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUwby-0006Kt-6J
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 12:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1iUwbH-0005sn-I4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1iUwbG-0000Sh-G0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:38:39 -0500
Received: from mail-eopbgr720100.outbound.protection.outlook.com
 ([40.107.72.100]:58963 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1iUwbG-0000S5-2N
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHjHhAECH9FSljA8Vfrb9oEffhiIHKNvdNM9Oz0AOXlLnBRkkIDsxkNsEg/0TcjdBymY7o6wDkZSSYCELiDnDF/3xjCULkEKZvuUDnvzkaU7kyqD87uZ9Y8cw3GqKlQ1iUxj9nsqccm2X0AX73HBpHSBIUPKb0kff2d3Vv/zaZywOLAD+eKGHmPjii17m6CqxxLz2fnOMuvA1KcLlwObnQVoyBsq6Az22pR5MWLwEwtH3R05U0ZQiQqOEGuxL0aksp05XTzZldrHpaAp//pjtu1JztzX3Xn8aTFaPalSihQCvIkc0Bqbt7p/SbAl45Goj34zaQTuMfxZw+4P+5mNGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv87dftzMpwFSoTZxKLNCwSwWSL6cXDzWfsVHu5JDQw=;
 b=YWieV5kk7rc5S1NL7FYLTdFncc4jsG5wHX9fJPFmgZzS9tIdDUDm8CnoXwkazKOF1l/hkJRXAO+gkvCu4v4DiLS2wOKXP5ypXx629jPUrAfepJGzTl0MXq++acpHWQPj1d3RYN3Gg76C3B/oL1MSnMEp0rEi9oLprJZJO5Y3PP5x5HSgVUYK0cekthnCHxpAWXsnvDRBY05qkWELUvN0EyGjcyK6tT7VZfQFE6ap8QxMKcyWKxHGXIMsO54L1/L65JR3wzkT+Zj3IrkYb3WKccVlWToN06hcYVHeWB1zZR9xKyGNNIqfEsN7JMfX5H1+ns7RjdCQd8brptr2xFFkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv87dftzMpwFSoTZxKLNCwSwWSL6cXDzWfsVHu5JDQw=;
 b=CeB20qbRZPHIrtilEr2YjVkoaQQsV9R7EMHfy/DpL+dTk5hV+FnHdl9O6qeoygDw49buVJvpT5aLVE9Xl05Q8zRfU6+7HD4hVp5GYZxWGZSswWrYWIz5zlmcPqB2mIbG3hfVSqG5svU2BZbxZtMEEz7loqIwhOFS1p1QJ3dPdCk=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1716.namprd22.prod.outlook.com (10.161.154.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 17:38:25 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::302a:6e1a:7c8e:867]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::302a:6e1a:7c8e:867%11]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 17:38:25 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL]Re: [PATCH v1 5/5] .travis.yml: drop 32 bit systems
 from MAIN_SOFTMMU_TARGETS
Thread-Topic: [EXTERNAL]Re: [PATCH v1 5/5] .travis.yml: drop 32 bit systems
 from MAIN_SOFTMMU_TARGETS
Thread-Index: AQHVmj+Cb/GAM+iMS0CnZ0mRQREU1qeJXF9H
Date: Wed, 13 Nov 2019 17:38:25 +0000
Message-ID: <BN6PR2201MB125185CB7DABA8AEE6888D92C6760@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-6-alex.bennee@linaro.org>,
 <d58692dc-b94f-cd6a-c3dd-e9c76e68bdee@redhat.com>
In-Reply-To: <d58692dc-b94f-cd6a-c3dd-e9c76e68bdee@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb3ff2a6-6083-4683-a85c-08d76860499b
x-ms-traffictypediagnostic: BN6PR2201MB1716:
x-microsoft-antispam-prvs: <BN6PR2201MB1716DE440556E6F8690E2036C6760@BN6PR2201MB1716.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(136003)(39840400004)(376002)(199004)(189003)(54164003)(186003)(2906002)(66476007)(81156014)(4326008)(33656002)(229853002)(66446008)(6436002)(256004)(55016002)(14444005)(66556008)(9686003)(6246003)(81166006)(102836004)(26005)(8936002)(11346002)(446003)(66066001)(486006)(476003)(8676002)(64756008)(76176011)(55236004)(99286004)(6116002)(3846002)(6506007)(7696005)(74316002)(66946007)(76116006)(91956017)(7416002)(86362001)(110136005)(2501003)(54906003)(25786009)(52536014)(478600001)(4744005)(71190400001)(7736002)(305945005)(316002)(71200400001)(14454004)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1716;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svxgGvqYg366aYiYOfgieo/vypcdTLyDFiZW69pZbtHLa5LTf6ArBIVaHKCvUVAIZriyeSgYfKWunVAQxWNAhlMZ9ZXCwhyGIMvDi0zZ5Uq/L7sBzHqpo11IGkBd03Aaoy5WnJg28ojgkx9uRxjSgs9eVaVH3zJG6Ww6GVOFygab80TLDi/fQr/03ytmD7VDTSDr5VhDvLHs+pLaxqsNkEBAjoFUDXnIQ6F7JC/SmI0E4iK/2KPGBSMk6PISqCIjjo1mnhcqX8jJkpftGwtksJSWHo6PafzTMXiece3ZyS5Y3XiWKgxpFQh9I/jR6+ScVIm9/WRcSXhrCzPW8wqxCnozRoUY8iqSxDhml2os8lK9cKweMyjPujsFXJq7o3cX02vV/DSwQke+/juzuVd1JdCzKDZ43U9Bzw2E3sDK9OzyRMQ2APN4DjwMJD6BviR0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3ff2a6-6083-4683-a85c-08d76860499b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 17:38:25.4382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glAjtd8rWNniA5eynlLb0pg4QgmcolnJpS1wF35THOy/SAClPPISnzeA+g5R5xpIohTFO3gvED3LBCOsXoS/zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1716
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.100
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>, "cota@braap.org" <cota@braap.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
> > -    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu=
,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x8=
6_64-softmmu"=0A=
> > +    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-sof=
tmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"=0A=
> =0A=
> Aleksandar, since you mostly test 32-bit MIPS, are you OK we keep=0A=
> mips-softmmu and drop mips64-softmmu here? Another job (acceptance-test)=
=0A=
> builds the mips64el-softmmu.=0A=
=0A=
Philippe, thanks for bringing this to my attention. Yes, 32-bit mips target=
s are important to us, but, what can we do, time constraints are time const=
raints, so I agree with Alex change, please go ahead, Alex. We can test 32-=
bit mips targets via other acceptance tests (those that can run longer, so-=
called "slow" group), and perhaps we can extend them to test more 32-bit mi=
ps systems.=0A=
=0A=
Thanks to everybody,=0A=
Aleksandar=

