Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC60C28CBC
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D3B207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 03:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LFM26Eme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D3B207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jULza-0006KK-RT
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 23:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jULyq-0005bm-AL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jULyp-0007PF-PD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 23:04:48 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:15219 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jULym-00075z-Mj; Thu, 30 Apr 2020 23:04:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8cox28/Mq0m5DpsqLJ8qrTgmJcNR7s/PibddCM15sdYxpfP7NTw30dyWZY94CcidiH39Oqixvnwoh6WxAxNmgevCzfWOSFLD3LrRMaKIWjDr3at0C3EFMV3sB7KkamhimmjxfMKuF9FIyy1ogbXCT6S9iiaEddo8JLHIy8kDTUtCJuV6dXRBPsL/hdQiVxE6+g9Cq9LsPyn8+wXr3XTutDdTOAaZKZOTiUkHlBIfxQOO9utrAiXQQNGS58SF2+iCXTvUhbcTMxDz3MeBPuBZwbYj+kK6P4b42tuHhcXT4lhmbUUPuVVEh2Zh48VVf7qXKVHKff1yqUHu9+O7mYvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/OkhOpPVcZHbpyUvwIPzheBTGIM5XIiSCFJzj/uKJo=;
 b=NSmNe4K/LUQt7BUgMpT1XwriTDMzTHkLiGbYLmShWhoA9c1zjjB88jdosNHmDoY9mLCRdzjZoBvFY4J4PIS0Js1k3Z6NpSk7ZT10UKfsqQd3KxDPKEfNii6XsXygqGX3rf/t5ByPtu8re89tb/qhWl3XGs9DGizmYQJeSl0ew2uTnuzpl4ZWqwq6ew3kSOplGwzgESYgdfX32rrjYlB0Ombl1bAcvNw/d0PW7Sc5ZPaJE3EAjQL5PxQuyDepaZEz0MavzB0TObHbJFcT424lb8VhWyvQ5v95eZj72wouwnm/C5f96yj1y+lvYKeX7sU847DO3TEzLcEhcGEUr2m0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/OkhOpPVcZHbpyUvwIPzheBTGIM5XIiSCFJzj/uKJo=;
 b=LFM26EmejidZeHvscCj5pPeBe/aLaCNBRvXDkKZoVeiE1QkkNWA1n4r6ubQug7CHiR3dd1j3KS/9N/9mfbnKlVWFdksED1iW1f0yvsO+oSLPMCgWlQaU/WvnZ8oKAZChfj1RR1kPxB5DthWBUtnVEy9C9HHXQCnPW61Ewm6dwn0=
Received: from VI1PR0802MB2206.eurprd08.prod.outlook.com
 (2603:10a6:800:9b::14) by VI1PR0802MB2461.eurprd08.prod.outlook.com
 (2603:10a6:800:af::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 03:04:39 +0000
Received: from VI1PR0802MB2206.eurprd08.prod.outlook.com
 ([fe80::5143:32f:9e92:487e]) by VI1PR0802MB2206.eurprd08.prod.outlook.com
 ([fe80::5143:32f:9e92:487e%6]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 03:04:38 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz
 <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>
Subject: Re: backing chain & block status & filters
Thread-Topic: backing chain & block status & filters
Thread-Index: AQHWHTrKF3m4/lh9KUS1BIAvNkbR0aiOYCaAgAA+V4CAA222AIAAf+aM
Date: Fri, 1 May 2020 03:04:38 +0000
Message-ID: <VI1PR0802MB22061BC34FBEC5953ADBD50DF4AB0@VI1PR0802MB2206.eurprd08.prod.outlook.com>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>,
 <f1220430-1d37-3cc4-0484-3e26fb7e4b84@virtuozzo.com>
In-Reply-To: <f1220430-1d37-3cc4-0484-3e26fb7e4b84@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [176.59.46.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f07fdf-b64a-4edf-ac38-08d7ed7c62f6
x-ms-traffictypediagnostic: VI1PR0802MB2461:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0802MB2461C26E894A3EDAFD7AD783F4AB0@VI1PR0802MB2461.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0390DB4BDA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AWOkaUdVBMWnyckzMeu8GEwvZ1eywi0YAec3oj+O9OeIWRLqKYM3zIzBs3mfC/pfnt4gcyHCvMtVu21guzhYI+MbTKoaT7B99uL9E8CwPfQaQhoVXI0R1F7+COSwFqgaus1V+cVwB47lrNmVNRnb9kJ8k3Wz1cTEZTLPFSJSNuzzmxKIMpDTgKuGo7+LZOsYAVfzT6Uo4jQRJ+plwIM1xSET4j44APMf9BC8GjNHrvi5hQNZ/jynnrqkqmsupf890arZzN0/Mv9BbttF7B9FGI1HkUUyLS/jtrb2Smp3dZ7rGJ0ucs5pQNNy1r+Zn/INsPBwXgkyIzh9BwwztZOGtYgiFY2kzYOCX/IY0RGCn+/vmyYAVm+NpaSaOZCF/B/jzIExrxQ8F4LWMrPmJoQnFC1Vdx1zI1Yau2foRXhuDGTeP9hV98qIJIqh99ngDXg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0802MB2206.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(366004)(396003)(136003)(54906003)(316002)(478600001)(76116006)(86362001)(6506007)(2906002)(66446008)(110136005)(53546011)(64756008)(66556008)(71200400001)(66946007)(4326008)(66476007)(33656002)(44832011)(52536014)(8676002)(5660300002)(8936002)(186003)(26005)(9686003)(55016002)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZOYOH2DCO4osYdCcIqUXPeBY7BLOlACH5oVrnbxUbczy7Ebf2YndRM8Qetvr9l2MP4vS9CPHQ9JTQvl5rG55jYnzfVfrVL5fgC3Cj+wKUiP3gc43i+DV6germ/3UX/2v7Q2knpDCltYw9WhZWRvUIaj1j3XOq1gnTGk+JOmmyHaN/bsQgq0NnONboKNkTtjkklJI2Yl1LthhBhiqFJJx1SMndGtaq94JxIPnHoM0orGSMfBW4+AuQyjFQ76+WtW8AT8b+q9bpyluGkV2PN+0xdZHM/5I2Bnq6GVi5K3IChpOLYQ3BSMYiWRDpcMFVjsuwJ8GzgK/HC8hr6hAqpkZDIHuUKXRkcqnrkiZVMcwuyydzTt5PtiID5xBOI3tA9ML594sMR7stMRIPHyKVRSypHWmoiF352KYIo46Bkbxz2/PxaJ0OBjc27lUhe71L424PzKZiQSAlfqlKcj5uGLLLyxEJooSwNFFRoxovzKMVwWFfppdGiId4N5/qcc2pb4nwOdktE8dkEYzv0lET3/6S/m0h6XLDWF+Eecs/ye5r+geBR1eV3moRWnkPdOptjWh0n0XwrYMcydLYz9/mJUrojF8GZUFs3apWXZu3oMXSwP/1Dxehb8Z+LCy9Q1ikgx3L999vk/Iuw4UjyldPKNfZ8xLGaa5g09SfbvKYlVL6E76U2SSqbIO82rLGcpbv32P5KtpcZX3zfNJKVczhFQ2YbBFfUFMm+od/5ZjcEjYznzNMz4BSBlJprzF5kBg4Wf+ShSJoLVQGvCD5e6l5mhz04/HggTWwKCakVvFrfO9KLk=
Content-Type: multipart/alternative;
 boundary="_000_VI1PR0802MB22061BC34FBEC5953ADBD50DF4AB0VI1PR0802MB2206_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f07fdf-b64a-4edf-ac38-08d7ed7c62f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 03:04:38.4886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbBSGkoHA5EVzNNByukrv52W8OXRQLQLUYl5k6O3Buydl5JMBMTuT4diMcTptM9A0YVkCvawup7yaef4H16vbEKOoRVb3NDPoM3rt3Wsjsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2461
Received-SPF: pass client-ip=40.107.8.111;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 23:04:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.111
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_VI1PR0802MB22061BC34FBEC5953ADBD50DF4AB0VI1PR0802MB2206_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sounds good to me generally.
Also, we need to identify the filter by its node name when the file names o=
f a node and of the filter above it are the same. And what about automatica=
lly generated node name for the filter? We will want to pass it to the stre=
am routine.

Andrey

________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Thursday, April 30, 2020 10:12 PM
To: Max Reitz <mreitz@redhat.com>; qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>; qemu-devel <qemu-devel@nongnu.org>; Andr=
ey Shinkevich <andrey.shinkevich@virtuozzo.com>
Subject: Re: backing chain & block status & filters


>
> .... The only difference is that if you use file-child-based filters, you=
 can't do stream/commit around them. I just think, that binding the concept=
 to the "backing" link of the node is simpler and more generic. In blockdev=
 era, when all nodes will be named and libvirt will take care of all nodes =
including filters, we will not need any filter-skipping magic, libvirt will=
 directly point to exact nodes it means. And we can deprecate "file" childr=
en of existing filters, to finally reach simple architecture with simple ba=
cking chain of nodes (any nodes). And after deprecating old filename-based =
interfaces, we'll drop all filter-skipping magic..

What do you think?

--
Best regards,
Vladimir

--_000_VI1PR0802MB22061BC34FBEC5953ADBD50DF4AB0VI1PR0802MB2206_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div>Sounds good to me generally.</div>
<div>Also, we need to identify the filter by its node name when the file na=
mes of a node and of the filter above it are the same.&nbsp;<span style=3D"=
font-family: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot;, Helve=
tica, Arial, sans-serif; font-size: 16px; font-style: normal; font-variant-=
ligatures: normal; font-variant-caps: normal; font-weight: 400;">And
 what about automatically generated node name for the filter?</span><span s=
tyle=3D"font-family: &quot;Segoe UI WestEuropean&quot;, &quot;Segoe UI&quot=
;, Helvetica, Arial, sans-serif; font-size: 16px; font-style: normal; font-=
variant-ligatures: normal; font-variant-caps: normal; font-weight: 400;">&n=
bsp;We
 will want to pass it to the stream routine.</span></div>
<div><br>
</div>
<div>Andrey</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Thursday, April 30, 2020 10:12 PM<br>
<b>To:</b> Max Reitz &lt;mreitz@redhat.com&gt;; qemu block &lt;qemu-block@n=
ongnu.org&gt;<br>
<b>Cc:</b> Kevin Wolf &lt;kwolf@redhat.com&gt;; qemu-devel &lt;qemu-devel@n=
ongnu.org&gt;; Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;<br=
>
<b>Subject:</b> Re: backing chain &amp; block status &amp; filters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
&gt; <br>
&gt; .... The only difference is that if you use file-child-based filters, =
you can't do stream/commit around them. I just think, that binding the conc=
ept to the &quot;backing&quot; link of the node is simpler and more generic=
. In blockdev era, when all nodes will be named
 and libvirt will take care of all nodes including filters, we will not nee=
d any filter-skipping magic, libvirt will directly point to exact nodes it =
means. And we can deprecate &quot;file&quot; children of existing filters, =
to finally reach simple architecture with
 simple backing chain of nodes (any nodes). And after deprecating old filen=
ame-based interfaces, we'll drop all filter-skipping magic..<br>
<br>
What do you think?<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
</div>
</span></font></div>
</body>
</html>

--_000_VI1PR0802MB22061BC34FBEC5953ADBD50DF4AB0VI1PR0802MB2206_--

