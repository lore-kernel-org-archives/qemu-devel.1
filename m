Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FDC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D251321D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D251321D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfL4-0004bJ-1n
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LMa@suse.com>) id 1jBfKL-0003sd-Gi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LMa@suse.com>) id 1jBfKJ-0000Mr-8e
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:53:44 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:56724)
 by eggs.gnu.org with esmtp (Exim 4.71) (envelope-from <LMa@suse.com>)
 id 1jBfKJ-00006C-0a; Tue, 10 Mar 2020 09:53:43 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0013g.houston.softwaregrp.com WITH ESMTP; 
 Tue, 10 Mar 2020 13:52:46 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 10 Mar 2020 13:51:25 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 10 Mar 2020 13:51:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4n2RY0tuF9wgSLWSmN0J+l2qqIfIrvNfzz9Qo1QgYxuv2NDdbftZ7OH1OgMWiA7LhfUH/jYdR0yxU4oFqfaZAnCU5sQLgo0QS10Bya9FcxKuyXM/x1q3hadM/nItL1/29loyOjnfCSGyvNyq1wf1jmr1JYCLdIhFLvaZf/v0dUB4qXAAGj60iU9cNe6WQeeTXi+9yBCsC7wml5jua8XAJG5KFlLuUP2xEzosLQbKdHOE9PCLHj8evY9oZccw9K7xtgNv+b1pgEn1DdmqRrQKZdzGqK7og0Q01p4yQ2WI1GNDb4WFfJaflcxQCnKBHVYROfHc6vFxQmxAvaJn+8VNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmkCmSkJdXJHF0UOqJ29IZThNA7VSa435x8u6zczEqM=;
 b=WSDC4IQLxRn0lDjRHluPFevquDs3saVwvBSvsyYfdGwRTcBJieGq9NqZ3YuA1FDInZDu9Ma13P2AtWSx8+kSJ9V4kvF/JK8yQ8Gq9O56LCTu3ItXmgVJlczg1xkrDtpn4ZEtt3G5p6SS29MSzLk2yj6aCg+Z1pzJ5fIX9K90N4tS/uZEVRwsKJkhaCVt45l04BUdI73HQXahh2a+qrK4+VZHmjBThfFn4n72zwQYRo2skpyzCe7pN5hbzcopoc9mHy0kXRdKuGDr7wRjzc8rWdAFzZOmIDKE1FXV//VYAP3HzqwSx7dmDUzLH6XRw/0lqo+IMkPaOxwlmC4LZHMmSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB3322.namprd18.prod.outlook.com (2603:10b6:5:1cb::11)
 by DM6PR18MB2444.namprd18.prod.outlook.com (2603:10b6:5:18d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 13:51:24 +0000
Received: from DM6PR18MB3322.namprd18.prod.outlook.com
 ([fe80::c7d:1a2e:74ed:f675]) by DM6PR18MB3322.namprd18.prod.outlook.com
 ([fe80::c7d:1a2e:74ed:f675%7]) with mapi id 15.20.2772.019; Tue, 10 Mar 2020
 13:51:24 +0000
From: Lin Ma <LMa@suse.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Question] About GET LBA STATUS(16) support in qemu scsi
 emulation layer
Thread-Topic: [Question] About GET LBA STATUS(16) support in qemu scsi
 emulation layer
Thread-Index: AQHV9uKQZWVG3EW84kaPMcZ8c7+DUA==
Date: Tue, 10 Mar 2020 13:51:24 +0000
Message-ID: <DM6PR18MB33228120F8F8A1C91B3BB621C5FF0@DM6PR18MB3322.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LMa@suse.com; 
x-originating-ip: [114.247.113.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6c640f0-2974-4d8a-3bad-08d7c4fa1f73
x-ms-traffictypediagnostic: DM6PR18MB2444:
x-microsoft-antispam-prvs: <DM6PR18MB2444F060C6BEF2FA9E808582C5FF0@DM6PR18MB2444.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(71200400001)(66946007)(478600001)(66476007)(64756008)(66556008)(66446008)(53546011)(6506007)(52536014)(8676002)(2906002)(5660300002)(8936002)(86362001)(81166006)(81156014)(54906003)(76116006)(186003)(9686003)(6916009)(33656002)(26005)(4326008)(55016002)(91956017)(19627405001)(316002)(7696005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR18MB2444;
 H:DM6PR18MB3322.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3wkl6yjLmXUK0N2wKE3DAOGiizmXKRmDIbTMbdjNh1mJG3Tg/0I2X7wzxlN2GRHNubiWW6EgoAGQp55gjfQUOGpnDt9i8k15KEdHh//g8oSBPx5+AMaov2K7l+aSqvflPI/LyyC2ydaQ7Px02UFenpxcRRPB53bCsIBI53MB1neRKV5c1UMTZ9eSruKp8FLRRQu5CfZYH0YMIEbaLRyXSSYQi1TzoULADkShe0LrHcqo2HyOHpAXZ02H3/xPTbpumdKafRpF2LoHFv3jzFuFYf3/MG07F9pASCf53k6lKEv3KdLOVLo5D18HEfoZLTVPIu3AJ3Qz7z84CtVFWv7dzZLfTnsoyYyI3dYkVnmutYWJTCGWPwiLb+AG5ibJl8jWrA5BZtbUl4OEmV2OBgq+2GAvRLHU0vp1C4uLvlIYRGcrxWnf18XDXfXfZmVTVgK
x-ms-exchange-antispam-messagedata: QNzjPLiONw4vTXWaA0XnXZeMwXxoYJapuE0LM19rRozDRpj69O/wzZ/mku/kDFUU++T7qPYiNYOYrg68bAgxcOg72SKMf0xUEETNM0q8ATKZiCB6oN65FeW1nKXNTRJyCK4lpp0fXWUSjuiroCYXqQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR18MB33228120F8F8A1C91B3BB621C5FF0DM6PR18MB3322namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c640f0-2974-4d8a-3bad-08d7c4fa1f73
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 13:51:24.3908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmfz1RQwZ2FefXMRDNKmvewgpN52d4zYlWCHiFEbM+XM9+9wFxJTsmGbKmRB/OsD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2444
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.91
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
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jon Maloy <jmaloy@redhat.com>,
 "hare@suse.de" <hare@suse.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR18MB33228120F8F8A1C91B3BB621C5FF0DM6PR18MB3322namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Due to no users complain about it so far, It seems not many people need it.
I'll spend some time reading some code of qemu block and diving into SCSI c=
ommand manual, then try to implement it.
If anyone's willing to implement it before this, it will be appreciated.

Thanks for your valuable information,
Lin
________________________________

From: Stefan Hajnoczi
Sent: Tuesday, March 10, 2020 5:24 PM
To: Lin Ma
Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; hare@suse.de; Eric Blake; J=
on Maloy; qemu-block@nongnu.org
Subject: Re: [Question] About GET LBA STATUS(16) support in qemu scsi emula=
tion layer

On Tue, Mar 10, 2020 at 06:18:00AM +0000, Lin Ma wrote:
> First of all, Thanks for your reply, Stefan.
>
> We know that the GET LBA STATUS works well under scsi lun passthrough due=
 to the vm directly talks to the scsi target.
> I'm curious that if I use file backend image(say qcow2) + qemu scsi emula=
tion, Does it make sense if I issue sg_get_lba_status in vm to get the lba =
status?
> If it doesn't make sense, That could explain why qemu scsi emulation laye=
r lack of this support for a long time and no user complains.

It does make sense to implement GET LBA STATUS because QEMU emulates the
UNMAP command.

Be careful though because there is no asynchronous bdrv_block_status()
API yet.  Internally the BlockDriver->bdrv_co_block_status() function is
already asynchronous because it runs in a coroutine.  It will be
necessary to expose a new bdrv_aio_get_block_status() or similar API so
the device models (i.e. SCSI emulation code) can take advantage of that.

Stefan

--_000_DM6PR18MB33228120F8F8A1C91B3BB621C5FF0DM6PR18MB3322namp_
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
<span>Due to no users complain about it so far, It seems not many people ne=
ed it.<br>
</span>
<div>I'll spend some time reading some code of qemu block and diving into S=
CSI command manual, then try to implement it.<br>
</div>
<span>If anyone's willing to implement it before this, it will be appreciat=
ed.</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>Thanks for your valuable information,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>Lin</span></div>
<div>
<div>
<hr tabindex=3D"-1" style=3D"color: rgb(0, 0, 0); font-family: Calibri, Ari=
al, Helvetica, sans-serif; font-size: 12pt; font-style: inherit; font-varia=
nt-ligatures: inherit; font-variant-caps: inherit; font-weight: inherit; ba=
ckground-color: ; display: inline-block; width: 98%;">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0);">
<b>From:</b> Stefan Hajnoczi<br>
<b>Sent:</b> Tuesday, March 10, 2020 5:24 PM<br>
<b>To:</b> Lin Ma<br>
<b>Cc:</b> qemu-devel@nongnu.org; pbonzini@redhat.com; hare@suse.de; Eric B=
lake; Jon Maloy; qemu-block@nongnu.org<br>
<b>Subject:</b> Re: [Question] About GET LBA STATUS(16) support in qemu scs=
i emulation layer
<div><br>
</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Mar 10, 2020 at 06:18:00AM &#43;0000, Lin =
Ma wrote:<br>
&gt; First of all, Thanks for your reply, Stefan.<br>
&gt; <br>
&gt; We know that the GET LBA STATUS works well under scsi lun passthrough =
due to the vm directly talks to the scsi target.<br>
&gt; I'm curious that if I use file backend image(say qcow2) &#43; qemu scs=
i emulation, Does it make sense if I issue sg_get_lba_status in vm to get t=
he lba status?<br>
&gt; If it doesn't make sense, That could explain why qemu scsi emulation l=
ayer lack of this support for a long time and no user complains.<br>
<br>
It does make sense to implement GET LBA STATUS because QEMU emulates the<br=
>
UNMAP command.<br>
<br>
Be careful though because there is no asynchronous bdrv_block_status()<br>
API yet.&nbsp; Internally the BlockDriver-&gt;bdrv_co_block_status() functi=
on is<br>
already asynchronous because it runs in a coroutine.&nbsp; It will be<br>
necessary to expose a new bdrv_aio_get_block_status() or similar API so<br>
the device models (i.e. SCSI emulation code) can take advantage of that.<br=
>
<br>
Stefan<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR18MB33228120F8F8A1C91B3BB621C5FF0DM6PR18MB3322namp_--

