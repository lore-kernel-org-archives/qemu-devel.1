Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A5C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11C0206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="OZ5CVMbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11C0206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspxc-0006Ey-9L
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47226)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hspx9-0005l3-BH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hspx8-0008B5-Bw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:51:43 -0400
Received: from mail-eopbgr780114.outbound.protection.outlook.com
 ([40.107.78.114]:12950 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hspx7-00089L-Sx
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:51:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE+LjPnacFeYF84TcdBB68YjwECVkDLkhoblAqG2+uRhM4SvZn3v0714Swc7Jxv2WXgJqbgmg+VZTPWT4Rals/c5ZGkcDr/PZ0wZaT2CtRzm1vvbySyAJtKs45JxGaYlKk6lNbQQ9ygPoBVr4HVJiWwLtxcl7LXykUkJTFBNekVObc5h5xvb669IUrXoykR+WbUb/zm58PxgpmH5gurlrBswq/yZD2OkZxrFzEt590nZ7r7NNtOLr+X8a9u/ZbFdNn5IGNieqXbj4egkoL8DLb6/1YUqoU6h/9nbiK5lwx/RxiYAE1CPiqtfJ5gZJwRqKn5TVPCW2lKmItqJfDVCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbPM5vQ/HFA3Sp9zk8OlA2EB8ylyZxWVHCTe/mht28Y=;
 b=m6CFuWqrDxtzqRAmU4Ogz+vVOWUK8ERtIGlcdsar/poVDP4lvEC6OFzYy/D2q0MPI/aJyK+8wODBC8nEoe//LYcgvVtQXzsUDCJo8ZZ64HtRk2PClO2L1Mf3nKIFwHctUVhsjIo9DMq/DQuw19/QSxeJHdXxcg6CfptOgpUAzCTOecB13I3XsU+lfaMJFKQrjedPokNwu4xLLs5skJH5F2Zy67lB9qfdIhax+YnlxrOt89X4rBhTJgGALL/ZSKGfVwpzNwgRxs20QtPoGMp1cU08wS4diR/arjd+STSSx0XAe3Fq2tvbiHr7J4UJWIX6U51jfM2pWVOcBiUJiOVVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbPM5vQ/HFA3Sp9zk8OlA2EB8ylyZxWVHCTe/mht28Y=;
 b=OZ5CVMbMb7ju3P5wOEOnGLNCUbRZ2s0sLGYTGOyB6yv0doysrGLN4QZRwbksbf7Xitm132Rj4Ejt/0Icxhq4ZfXFtvCTxzm+xdwW3493NvQ5+C3PQfxhdG0op0UPG2NSkUK6ci5lQBtWCgYoVYaRkSLy0KZ3t2CREWqY5NqaoUI=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1556.namprd22.prod.outlook.com (10.174.82.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 14:51:38 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 14:51:37 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: "tony.nguyen@bt.com" <tony.nguyen@bt.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL][Qemu-devel] [PATCH v4 1/1] configure: Define target
 access alignment in configure
Thread-Index: AQHVR3kc1VEL+t0h/0yONmwGIVsc8qbkze2e
Date: Wed, 31 Jul 2019 14:51:37 +0000
Message-ID: <BN6PR2201MB12511C7ECE98DBE03CCC450AC6DF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <2aaac4eafedb4aec979657993d00b8cd@tpw09926dag18e.domain1.systemhost.net>,
 <1564561349027.20997@bt.com>
In-Reply-To: <1564561349027.20997@bt.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56969355-da22-4055-62ae-08d715c69720
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1556; 
x-ms-traffictypediagnostic: BN6PR2201MB1556:
x-microsoft-antispam-prvs: <BN6PR2201MB15566A148C4629EE88868E3CC6DF0@BN6PR2201MB1556.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(376002)(396003)(366004)(136003)(199004)(189003)(52536014)(8936002)(446003)(102836004)(86362001)(55016002)(4326008)(2906002)(486006)(26005)(11346002)(6506007)(229853002)(14454004)(256004)(186003)(5660300002)(53936002)(476003)(14444005)(68736007)(55236004)(6436002)(25786009)(81156014)(99286004)(64756008)(76116006)(9686003)(2501003)(76176011)(66946007)(66476007)(81166006)(7736002)(33656002)(54906003)(71200400001)(66066001)(3846002)(478600001)(6246003)(66556008)(305945005)(71190400001)(91956017)(74316002)(110136005)(316002)(4744005)(8676002)(66446008)(6116002)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1556;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B2aWsUMRRjiEvwy1C+M+Fj2HGH0tH9iwQi5Hqr/ewIjvrp19VwmflZDovdehTVNg1+LEMMccQm6ebSmjpfP8ceVztkd9IuEbsGJYU8UlhqmVXPdn5Kh2LFkp1VeRiPPiiUX/HWA0JM4Yi9S8MHLeRh+UzThFoD4NjkH3k1+rJfdRf3AZT/V8jf5Iod+7xffJz6gYM6dz3JsbCc6d3Rx0siwWVLi8vBjPRQst1kaJRjEJz78zv2/SO4yidgLcRLSAaEeNaVaaIP+3Zcs/SUP384NKKU24/T8OkCENEQLoM87js1AKh/XTm8nxw3/aiCpzs4rDnP3xoogW8GfXsdmoHYKROkr/hr7bwI1jlrToptt+nZWD25RlCYxpv48eagf3YsLfgTSSw1EnsQ8SBTeAvpQp3+ALA45TFXitP3qR2+s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56969355-da22-4055-62ae-08d715c69720
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 14:51:37.7545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1556
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.114
Subject: Re: [Qemu-devel] [EXTERNAL] [PATCH v4 1/1] configure: Define target
 access alignment in configure
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "atar4qemu@gmail.com" <atar4qemu@gmail.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: tony.nguyen@bt.com <tony.nguyen@bt.com>=0A=
> Subject: [EXTERNAL][Qemu-devel] [PATCH v4 1/1] configure: Define target a=
ccess alignment in configure=0A=
>=0A=
> Rename ALIGNED_ONLY to TARGET_ALIGNED_ONLY for clarity and move=0A=
> defines out of target/foo/cpu.h into configure, as we do with=0A=
> TARGET_WORDS_BIGENDIAN, so that it is always defined early.=0A=
>=0A=
> Poison TARGET_ALIGNED_ONLY to prevent use in common code.=0A=
>=0A=
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>=0A=
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>=0A=
> ---=0A=
=0A=
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
=0A=
Advice: Try to always check and, if possible, improve commit messages=0A=
prior to submissions. This doesn't take a lot of time, but improves the=0A=
quality of one's contributions and increases overall submitter's reputation=
=0A=
significantly.=

