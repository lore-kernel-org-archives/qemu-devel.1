Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D18EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEAD20772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r2u2mx9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEAD20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhA1G-0005OV-3c
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhA04-0004PA-MI; Fri, 05 Jun 2020 06:55:00 -0400
Received: from mail-eopbgr130115.outbound.protection.outlook.com
 ([40.107.13.115]:15511 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhA03-0004qN-68; Fri, 05 Jun 2020 06:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5blhVQ2QkVykYyM/XKJ57oi6/RneiavTJLJWPsBB8vb6HT+VnZryVXZNP2/JGr8Bg+Bu7Fz4ohZiG0r8V/GZysc85jabFaJhppeUCERPDRX2mC+SBCb1I6tlcz93n9l8scZlNz4zoYcfa/nHb+MlxqLjGLzYBWhHLyjejhh+u5YBFUBxUJzD8YmHcW1Y8OAW71tDsFaK3W4e68WEQeQtAFiOf4eFQpTBePxtscFR0fsI1Xw7ioxH7FvD5z6+bz2ASWwrT8Nehh6B+RNRzee8GFMhOBl3QJ+DtNJzeC8BBwXsORF7qNqoU8uqYXf89mS2EIjjkn66xh3rFoGgb43Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FX+K597d4xdCmcikn3j7d+o4kwJTKDZIj2Nwuwhb3k=;
 b=i8KO1t/bQ789n5J5N7E0JARMfwGLnRRNIuJx13HRyQmPZvhMP/hTld5k/peeWVNFd7HUNhnHTP2+DAJtZKA8OhUbw1waHlgY3ko4vNa0jNBrtncBi52ev6c0Ymgc7xPXAlHp7VUooB43b/6Irbq2l+a8pcoj3mEhiVBtBayQzN1KPJ/xJ6MZB6Z47c1X3bgJul5n6FpLHX2NfTRbo5HFMPG4deOZRTVGWj9cR6RiOhLlxDFdXY8DLfRWlOnzshH6O1ad1iowINwP6IMwXImfUspHavKKrq0CbAIEplU5DAK45VqpOpvImmGMhcrfRdINeWricxwsgvnbKsYLK+c3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FX+K597d4xdCmcikn3j7d+o4kwJTKDZIj2Nwuwhb3k=;
 b=r2u2mx9Ig3jzcthQ7ogHhZ3TF2zrtGPcmw2Cv6N2A+71VDOPlhiOw9bGFvqWxSTf6E9187ZKtGRtt40s6Fk3KquL9zVn1DGBL53yE6JL+mF0sp3Vsv5v6P+VzITKZhn4NU97+xENwlUV2XSzQOuek0KGmkyALjwPAqBqIiD3VyY=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3063.eurprd08.prod.outlook.com (2603:10a6:209:46::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 10:54:55 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 10:54:55 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 03/12] qcow2_format.py: drop new line printing at end
 of dump()
Thread-Topic: [PATCH v4 03/12] qcow2_format.py: drop new line printing at end
 of dump()
Thread-Index: AQHWOpdv+JAchzSfdk21HqfdH8ki6KjJ2iv7
Date: Fri, 5 Jun 2020 10:54:55 +0000
Message-ID: <AM6PR08MB4070EFB77CC427D4FC3DC68EF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-4-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-4-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d38eea92-c366-47ef-3d8f-08d8093ee1fe
x-ms-traffictypediagnostic: AM6PR08MB3063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB30638B8F18F121DD07E9A16BF4860@AM6PR08MB3063.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HR6GUTJvNLDmd5OUtvK14zqK4bjIUwcUPJzlvtQPQeRJBT6FhGMXPv+MwwvErAdM+SeV4BEPj44Ywk3HQGaY0OV6DqYyOeaYhO9Likp9VfFCOq4EsojYrO+BTS820CX6IOaEw3Ex0dYh3uk2hKZ+qgHmhB2Tz1x0NDqtNH5POlJfzQLNSm+oW9BXbVcQHJF74jlCe0Uy0Dz5in976gQmpbI9AxBRZAser90B3vIoU3JeQ22felhyIcozCEuOTu4z88VFAXs6QiosprBPEJ+OdO0RO4VW0MWYH2JkINWXHmsRZE3huNanTrIMZ+D0etrXXVloHfIknmP0PXndWMBpVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(396003)(376002)(346002)(66556008)(64756008)(110136005)(83380400001)(71200400001)(76116006)(9686003)(186003)(8676002)(91956017)(8936002)(54906003)(66476007)(86362001)(107886003)(33656002)(4326008)(316002)(7696005)(66446008)(52536014)(55016002)(2906002)(26005)(478600001)(53546011)(5660300002)(44832011)(66946007)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: jomWfynJkucaRry26CKqsW5wxiu/vsK0cT0XZk9EgVwUX6Lm3YCqJGEWPCq2a3XLhd1ujNfXVG/wDTM73naN71kwW00Uc1RfQRi/eK8205v1FTzGQ+YqjtE5wd5O2b8Thn5syMOmyCjX0Y7O0BspANJ9YYH0YBWM6SvlVCZIwaha/BHot7bY4zOsu0FumBfFqcnIwv/EL5rMsLmI1zhQ/O/TT4Sh7JRaFD7SQavex9KSMuBDZZ8cQR/4pw83szI/iFKBU3K36A2f6RqaQrr+1TwseeMVQrhYwo3U1WGJtcPSrY557eRzkX8GfGDqD2mz/SyhkfLj3ASHsZ0BkyHLqJmMzvAs603UKBQ81g8W5l9PtwuVmGTHtpgRd3mrUChy+wHTf8Cigy9nqPvdbwVuuNvAiQc49fAhgk9ab+fSuFrlgk/rNm09L4jl73uxMQ1J2yi+j2IqVh7hAs8p6X1VldlFEvisAbz2NDWjXVSBPi0mGpFISUc58TBiQ5wn3fGq
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070EFB77CC427D4FC3DC68EF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38eea92-c366-47ef-3d8f-08d8093ee1fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 10:54:55.6653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V29+l2pZqZwJ/dTfSmm6V0faJhmM7S1oBlhfMeyn8UXLQQ5Evr4nsL4Gp977MV13gmNrlbszn3hu6dcIs4GW6wp1lVNbXyEo41io4NSrG6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3063
Received-SPF: pass client-ip=40.107.13.115;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 06:54:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB4070EFB77CC427D4FC3DC68EF4860AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Thursday, June 4, 2020 8:41 PM
To: qemu-block@nongnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; mreitz@redhat.com <mreit=
z@redhat.com>; kwolf@redhat.com <kwolf@redhat.com>; eblake@redhat.com <ebla=
ke@redhat.com>; Denis Lunev <den@virtuozzo.com>; Vladimir Sementsov-Ogievsk=
iy <vsementsov@virtuozzo.com>; Andrey Shinkevich <andrey.shinkevich@virtuoz=
zo.com>
Subject: [PATCH v4 03/12] qcow2_format.py: drop new line printing at end of=
 dump()

This will simplify further conversion. To compensate, print this empty
line directly in cmd_dump_header().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py        | 1 +
 tests/qemu-iotests/qcow2_format.py | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index d9c41668fd..79db81b040 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -10,6 +10,7 @@ from qcow2_format import (
 def cmd_dump_header(fd):
     h =3D QcowHeader(fd)
     h.dump()
+    print()
     h.dump_extensions()


diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py
index c7270a0a6e..99e5248e73 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -139,7 +139,6 @@ class QcowHeader:
                 value_str =3D f[1] % value

             print("%-25s" % f[2], value_str)
-        print("")

     def dump_extensions(self):
         for ex in self.extensions:
--
2.21.0


--_000_AM6PR08MB4070EFB77CC427D4FC3DC68EF4860AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div><span style=3D"color: rgb(33, 33, 33); font-family: &quot;Segoe UI Wes=
tEuropean&quot;, &quot;Segoe UI&quot;, Helvetica, Arial, sans-serif; font-s=
ize: 14.6667px; font-style: normal; font-variant-ligatures: normal; font-va=
riant-caps: normal; font-weight: 400;">Reviewed-by: Andrey
 Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;</span><br>
</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Thursday, June 4, 2020 8:41 PM<br>
<b>To:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; mreitz@redh=
at.com &lt;mreitz@redhat.com&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;=
; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozz=
o.com&gt;; Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;;
 Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;<br>
<b>Subject:</b> [PATCH v4 03/12] qcow2_format.py: drop new line printing at=
 end of dump()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This will simplify further conversion. To compensa=
te, print this empty<br>
line directly in cmd_dump_header().<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2.py&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 1 &#43;<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 1 -<br>
&nbsp;2 files changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py<br>
index d9c41668fd..79db81b040 100755<br>
--- a/tests/qemu-iotests/qcow2.py<br>
&#43;&#43;&#43; b/tests/qemu-iotests/qcow2.py<br>
@@ -10,6 &#43;10,7 @@ from qcow2_format import (<br>
&nbsp;def cmd_dump_header(fd):<br>
&nbsp;&nbsp;&nbsp;&nbsp; h =3D QcowHeader(fd)<br>
&nbsp;&nbsp;&nbsp;&nbsp; h.dump()<br>
&#43;&nbsp;&nbsp;&nbsp; print()<br>
&nbsp;&nbsp;&nbsp;&nbsp; h.dump_extensions()<br>
&nbsp;<br>
&nbsp;<br>
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py<br>
index c7270a0a6e..99e5248e73 100644<br>
--- a/tests/qemu-iotests/qcow2_format.py<br>
&#43;&#43;&#43; b/tests/qemu-iotests/qcow2_format.py<br>
@@ -139,7 &#43;139,6 @@ class QcowHeader:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; value_str =3D f[1] % value<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr=
int(&quot;%-25s&quot; % f[2], value_str)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print(&quot;&quot;)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; def dump_extensions(self):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for ex in self.extensions:=
<br>
-- <br>
2.21.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070EFB77CC427D4FC3DC68EF4860AM6PR08MB4070eurp_--

