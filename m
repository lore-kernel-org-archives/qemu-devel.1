Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E165C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BFF22527
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 22:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FV2f2glo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BFF22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwCqF-0006KN-5G
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 17:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robhenry@microsoft.com>) id 1iwCpJ-0005k7-W2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robhenry@microsoft.com>) id 1iwCpH-00055J-J2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:25:49 -0500
Received: from mail-dm6nam10on2111.outbound.protection.outlook.com
 ([40.107.93.111]:22045 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <robhenry@microsoft.com>)
 id 1iwCpH-00054k-33
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 17:25:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E70819qXZxZgNr4vhi/hOnB0XdIDSD8aJc5Mb6ubEwcIDQURvU/Ii6yXo2NxgIuP0E2LybUUQdLJNLyeCsf0O/AZjY03zE+YBhWcNBn4XXVyp4cdcP2JJNCRX3F9Y4KO7W+O0ERwzs891M2H68qrOcn135JO2983y83jqAeVty8aIEzUFqtB18do7lrSVx7u6psujhEf3VJtl6yLSYnOU/W5Cw+ClPNGteR9AQ+/isJkFfnzTbrb5Bqm1z9B2Aa7gW5mfUxzPGV7vZuTQfZZXV1joBOhQUFQR8iP8Z7ovagMqeIYaPv0OrXSfnxHOEOJeYy00W0KynND/s0jPeKOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=636T/OpFve6ORMjiOoTq98qRT6B4CcsMCdohZbHBkBg=;
 b=JcwFUXDEoUUCWeL8ujLWhxn+zPtR93m0c+d4i95lfeR02fcsS4k7y7IGJmILurpyZj9fbeANt93t9kgyMND5bDzbPJIUsdsFekhcTnFTV8kh/cUKm5EQr6JmNI3OwZ4sSEmKbJxsqbqm1sv0iPMF9DLsq1yFn9cxXOgXJB0HMgzaSiozFKn4oRI29QX+M0NCzxcCZ8PDstlyrbHJh/XPvs280SgwoD2eUu9DCTLMAkIntDWAyDb4/+F9X49LyHn9NOpoDjqm0R84cxEkdmm5oCCPZPGw0rOn4bJYrCXYL6xDtR3+0gGsjf5PI5xPop/1lBKIMWFMpJWP5tGSwKOrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=636T/OpFve6ORMjiOoTq98qRT6B4CcsMCdohZbHBkBg=;
 b=FV2f2glovhpqZpVE8wMMqB/RfUfDq1KBqWfWPC+n7nQiEGcoZYBJGDNP6maJvKUn7H7nQXGkDEowxysseiJ1oeX4RicREEAI5MLd/DeyIWeRV9ek4FxF8i8Y1oDAyDmJCuUvtzGa2YqnqWIwqR56K+OXB1dkHPkUk0KcV++SHis=
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com (52.132.20.149) by
 BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.4; Mon, 27 Jan 2020 22:25:44 +0000
Received: from BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4]) by BL0PR2101MB1026.namprd21.prod.outlook.com
 ([fe80::acbf:dcfe:4658:e7d4%5]) with mapi id 15.20.2707.003; Mon, 27 Jan 2020
 22:25:44 +0000
From: Robert Henry <robhenry@microsoft.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: Laurent Desnogues <laurent.desnogues@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail basic
 consistency checks
Thread-Topic: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail basic
 consistency checks
Thread-Index: AQHV0k8E/OZrWdWsYkuV7phGRZSNIaf6BEuAgAAUvGKAAB/VAIAE4oNu
Date: Mon, 27 Jan 2020 22:25:44 +0000
Message-ID: <BL0PR2101MB1026788A4BAC4B40D6EE43ACD60B0@BL0PR2101MB1026.namprd21.prod.outlook.com>
References: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <87eevoak12.fsf@linaro.org>
 <BL0PR2101MB10265432576D6FF63AFA2282D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>,
 <8736c4abbh.fsf@linaro.org>
In-Reply-To: <8736c4abbh.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-27T22:25:43.515Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robhenry@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:b137:ca9d:7874:57dd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70b19434-9660-4982-c803-08d7a377d9b9
x-ms-traffictypediagnostic: BL0PR2101MB1123:
x-microsoft-antispam-prvs: <BL0PR2101MB1123A8B4B3F205787B6B5AF0D60B0@BL0PR2101MB1123.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(5660300002)(186003)(8990500004)(8676002)(81166006)(81156014)(66574012)(6916009)(71200400001)(19627405001)(52536014)(8936002)(316002)(76116006)(91956017)(86362001)(54906003)(7696005)(64756008)(10290500003)(66446008)(55016002)(2906002)(9686003)(6506007)(33656002)(4326008)(478600001)(53546011)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB1123;
 H:BL0PR2101MB1026.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HeQ2TEkvCHuIOKmqrJwKKkkfTmUD0dODMzdHTnxpu7RqE4wD+UvUjhc9+xRtBQdkirJCwO39YCLnMSkUwo8FirfQHeITWat/QCowUIi5sMgU1ZktcHYSJEHKjzJJWHsgMitKnQBb6M3n7PRNc4s3Eb6PBkcYqIr0uR9DzXk9OAulh7zv3YC0VVKS8pK5JcVGbIw0XdNXfm/e94daEPrAR7IJnMvz9Pjc347TzBlvFTLy7useZwEpp6tNujsqZbnzJ0Hvq9v1LqY7R5L5zYmfEoOhQ77JUu/f0DWfu/VA26hA4imOoUaoozb5QhcKtbUhyDdlu9f9zmcNntSRlAmG21E/r81VxanXjiKPX/QOJV8/x50wm9AslvrJpwoyrPFlnMpdnmNw2Zf5HK5ZaqrvwMMuhn1TbXZ8ag4D+2dbYw/Sjp9aH2DbbQiANs4I+XMa
x-ms-exchange-antispam-messagedata: 9P9mIGfvcZ+bjXo5oqMFyStuZZBtOSweHqnyhKdFXN4jCZ6bzE5TSw9wJ4tfVJKnLv/4PgT6RGEfihymc3GyBOMVXNVb5ZDLCZtlCZuzc+4fGgKbw29jugmAyW3AmeZWwfX2o9Jk8ft610j4U5n/4x5v8ft3nMJxHNMvU/y37NA2/uq5Be+K70y64LWj9VIGHTkqdQzlRYKSWyjvjYAbFg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1026788A4BAC4B40D6EE43ACD60B0BL0PR2101MB1026_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b19434-9660-4982-c803-08d7a377d9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 22:25:44.0455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffF7DwPGrJZiLoZMWcd8hQzWwuh/vHZ0fe8ljRVtMYO1vqXSxR1aA+OEkK2jFctc0sUIB8mxRCat9mmKTaOlQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1123
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.111
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BL0PR2101MB1026788A4BAC4B40D6EE43ACD60B0BL0PR2101MB1026_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This proposed text sounds good. Better English is to say "concepts" rather =
than "conceptions".

My plugin currently allocates its own unique user data structure on every c=
all to the instrumentation-time callback.  This piece of user data captures=
 the transient data presented from qemu.   What's missing from the interfac=
e is a callback when qemu can guarantee that the run-time callback will nev=
er be called again with this piece of user data.  At that point I would fre=
e my piece of user data.

I'm not too worried about this memory loss, yet.  I ran ubuntu for 3 days o=
n qemu+plugins and only observed a tolerable growth in qemu's memory consum=
ption.
________________________________
From: Alex Benn=E9e <alex.bennee@linaro.org>
Sent: Friday, January 24, 2020 11:44 AM
To: Robert Henry <robhenry@microsoft.com>
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>; qemu-devel@nongnu.org =
<qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail bas=
ic consistency checks


Robert Henry <robhenry@microsoft.com> writes:

> I found at least one problem with my plugin.
>
> I was assuming that the insn data from
>       struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
> could be passed into qemu_plugin_register_vcpu_insn_exec_cb both as the 1=
st argument AND as the user data last argument.  This assumed that insn wou=
ld persist and be unique from when qemu_plugin_register_vcpu_insn_exec_cb w=
as called to when the execution-time callback (vcpu_insn_exec_before) was c=
alled.
>
> This assumption is not true.
>
> I now capture pieces of *insn into my own persistent data structure, and =
pass that in as void *udata, my problems went away.
>
> I think this lack of persistence of insn should be documented, or
> treated as a bug to be fixed.

I thought I had done this but it turns out I only mentioned it for
hwaddr:

  /*
   * qemu_plugin_get_hwaddr():
   * @vaddr: the virtual address of the memory operation
   *
   * For system emulation returns a qemu_plugin_hwaddr handle to query
   * details about the actual physical address backing the virtual
   * address. For linux-user guests it just returns NULL.
   *
   * This handle is *only* valid for the duration of the callback. Any
   * information about the handle should be recovered before the
   * callback returns.
   */

But the concept of handle lifetime is true for all the handles. I
propose something like this for the docs:


--8<---------------cut here---------------start------------->8---
docs/devel: document query handle lifetimes

I forgot to document the lifetime of handles in the developer
documentation. Do so now.

Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

1 file changed, 11 insertions(+), 2 deletions(-)
docs/devel/tcg-plugins.rst | 13 +++++++++++--

modified   docs/devel/tcg-plugins.rst
@@ -51,8 +51,17 @@ about how QEMU's translation works to the plugins. While=
 there are
 conceptions such as translation time and translation blocks the
 details are opaque to plugins. The plugin is able to query select
 details of instructions and system configuration only through the
-exported *qemu_plugin* functions. The types used to describe
-instructions and events are opaque to the plugins themselves.
+exported *qemu_plugin* functions.
+
+Query Handle Lifetime
+---------------------
+
+Each callback provides an opaque anonymous information handle which
+can usually be further queried to find out information about a
+translation, instruction or operation. The handles themselves are only
+valid during the lifetime of the callback so it is important that any
+information that is needed is extracted during the callback and saved
+by the plugin.

 Usage
 =3D=3D=3D=3D=3D

--8<---------------cut here---------------end--------------->8---

--
Alex Benn=E9e

--_000_BL0PR2101MB1026788A4BAC4B40D6EE43ACD60B0BL0PR2101MB1026_
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
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
This proposed text sounds good. Better English is to say &quot;concepts&quo=
t; rather than &quot;conceptions&quot;.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
My plugin currently allocates its own unique user data structure on every c=
all to the instrumentation-time callback.&nbsp; This piece of user data cap=
tures the transient data presented from qemu.&nbsp; &nbsp;What's missing fr=
om the interface is a callback when qemu can guarantee
 that the run-time callback will never be called again with this piece of u=
ser data.&nbsp; At that point I would free my piece of user data.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" spellcheck=3D"false">
I'm not too worried about this memory loss, yet.&nbsp; I ran ubuntu for 3 d=
ays on qemu&#43;plugins and only observed a tolerable growth in qemu's memo=
ry consumption.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Benn=E9e &lt;ale=
x.bennee@linaro.org&gt;<br>
<b>Sent:</b> Friday, January 24, 2020 11:44 AM<br>
<b>To:</b> Robert Henry &lt;robhenry@microsoft.com&gt;<br>
<b>Cc:</b> Laurent Desnogues &lt;laurent.desnogues@gmail.com&gt;; qemu-deve=
l@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to f=
ail basic consistency checks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
Robert Henry &lt;robhenry@microsoft.com&gt; writes:<br>
<br>
&gt; I found at least one problem with my plugin.<br>
&gt;<br>
&gt; I was assuming that the insn data from<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qemu_plugin_insn *insn =3D =
qemu_plugin_tb_get_insn(tb, i);<br>
&gt; could be passed into qemu_plugin_register_vcpu_insn_exec_cb both as th=
e 1st argument AND as the user data last argument.&nbsp; This assumed that =
insn would persist and be unique from when qemu_plugin_register_vcpu_insn_e=
xec_cb was called to when the execution-time
 callback (vcpu_insn_exec_before) was called.<br>
&gt;<br>
&gt; This assumption is not true.<br>
&gt;<br>
&gt; I now capture pieces of *insn into my own persistent data structure, a=
nd pass that in as void *udata, my problems went away.<br>
&gt;<br>
&gt; I think this lack of persistence of insn should be documented, or<br>
&gt; treated as a bug to be fixed.<br>
<br>
I thought I had done this but it turns out I only mentioned it for<br>
hwaddr:<br>
<br>
&nbsp; /*<br>
&nbsp;&nbsp; * qemu_plugin_get_hwaddr():<br>
&nbsp;&nbsp; * @vaddr: the virtual address of the memory operation<br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * For system emulation returns a qemu_plugin_hwaddr handle to =
query<br>
&nbsp;&nbsp; * details about the actual physical address backing the virtua=
l<br>
&nbsp;&nbsp; * address. For linux-user guests it just returns NULL.<br>
&nbsp;&nbsp; *<br>
&nbsp;&nbsp; * This handle is *only* valid for the duration of the callback=
. Any<br>
&nbsp;&nbsp; * information about the handle should be recovered before the<=
br>
&nbsp;&nbsp; * callback returns.<br>
&nbsp;&nbsp; */<br>
<br>
But the concept of handle lifetime is true for all the handles. I<br>
propose something like this for the docs:<br>
<br>
<br>
--8&lt;---------------cut here---------------start-------------&gt;8---<br>
docs/devel: document query handle lifetimes<br>
<br>
I forgot to document the lifetime of handles in the developer<br>
documentation. Do so now.<br>
<br>
Signed-off-by: Alex Benn=E9e &lt;alex.bennee@linaro.org&gt;<br>
<br>
1 file changed, 11 insertions(&#43;), 2 deletions(-)<br>
docs/devel/tcg-plugins.rst | 13 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;--<br>
<br>
modified&nbsp;&nbsp; docs/devel/tcg-plugins.rst<br>
@@ -51,8 &#43;51,17 @@ about how QEMU's translation works to the plugins. W=
hile there are<br>
&nbsp;conceptions such as translation time and translation blocks the<br>
&nbsp;details are opaque to plugins. The plugin is able to query select<br>
&nbsp;details of instructions and system configuration only through the<br>
-exported *qemu_plugin* functions. The types used to describe<br>
-instructions and events are opaque to the plugins themselves.<br>
&#43;exported *qemu_plugin* functions.<br>
&#43;<br>
&#43;Query Handle Lifetime<br>
&#43;---------------------<br>
&#43;<br>
&#43;Each callback provides an opaque anonymous information handle which<br=
>
&#43;can usually be further queried to find out information about a<br>
&#43;translation, instruction or operation. The handles themselves are only=
<br>
&#43;valid during the lifetime of the callback so it is important that any<=
br>
&#43;information that is needed is extracted during the callback and saved<=
br>
&#43;by the plugin.<br>
&nbsp;<br>
&nbsp;Usage<br>
&nbsp;=3D=3D=3D=3D=3D<br>
<br>
--8&lt;---------------cut here---------------end---------------&gt;8---<br>
<br>
-- <br>
Alex Benn=E9e<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL0PR2101MB1026788A4BAC4B40D6EE43ACD60B0BL0PR2101MB1026_--

