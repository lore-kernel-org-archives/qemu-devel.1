Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB62C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FDE2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nqFRuoKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FDE2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9cM-0007zX-KS
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jh9VV-0004ND-5E; Fri, 05 Jun 2020 06:23:25 -0400
Received: from mail-eopbgr50107.outbound.protection.outlook.com
 ([40.107.5.107]:2162 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jh9VR-0006Y5-W4; Fri, 05 Jun 2020 06:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHAXoiCX+je+EBJr3udTvwrME7B42pCsWgD5oGBf1TiIrxq8dzKPmrm7a30dHESkEGc80nWTjtFqGDI4Q9El2doUw3eNMNIZCwQXa91UaliHMVFHQwqo8VeGIM0lyb+yHZzTVmhzDaXEZ0qInr2fjnLlw4789cbevH+ZzvKPrZ0CwnEa171IZ4FYQ/lvmnAbKqPMHKUgT3Ta1lltLTSSKOF3KCdyXD+umaH4jwrTpk9jk0BES3XaA13DqqycQbIU10yNP/QqPdxlWU3nD1HEluyYAMkiXJU0eyXMlAMvoHHkaa0A+bCy25K826cRD1HOO9jBo4syZJagYNPGzdpgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDaXT4ODm2eOiH6dnni6GLRV8w7NOH0CNTm4n9yj04s=;
 b=UwhEXgyOGLIhiHweRDXy9ydRCmE14G4OgPJdNGRND0jLJ5SoElQGv2l9oSfx/MnucRpMr/SGBvUZJnmQS6uCrsI+QO04/XilhAYEHtAjLFHuV+P7Ct5ijNEG1UfpKuOwD1FhZAjjhE4NbclI0Q+t8kgPosWVaq5MTRp/5S/Ycgr38i197XY/7M+knUS3w6IRxle3d71k7mOl8hwbLnym3r8lVdGgsc8U403Qg6/ppudMHtG2Mi+v+jIVKpo4DuRstEPaYhMCYyPlx9YDTCvoLbgRpHnAvf88Zt5P4QT1J9CRKLkXUZc+fNOHB8mEoT5T91LfCfuxpbAzBoHhY+KxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDaXT4ODm2eOiH6dnni6GLRV8w7NOH0CNTm4n9yj04s=;
 b=nqFRuoKtkxDhUh4jnNcPkKGf90bLbE8ACWtv6S303DbOA6ICbFoddCy4S0hs1uACiynp9dPYuQEW6K74fYxWHyEveS4TfG/F6M7nhUvgzke5PKFJJKSxHJE85S4VfUqnuEcsoxsPWPPSsY2Atb2tEXkUOjA2sadKIBHHn89Wn1I=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4898.eurprd08.prod.outlook.com (2603:10a6:20b:cd::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 10:23:17 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 10:23:17 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 01/12] qcow2.py: python style fixes
Thread-Topic: [PATCH v4 01/12] qcow2.py: python style fixes
Thread-Index: AQHWOpdtGVePcrUOpU6Bf+AJz84ie6jJ0Tam
Date: Fri, 5 Jun 2020 10:23:17 +0000
Message-ID: <AM6PR08MB4070E4169E7B3F27C24FF6EDF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-2-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-2-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebccbf50-cf34-47c1-270c-08d8093a769d
x-ms-traffictypediagnostic: AM6PR08MB4898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB48985ED35D0ECB71FC77A2AAF4860@AM6PR08MB4898.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OhYQgs38jpc0al0OQ8uMFKywyAJ1M5W7/rn+dn1zS+ZDYi2OVJ8j9mAKNq43IsGl2GOKBjUqdw7rbTGwfQzJPXiy+1rLkFDYkzrcP/Tuyy+a7RToTo9H0ynyTfgQFRX4PglZfUFBlKMp84q61H9DZHu/feQUJ82rMInk7Yo7A5x4ExamTybPTbiLoIY1Y7KYF/07Sz0nxQUuftQTbcLL1VC3RItomGFQv+apcoSUm8FLe8k7xShgtG0OtyEQaBoAByQR1vSy2klOxjGZgknOIcUsYKbrZ3hVRAONkneHLjuXGusystm2uEa5XfZ2eKSlzqs6B1KgIUSgQ8VXc17lw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(366004)(396003)(346002)(136003)(66556008)(9686003)(7696005)(107886003)(6506007)(4326008)(5660300002)(26005)(186003)(53546011)(71200400001)(55016002)(316002)(33656002)(66446008)(44832011)(76116006)(54906003)(91956017)(66946007)(52536014)(64756008)(8936002)(478600001)(86362001)(83380400001)(2906002)(66476007)(8676002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wUyi80N0/OFg5HkF/K+dU+jjhQSk6ESAltFG8y1HZC++snwdW5CLeOnqS6VlZcJmivnahujmlAifJy1aG++t8HNQCunk8THEb/lhjTGXeOfvatZkaJB4diGktJI3Ie/N07SmRx1s3ollxchOB0Ct5zCRiEutk7UZCfX5Vp2h/AomHd20wjBhvAXBdJMsEjfrql5fCTA2+SAO105dHfRSIr/plzOXItJ3nmOBi2Y1xtYPYe2SRXVE79dWm6hf1QYsEdlvyKd8LRQacQxyoo8z8J95m0bUvOMLLaVzQNJrFgFykhu+IPxY7YyTVowpW+tlcx+S1E3uyIFbO9g9Utez5t7wgk3LreaTw2rrTPXBYOrp7JYXhqUp9+xH4UUFPucgNn3FllC9VrRjnodsBNM8nYx3DrRlkpMBcF5FIOTx4pFkjqq2dhgJOdgSlJYVStqP6OCpBhwXVc8JocVl+TLs+8Ga8I3s/d1aFIfrW3oFE7sCRSMWi3my5JXtB4QFz9dQ
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070E4169E7B3F27C24FF6EDF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebccbf50-cf34-47c1-270c-08d8093a769d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 10:23:17.4839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBdc+QpEVJ23Pef3Q9deDJzfKJh92AoxVUpkZZTEtcPgHQKYShvfYTgQIwgQMp9zcn8DD0JTRxd1qAMaqdVf0DCk3wpDaPJMNivkW+V/fjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4898
Received-SPF: pass client-ip=40.107.5.107;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 06:23:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

--_000_AM6PR08MB4070E4169E7B3F27C24FF6EDF4860AM6PR08MB4070eurp_
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
Subject: [PATCH v4 01/12] qcow2.py: python style fixes

Fix flake8 complains. Leave the only chunk of lines over 79 characters:
initialization of cmds variable. Leave it for another day, when it
should be refactored to utilize argparse instead of hand-written
parsing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2.py | 92 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 39 deletions(-)

--_000_AM6PR08MB4070E4169E7B3F27C24FF6EDF4860AM6PR08MB4070eurp_
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
<b>Subject:</b> [PATCH v4 01/12] qcow2.py: python style fixes</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix flake8 complains. Leave the only chunk of line=
s over 79 characters:<br>
initialization of cmds variable. Leave it for another day, when it<br>
should be refactored to utilize argparse instead of hand-written<br>
parsing.<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2.py | 92 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------=
----------<br>
&nbsp;1 file changed, 53 insertions(&#43;), 39 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070E4169E7B3F27C24FF6EDF4860AM6PR08MB4070eurp_--

