Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB882CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7898221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bHkQnPT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7898221D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxOo-0005zC-Ew
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <casasfernando@outlook.com>) id 1iNx5t-0003tB-LN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <casasfernando@outlook.com>) id 1iNx5r-0004ES-Ch
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:45:20 -0400
Received: from mail-oln040092070089.outbound.protection.outlook.com
 ([40.92.70.89]:36078 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <casasfernando@outlook.com>)
 id 1iNx5r-0004EH-4q; Fri, 25 Oct 2019 06:45:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KErhM21sAtmrecjCvhgDO6ioXl8plR4SkhLVGeTFS4JVpQ1gz9Jaga4VRTOicJmtFqVBXKC5aqJ4ppfTgrtcwYwq//aHiV1y9BhPKjvCOlaCA3POgxmm2LBUTQ8jKxEugTtepMJKoi9grnj/vAJF9YIpd7Zv1Yrw7ioJaqI8GYXi2+1b3gxmtZGFEEZEKBk2iPyubsi2rklnhb+O9rHrt1L5kkMRF5zWqQvbu8qxT2DBBd/LFvzDJ+MNcG42QYeYXR0FEConT7wU7HynHD3HrfWQvBAoMruJQVS7TO9WuG82PsjW+fonccjDvZCm17UOmAzzPU65j0xOqgzTQk6NhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pEQtAvDP2r+gZVdIw3qYmfr/8zupZyHryRLLq9+rYA=;
 b=WtanshubQHFDU+xkp3QXswBtZOk+zCX1q29orSYpOYN8uWSpwkkXB0WNXiXq1E5ieZSv4uulk0IiiHyNROGmw/oTh2F9k1R8koyp0lJ2VmKM12o8ODqP7xzZA5jUE5IgdlFLUkU+BdPcVpfmvAwwwPW6OOMz7W+ZuwIUWR1O37DMMsEUNqXL9MNX0k+wsCG4kfCEg9iKpzV4gsiCfJQaKrUjMPgdm28zPl4Crh86yZBSdjjwdcyUj2eH894Wj0O8rUJ6qBjMECX8ptnqhgPMPrCspa7fq7BAXFnyv7ocu2OZjHcscnzb6hcE6wPno7h0S/C+f5mPBctVcL3TR2MB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pEQtAvDP2r+gZVdIw3qYmfr/8zupZyHryRLLq9+rYA=;
 b=bHkQnPT5FNtaXxMJ4wC8tBKXOrIiUHj+u/JTkJfDoXo3ftumZFfhyi7NtkYkBVUfcH/c4MeqLMe2gLjwrXA+puOTTnwMTMKvrImK+o8PcBL4MIEeL2HZfKrJh4gNrLeOBap0POv1MvywhqjPfsOyDNPXzZqEJOnKss1Z/5o57Fz6+qQ6KuKc8+cNvOLiSP0rlfKnp/YcV+EkSvQiLdCOussKI87wIjAit3WQZg1sSnHGzjua3WtAsr82Tcnp2S00QsyLpXneJSr35CWMFXJJcDjPemXLdmbA0OWD8iCIyJH4e/WVVmDUo461+/rr9F9nJXk5uw2cNeK6SCBg4c7TtA==
Received: from VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (10.152.18.51) by VE1EUR03HT205.eop-EUR03.prod.protection.outlook.com
 (10.152.18.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15; Fri, 25 Oct
 2019 10:45:17 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com (10.152.18.59) by
 VE1EUR03FT059.mail.protection.outlook.com (10.152.19.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Fri, 25 Oct 2019 10:45:17 +0000
Received: from VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75]) by VI1PR03MB4814.eurprd03.prod.outlook.com
 ([fe80::a063:1748:6dae:1c75%6]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 10:45:17 +0000
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@outlook.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Topic: qemu crashing when attaching an ISO file to a virtio-scsi CD-ROM
 device through libvirt
Thread-Index: AQHVhfzB7lc3mC9pr0OyFBE/io6S3g==
Date: Fri, 25 Oct 2019 10:45:17 +0000
Message-ID: <VI1PR03MB4814ED579467768D43E5CF94A4650@VI1PR03MB4814.eurprd03.prod.outlook.com>
References: <VI1PR03MB481484C08A04458ACA64F7A0A46C0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <dbb363cf-bc3a-6de5-a62a-1467208d0017@redhat.com>
 <VI1PR03MB4814DBEC71814C520D123ADDA46B0@VI1PR03MB4814.eurprd03.prod.outlook.com>
 <20191025100735.GA7275@localhost.localdomain>
 <VI1PR03MB48140DB2BA084EAEBD980302A4650@VI1PR03MB4814.eurprd03.prod.outlook.com>
In-Reply-To: <VI1PR03MB48140DB2BA084EAEBD980302A4650@VI1PR03MB4814.eurprd03.prod.outlook.c
 om>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0015.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::27)
 To VI1PR03MB4814.eurprd03.prod.outlook.com
 (2603:10a6:803:b7::21)
x-incomingtopheadermarker: OriginalChecksum:AB8C7F67A8B01187E7B8E34680C29F4B04FB0C06099E396CA7134C25AB34B125;
 UpperCasedChecksum:182A492FC5E7DDFC732CDAD74109BC99636409670EB6E45EB26E3025ABE28E80;
 SizeAsReceived:7708; Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: pantheon-mail/1.0.8
x-tmn: [sueqf5rotUbJquENBxX7jQP1y4cEu/V0oh5WwWbJztQ=]
x-microsoft-original-message-id: <1572000314.6067.1@smtp-mail.outlook.com>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: VE1EUR03HT205:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMItrmCc45lKa+iPuX+CunktDyO4/Ra+xB/PlhkoGl1r/11Xn9zJZgv/daMsRhJsfJ0fgnPbboRFGF9nree/uscgwOdWQw+gLzjjE+odGLqlh9X3yCjjWmh4MalXs9VvGLRXQ6IAO0SXg6pgnzENFRok80KNkfRI4FTgiwYSYj6g+egeoMUTiWG1qWzfaBS0
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_VI1PR03MB4814ED579467768D43E5CF94A4650VI1PR03MB4814eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 067ed84a-968a-46a4-b122-08d759386c57
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 10:45:17.2428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT205
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.92.70.89
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_VI1PR03MB4814ED579467768D43E5CF94A4650VI1PR03MB4814eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I managed to upgrade to qemu 4.1 on a test KVM host and I can confirm I can=
't repro the issue in this version.
Great news that is fixed in 4.1.

Thanks everyone for your inputs and the fast replies.

Kind regards,

Fernando

On vie, oct 25, 2019 at 12:28 PM, Fernando Casas Sch=F6ssow <casasfernando@=
outlook.com> wrote:
Thanks for the reply Kevin.

I will do my best to upgrade to 4.1, test again and report back if this is =
fixed or not in that version.
Hopefully it is.

Fernando

On vie, oct 25, 2019 at 12:07 PM, Kevin Wolf <kwolf@redhat.com> wrote:
Am 23.10.2019 um 19:28 hat Fernando Casas Sch=F6ssow geschrieben:
Hi John, Thanks for looking into this. I can quickly repro the problem with=
 qemu 4.0 binary with debugging symbols enabled as I have it available alre=
ady. Doing the same with qemu 4.1 or development head may be too much hassl=
e but if it's really the only way I can give it try.
We had a lot of iothread related fixes in 4.1, so this would really be the =
only way to tell if it's a bug that still exists. I suspect that it's alrea=
dy fixed (and to be more precise, I assume that commit d0ee0204f fixed it).=
 Kevin





--_000_VI1PR03MB4814ED579467768D43E5CF94A4650VI1PR03MB4814eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <F67DCBCE9CC61E4A948062F7E8DAABD1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
I managed to upgrade to qemu 4.1 on a test KVM host and I can confirm I can=
't repro the issue in this version.
<div>Great news that is fixed in 4.1.</div>
<div><br>
</div>
<div>Thanks everyone for your inputs and the fast replies.</div>
<div><br>
</div>
<div>Kind regards,</div>
<div><br>
</div>
<div>Fernando<br>
<div><br>
On vie, oct 25, 2019 at 12:28 PM, Fernando Casas Sch=F6ssow &lt;casasfernan=
do@outlook.com&gt; wrote:<br>
<blockquote type=3D"cite">Thanks for the reply Kevin.
<div><br>
</div>
<div>I will do my best to upgrade to 4.1, test again and report back if thi=
s is fixed or not in that version.</div>
<div>Hopefully it is.</div>
<div><br>
</div>
<div>Fernando</div>
<div><br>
</div>
<div>
<div>On vie, oct 25, 2019 at 12:07 PM, Kevin Wolf &lt;kwolf@redhat.com&gt; =
wrote:<br>
<blockquote type=3D"cite">
<div class=3D"plaintext" style=3D"white-space: pre-wrap;">Am 23.10.2019 um =
19:28 hat Fernando Casas Sch=F6ssow geschrieben:
<blockquote>Hi John, Thanks for looking into this. I can quickly repro the =
problem with qemu 4.0 binary with debugging symbols enabled as I have it av=
ailable already. Doing the same with qemu 4.1 or development head may be to=
o much hassle but if it's really
 the only way I can give it try. </blockquote>
We had a lot of iothread related fixes in 4.1, so this would really be the =
only way to tell if it's a bug that still exists. I suspect that it's alrea=
dy fixed (and to be more precise, I assume that commit d0ee0204f fixed it).=
 Kevin
</div>
</blockquote>
<br>
<br>
</div>
</div>
</blockquote>
<br>
<br>
</div>
</div>
</body>
</html>

--_000_VI1PR03MB4814ED579467768D43E5CF94A4650VI1PR03MB4814eurp_--

