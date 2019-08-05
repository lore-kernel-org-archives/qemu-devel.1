Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD951C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87740216F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="fPuTuaz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87740216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huf6I-00033m-SN
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1huf5E-0000Rl-I7
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1huf5D-0007On-DM
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:39:36 -0400
Received: from mail-eopbgr790131.outbound.protection.outlook.com
 ([40.107.79.131]:6487 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1huf5D-0007Nx-5v
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:39:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd34BS1fdIthN2kjn+AMrDQD8j5arRzi5oPrKHs9GHY+L0d7RDIkjh07RuwJb+7r3sEJ9sF6Kg75M7wZkrmC+BvrrqEZg/VHpNDn6GdppCDXPVnAiXLR1ytS7L8THo9ftr7KRBFa2ViLQv848Haov3K2ZnfRwHNj5dyEg76DnpYzfkjqG17U+c9wLnIEnbzEuB/xB3yMTfCqxzhpgm20cndepv0mqemm2bujsiZjCBe2P9mXm2J43MEtI0DG8C87TGxcLgaUhEUTMXOrcTBe5knj2e6yk7t9n645qJW9G+e9BglWb8g9ba1jd/j0+TtM46/ST6PF9LsYAZNxpWOJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPDHOxGismHV0VFj9/iH2vBGXCaKwNAyVFt5G1uqI9I=;
 b=LhPFjxVTxGbq0Yol/MkNRUzdrYWgWDUwo7CNu6h7B++XoDaY5mPn9DJLa76EOSdKyXWtcQ2lvt04A8uULDsb8aIQS9HXkmm2Z8FILCmOB/BqJH+EWrCPPQUkGPwIp6eItfdf9cPX0MoI+//O0YUEmNcm7rfe4gGjSs5O4LEGBiJuK0Yf1yUJl8jMUf0kHWf+868tyGIztx7ny82mVLO8Z0FrhPQ80uSjMSXrCp5GZ+TB4zRgDKL/SVScamb/jtHU3L9ErADrihzIXSEyBxKZ8nlboHs/NyPMCuswsmxxcqB4Gree87igr6P7Ms5Xcs/dPAp8xAPT6h1v7UeEmotM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPDHOxGismHV0VFj9/iH2vBGXCaKwNAyVFt5G1uqI9I=;
 b=fPuTuaz67YuKkWmK7v5+TYGIKoTfvAlO8I4fLOlqGEj7sctmRg7pkh8knxY7yDn7JzUDxFhcKFKYlOXDnef9I6VkVaC1oulaiZsX27fTycN4AcgZa/ci/tJ9W1f7Gg8OY9aYlzqkOPkYD2BhNWhTUgRuZl2jqL6+5J17+YK12mc=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1315.namprd22.prod.outlook.com (10.174.80.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 15:39:29 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 15:39:29 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Thread-Topic: [Qemu-devel] [BUG] gcov support appears to be broken
Thread-Index: AQHVS6OJufujL2TSeUSPSHf+V3yBK6bssGAO
Date: Mon, 5 Aug 2019 15:39:29 +0000
Message-ID: <BN6PR2201MB12512C8AF64BD24CFFA9BCCFC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>,
 <871rxzk8ho.fsf@linaro.org>,
 <BN6PR2201MB12511114EB865D69305CC9D9C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12511114EB865D69305CC9D9C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e8c6ee8-6ab5-4f51-1aaf-08d719bb1ae7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1315; 
x-ms-traffictypediagnostic: BN6PR2201MB1315:
x-microsoft-antispam-prvs: <BN6PR2201MB1315AB9C60BAF6CEC6CA0F6CC6DA0@BN6PR2201MB1315.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(14454004)(33656002)(2940100002)(8676002)(52536014)(71200400001)(8936002)(71190400001)(81166006)(68736007)(316002)(9686003)(53936002)(86362001)(81156014)(4326008)(446003)(25786009)(11346002)(26005)(76176011)(110136005)(102836004)(55236004)(186003)(3846002)(99286004)(66574012)(7696005)(6506007)(14444005)(256004)(66066001)(6116002)(486006)(476003)(5660300002)(64756008)(66446008)(91956017)(478600001)(229853002)(66476007)(66556008)(76116006)(2906002)(74316002)(55016002)(305945005)(6436002)(6246003)(7736002)(66946007)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1315;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6G9bJcqH/l7OBd536CO08IlzP0QpUg4Dk0F4AyfW63Qp/+CzizpWuxiIS4nDVVptwSghgsF6/z3TBB/4qOXmVBHDd/UVuM2kc/rX4ExzKSzeUThzo6033xTWQtJYvzHFByre3oB7V5v0DGCGCkS3jAp5S8Iwaf98Y34ykY+swEoyunNszAe0H4F6/0WUyTnsauJrVC4SEyJl/DgrFuwmxncmRLXfDVQx2PSo2Z22k71km1cTTUakh2vXo4iBfJimuuEf/BxpcHcPVpqY9SkZKxGDI84bEFy2RnfvRXjK9EmEUA7Ryqx6rak6Uhv6tepqEmjqFXbQ0j8H3RBt4hVH3GitcHJUdGeT34W/vpboIr077PVe0pb/CQxhR2ixkTrGoGmQfjVh3Ah3H6NVF4/YLEzrjVomcauTWSC5+79rYoo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8c6ee8-6ab5-4f51-1aaf-08d719bb1ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 15:39:29.5377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1315
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.131
Subject: Re: [Qemu-devel] [BUG] gcov support appears to be broken
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
>> #./configure --enable-gcov=0A=
>> #make=0A=
>> #make check=0A=
>> #make coverage-report=0A=
>>=0A=
>> It seems that first three commands execute as expected. (For example,=0A=
>> there are plenty of files generated by "make check" that would've not=0A=
>> been generated if "enable-gcov" hadn't been chosen.) However, the=0A=
>> last command complains about some missing files related to FP=0A=
=0A=
> So your failure mode is no report is generated at all? It's working for=
=0A=
> me here.=0A=
=0A=
Another piece of info:=0A=
=0A=
~/Build/qemu-TOT-TEST$ gcov --version=0A=
gcov (Ubuntu 5.5.0-12ubuntu1~16.04) 5.5.0 20171010=0A=
Copyright (C) 2015 Free Software Foundation, Inc.=0A=
This is free software; see the source for copying conditions.=0A=
There is NO warranty; not even for MERCHANTABILITY or =0A=
FITNESS FOR A PARTICULAR PURPOSE.=0A=
=0A=
:~/Build/qemu-TOT-TEST$ gcc --version=0A=
gcc (Ubuntu 7.2.0-1ubuntu1~16.04) 7.2.0=0A=
Copyright (C) 2017 Free Software Foundation, Inc.=0A=
This is free software; see the source for copying conditions.  There is NO=
=0A=
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=
=0A=
=0A=
=0A=
=0A=
=0A=
Alex, no report is generated for my test setups - in fact, "make coverage-r=
eport" even says that it explicitly deletes what appears to be the main cov=
erage report html file).=0A=
=0A=
This is the terminal output of an unsuccessful executions of "make coverage=
-report" for recent ToT:=0A=
=0A=
~/Build/qemu-TOT-TEST$ make coverage-report=0A=
make[1]: Entering directory '/home/user/Build/qemu-TOT-TEST/slirp'=0A=
make[1]: Nothing to be done for 'all'.=0A=
make[1]: Leaving directory '/home/user/Build/qemu-TOT-TEST/slirp'=0A=
        CHK version_gen.h=0A=
  GEN     coverage-report.html=0A=
Traceback (most recent call last):=0A=
  File "/usr/bin/gcovr", line 1970, in <module>=0A=
    print_html_report(covdata, options.html_details)=0A=
  File "/usr/bin/gcovr", line 1473, in print_html_report=0A=
    INPUT =3D open(data['FILENAME'], 'r')=0A=
IOError: [Errno 2] No such file or directory: 'wrap.inc.c'=0A=
Makefile:1048: recipe for target '/home/user/Build/qemu-TOT-TEST/reports/co=
verage/coverage-report.html' failed=0A=
make: *** [/home/user/Build/qemu-TOT-TEST/reports/coverage/coverage-report.=
html] Error 1=0A=
make: *** Deleting file '/home/user/Build/qemu-TOT-TEST/reports/coverage/co=
verage-report.html'=0A=
=0A=
This instance is executed in QEMU 3.0 source tree: (so, it looks the proble=
m existed for quite some time)=0A=
=0A=
~/Build/qemu-3.0$ make coverage-report=0A=
        CHK version_gen.h=0A=
  GEN     coverage-report.html=0A=
Traceback (most recent call last):=0A=
  File "/usr/bin/gcovr", line 1970, in <module>=0A=
    print_html_report(covdata, options.html_details)=0A=
  File "/usr/bin/gcovr", line 1473, in print_html_report=0A=
    INPUT =3D open(data['FILENAME'], 'r')=0A=
IOError: [Errno 2] No such file or directory: '/home/user/Build/qemu-3.0/ta=
rget/openrisc/decode.inc.c'=0A=
Makefile:992: recipe for target '/home/user/Build/qemu-3.0/reports/coverage=
/coverage-report.html' failed=0A=
make: *** [/home/user/Build/qemu-3.0/reports/coverage/coverage-report.html]=
 Error 1=0A=
make: *** Deleting file '/home/user/Build/qemu-3.0/reports/coverage/coverag=
e-report.html'=0A=
=0A=
Fond regards,=0A=
Aleksandar=0A=
=0A=
=0A=
> Alex Benn=E9e=0A=

