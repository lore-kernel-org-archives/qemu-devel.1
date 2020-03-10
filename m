Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12B5C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E2424673
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E2424673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBYEV-0008Ng-LE
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 02:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LMa@suse.com>) id 1jBYDj-0007kb-99
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LMa@suse.com>) id 1jBYDg-0004xv-SI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:18:26 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:58091)
 by eggs.gnu.org with esmtp (Exim 4.71) (envelope-from <LMa@suse.com>)
 id 1jBYDg-0004mp-2g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:18:24 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY
 m4a0073g.houston.softwaregrp.com WITH ESMTP; 
 Tue, 10 Mar 2020 06:16:09 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 10 Mar 2020 06:18:02 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.8.14) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 10 Mar 2020 06:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cem/Ra9ixjm4lb93wEoOsMcntAD46BYf2wS0sE5Ra1+c9UQG/SMyySY+QIFEMIMiex7kXerexuVdhtokycIt1r5LIXIVOSk30KZjSsaOOfjidaMCJkZ7S5WLCgNGKVmuYN7Sq1C+TNs9KedaN8OJwzRoSpJOj3g1pw8zh0KA5wSRvujwaeE+JvmJzij5egZBQKMb/V/NnDbhuu62y/OyPFBHYXDyW49Mr3oAyZQVQ84QxkFsr//bEkqyqM0hLiWNMcMDjAXRsM5ywUTG1E7mMsmmVR9omDdl25j4uuNjvLifXeLs0RM74gY4a85sp550dJDUA/WCtmcP4fMepEd2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KKz3Gu8REnRoaGVBmWe7CPFTeoFYt0sBOfqGiZL9O4=;
 b=fmvd0Du50B1m1gG5HJqyF2yu/nWyFXvjG/7ing6Dhvc3lO8Hl1o6mtKHbbQ8YrHyFTO8+OPndjgRye1FvAByveGM4cQ4mDgABiHBmHu3kUzY/Fi5cIkIqauLqoD6thnfK8FQSeV2op921/towaImja7nFUU8BdsZE9TNZE9oT5uQOo6892y3OEozOT8rVARn0GmWmoMaY8y6bJjFkqy8IEUnXueK6VbTRydcUio92Xgz7XQm3rwZWg65FKhy5dykK9j/oJafrGWzAMkSe6bw+kjEn5NsAmK5ToGvo+wfqtIEQSSzR4NTz5KEkdeKx5kaBHskjbfmmF0oTid97u7BGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB3322.namprd18.prod.outlook.com (2603:10b6:5:1cb::11)
 by DM6PR18MB2745.namprd18.prod.outlook.com (2603:10b6:5:16c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 06:18:00 +0000
Received: from DM6PR18MB3322.namprd18.prod.outlook.com
 ([fe80::c7d:1a2e:74ed:f675]) by DM6PR18MB3322.namprd18.prod.outlook.com
 ([fe80::c7d:1a2e:74ed:f675%7]) with mapi id 15.20.2772.019; Tue, 10 Mar 2020
 06:18:00 +0000
From: Lin Ma <LMa@suse.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Question] About GET LBA STATUS(16) support in qemu scsi
 emulation layer
Thread-Topic: [Question] About GET LBA STATUS(16) support in qemu scsi
 emulation layer
Thread-Index: AQHV9qNUhFirGurUM06KwP8HbzEibQ==
Date: Tue, 10 Mar 2020 06:18:00 +0000
Message-ID: <DM6PR18MB3322E8AF16F20D91557C3335C5FF0@DM6PR18MB3322.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LMa@suse.com; 
x-originating-ip: [114.247.113.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76610d0c-80d8-406b-8ccd-08d7c4bac876
x-ms-traffictypediagnostic: DM6PR18MB2745:
x-microsoft-antispam-prvs: <DM6PR18MB274565FDA540B179B1028B88C5FF0@DM6PR18MB2745.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(33656002)(6506007)(6916009)(52536014)(53546011)(8676002)(7696005)(8936002)(4326008)(81166006)(81156014)(2906002)(76116006)(86362001)(55016002)(9686003)(54906003)(66946007)(478600001)(91956017)(5660300002)(66556008)(71200400001)(66476007)(186003)(26005)(66446008)(19627405001)(64756008)(316002)(175924003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR18MB2745;
 H:DM6PR18MB3322.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmHdcTIJnYAEV9WSMfjqljtguFVZqtntz23nabqxp+F0TxQUK3fP42O4mDTN/jNvZzebJJDBhU+GOB0KZy5RocMzuhdmyR6ZsJNvqgF4h/RenEaZ9BFok0AeYwBB4GfVHn767KCt0QGLRVsCJNYFnqsQI4cqjAxIFxozNRahKzbfiCF24dyzDPwXEqN0WYNceg67RbIj7haD0LNDdnYf4ismSOBm2SWvVMfSOSFaE1SCpkZ2TUoEaNjcce9hCo43npPZQsFzSO7wr5dyWyvhGWHQTDtemvjoqV34mW9WojyuyWPOb5j2JM+vtiWPyDcGXNIYQhGHebCK3IwIK+cCwHaVUFqe2BWbW7zx49E+LcYeyDI0qxy5TTpEmqbLyhmCz6Fl3vZaT8Al8MkLGvFq8q7juwthb+6kWDsfQhL+pL6aNhDBm8DwmsleHXUw/i6oqzMDKxH7LJiwiaIfEyJUkb+hJe3cW42aJVKnEGNPuFPZEE+P8NwFgriNz55g9KLA
x-ms-exchange-antispam-messagedata: 6tKfo/SGJHEcQWnxFwozRVJUOqL8hb8gZQ9t/z7srP8uY3WrimDjPN5YHbq33zXrGr6ktsFvHhqFjXDKpXbiitAfQC/Mi/XDL/LA5KXt8uOmCs/Rr0xXW9d3dAISTZQ/7AQmtHa39m+5kAndY8a9tw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR18MB3322E8AF16F20D91557C3335C5FF0DM6PR18MB3322namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76610d0c-80d8-406b-8ccd-08d7c4bac876
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 06:18:00.0469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I62NDewKhS48Bi9h84stYYa/E9BCnRWF50Ko8biz5YTYXvhnat5301OStOWZrPOK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2745
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
Cc: Jon Maloy <jmaloy@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hare@suse.de" <hare@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR18MB3322E8AF16F20D91557C3335C5FF0DM6PR18MB3322namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

First of all, Thanks for your reply, Stefan.

We know that the GET LBA STATUS works well under scsi lun passthrough due t=
o the vm directly talks to the scsi target.
I'm curious that if I use file backend image(say qcow2) + qemu scsi emulati=
on, Does it make sense if I issue sg_get_lba_status in vm to get the lba st=
atus?
If it doesn't make sense, That could explain why qemu scsi emulation layer =
lack of this support for a long time and no user complains.

Thanks,
Lin
________________________________
From: Stefan Hajnoczi
Sent: Friday, March 6, 2020 9:01 PM
To: Lin Ma
Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; hare@suse.de; Eric Blake; J=
on Maloy
Subject: Re: [Question] About GET LBA STATUS(16) support in qemu scsi emula=
tion layer

On Sun, Mar 01, 2020 at 01:01:29PM +0000, Lin Ma wrote:
> Hi all,
>
> I'm not familiar with scsi, I'm curious why there is no GET LBA STATUS(16=
) support in qemu scsi emulation layer.
>
> So far, There is only one subcommand of SERVICE ACTION was implemented: T=
he READ CAPACITY(16)
> e.g.
> static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
>     [......]
>     case SERVICE_ACTION_IN_16:
>         /* Service Action In subcommands. */
>         if ((req->cmd.buf[1] & 31) =3D=3D SAI_READ_CAPACITY_16) {
>             [......]
>         }
>         trace_scsi_disk_emulate_command_SAI_unsupported();
>         goto illegal_request;
>     [......]
>
>
> It seems that this situation has been for a long time. Is the GET LBA STA=
TUS (16 or 32) unnessesary for qemu scsi emulation or did I misunderstand s=
omething?

GET LBA STATUS is optional according to the SBC specification so QEMU's
SCSI target is conformant.

I guess the question is which applications need this command?

It's probably a case of no one needing this command enough to implement
it yet.

Stefan

--_000_DM6PR18MB3322E8AF16F20D91557C3335C5FF0DM6PR18MB3322namp_
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
<span>First of all, Thanks for your reply, Stefan.<br>
</span>
<div><br>
</div>
<div>We know that the GET LBA STATUS works well under scsi lun passthrough =
due to the vm directly talks to the scsi target.<br>
</div>
<div>I'm curious that if I use file backend image(say qcow2) &#43; qemu scs=
i emulation, Does it make sense if I issue sg_get_lba_status in vm to get t=
he lba status?<br>
</div>
<div>If it doesn't make sense, That could explain why qemu scsi emulation l=
ayer lack of this support for a long time and no user complains.<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<span>Lin</span></div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%;">
<b>From:</b> Stefan Hajnoczi<br>
<b>Sent:</b> Friday, March 6, 2020 9:01 PM<br>
<b>To:</b> Lin Ma<br>
<b>Cc:</b> qemu-devel@nongnu.org; pbonzini@redhat.com; hare@suse.de; Eric B=
lake; Jon Maloy<br>
<b>Subject:</b> Re: [Question] About GET LBA STATUS(16) support in qemu scs=
i emulation layer
<div><br>
</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Sun, Mar 01, 2020 at 01:01:29PM &#43;0000, Lin =
Ma wrote:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; I'm not familiar with scsi, I'm curious why there is no GET LBA STATUS=
(16) support in qemu scsi emulation layer.<br>
&gt; <br>
&gt; So far, There is only one subcommand of SERVICE ACTION was implemented=
: The READ CAPACITY(16)<br>
&gt; e.g.<br>
&gt; static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *bu=
f)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; [......]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; case SERVICE_ACTION_IN_16:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Service Action In s=
ubcommands. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((req-&gt;cmd.buf[1=
] &amp; 31) =3D=3D SAI_READ_CAPACITY_16) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; [......]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_scsi_disk_emulat=
e_command_SAI_unsupported();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto illegal_request;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; [......]<br>
&gt; <br>
&gt; <br>
&gt; It seems that this situation has been for a long time. Is the GET LBA =
STATUS (16 or 32) unnessesary for qemu scsi emulation or did I misunderstan=
d something?<br>
<br>
GET LBA STATUS is optional according to the SBC specification so QEMU's<br>
SCSI target is conformant.<br>
<br>
I guess the question is which applications need this command?<br>
<br>
It's probably a case of no one needing this command enough to implement<br>
it yet.<br>
<br>
Stefan<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR18MB3322E8AF16F20D91557C3335C5FF0DM6PR18MB3322namp_--

