Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E67C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FD820679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 07:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FD820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgNVp-0001oi-3V
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 03:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jgNVE-0001KI-Ne
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 03:07:56 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:48132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jgNVC-0004gT-LY
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 03:07:55 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0014g.houston.softwaregrp.com WITH ESMTP; 
 Wed,  3 Jun 2020 07:07:01 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 3 Jun 2020 07:04:56 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 3 Jun 2020 07:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeTi6635HizTg6V4EgAtVvXaJPLKltp2rQ37mgOvbrP1DAFvplt8R0ng6RUtrxv2xVMt5aya3Hg+TowiBXZrwuJozW0Xlxl+aGoqMDxrZISWyduuKLGW7PqPlvSo8Jr9iA/SQH4LqNr3LHY8u51P9qJoMhsIz3YRR5zYw1kfWw7O/RRE7RXjgPNtUCc2UG/A3i0rN7UWHGgmiTGHH9suq/6bnYhG7IYiLm2lHynTGgWVxU13RQtcRXOoRuXzZpIqJgUZk1FJ5C1TMpk/Ygehs8PIYAGcB2D8OOc4Y+rfOVBNPpvV0tQKi/kcH/Oj+7GNPnDjAd43p/yE7JhOUNG+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkWBLTUZLNCQhqEq0hle1SuTohxbLhXNHuNjmtsPhNw=;
 b=gBojy4qvY2nFOF71QEDQYehvASR9yAcFD97RY9eBV6U3nYE0EyT/yOsvPgvzgHrw4eVfmRuimrnkyA/tYNBW7Kj8rMEQKP0CYSV2d5BTt6VDCxmYlvfLqe5WLFcnPGVC/C4Xr8oYHAyz3wuAngCbLHzQ+eFvWqUSxpb7J6XpwNtJ8TGNZ4WNMj3T1rlZ3IS4KZAsUN8PDrlieVQr9kQTidnyY+l/cFU7eM5aLstqIqpZ/bbuJWBjDzc/dBEWgl9xHgvJ+7kJK7G942DBVyN9NasTp+pqSFQv563+f+eAxiInUMAcord0gf4Gh55kjoAmeQVjLm3VfcKKaUaxrJzAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3313.namprd18.prod.outlook.com (2603:10b6:a03:1a9::28)
 by BY5PR18MB3378.namprd18.prod.outlook.com (2603:10b6:a03:195::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 07:04:55 +0000
Received: from BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::e4f5:6729:fa11:1240]) by BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::e4f5:6729:fa11:1240%7]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 07:04:55 +0000
From: Lin Ma <LMa@suse.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [question] Partial sector issue while discard in qcow2 image
Thread-Topic: [question] Partial sector issue while discard in qcow2 image
Thread-Index: AQHWOK7m5N2XkTj0GUW+Cz5gfuCM5KjFKnMAgAFOT+s=
Date: Wed, 3 Jun 2020 07:04:54 +0000
Message-ID: <BY5PR18MB33139BC1147B5E1224A08874C5880@BY5PR18MB3313.namprd18.prod.outlook.com>
References: <BY5PR18MB331316E948CB9AFDA33A6F6DC58B0@BY5PR18MB3313.namprd18.prod.outlook.com>,
 <20200602110648.GE5940@linux.fritz.box>
In-Reply-To: <20200602110648.GE5940@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
x-originating-ip: [60.251.47.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea7dd7c-5942-4132-423b-08d8078c6b5d
x-ms-traffictypediagnostic: BY5PR18MB3378:
x-microsoft-antispam-prvs: <BY5PR18MB3378635D129880F8275D2C58C5880@BY5PR18MB3378.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5NKfJz1dBjc8qcbq4/MsWW0k4Q8CiSxKPChaTEJSo9H+0oOllfdtMDhW5yDBXM/qN/vbPgPEWuT+5qW19ft69H68Ko5RlQBbbN273X3i34IKtSkaIobjx7KvPGMs+K7grFUYKCsAEfQrlm1r2NfvoC3U8UiRkPUKkA4XWSt9QY3gfodYIx5VNOT8LbDmPfY1hhl8nU3AeeoCnbq9j1cBafhJgvuwR7KEhEwrgXicT+hgWtXXOyTBd5yl0GxNwwvu+y1nRYTamW5Tr4rT8Nx+NgYmCNL880cndHA/hN7S5MoBclffaGFhbmhS/n9J/wP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR18MB3313.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(52536014)(53546011)(7696005)(71200400001)(64756008)(66946007)(55016002)(66556008)(66446008)(76116006)(8936002)(186003)(26005)(91956017)(5660300002)(9686003)(6506007)(8676002)(86362001)(6916009)(478600001)(4326008)(316002)(66476007)(83380400001)(19627405001)(2906002)(55236004)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NveAOT/nzpdgVDRVbSSGs2XN9LEFpJ1XmAGqtTCh25H9ZLDI780xaMFEw7h8GliISyyilWnsaRfaV++1ffwwydEsnO3e+41ZnsPWtVIg0JXA3C7biwJWPnb1fum4QQx9oKfGPeHKlAgzOIOaPyODDZOcMVM0FWeyqGoeVVjbymbCeE3Pr6j8I60LeARgXsJcLkOKB4upDKvmHCDmA4Dfzyo2WYJJ3iFX7u/B7QO+r4dhUQyiZ14mUCLXbbEXXWHyNZz8M4kLWly3Om9z+d6CdKcOj4FpRYwK0a96x57vRLx07BpGE33dojwgHGpm5Gv90AI7ltFRN+EOyerrm8/ECrwYOLIgFs/zHpVDs7n21Kji9xnL+MTTwJamkw4/vVBZGb4N4RZXip5VcNX2eUDv6Z1sHzed3AkWBc718xV0diUuWsCqIE39YHCVxyrP9K9ZDM7WTWMsw69CX4rJfRZz6zkXLeReXwGLH0FS4qOn4+o=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR18MB33139BC1147B5E1224A08874C5880BY5PR18MB3313namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eea7dd7c-5942-4132-423b-08d8078c6b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 07:04:54.9036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDNY6IQzQSctzTalv0wRfbj+wE5wlan3yzUUL2xG+w7mGho0ZhGJQSzdops6LpoO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3378
X-OriginatorOrg: suse.com
Received-SPF: pass client-ip=15.124.64.90; envelope-from=LMa@suse.com;
 helo=m9a0014g.houston.softwaregrp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 03:07:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

--_000_BY5PR18MB33139BC1147B5E1224A08874C5880BY5PR18MB3313namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

Thanks for the explanation!

Lin

________________________________
From: Kevin Wolf <kwolf@redhat.com>
Sent: Tuesday, June 2, 2020 7:06 PM
To: Lin Ma <LMa@suse.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; pbonzini@redhat.com <pbo=
nzini@redhat.com>
Subject: Re: [question] Partial sector issue while discard in qcow2 image

Am 02.06.2020 um 09:45 hat Lin Ma geschrieben:
> Hi all,
>
> During  woring to add GET LBA STATUS support in qemu scsi emulation
> layer, I encountered an unmap issue with qcow2 image, It's likely
> about how to unmap partial clusters. e.g.:
>
> With these default values:
> * the default value of s->qdev.blocksize: 512
> * the default value of s->cluster_size of qcow2 image: 65536
>
> Running 'sg_unmap -l 1024 -n 32 /dev/sda' hits the condition
> 'if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size))' in the
> function qcow2_co_pdiscard, Then it won't perform
> qcow2_cluster_discard(), So the corresponding clusters won't be
> discard in this situation, Correct?

Yes, this is correct. Discard is just a hint, so doing nothing is a
perfectly valid implementation. In the case of qcow2, only full clusters
are discarded.

> Of cause, with the default blocksize and cluster_size, The below
> examples won't hit the condition 'if (!QEMU_IS_ALIGNED...'.
> sg_unmap -l 1024 -n 128 /dev/sda
> or
> sg_unmap -l 256 -n 128 /dev/sda

Yes, and when discarding whole block devices (e.g. while creating a new
filesystem on them) or large files, you'll probably get this case for
most parts.

Kevin


--_000_BY5PR18MB33139BC1147B5E1224A08874C5880BY5PR18MB3313namp_
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
Hi <font size=3D"2"><span style=3D"font-size:11pt">Kevin</span></font>,</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for the explanation!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Lin<br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Kevin Wolf &lt;kwol=
f@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, June 2, 2020 7:06 PM<br>
<b>To:</b> Lin Ma &lt;LMa@suse.com&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; pbonzini@re=
dhat.com &lt;pbonzini@redhat.com&gt;<br>
<b>Subject:</b> Re: [question] Partial sector issue while discard in qcow2 =
image</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 02.06.2020 um 09:45 hat Lin Ma geschrieben:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; During&nbsp; woring to add GET LBA STATUS support in qemu scsi emulati=
on<br>
&gt; layer, I encountered an unmap issue with qcow2 image, It's likely<br>
&gt; about how to unmap partial clusters. e.g.:<br>
&gt; <br>
&gt; With these default values:<br>
&gt; * the default value of s-&gt;qdev.blocksize: 512<br>
&gt; * the default value of s-&gt;cluster_size of qcow2 image: 65536<br>
&gt; <br>
&gt; Running 'sg_unmap -l 1024 -n 32 /dev/sda' hits the condition<br>
&gt; 'if (!QEMU_IS_ALIGNED(offset | bytes, s-&gt;cluster_size))' in the<br>
&gt; function qcow2_co_pdiscard, Then it won't perform<br>
&gt; qcow2_cluster_discard(), So the corresponding clusters won't be<br>
&gt; discard in this situation, Correct?<br>
<br>
Yes, this is correct. Discard is just a hint, so doing nothing is a<br>
perfectly valid implementation. In the case of qcow2, only full clusters<br=
>
are discarded.<br>
<br>
&gt; Of cause, with the default blocksize and cluster_size, The below<br>
&gt; examples won't hit the condition 'if (!QEMU_IS_ALIGNED...'.<br>
&gt; sg_unmap -l 1024 -n 128 /dev/sda<br>
&gt; or<br>
&gt; sg_unmap -l 256 -n 128 /dev/sda<br>
<br>
Yes, and when discarding whole block devices (e.g. while creating a new<br>
filesystem on them) or large files, you'll probably get this case for<br>
most parts.<br>
<br>
Kevin<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BY5PR18MB33139BC1147B5E1224A08874C5880BY5PR18MB3313namp_--

