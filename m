Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FBBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 13:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4131E214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 13:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4131E214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8OFW-0000MM-AF
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 08:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LMa@suse.com>) id 1j8OEg-00088O-8L
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 08:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LMa@suse.com>) id 1j8OEd-0008GT-IJ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 08:02:20 -0500
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:41922)
 by eggs.gnu.org with esmtp (Exim 4.71) (envelope-from <LMa@suse.com>)
 id 1j8OEd-0008CK-Av
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 08:02:19 -0500
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY
 m4a0073g.houston.softwaregrp.com WITH ESMTP; 
 Sun,  1 Mar 2020 13:00:12 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sun, 1 Mar 2020 13:01:32 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Sun, 1 Mar 2020 13:01:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONXI0O9ltSng4vHI7U1Z90upi/c4zbY8LzKh8s1r8Lf2Kh2e5Kj9sjyJnWPwg0Q3KEy5IUYiVXHsVf6rVqcKaWS5BKqkbMPVl/IEj3q1N37d1TepTGRUx3QmeB8+h+auW5T0HrlDllWEFkwM2rtzW9iHKpBF/NLA3D0GhfV9TaxjGdZf96THm9TT/yn6+dGlmMNVsPx6odY9P2DFIeepEOZFuVxPx8IxIiI8QCG8UE1UMo9SUdad2qmnV5hvaG/LGYNHE+jyAWhYXn5gx1pHwKYsbzoWJTkweBtrK6NheGAl0XJsPS5jW2l6dpkEzP09pR6Xfq68Y3+bZl4DKU7xMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzbbUl3bcbndnVEo9UwO74kml3xpx8IIAenw9WOqxEk=;
 b=OgLLiBIA+g3WKulH3qIozZZEwsh5Dqxr5HUThwaZyfQPjhBSRc78WlbgNWdVr63bv79VToOKJTNjBpayNw+LkeXjL4MUrf5iR9IUBAGSS/iqsqy98iW/OMEfspksOLFpeMv4h35oNcu4LATZFg56wAAIk8lToClcEoWdx/tqvFGuBJyyuY0IDyuHblk8KEvoH7QdEi+/5d4eSWaPRN92O8JFf/ndVwVq0Qzj0le0ZQSwT/Wi36NRPR6TqtxV7bDQDK+okj8UHvudTExAan7ZsdzrTi+dAqgU8nyFy2LiqR9CgdvXE8JMkQwF7cXpdg54kk/5x3/FRq1znn4HhBmrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3313.namprd18.prod.outlook.com (2603:10b6:a03:1a9::28)
 by BY5SPR01MB0004.namprd18.prod.outlook.com (2603:10b6:a03:1b4::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Sun, 1 Mar
 2020 13:01:29 +0000
Received: from BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::f077:6325:2cf3:294e]) by BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::f077:6325:2cf3:294e%5]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 13:01:29 +0000
From: Lin Ma <LMa@suse.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [Question] About GET LBA STATUS(16) support in qemu scsi emulation
 layer
Thread-Topic: [Question] About GET LBA STATUS(16) support in qemu scsi
 emulation layer
Thread-Index: AQHV78lTqZlKi38OCUGjGWSZ+bp/MA==
Date: Sun, 1 Mar 2020 13:01:29 +0000
Message-ID: <BY5PR18MB33131C4403EEE72D5DD0FA91C5E60@BY5PR18MB3313.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LMa@suse.com; 
x-originating-ip: [114.247.113.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b75ba569-0990-4300-9c06-08d7bde0a875
x-ms-traffictypediagnostic: BY5SPR01MB0004:
x-microsoft-antispam-prvs: <BY5SPR01MB0004E9D5B43FB8E60EFEFD02C5E60@BY5SPR01MB0004.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(39850400004)(346002)(136003)(366004)(199004)(189003)(26005)(186003)(8936002)(478600001)(6916009)(52536014)(316002)(2906002)(54906003)(7696005)(33656002)(86362001)(4744005)(8676002)(71200400001)(81166006)(81156014)(55016002)(9686003)(66476007)(6506007)(64756008)(66446008)(4326008)(66556008)(66946007)(5660300002)(91956017)(76116006)(19627405001)(175924003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BY5SPR01MB0004;
 H:BY5PR18MB3313.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bmTFwXPYurevuQjpUy8sWB+h6PUGHW1qso6XhDoDiJ8CDPZW40KRWxdMRjf1punl0uWUps4lmRlVLTR6LUqVyn/XEzn0DbWL4iFQL4dfD79mz3vXxyiZc6ivQitJoKcUUesR2w9A7C3Z3OSYW86L042FAe9Mkj/Wi1lUmnEcKGtWWkiEonDLc/dtUTwXOhk8rqwcSrQNftUjorGPGCIJwCKxKMTKiGgkvA3oZnDSe175O0h6k9rzVJIL6th7Fjf3Y6CqmOmI/xQnVv+JR09wPDv4+vBudZ7+FuZGFkq28tvyvmueYm4g3B9lBv57NJau3U7+fqVP/SgWybw/2CCg0Fui8HJWnOgfi+kz1Fh2ZwR+FhPtOnoBwd2XBw4dZ4zHOUrBn7Vuw8cAdZ0/4ozTLeiGdh6vfme/v1kC9W/wcI0iWtUb2YBPgsq8Pq/OwYTn8msd0na+vdl0y8Vm7j1W9eGDxk7g7nlWWo6zUHkIHSSX3OcMh6/JI05z2z7PPE2M
x-ms-exchange-antispam-messagedata: XacOfCSjC60BWxm4PBS5mdXWELs5IFiVpCGhTdt0lZ1no1lvQfROwVF1iWWxIOq6yaTtuuBafEklSN0oxpmA1+YmsCFAlIk8FOh3qLfIsFNpaeD1wRU7XM2xoJKCQNKIo4xtXgAoEd39f94U/kNASA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR18MB33131C4403EEE72D5DD0FA91C5E60BY5PR18MB3313namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b75ba569-0990-4300-9c06-08d7bde0a875
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 13:01:29.1339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvAbSKAsMjMQai4SQCWa+qzh/IdSgDr2DYx8Ob0kpirgR4t/wid8LooToWdE/xxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5SPR01MB0004
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.2.131
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "hare@suse.de" <hare@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR18MB33131C4403EEE72D5DD0FA91C5E60BY5PR18MB3313namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm not familiar with scsi, I'm curious why there is no GET LBA STATUS(16) =
support in qemu scsi emulation layer.

So far, There is only one subcommand of SERVICE ACTION was implemented: The=
 READ CAPACITY(16)
e.g.
static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
    [......]
    case SERVICE_ACTION_IN_16:
        /* Service Action In subcommands. */
        if ((req->cmd.buf[1] & 31) =3D=3D SAI_READ_CAPACITY_16) {
            [......]
        }
        trace_scsi_disk_emulate_command_SAI_unsupported();
        goto illegal_request;
    [......]


It seems that this situation has been for a long time. Is the GET LBA STATU=
S (16 or 32) unnessesary for qemu scsi emulation or did I misunderstand som=
ething?

TIA,
Lin

--_000_BY5PR18MB33131C4403EEE72D5DD0FA91C5E60BY5PR18MB3313namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>Hi all,<br>
</span>
<div><br>
</div>
<div>I'm not familiar with scsi, I'm curious why there is no GET LBA STATUS=
(16) support in qemu scsi emulation layer.<br>
</div>
<div><br>
</div>
<div>So far, There is only one subcommand of SERVICE ACTION was implemented=
: The READ CAPACITY(16)<br>
</div>
<div>e.g.<br>
</div>
<div>static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *bu=
f)<br>
</div>
<div>&nbsp; &nbsp; [......]<br>
</div>
<div>&nbsp; &nbsp; case SERVICE_ACTION_IN_16:<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; /* Service Action In subcommands. */<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; if ((req-&gt;cmd.buf[1] &amp; 31) =3D=3D S=
AI_READ_CAPACITY_16) {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [......]<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; }<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; trace_scsi_disk_emulate_command_SAI_unsupp=
orted();<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; goto illegal_request;<br>
</div>
<div>&nbsp; &nbsp; [......]<br>
</div>
<div>&nbsp; &nbsp; <br>
</div>
<div><br>
</div>
<div>It seems that this situation has been for a long time. Is the GET LBA =
STATUS (16 or 32) unnessesary for qemu scsi emulation or did I misunderstan=
d something?<br>
</div>
<div><br>
</div>
<div>TIA,<br>
</div>
<span>Lin</span><br>
</div>
</body>
</html>

--_000_BY5PR18MB33131C4403EEE72D5DD0FA91C5E60BY5PR18MB3313namp_--

