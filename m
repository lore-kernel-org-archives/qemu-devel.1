Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A9BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AADE206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AADE206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=windowslive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc5a4-0004UQ-0l
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kc5Z4-0003FV-Cl
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:42:26 -0500
Received: from mail-oln040092064023.outbound.protection.outlook.com
 ([40.92.64.23]:19139 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foxen@windowslive.com>)
 id 1kc5Z1-00025j-Jj
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:42:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDJd/d86bilywRyfwTTSzPXKh84TVMdmepe3kJk2dR3TvvNPwQ8+v4Y9yhz3jG4iiuMu2lEc6TatsA20mYWuWLiPgsFMCwzpwOWpYctHJ8gUctPD8X/PsB+osiOTND/kLYcUMBHFE65IK18gPyYyUYh5OcbQEw5dmnHvyv1zi+onlXerGPD4piWuULwNDKud4tH8xJsHVNKxEVVqP9xecT5aecsUoLizARlpTQGZmJeXZelamm05Je7sLZGb4TXyVAjZHWnMArgbX/MOuyyvdsk6+pfvx8VCbm4t4dnuPsf7WLgFZRgrPg9yqzVxW7hTljTw2sBp0IAR6APWwJpuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UwUdDytwu78LH8Lq71WkEdnk6leYQ2E0bOV+jgauUI=;
 b=gzRIPWm6HcJdYfvDLTL7FIcROKAXM9V+1wvtxUJPkr3e1gFGL0ylr8RR5toCW059EUfkrysbEb8okxARTqBK2uTgLpu6xeeTjm4DBMLTapW9Nb9Y/ffpCs5gBnWPoUL40m4bYqg61wRJyYfiS17DNlkhzCgxG4V2SADWcCWUHNFBYNM0t+OIHDgPGTFSKWyXYnvNsXZ3QIm3+d8bQQk1jpjbTiVeTxQFk/WVxlftk6pJYi9eHfaEmbEVLQpL2IG6KipSJHxkvdD0qH56E5s9CeHSb3Ahc8y1Y3oMQG/7yiYfLuSGfp/8Z4YswTy9VRbiDOtiX9l0Mx2udwma7lN8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e1a::40) by
 DB5EUR01HT062.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e1a::361)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 11:27:19 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 (2a01:111:e400:7e1a::49) by DB5EUR01FT031.mail.protection.outlook.com
 (2a01:111:e400:7e1a::253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Mon, 9 Nov 2020 11:27:19 +0000
Received: from AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0]) by AM0PR03MB6292.eurprd03.prod.outlook.com
 ([fe80::bc55:cbe1:29ae:e5b0%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 11:27:18 +0000
From: Fotis Xenakis <foxen@windowslive.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [qemu-web PATCH v2] Add virtio-fs in OSv overview blog post
Thread-Topic: [qemu-web PATCH v2] Add virtio-fs in OSv overview blog post
Thread-Index: AQHWssoK3s/6fYjLwkqYhPTju7OCoqm/p7cAgAAJBMk=
Date: Mon, 9 Nov 2020 11:27:18 +0000
Message-ID: <AM0PR03MB62923C15DE8F5D150AC2BB88A6EA0@AM0PR03MB6292.eurprd03.prod.outlook.com>
References: <AM0PR03MB629226965B72D3808EFB8795A6EF0@AM0PR03MB6292.eurprd03.prod.outlook.com>,
 <ac1fe8d1-ac26-950d-6905-008f2f1189a8@redhat.com>
In-Reply-To: <ac1fe8d1-ac26-950d-6905-008f2f1189a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:89C71C659B2A979C487530A7322BCDFFE682CE2EB30ED1D39FAD656F3573BD61;
 UpperCasedChecksum:F2CA4199C997BF741AC1BE52D655182A07CC048EBABD584EE5E59DC66CC3D641;
 SizeAsReceived:7192; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [WgRZwcYdVcxI8RhC0UGZQLp0LEPohqdzhbLuU6MQhUArPit9BhwkZTbEWsn7rGYh]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: eb8f8e4f-afc6-4a2a-a115-08d884a26b15
x-ms-traffictypediagnostic: DB5EUR01HT062:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZmbsabYfL2dNMq6F01pLRTgcCok+Odsz8RXuRjG/zAVYm0/XtLCo45A6BYtN8pnXx86Bq0wZiP2+tt5+FcydKK5Y23RNl+Te5hFMzPaMtTIFgYR8oY6PRBHhpXcTtUZWtjPqiSyg7vr6xkm393XBSvX+7Sz/QhjJcqC2QfDUm9JkIdRWfu2BkLgcKFknV9FdS5My1xk3f2LOR0xcs8JkA==
x-ms-exchange-antispam-messagedata: Y8C6VKfeUVeh0B83NdRwcgP2UPBtlI7nLIE6f6WID5/cIn4yOHkbAUfCn6VmHm7S4ONius1BLrzZtvooq9VzR9CsjTb5nSWpg6+zLjgZC1QgRY9TPHUHlj2tH98/jk8j9cmxf+08+cfgb6ICNS+zO3ovSOc04ddHrucgzP9x/rpJ06XXYE+F/zrstcokMIFm1D5LcZ4jIT0JUJXzLF1cEA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_AM0PR03MB62923C15DE8F5D150AC2BB88A6EA0AM0PR03MB6292eurp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8f8e4f-afc6-4a2a-a115-08d884a26b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 11:27:18.8396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT062
Received-SPF: pass client-ip=40.92.64.23; envelope-from=foxen@windowslive.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 06:42:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "virtio-fs@redhat.com" <virtio-fs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM0PR03MB62923C15DE8F5D150AC2BB88A6EA0AM0PR03MB6292eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thank you for your time and the precious feedback!

Fotis
________________________________
From: Thomas Huth <thuth@redhat.com>
Sent: Monday, November 9, 2020 12:54
To: Fotis Xenakis <foxen@windowslive.com>; qemu-devel@nongnu.org <qemu-deve=
l@nongnu.org>
Cc: virtio-fs@redhat.com <virtio-fs@redhat.com>
Subject: Re: [qemu-web PATCH v2] Add virtio-fs in OSv overview blog post

On 04/11/2020 17.46, Fotis Xenakis wrote:
> This post briefly goes over the main points of virtio-fs and OSv, a
> unikernel running under QEMU/KVM and taking advantage of its virtio-fs
> implementation.
>
> Changes since v1:
> - Fixed wording and links, as suggested by Thomas Huth.
> - Added a short example of virtio-fs usage in OSv.
>
> Signed-off-by: Fotis Xenakis <foxen@windowslive.com>
> ---

Thanks, pushed now!

 Thomas



--_000_AM0PR03MB62923C15DE8F5D150AC2BB88A6EA0AM0PR03MB6292eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Thank you for your time and the precious feedback!</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Fotis</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thomas Huth &lt;thuth=
@redhat.com&gt;<br>
<b>Sent:</b> Monday, November 9, 2020 12:54<br>
<b>To:</b> Fotis Xenakis &lt;foxen@windowslive.com&gt;; qemu-devel@nongnu.o=
rg &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> virtio-fs@redhat.com &lt;virtio-fs@redhat.com&gt;<br>
<b>Subject:</b> Re: [qemu-web PATCH v2] Add virtio-fs in OSv overview blog =
post</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 04/11/2020 17.46, Fotis Xenakis wrote:<br>
&gt; This post briefly goes over the main points of virtio-fs and OSv, a<br=
>
&gt; unikernel running under QEMU/KVM and taking advantage of its virtio-fs=
<br>
&gt; implementation.<br>
&gt; <br>
&gt; Changes since v1:<br>
&gt; - Fixed wording and links, as suggested by Thomas Huth.<br>
&gt; - Added a short example of virtio-fs usage in OSv.<br>
&gt; <br>
&gt; Signed-off-by: Fotis Xenakis &lt;foxen@windowslive.com&gt;<br>
&gt; ---<br>
<br>
Thanks, pushed now!<br>
<br>
&nbsp;Thomas<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM0PR03MB62923C15DE8F5D150AC2BB88A6EA0AM0PR03MB6292eurp_--

