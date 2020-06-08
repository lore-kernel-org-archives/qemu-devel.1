Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D22C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F6C2067B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aJjbRKOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F6C2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiAf8-0005oX-Nb
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 01:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jiAeH-000516-Ts; Mon, 08 Jun 2020 01:48:41 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:16679 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jiAeF-00007u-Ol; Mon, 08 Jun 2020 01:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faBI1c8AoU6lhsh/UXO98Tz8Q4zw7TefC3r11fcljyrNkFk/QbeI0zaJLwRkgEIfOlYND+mQza9rPHXc6mLyTOJC1FUA4z69irmsejD3CAG/dNjYzZLhVJ8gf4EIL7RPeMQf4+YBaOlFWINbylm6gv00dQP+wPh461tTX5XvWdF7IuTRmNWYTtdE9LasQSXQDgpf8yHy6a7AxtZTqSUr7fpqKibW9MijOOtXDNvmczLb1tfSbFd6StDqo5YgLLSkf2t8oaGPPKBXVPVYYrHDupt+eqcoZ2hgphT82b6vY6yULsTNIGmUIGkmF3jdOzIhfcTLiBZvfMm7CGJMsUBoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UKAn1eLdEatdtJ5DHjWObHMcO0kZIC0Iatos8bSzAI=;
 b=FuDEtYe4wb09f5hUrcmz3Jth0Qme6ZqHEi74t5XTAQ/4pLHd6iKQbfRA/uAy5ik/jQE1h1h3shYJnvhNG8hN0oArumDZCEjJzIWdkUbm4MSI0lUXbHn6q84ABqhwlpRrsL0p+lDdqtEEuhgRbs4Rt2g873r12aKCqFaGYfrGnCaIBEpSpCBt7Ifps34SkEbBV2MzPxBTiIFYlaIkCNy93OPMMdi7HDDEuzf/o3HTU7qUuIAc6Au+t42k5RgB+UPSeCvE/PeitqR4WnN0e4jROztQRfMBLMDlrSUgNd2Wr+JUt3poHgVAHG/Q54YIlogPdISUExFAuYdYAn5VqgA0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UKAn1eLdEatdtJ5DHjWObHMcO0kZIC0Iatos8bSzAI=;
 b=aJjbRKOonaciH6lf41TGNF4iEndJwciQx8BPq4D1CTpK1U31GorZS8JfLwrTiFFSqByCezV6/mLPFsofeZyfUeWWun8y3VB3jhgCCu0no8Cza5QKKewnjA2Vsf15HNUQG5RqauSj3gNwINZgle4R9JwQBvlf4LjOnuZIz4rr5p4=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 05:48:35 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 05:48:35 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Topic: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for
 extension magics
Thread-Index: AQHWO9sQh+oMXy2mWEmAdvXrPnkkoajOOAVt
Date: Mon, 8 Jun 2020 05:48:35 +0000
Message-ID: <AM6PR08MB407028BA3B40A5CAE37C21D6F4850@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>,
 <20200606081806.23897-13-vsementsov@virtuozzo.com>
In-Reply-To: <20200606081806.23897-13-vsementsov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
x-originating-ip: [95.25.201.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e48e190c-1101-47df-1aff-08d80b6f95d5
x-ms-traffictypediagnostic: AM6PR08MB5080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB50800AD87F143F8FC9DD7E32F4850@AM6PR08MB5080.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:529;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pSpkLyKBWyA+7q+Kh3JYccPrKvtMsxUABWk/6IKWjcKLL18oKuEZ7QWnPJjBnTTGklQZf4Uxh03m2LGhci+LiKK+AIScXUSFe7UFT6lixWTErmQlsGCU5foNam92PmZILfMdM3E0zJi/3NfODmuAqU4iwTkgHImGZc15VOnbo3RAmunZfxKpryguwhUkn0ZSPR+mBlUsrpS86MwEGE94vp+bn9f+YmulHcD/QdRpO+AsDyLb5WiaQJq12gfrlj8owqPx/H3oEifS9arGuXS40YkeewmCJOSCm1kN07/lbyfyz/FVD2BOgkVolXsNH2ECasrJPNNWmcfGerFR7Olsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(136003)(396003)(376002)(366004)(346002)(44832011)(8936002)(33656002)(2906002)(71200400001)(107886003)(6506007)(7696005)(52536014)(4326008)(54906003)(83380400001)(86362001)(53546011)(110136005)(316002)(66446008)(8676002)(186003)(64756008)(55016002)(26005)(9686003)(66556008)(66476007)(478600001)(76116006)(66946007)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PJSzaj6tRH5vi+pjhcDPT4Zo9KdeOEtT9xKCncSKldkdhCABwktXcZ4oWs03tGtx6COnBCxmsIuDsmdprJXZDjkrWU6kZHGuzMYZPs84h3CzoryKBMIW4gnIbvUUWRVHy76KIxBULR263lR+bdQjxYh9vy129k451iaC+xl0T68KoW9TiPDsMWf+zA9IkMv8Odag2sLmUjW0VPAeTKvg11L7yTWO5wwYpcHLGc+PAlIXnCbVvoJMGw2STyJttV+e2DuU+1EBFvWun9JOnKfXRNjuA9LsTmCp6U7UT4EAqPYdqmTjDRx6NOT5VIjvIUGOfxsuL2zr5TFUeXH25aEROCrZvY7ErLhEjPwkHxcad7NZX6fXI+H6+9OmK0G2OiBbGTDUDy/5IgVNVhlt30ds6Ikjrybd9ihyXe6DAc4osDIxr0QEZ5o1dfUWSH6SgzSNvRQ/yOUEX9HSQzyN6IKzAWoHzzUe2g7SNaCcZ07apAk=
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB407028BA3B40A5CAE37C21D6F4850AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48e190c-1101-47df-1aff-08d80b6f95d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 05:48:35.5032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJD74ztKlzwsj05QT3GEor84s87GHT7RlGwdL7V3iN3Y7nDWggd0AKizc77OmmkjnRGhBXF7ITAUSbzBTPUIZr4T4yyj3ziMN8rkpSplGls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Received-SPF: pass client-ip=40.107.4.111;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:48:36
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

--_000_AM6PR08MB407028BA3B40A5CAE37C21D6F4850AM6PR08MB4070eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Sent: Saturday, June 6, 2020 11:18 AM
To: qemu-block@nongnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; mreitz@redhat.com <mreit=
z@redhat.com>; kwolf@redhat.com <kwolf@redhat.com>; eblake@redhat.com <ebla=
ke@redhat.com>; Denis Lunev <den@virtuozzo.com>; Andrey Shinkevich <andrey.=
shinkevich@virtuozzo.com>; Vladimir Sementsov-Ogievskiy <vsementsov@virtuoz=
zo.com>
Subject: [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for extens=
ion magics

Suggested-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/031.out         | 22 +++++++++++-----------
 tests/qemu-iotests/036.out         |  4 ++--
 tests/qemu-iotests/061.out         | 14 +++++++-------
 tests/qemu-iotests/qcow2_format.py | 17 ++++++++++++++++-
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py
index 32371e42da..40b5bf467b 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -39,6 +39,12 @@ class Flags64(Qcow2Field):
         return str(bits)


+class Enum(Qcow2Field):
+
+    def __str__(self):
+        return f'{self.value:#x} ({self.mapping.get(self.value, "<unknown>=
")})'

I've got the error E0100: invalid syntax [pylama]

Andrey


--_000_AM6PR08MB407028BA3B40A5CAE37C21D6F4850AM6PR08MB4070eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div><br>
</div>
<div><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vladimir Sementsov-Og=
ievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Sent:</b> Saturday, June 6, 2020 11:18 AM<br>
<b>To:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; mreitz@redh=
at.com &lt;mreitz@redhat.com&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;=
; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozz=
o.com&gt;; Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;;
 Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;<br>
<b>Subject:</b> [PATCH v5 12/13] qcow2: QcowHeaderExtension print names for=
 extension magics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Suggested-by: Andrey Shinkevich &lt;andrey.shinkev=
ich@virtuozzo.com&gt;<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt=
;<br>
---<br>
&nbsp;tests/qemu-iotests/031.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 22 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------=
--<br>
&nbsp;tests/qemu-iotests/036.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 4 &#43;&#43;--<br>
&nbsp;tests/qemu-iotests/061.out&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; | 14 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;tests/qemu-iotests/qcow2_format.py | 17 &#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;4 files changed, 36 insertions(&#43;), 21 deletions(-)<br>
&nbsp;<br>
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_=
format.py<br>
index 32371e42da..40b5bf467b 100644<br>
--- a/tests/qemu-iotests/qcow2_format.py<br>
&#43;&#43;&#43; b/tests/qemu-iotests/qcow2_format.py<br>
@@ -39,6 &#43;39,12 @@ class Flags64(Qcow2Field):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return str(bits)<br>
&nbsp;<br>
&nbsp;<br>
&#43;class Enum(Qcow2Field):<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; def __str__(self):<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return f'{self.value:#x} ({=
self.mapping.get(self.value, &quot;&lt;unknown&gt;&quot;)})'</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">I've got the error E0100: invalid syntax [pylama]<=
/div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Andrey<br>
&nbsp;<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB407028BA3B40A5CAE37C21D6F4850AM6PR08MB4070eurp_--

