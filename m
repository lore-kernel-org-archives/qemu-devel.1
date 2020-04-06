Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD739C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E0924682
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lI7B3VhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E0924682
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLT8S-0003vQ-Nu
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 10:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jLT7c-0003Ov-IB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jLT7Y-0008WS-Ux
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:53:06 -0400
Received: from mail-eopbgr60094.outbound.protection.outlook.com
 ([40.107.6.94]:62526 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jLT7Y-0008Uj-DA; Mon, 06 Apr 2020 10:53:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3onTo2ZZXEsfMvC5WfI3x2LcpKgIlbeR8l+LkRJH2sGg35AZfUpkfGeCzNRPZK+hZN/4wMkEgXfEEoisqbqOLkhhGKarCdO3COeM+OwLh59TseQcvLR/chzjqhNRm6Tt/WUaBVcLPet7g78TVzzFITM49TrgRwB+MJLoEUfDr6g69EOJRfqzMDBi/lCju1H8pVMfRYSUZnPk0abE9aiJ7SvoyMBS5EUcMA6oLq0yR6kpY3655IrpQQY5xCh1nwISM8LBsiD1Kdp3I/vA9yc6X+lVfLkmE2ktZut+t4cG7dPsy0I7Wcenx17jzeJCCX7YJwsj9YvkpA/ETASN8fGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj7hBRD17oWjVX/h3D7vAwuKw7wLitN1l7bI0v+3lLw=;
 b=gJ8rnAk6tbNYnKUsGu2nl5xszw94iY/P75Bjg8+w74TQWoH9owU+y+uGOg5JF8xnKeK7ivlL81sFDv/LTGFJh+KhOWKf2BZFOgoXmEg0hyZyQ0CPcEpXOaa6SZlXicXyXwc3kfN6c3Oo2kiylNcR1aTCfiiyv2hb/i+9WVzMTwj+yUrO8CkPyt+esXBpzK8LngkQFOeeOHKpzqj9dN+XB6922SrOq8cEGi+ArW+HW53bdHaqK56gUyfZmsHBd9TbZHgLN3ctWDcXzJmngGcjlUCDsx2gddWUnCAxVzDUgWXCU9t7U37GIMNwjMeJvBjR5kCRokfQa8N/sIRNeTFhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj7hBRD17oWjVX/h3D7vAwuKw7wLitN1l7bI0v+3lLw=;
 b=lI7B3VhJpkplcSkHa7bXqBiLo5LkilJYwlhmZHm/QItUW9+h1MR/jIybdnU2Z83KgomFa7dgxs3x9eiW3Bbey23RQaQZ6cGMvCZ2xM4zqfwomilLp8WlzCNKNLFh34HetHCSFArywbWbi4Tzg4KrR+zQa/zo6mJZQibGwwyrTA4=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Mon, 6 Apr 2020 14:53:00 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2878.017; Mon, 6 Apr 2020
 14:53:00 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Thread-Topic: [PATCH v2] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Thread-Index: AQHWDCB88p2wqMkMHkKOqJjxfSztq6hsLbgO
Date: Mon, 6 Apr 2020 14:52:59 +0000
Message-ID: <AM6PR08MB5048AE188B78CD18B53DF0C9F4C20@AM6PR08MB5048.eurprd08.prod.outlook.com>
References: <20200406143401.26854-1-berto@igalia.com>
In-Reply-To: <20200406143401.26854-1-berto@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-originating-ip: [109.252.115.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b34ee1b-5d0d-451f-7367-08d7da3a3359
x-ms-traffictypediagnostic: AM6PR08MB5208:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB52083E5D39B982F79B1A8CF0F4C20@AM6PR08MB5208.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB5048.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(376002)(396003)(39840400004)(346002)(136003)(66556008)(64756008)(66446008)(66946007)(66476007)(76116006)(2906002)(33656002)(6506007)(7696005)(478600001)(4744005)(44832011)(110136005)(54906003)(316002)(26005)(53546011)(55016002)(8676002)(8936002)(9686003)(4326008)(81156014)(81166006)(19627405001)(5660300002)(71200400001)(107886003)(52536014)(86362001)(186003);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSSBfwkZT7IK5GOZtyN8sJtiDPs39IvD3uY+FN05RlIy2gVr1m9/pMhYW2xEWAQce2XI0saRXmno7J9hwBfAJOjJ4ToUm60uxyW/mXlkb10OyR2bhxR43dTZ8ZiBL1uhABGfjJpoyVDh/QljlTv1VCul1IHoVUEzU0JMQxyxREEfTg90fRkN/eKhqZFix3jkyxmQFqPwU0Murr6jsm+M7ikJvV1JIpKt+VwGQWDqHJZkRZmBcn+NZlxcKJ3rAurUslWamunauAlLlwVUPQERF31wVHm7OQZLxu47VDY5A9Ern1nBNyrgczVOe2EvG3WBKFN/1gtMto5W/XxoSGGj3CLuQHdctJiSC7xeCIEaqMMxxgbM3ZfSAP0fc5wGytBG/xdVaqQhu5EpvnTtBSHipdutpg2IpWdnTPNmGbnJLgdZCIwa0iV5XILfv3Jw3cph
x-ms-exchange-antispam-messagedata: Z7Jqs1w4vbmoKBtqXmamgD7nYeEmT9AkjSeX3QWA+t7y1jsDxPX0z2RTJgWXmNshqR+x2olzVsJRsOeMtYmQhQrZLc5gymRcZU4Gp54DRpP/H9fbek8budgDxCFppjwJB8P0oQlZcIWBgS7XhpYr7w==
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB5048AE188B78CD18B53DF0C9F4C20AM6PR08MB5048eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b34ee1b-5d0d-451f-7367-08d7da3a3359
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 14:52:59.9623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2aJqJiXEFr8YkFleEdbi1MHWEAzwNRDfGV8kn3z44LNUUE3b9NiqvkznVAyM712RqmMEKY+S28cqfUOQ4bxgwiHFFnns7XSVhrV6cFaHoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5208
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.94
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB5048AE188B78CD18B53DF0C9F4C20AM6PR08MB5048eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

________________________________
From: Alberto Garcia <berto@igalia.com>
Sent: Monday, April 6, 2020 5:34 PM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: Alberto Garcia <berto@igalia.com>; qemu-block@nongnu.org <qemu-block@no=
ngnu.org>; Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>; Max Reitz <=
mreitz@redhat.com>; Kevin Wolf <kwolf@redhat.com>; Vladimir Sementsov-Ogiev=
skiy <vsementsov@virtuozzo.com>; Pavel Butsykin <pbutsykin@virtuozzo.com>
Subject: [PATCH v2] qcow2: Check request size in qcow2_co_pwritev_compresse=
d_part()


--_000_AM6PR08MB5048AE188B78CD18B53DF0C9F4C20AM6PR08MB5048eurp_
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
<span style=3D"caret-color: rgb(32, 31, 30); color: rgb(32, 31, 30); font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.666666984558105px; background-color=
: rgb(255, 255, 255); display: inline !important">Reviewed-by:
 Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alberto Garcia &lt;be=
rto@igalia.com&gt;<br>
<b>Sent:</b> Monday, April 6, 2020 5:34 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> Alberto Garcia &lt;berto@igalia.com&gt;; qemu-block@nongnu.org &=
lt;qemu-block@nongnu.org&gt;; Andrey Shinkevich &lt;andrey.shinkevich@virtu=
ozzo.com&gt;; Max Reitz &lt;mreitz@redhat.com&gt;; Kevin Wolf &lt;kwolf@red=
hat.com&gt;; Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;;
 Pavel Butsykin &lt;pbutsykin@virtuozzo.com&gt;<br>
<b>Subject:</b> [PATCH v2] qcow2: Check request size in qcow2_co_pwritev_co=
mpressed_part()</font>
<div><br>
</div>
</div>
</body>
</html>

--_000_AM6PR08MB5048AE188B78CD18B53DF0C9F4C20AM6PR08MB5048eurp_--

