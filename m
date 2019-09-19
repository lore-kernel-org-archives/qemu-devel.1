Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58011C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 19:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107A821907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 19:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5VukyyGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107A821907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2FO-00057N-5l
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 15:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iB2EL-0004hN-QI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iB2EJ-0003PD-8R
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:36:41 -0400
Received: from mail-eopbgr760133.outbound.protection.outlook.com
 ([40.107.76.133]:25597 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iB2EG-0003NX-21
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:36:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1LrnVoNKDjHETXxMek0lScBdEDmmK1iQ8lFwP94iJ1KSnARffsnprSNXP0Qpo6L5BlBJbW+EniLFbifmdOtwNE9UQ27KzugbzEZXdzCM3XkRwx4RMIqC28WFh0HWONSY0QGgDzAQRadMMj/j4jUSRjj6SposdJiRupPSPLp5z59p30drL0MlzXceLcfc5Xygcez/XzjyTudBphB9eu/p6hNBI1RRixo92xZgux4jBJYhPBMdAy6e7E49/E5W/q5iR/sAWLPwjUzjnJniP5G6LelBlCY/o/2OBbxT4VHbhi+b918ljkkNMi65MYTSGkxm331KaK9pNLvotp2g7Yw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO0H6UD2UfwXcv/vjRCKs+1BrCh5JLfdJi40zaZuKmo=;
 b=U1ZDhLehWZJrc3lJ9i0O8tvHmj7MhD7YNcrReCt+3vtxzOOGkiawMMiR03omSf8K1S+8v+tDE1XMfyBf5sA1QV4Ybr3QCRP2MKccJTspiLJfubI3NVR+huVDOgx0nyVEX39zx4OFANT4FThkGX7TWbhAUSdJoCO2Ad2fxlCgapu0dFMAtcFDCfY4fXifCagYlinQ/2sW4kt1eUBWF01Bn7vLj1SWFvDFhdhD8no5/KYKzamtR3AQ4Fs7Y9pV2PGdXXaImAc4w5PyuJ5YSBJlVjAAvnuV4c7ufp5eevDvzds3d9wmzB6+xWtExqsoE+E2RwXj1dESh4lwUmt4z3eCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO0H6UD2UfwXcv/vjRCKs+1BrCh5JLfdJi40zaZuKmo=;
 b=5VukyyGylrmXy4XaAaSNQUQaRy59BP+C0UKoHFjzyngWLYk4TRTuGx7hsO+Q3O+Y4qjnl6vw7UqDE416HFEcApSKNOQ8vqLNkgGn0K3ZQ3WZYy6vASSFjx3AYKXqA3fxi4nI3n9iAUWha19NzUY7B1Z5Nu4s36iAltZ7Dwfn3xA=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3109.namprd03.prod.outlook.com (10.171.247.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 19:36:32 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 19:36:32 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 13/22] libqtest: make qtest_bufwrite send "atomic"
Thread-Topic: [PATCH v3 13/22] libqtest: make qtest_bufwrite send "atomic"
Thread-Index: AQHVbneLvcrhrDR470+fVESmeJqVGacyz5eAgACLYoCAAAsJgA==
Date: Thu, 19 Sep 2019 19:36:31 +0000
Message-ID: <b416ebcc5d9a0b09a0ad7ef78ba0cd19d13f9f2d.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-14-alxndr@bu.edu>
 <20190919103741.GO3606@stefanha-x1.localdomain>
 <da63050e-73b2-d9ac-112b-75b9a7caa54d@redhat.com>
In-Reply-To: <da63050e-73b2-d9ac-112b-75b9a7caa54d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c19c5a22-c37f-44f5-f047-08d73d38acc2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3109; 
x-ms-traffictypediagnostic: CY4PR03MB3109:
x-microsoft-antispam-prvs: <CY4PR03MB31094B514E670F80FBFFBF1BBA890@CY4PR03MB3109.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(6246003)(75432002)(7736002)(99286004)(6436002)(110136005)(54906003)(76176011)(5660300002)(25786009)(86362001)(256004)(88552002)(71190400001)(4326008)(71200400001)(2906002)(81166006)(81156014)(478600001)(8936002)(8676002)(229853002)(14454004)(66476007)(66066001)(6486002)(36756003)(118296001)(66946007)(66556008)(102836004)(64756008)(66446008)(53546011)(486006)(54896002)(76116006)(236005)(26005)(6512007)(786003)(446003)(105004)(19627405001)(11346002)(14444005)(476003)(6506007)(186003)(6116002)(3846002)(2616005)(316002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3109;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jf4AhiMxEuX4AEWi4ETwzjDzvTtdOJ/N0OvTJihsoCIRXdEV450O+5+QN8rniHhYxHqb2WcPpetVybtR+cDKGi/5n1BXIuoV8h6O4bVllLrnyLfnMisTKZl+0zJVIN0M4A+CrH2N1mro3KqbpshkhIaBbiWTFPZqOLk5MOy3Q8UYvs5cQdIywRM5gqF6cRAoVR/ry8cqatTeaLgEexD+v9DCbFY0ZyzP5l+ygb4UaMhfdGjjkd6ACZ9b2+SCRADY/AVbcsLZbkjL9gEir0OtPolyAc4/QReCyaM/xYQo72ax7ZiJZpFuhenpHVJBrTGqoXpAosv8e0VHmEuSmEQ65/9t0YKr7zwMHz9cf5oOgnaDh8zF3NR/lS4VD7Hj04iBnBJK3ii3YGllt85dGiCGjCqUICbQTrnszDkMlVyxBF0=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_b416ebcc5d9a0b09a0ad7ef78ba0cd19d13f9f2dcamelbuedu_"
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c19c5a22-c37f-44f5-f047-08d73d38acc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 19:36:31.9115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaeCJ6t5rPniD6DVKnIQXdzLn0WHQPHez5kwCDuwRLcX+lOPX5BNLm1VfsSZGKwy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3109
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.76.133
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_b416ebcc5d9a0b09a0ad7ef78ba0cd19d13f9f2dcamelbuedu_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-19 at 14:56 -0400, John Snow wrote:
>
> On 9/19/19 6:37 AM, Stefan Hajnoczi wrote:
> > On Wed, Sep 18, 2019 at 11:19:40PM +0000, Oleinik, Alexander wrote:
> > > When using qtest "in-process" communication, qtest_sendf directly
> > > calls
> > > a function in the server (qtest.c). Combining the contents of the
> > > subsequent socket_sends into the qtest_sendf, makes it so the
> > > server can
> > > immediately handle the command, without building a local buffer
> > > and
> > > waiting for a newline.
> > >
> > > Signed-off-by: Alexander Oleinik <alxndr@bu.edu<mailto:alxndr@bu.edu>=
>
> > > ---
> > >  tests/libqtest.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/tests/libqtest.c b/tests/libqtest.c
> > > index 19feea9e17..d770462869 100644
> > > --- a/tests/libqtest.c
> > > +++ b/tests/libqtest.c
> > > @@ -1086,9 +1086,7 @@ void qtest_bufwrite(QTestState *s, uint64_t
> > > addr, const void *data, size_t size)
> > >      gchar *bdata;
> > >
> > >      bdata =3D g_base64_encode(data, size);
> > > -    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
> > > -    socket_send(s->fd, bdata, strlen(bdata));
> > > -    socket_send(s->fd, "\n", 1);
> > > +    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx %s\n", addr,
> > > size, bdata);
> > >      qtest_rsp(s, 0);
> > >      g_free(bdata);
> > >  }
> > > --
> > > 2.23.0
> >
> > Cc John Snow, who added the b64write command.
> >
> > The downside to doing this is that sprintf-formatting needs to be
> > performed on the entire base64 buffer.  This slows things down
> > slightly
> > and a larger temporary buffer needs to be allocated, but I'm not
> > sure it
> > matters.
> >
>
> *struggles to remember*
>
> I guess I wanted something that had some space savings while
> maintaining
> some semblance of debuggability. This is almost certainly meant for
> AHCI
> tests where it's writing various patterns to large blocks of memory.
>
> I doubt I really measured the performance of it, but it seemed like
> the
> way to go for transferring medium amounts of data at the time via the
> qtest protocol.
>
> Looks like I am the only user of it, still:
>
> tests/ahci-test.c:    qtest_bufwrite(ahci->parent->qts, ptr, tx,
> bufsize);
> tests/ahci-test.c:    qtest_bufwrite(ahci->parent->qts, ptr, tx,
> bufsize);
> tests/libqos/ahci.c:        qtest_bufwrite(ahci->parent->qts, ptr,
> buffer, bufsize);
>
> The buffers can be quite large, so you might be re-buffering a decent
> amount of data from the sender now.
>
> 1, Are large transfers like this guaranteed to be atomic anyway? What
> kind of socket is it? we're probably eclipsing frame and packet sizes
> here.
>
> 2, I am not sure what being "atomic" affords us in terms of allowing
> the server to not wait for newlines, how does this change help?
>
> --js

I'm modifying qtest to allow the server and client to co-exist within
the same process (facilitating coverage-guided fuzzing). One of the
modifications is making qtest_sendf directly call a function in
qtest.c. All the other qtest commands are sent with a single
qtest_sendf call, so the qtest.c function could immediately call
qtest_process_command. This breaks if the command is sent with
different qtest_send/socket_send calls, as in b64write.

It should be simple to change qtest_server_inproc_recv (the qtest.c receive=
r) to wait for an "\n" prior to qtest_process_command, so I will probably d=
o that and then normal(socket) qtest will keep the memory-reduction benefit=
s of the non-"atomic" approach.

As a side note, would qtest_memwrite, also benefit from splitting up the se=
nd command?

    for (i =3D 0; i < size; i++) {
        sprintf(&enc[i * 2], "%02x", ptr[i]);
    }

    qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
    qtest_rsp(s, 0);
    g_free(enc);

--_000_b416ebcc5d9a0b09a0ad7ef78ba0cd19d13f9f2dcamelbuedu_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <BE7C6515F6057944BB83864651BD2822@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"" style=3D"width:71ch">On Thu, 2019-09-19 at 14:56 -0400, Joh=
n Snow wrote:</div>
<blockquote type=3D"cite" style=3D"padding: 0ex; margin: 0ex; color: rgb(11=
5, 115, 115) !important;">
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>On 9/19/19 6:37 AM, Stefan Hajnoczi wrote:</div>
<blockquote type=3D"cite" style=3D"padding: 0ex; margin: 0ex; color: rgb(11=
5, 115, 115) !important;">
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>On Wed, Sep 18, 2019 at 11:19:40PM &#43;0000, Oleinik, Alexan=
der wrote:</div>
<blockquote type=3D"cite" style=3D"padding: 0ex; margin: 0ex; color: rgb(11=
5, 115, 115) !important;">
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>When using qtest &quot;in-process&quot; communication, qtest_=
sendf directly<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>calls</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>a function in the server (qtest.c). Combining the contents of=
 the</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>subsequent socket_sends into the qtest_sendf, makes it so the=
<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>server can</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>immediately handle the command, without building a local buff=
er<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>and</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>waiting for a newline.</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>Signed-off-by: Alexander Oleinik &lt;<a href=3D"mailto:alxndr=
@bu.edu" style=3D"color: rgb(141, 141, 141);">alxndr@bu.edu</a>&gt;</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>---</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;tests/libqtest.c | 4 &#43;---</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;1 file changed, 1 insertion(&#43;), 3 deletions(-)</div=
>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>diff --git a/tests/libqtest.c b/tests/libqtest.c</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>index 19feea9e17..d770462869 100644</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>--- a/tests/libqtest.c</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&#43;&#43;&#43; b/tests/libqtest.c</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>@@ -1086,9 &#43;1086,7 @@ void qtest_bufwrite(QTestState *s, =
uint64_t<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>addr, const void *data, size_t size)</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gchar *bdata;</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bdata =3D g_base64_encode(data,=
 size);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>-&nbsp;&nbsp;&nbsp;&nbsp;qtest_sendf(s, &quot;b64write 0x%&qu=
ot; PRIx64 &quot; 0x%zx &quot;, addr, size);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>-&nbsp;&nbsp;&nbsp;&nbsp;socket_send(s-&gt;fd, bdata, strlen(=
bdata));</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>-&nbsp;&nbsp;&nbsp;&nbsp;socket_send(s-&gt;fd, &quot;\n&quot;=
, 1);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&#43;&nbsp;&nbsp;&nbsp;&nbsp;qtest_sendf(s, &quot;b64write 0x=
%&quot; PRIx64 &quot; 0x%zx %s\n&quot;, addr,<span></span><br class=3D"-x-e=
vo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>size, bdata);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qtest_rsp(s, 0);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g_free(bdata);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>&nbsp;}</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>--&nbsp;</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);color: rgb(138, 226, 52);">&gt;
</span></span>2.23.0</div>
</blockquote>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>Cc John Snow, who added the b64write command.</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>The downside to doing this is that sprintf-formatting needs t=
o be</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>performed on the entire base64 buffer.&nbsp;&nbsp;This slows =
things down<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>slightly</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>and a larger temporary buffer needs to be allocated, but I'm =
not<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>sure it</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span>matters.</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span><span class=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159,=
 207);color: rgb(173, 127, 168);">&gt;
</span></span><br>
</div>
</blockquote>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>*struggles to remember*</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>I guess I wanted something that had some space savings while<=
span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span></span>maintaining</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>some semblance of debuggability. This is almost certainly mea=
nt for<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span></span>AHCI</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>tests where it's writing various patterns to large blocks of =
memory.</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>I doubt I really measured the performance of it, but it seeme=
d like<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span></span>the</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>way to go for transferring medium amounts of data at the time=
 via the</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>qtest protocol.</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>Looks like I am the only user of it, still:</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>tests/ahci-test.c:&nbsp;&nbsp;&nbsp;&nbsp;qtest_bufwrite(ahci=
-&gt;parent-&gt;qts, ptr, tx,<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span></span>bufsize);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>tests/ahci-test.c:&nbsp;&nbsp;&nbsp;&nbsp;qtest_bufwrite(ahci=
-&gt;parent-&gt;qts, ptr, tx,<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span></span>bufsize);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>tests/libqos/ahci.c:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;qtest_bufwrite(ahci-&gt;parent-&gt;qts, ptr,</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>buffer, bufsize);</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>The buffers can be quite large, so you might be re-buffering =
a decent</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>amount of data from the sender now.</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>1, Are large transfers like this guaranteed to be atomic anyw=
ay? What</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>kind of socket is it? we're probably eclipsing frame and pack=
et sizes<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span></span>here.</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>2, I am not sure what being &quot;atomic&quot; affords us in =
terms of allowing<span></span><br class=3D"-x-evo-wrap-br">
<span class=3D"-x-evo-quoted"><span class=3D"-x-evo-quote-character" style=
=3D"color: rgb(114, 159, 207);">&gt;
</span></span>the server to not wait for newlines, how does this change hel=
p?</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span><br>
</div>
<div class=3D"" style=3D"width:71ch"><span class=3D"-x-evo-quoted"><span cl=
ass=3D"-x-evo-quote-character" style=3D"color: rgb(114, 159, 207);">&gt;
</span></span>--js</div>
</blockquote>
<div class=3D"" style=3D"width:71ch"><br>
</div>
<div class=3D"" style=3D"width:71ch">I'm modifying qtest to allow the serve=
r and client to co-exist within<span></span><br class=3D"-x-evo-wrap-br">
the same process (facilitating coverage-guided fuzzing). One of the<span></=
span><br class=3D"-x-evo-wrap-br">
modifications is making qtest_sendf directly call a function in<span></span=
><br class=3D"-x-evo-wrap-br">
qtest.c. All the other qtest commands are sent with a single<span></span><b=
r class=3D"-x-evo-wrap-br">
qtest_sendf call, so the qtest.c function could immediately call<span></spa=
n><br class=3D"-x-evo-wrap-br">
qtest_process_command. This breaks if the command is sent with<span></span>=
<br class=3D"-x-evo-wrap-br">
different qtest_send/socket_send calls, as in b64write.</div>
<div class=3D"" style=3D"width:71ch"><br>
</div>
<div class=3D"" style=3D"width:71ch">It should be simple to change qtest_se=
rver_inproc_recv (the qtest.c receiver) to wait for an &quot;\n&quot; prior=
 to qtest_process_command, so I will probably do that and then normal(socke=
t) qtest will keep the memory-reduction benefits
 of the non-&quot;atomic&quot; approach. </div>
<div class=3D"" style=3D"width:71ch"><br>
</div>
<div class=3D"" style=3D"width:71ch">As a side note, would qtest_memwrite, =
also benefit from splitting up
<span id=3D"-x-evo-selection-start-marker"></span><span id=3D"-x-evo-select=
ion-end-marker"></span>the send command?</div>
<div class=3D"" style=3D"width:71ch"><br>
</div>
<div class=3D"" style=3D"width:71ch">&nbsp;&nbsp;&nbsp;&nbsp;for (i =3D 0; =
i &lt; size; i&#43;&#43;) {</div>
<div class=3D"" style=3D"width:71ch">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;sprintf(&amp;enc[i * 2], &quot;%02x&quot;, ptr[i]);</div>
<div class=3D"" style=3D"width:71ch">&nbsp;&nbsp;&nbsp;&nbsp;}</div>
<div class=3D"" style=3D"width:71ch"><br>
</div>
<div class=3D"" style=3D"width:71ch">&nbsp;&nbsp;&nbsp;&nbsp;qtest_sendf(s,=
 &quot;write 0x%&quot; PRIx64 &quot; 0x%zx 0x%s\n&quot;, addr, size, enc);<=
/div>
<div class=3D"" style=3D"width:71ch">&nbsp;&nbsp;&nbsp;&nbsp;qtest_rsp(s, 0=
);</div>
<div class=3D"" style=3D"width:71ch">&nbsp;&nbsp;&nbsp;&nbsp;g_free(enc);</=
div>
<div class=3D"" style=3D"width:71ch"></div>
<div class=3D"" style=3D"width:71ch"></div>
<div class=3D"-x-evo-signature-wrapper"><span class=3D"-x-evo-signature" id=
=3D"none"></span></div>
</body>
</html>

--_000_b416ebcc5d9a0b09a0ad7ef78ba0cd19d13f9f2dcamelbuedu_--

