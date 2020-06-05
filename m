Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4846EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 114082053B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gwVV4v2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114082053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAWz-0005Bl-9V
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhAW1-0003MJ-C0; Fri, 05 Jun 2020 07:28:01 -0400
Received: from mail-eopbgr140090.outbound.protection.outlook.com
 ([40.107.14.90]:62350 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jhAVz-00034U-4T; Fri, 05 Jun 2020 07:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mnx3Ut12kjcsQ1pqPyLxbQ1p3K709F0KUlUenmgUhb7BrJm252W8BhoJKo21ef6UtkDlDpOhnPUtbb4MkWc6fCzppRM5xl1uLdD46hY5PybstRJuWM1ao3HmQYZiDwul8yDaftt7MoSMG032jZ8rcV1SRa7lViXgrXLVyDhH5LhtFH671F2rs6ddAwpuNOeZSby2pFJByJpsvCtCpoWEbLeyc5o2nooLUIm629fMdXua5ulLBfmQ2rFMDCzrNDFdH7OoCCZ1Mij9OD5fRo2S5jLfBfqEUQwlBeLG0P5hWceF6eI9N8ZX3L6wMYX2obtHXqko9elVpZvpAwsxAaZNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOPdK4Z6wNsYrMP9TjQV3U1zywrqXJcv5X4yuh51lkw=;
 b=XaphOFt95VrtwUw3InC9iGKhG4w0mZatNZmfs/RZBrq3Szt41vqgNf19rSbrFE1JeMcN7EE4hfNwhdMKPwmmVZR1ccfv6eQJryuRG5xhdKEWX67grTJGFNhhF7aE4UzSuWQrrBd5vzN36XIEzQBU58gM1lVmChIMckFp+0pfWD5pE4RnSMfDMgynqPsRu7FQkrWzQ4et499w+Ik+t19/HzHI+CkacOPXqhgxaE0optpc8ncXd9YWnhdytTa+ZUFPspDxBl49c1RzQZx25d48i/WFYwtNNXigFUJACCV5f9PPWckabDlx0FynZOZcvTcuEna0cmGitYjZwhYH3uAHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOPdK4Z6wNsYrMP9TjQV3U1zywrqXJcv5X4yuh51lkw=;
 b=gwVV4v2qwvHLpFmQJbq2mqSbMaokCdXKkUZ/13zfhDS3V2N1fBZx3qaao8yxyGXwLTdwiMPOxi8k9T7nr9xAAl5qzdRiwEGBiCw+TTzSYfcqjLrH0pBvX4lq8bWv3yruXLEc2YExUR2UGFzwfePXx9deqRwcaHSqBGBmbDN+aDI=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3720.eurprd08.prod.outlook.com (2603:10a6:20b:8f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 11:27:56 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 11:27:56 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 05/12] qcow2_format.py: use modern string formatting
Thread-Topic: [PATCH v4 05/12] qcow2_format.py: use modern string formatting
Thread-Index: AQHWOpdv9Y0jqyHt60Sku48pWoe0I6jJ42jJ
Date: Fri, 5 Jun 2020 11:27:56 +0000
Message-ID: <AM6PR08MB4070F1D973E70378C33EF00DF4860@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>,
 <20200604174135.11042-6-vsementsov@virtuozzo.com>
In-Reply-To: <20200604174135.11042-6-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [109.252.114.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 891dd3d2-24fa-4dd0-1557-08d809437e7e
x-ms-traffictypediagnostic: AM6PR08MB3720:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB37207FD3BCE5EDF2CF2EFB7EF4860@AM6PR08MB3720.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjfywaVssjth3ryTUcl4CpvY1jXG2URLb7QXJD63SQGXnJ63ifb2AzKz7Tk5kv9Y0iV9yr/0FJiGipR88VLsgvzqumMs1S1SxjJTKpfDAP/+UyGehE5tPPzx8AgzgQ2ZbLcr5dtqCqxoMf3sNpvJAiChZCPLlLqqyqYmAKYaDm8wjA9lU+qucOkM6QfhD25S/VQcYK08gM7MrMYK0o3ls6iwYSjVF2O5GpoOtCChPTZelNk6LIuTvFDAt5Rvz48H+YPVjXWY5qX/OMR4jN5iYkVRtIieXkXmsKVJujnPYmapzfaoCR2XEtkZ4qLxsfA7Flji7H+4TUP/SRXrdFBQ7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(39840400004)(376002)(346002)(44832011)(66556008)(33656002)(66476007)(76116006)(64756008)(5660300002)(66446008)(66946007)(6506007)(52536014)(91956017)(86362001)(71200400001)(186003)(53546011)(83380400001)(4326008)(26005)(110136005)(8936002)(316002)(54906003)(8676002)(7696005)(478600001)(2906002)(107886003)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2aWMVjKBoRTvNPuqANiH6C5kErMgjqjYfyayoEjivCwbpx5MmUbXA4jAmbiZq3rDfRL4tIsLzKdezN6pzhVysLzi5PUyn1OCWVFEmRgp4GSS/hqSwYTCJ8vkhb9RahHXy8GanQRndodHF1WKBSZCKktwmMWqTXSSQ/3dB7ytCRpjUzfLccJTgVMJPbfaJ14c/s8wBusMt1V1/BuQHHaLb5Oe0M14fJIsownlqML1kGCXbk10D/I0PXOyHfLx4/9OHvSY4OsHS0meAE/fGEMExD62HpHDipwz4KBXSuSXM1b+Z0lK/Wm7dpEQ2HxP/InNM/U9h6WbfLZQ9QXNbloW+F/4fIQI+lw9VC8hd4LzxSOC99DC69plZRzx875Jmg3retHPbcUoaoFgvMQxUyLX2SnQqYNTx3rgzXLGNiS3WmbFfOTV/4J6K7k+OM/fJQSAhC+M5UiRsKXGr9Z1j1vJ8/0BvPhwNX4ba9kfmN19NlVpKnzbUhFe2yR7N2Mp1ChX
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB4070F1D973E70378C33EF00DF4860AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891dd3d2-24fa-4dd0-1557-08d809437e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 11:27:56.1017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDx2qvgmRVx12F+Xx+6K6ZuvUYYGFVqqNGo2rhzPoRtZ0TWLYjoO17G/wpqPjr7PqFeFfmgvI/XBQAWL1OqRUmQovWQmYizRK8i3yMJT5i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3720
Received-SPF: pass client-ip=40.107.14.90;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:27:57
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

--_000_AM6PR08MB4070F1D973E70378C33EF00DF4860AM6PR08MB4070eurp_
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
Subject: [PATCH v4 05/12] qcow2_format.py: use modern string formatting

Use .format and f-strings instead of old %style. Also, the file uses
both '' and "" quotes, for consistency let's use '', except for cases
when we need '' inside the string (use "" to avoid extra escaping).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

--_000_AM6PR08MB4070F1D973E70378C33EF00DF4860AM6PR08MB4070eurp_
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
<b>Subject:</b> [PATCH v4 05/12] qcow2_format.py: use modern string formatt=
ing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use .format and f-strings instead of old %style. A=
lso, the file uses<br>
both '' and &quot;&quot; quotes, for consistency let's use '', except for c=
ases<br>
when we need '' inside the string (use &quot;&quot; to avoid extra escaping=
).<br>
<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 54 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------------<br>
&nbsp;1 file changed, 27 insertions(&#43;), 27 deletions(-)<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB4070F1D973E70378C33EF00DF4860AM6PR08MB4070eurp_--

