Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E772C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A862070D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="Xcdl5amW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A862070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huf2w-0004Uh-C4
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53462)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1huf2D-0003A4-Uy
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1huf2C-0004aB-Rc
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:36:29 -0400
Received: from mail-eopbgr770104.outbound.protection.outlook.com
 ([40.107.77.104]:28142 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1huf2B-0004YR-Qa
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCp6eRdlN6CQ2SEQ7bydb5wyhsViPq4fbp5GXTqTj1xf8ykMlKe/wFDychDLjm1VWwbkXJblOKxyiYsETRTi1X+CTNzOVYHmeDE9ZLlCKxWFZ3TPMXFevPXlBb9e0+Z1Pwyc7onB4ZerymNbphYYeG7tKS7VzsGDSwSjJTp0EiLBmsycIJb+VfFwOLjXScQ179tErgXMQgeSeNn/xw1qbmv6Dixc/vW6WsZGsb5SfqudEYO9tcibZgZxSjkt4Zsm+bAW+QTcrMHMCQSYbAbIxsm9hOHjql6QeXxCY0mhRo8PqukcloVyr9Ydu915DeqdfRcW5fFotyGW18gwTQpi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtR5IyQvOMe26fCk9d9tYFlR/96jJPrc5fmCuxtYygM=;
 b=ARL2fwz+zZih6m5Rayq8KJ5Z6+Lx2N8ArYo673jSWO15wNlwKap3bOGROGp/n2ScuCbMPPgEnmR29Tnd6CWnXDTVUwwRzkju5QqGA2r9b3Klit4F3OelXJwbyMMkW9y4eHNXgZZ9nDh82ph+QEehh6zXM8DT846qKedShrIBba3gJaakNWE1h/tLtLa3KsPlux+3leZGic3Hpq4LA1+/gC29vLKSUvRU8cQX6kiaca1+l4WxXtEJADJE8/FgQiK8ZvrqZdUhq+sy7Jj5D4PJpgboSVOW+XzfC4p0HmIla6joqdUOCR00+HvHYYjpQte9SS5xyg+SY09tYH/mOldXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtR5IyQvOMe26fCk9d9tYFlR/96jJPrc5fmCuxtYygM=;
 b=Xcdl5amWw8h9hfGSynN+s3kCPt6b8WlFNjwuaqzpJCbWQzQVi7dLt4ry946Jx6mmael5HdgrG4KQPImvycdPHylBXtf+RaAJBcQ0MZ6DpFodhZPWg+B0be2n7Ze5o5erMayN2Rxf9XbWJ78Gjy/H2VpA7PgzvbjWjHR7pseM8Ho=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1201.namprd22.prod.outlook.com (10.174.81.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 15:36:24 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 15:36:23 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Thread-Topic: [Qemu-devel] [BUG] gcov support appears to be broken
Thread-Index: AQHVS6OJufujL2TSeUSPSHf+V3yBKw==
Date: Mon, 5 Aug 2019 15:36:23 +0000
Message-ID: <BN6PR2201MB12511114EB865D69305CC9D9C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>,
 <871rxzk8ho.fsf@linaro.org>
In-Reply-To: <871rxzk8ho.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d453c849-33b7-4e07-e82f-08d719baac23
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1201; 
x-ms-traffictypediagnostic: BN6PR2201MB1201:
x-microsoft-antispam-prvs: <BN6PR2201MB120153FC6C339777C3A1F06BC6DA0@BN6PR2201MB1201.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(39830400003)(366004)(136003)(199004)(189003)(91956017)(6506007)(71200400001)(14454004)(229853002)(2906002)(9686003)(6436002)(76176011)(66066001)(110136005)(55016002)(305945005)(76116006)(53936002)(66946007)(256004)(66446008)(64756008)(66556008)(66476007)(7736002)(316002)(476003)(5660300002)(52536014)(66574012)(11346002)(486006)(14444005)(33656002)(186003)(71190400001)(102836004)(26005)(55236004)(3846002)(81166006)(6116002)(86362001)(68736007)(81156014)(478600001)(8936002)(74316002)(6246003)(4326008)(25786009)(7696005)(8676002)(446003)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1201;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Opp6Jk1WYUMh0L8V3nV1st31h8oAWs3BGijp/+f+b5jO3jFdNBcAlvLqQxH2AM76k4BKFi79dokd/tcaRp0jsE9i61gHH9RkSqOqw2TG7qnwxVcmRhd8DN+Dz/rtYMj7hOXqmHcypu4vXmnkemrHENAwTkqR+YIklPxmxTfdzDJlTIQjbufiZk5s4VluUP/Whq5kI5QYIYxpitwEVM7jx1mlVJPsOCzjS47nEgqZCcRUQhQbyH2Andxz/6M8pp1Z/9j42iMsOpCwL1rZMEUTVBHIDMdYQMKOGkHF7svYgXe4mK4GwcDL6kPsMoHOe3kUEXaPhaQkZJRECdAXXCMPWvNsO43X4o/7eSZ+60SQx1g9Lcxv3uGYwopNZVb61qMBK/mZrWm6cl7ZGvblMvYlVmz/5HxgrSWME+H98lQBPM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d453c849-33b7-4e07-e82f-08d719baac23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 15:36:23.7061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1201
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.104
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

