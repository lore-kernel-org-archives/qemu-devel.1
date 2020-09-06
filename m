Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4CFC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 19:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814782080A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h9HGW5DQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AVaIpeJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814782080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF0h5-0005cy-7F
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 15:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511e27070=Dmitry.Fomichev@wdc.com>)
 id 1kF0gG-00056J-5x; Sun, 06 Sep 2020 15:50:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511e27070=Dmitry.Fomichev@wdc.com>)
 id 1kF0gA-0003Qc-5N; Sun, 06 Sep 2020 15:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599421823; x=1630957823;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=d9oOPypsyufOuBu2svScmYsvIwodnEtjjbCCXZl8YU0=;
 b=h9HGW5DQS1KyqukaBkseo4m/RytXLv5Mi1XQ7y/5f4vgkTZlB0KwhPzr
 K1OCeGuoiYsqBPKcHHqBlw7Fn1fO8igWW33b9hrLy3JccQy7iFtaJcVLh
 FYas5HFz3IIyyrqZiELR1JIOeMjhNbWYpuOLiE4Q2M1XOPK1dVfO1kyY8
 qg1Ex+dl7c2ihPvyeIp5vAEAcwbQlra1BjQb9PTIH0viG1NdQIGv6OurN
 kEbE8pJcHM2/1Tk2tUgBZKCu5Cg4a5QhuXjBqFWbrLdMkSdZfjEMpLLxI
 yZd8wPGrYr4ve9By8oi9rRhT1LxOuVNfrnH65YmHb4mtn2IxgyxFtOLgE w==;
IronPort-SDR: tRD4IgGG1IDbx4Lo0I29QMWeSMkpYpzSNppTQXZxY9Su5t6H7kDlT2QafMkXqndmEWpXrodKs9
 8B+9yuoRdqE6EAi0zC5wMJ05aIDKk7PJeQE0Y+6FjMo3krgRZ3ZuBKbQ/h70uBnhI1fKXa+5Km
 AFOItPVtfbAfnxolTc5W5i1yis222TB5gUjEms4EpAIoPI0B4k0yxCyxwITQx0GKKS/SXeAfh3
 +t9cycXD7Ka97pQlRmRqPQf0QXLqnMYMRWjdplArDsWkXDK3T8NSCKNg/xu4Olc2KsD8iDs/V2
 DBA=
X-IronPort-AV: E=Sophos;i="5.76,399,1592841600"; d="scan'208";a="147906061"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
 by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 03:50:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO900N9b9Q8CpldXISQbk0KP6RfTXKDTuAL9PO/ty+PYMmnTaCxxRud6JqhYnlQdE9C7ItwuKdkkqXLS6POk1DknhhRbbd5pXFx76zPiziPx5QNSUrlnQhdZs4BV87o+oevc/yYRaQQCce5fKGwAdgfoDEdzAY1MXyvLkq7218VOBNKcqD9dJnNlVh7p97uNtIzE2p9+2FcCWKVYSYb2+mljEesq3ubz1ZwbOIBYDDE/Dx2VVfDVsRC2/WUO4nRFbxsHWTzhOxIyvXXbhVsFviGTwG0ofxiwCkepk0RsMGvugixpQVzrlnbE8ee6MKrhliZCWLGNybeIDa4JWOjMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9oOPypsyufOuBu2svScmYsvIwodnEtjjbCCXZl8YU0=;
 b=YyxwOs7LF4waLba8YypYJAAADTYoSdwXpKaakQ4PvjUamc9qSwFIh7oit9NAQNtlFpBGogj5ihCbmRMTQEnXjER1V9j+zMxMR2OX6dn3AZIS9kqwM/3SvWrkvWbjG9xTC5UgZFgCCxw0T8429zSHQWzfHixmyERzgpcu69fP/bPXEh3A3VPg48Gc+sVBlcgrJGw7FVRm8ER05jfe8LQPGkrietDUYI6kMXDnm0kUnuqheqRZoW/Nn7Vy0UTGK4i6zR8wNU06Fs8YkZWxjqkI2oDUPQKVBFaai3xuWeoOok7kJeEyGENTThXDaT+ovIPsYf1PZ6QwooFxy8w/V9yPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9oOPypsyufOuBu2svScmYsvIwodnEtjjbCCXZl8YU0=;
 b=AVaIpeJNvE9fzM6Sz6XTNWX0xqArXGQsoRcUp1+N4S1vHQgNHbWID2x6UaOQ2zXJ2U88etBdtDbRY/9Xb6Ut8rRgNQlhVKVWIgEGd6L6mCH4QOuiBkvjEta4Y8Vfx0nOgP7K/JHTISADX7b41C7EoJ3WgHbB3x4qKTDL33V+fpo=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5680.namprd04.prod.outlook.com (2603:10b6:208:3a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Sun, 6 Sep
 2020 19:50:13 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3348.019; Sun, 6 Sep 2020
 19:50:13 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, Tom Yan <tom.ty89@gmail.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "anielhb@linux.vnet.ibm.com" <anielhb@linux.vnet.ibm.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Subject: RE: [PATCH v4 2/2] file-posix: add sg_get_max_segments that actually
 works with sg
Thread-Topic: [PATCH v4 2/2] file-posix: add sg_get_max_segments that actually
 works with sg
Thread-Index: AQHWgmCqZXNHz4t/1kKDFv3XFB7gGKlbdHEAgAAB44CAAB5EgIAAKuiAgAAbqACAACasIA==
Date: Sun, 6 Sep 2020 19:50:12 +0000
Message-ID: <MN2PR04MB59515F55488E14F1859D7C42E12B0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200904020907.241550-1-tom.ty89@gmail.com>
 <20200904020907.241550-2-tom.ty89@gmail.com>
 <CAGnHSEnF--OJ9biTx_ZxgqizVtr+0rBL8o-b9wY9+XNsnLPV=A@mail.gmail.com>
 <CAGnHSE=qnj8a8qaS6eiFdevp6ya0GjqXHuDgAV12B0tEAajddg@mail.gmail.com>
 <f5f5a6e2f4cc75c84e1364ab1276ee22aa5e3748.camel@redhat.com>
 <CAGnHSEkdTBBdT-Dm1Ztazq-ZxkLU5zq=3kYa_uiqna2uzm0Gkg@mail.gmail.com>
 <46216704388f0c33c18e3a1d54505ab5e71c8cb2.camel@redhat.com>
In-Reply-To: <46216704388f0c33c18e3a1d54505ab5e71c8cb2.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 629d1a22-bf15-4895-bbee-08d8529e1207
x-ms-traffictypediagnostic: MN2PR04MB5680:
x-microsoft-antispam-prvs: <MN2PR04MB568033C5052D37DFF3E7B51AE12B0@MN2PR04MB5680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zM7IFBLvhlq2ncxeyfAIkkDOgtcgK5KbXH6qvaJGw253ZFRrkM/iH9LDhn17AFgdMO9mhZbV5+oSY9TMZ1EZDMQ3ANLKIKindKQzKLVsQY8LLVyrj9y1BY3M+AIwKFbod7Z7bsQ45Na2K4o008RBQcnWqCt/C4nKuyGOXVctrP5JMaIuNxFNYFh6Mx3l+H2AnR0mb8Y8sOHme46QbxQggHHedtbhnXG+xBD7HgXolJWo4fB7P0lpAfMY+SHKrfIHZwgPkmQkzzc0sz127pJe2Gg0WP6+OFGAiZrxFSmKqAQvzzXoKYvdO1QcVTubDLrnkzMskKz9BAkwDGSyzo/jMJubYapAlraQ7qTdHmIIFvAAl1GK4mGy76O6HDpTIEh3NNWI5aQOtzUYCZL4qnbTrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(64756008)(7416002)(66476007)(966005)(55016002)(9686003)(7696005)(2906002)(26005)(186003)(8936002)(76116006)(316002)(110136005)(54906003)(53546011)(4326008)(6506007)(8676002)(66946007)(478600001)(66446008)(86362001)(5660300002)(52536014)(66556008)(33656002)(83380400001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: fpB6P9RR0xEHqm97kJbB/FxVeff+Yk/QJ5xqFEhHkxUS5VnJt/1hWQJEi3YeAh6/ld8Q7DQ9QADDkFQFRC07X3WzYTnQf+aVl7WwvrRgnidbCMZNdwOHaRFthQ50Bd4uyUOyAJmczUP/A5mqYBDyzJg+7KSMkFNw5WZALts4oBLpIrlo83Znwn0X4nyatAVVugq6ouPzk42zhs3XL10laU2FpGMuuJ1wEovo+nAHJU+Lmfby7iDg29nQKb9V4ieiGVPFMDVgTz8xWGoPV3xOvF3qNc3DriA9AU6O0z44a+baaKX9+M1aDdb3oAfHGf32FPrtQJsjwkeOj4MxwV/Bi1CsdX8bqREyQNQTJI4VtQnyYlo1lVOwEzYbeMy0rmVTlTvt5T5qFs3ksoTgfuAvSXyn75y3q5ciRswioKBedDRZJ75R7sTrgTDMTvziMbZsOiijvkV081Cu2UfI7MaEoegh8FQC0o84lQoPm6FZDsGxWO083ap5WNK135T1udC1giMsFaEnLOQSXTepeQBD+nqGBF6AomYoorV/toKRVGPPYnd5aNQvqlu1Qj/RYchFrk586miCfpf/8EQBFpaXqFshMRXQZmG9K0QG/ypR7FnbqWALGE/udpmpZ+TXog4o/HhzvumDAtsqYVXvGI3aUg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629d1a22-bf15-4895-bbee-08d8529e1207
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2020 19:50:13.0174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/boiiVJMaPupkCPy9Q46TVHoKXmIJLUgK68G/sMvWy5CJEQERyg+WPt9Key1CkPQVftHeP9JTIXKECSNxDCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5680
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=511e27070=Dmitry.Fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 15:50:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWVtdS1ibG9jayA8cWVt
dS1ibG9jay0NCj4gYm91bmNlcytkbWl0cnkuZm9taWNoZXY9d2RjLmNvbUBub25nbnUub3JnPiBP
biBCZWhhbGYgT2YgTWF4aW0NCj4gTGV2aXRza3kNCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIg
NiwgMjAyMCAxOjA2IFBNDQo+IFRvOiBUb20gWWFuIDx0b20udHk4OUBnbWFpbC5jb20+OyBlYmxh
a2VAcmVkaGF0LmNvbTsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsgZmFtQGV1cGhvbi5uZXQ7IGFu
aWVsaGJAbGludXgudm5ldC5pYm0uY29tOw0KPiBrd29sZkByZWRoYXQuY29tOyBtcmVpdHpAcmVk
aGF0LmNvbQ0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LWJsb2NrQG5vbmdudS5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzJdIGZpbGUtcG9zaXg6IGFkZCBzZ19nZXRf
bWF4X3NlZ21lbnRzIHRoYXQNCj4gYWN0dWFsbHkgd29ya3Mgd2l0aCBzZw0KPiANCj4gT24gU3Vu
LCAyMDIwLTA5LTA2IGF0IDIzOjI2ICswODAwLCBUb20gWWFuIHdyb3RlOg0KPiA+IEkgZG9uJ3Qg
ZGlzYWdyZWUgd2l0aCB5b3VyIHByb3Bvc2FsLCBidXQgdGhlIHRoaW5nIGlzLCBkbyB3ZSBldmVu
IG5lZWQNCj4gPiBhbm90aGVyIGZpZWxkL2xpbWl0IGZvciBjYXNlIDE/IEZvciBleGFtcGxlLCBk
byB3ZSAqcmVhbGx5KiBuZWVkIHRvDQo+ID4gY2xhbXAgc2l6ZXNbMl0gKE5CRF9JTkZPX0JMT0NL
X1NJWkUpIGluIG5iZC9zZXJ2ZXIuYyBhbmQNCj4gPiBtYXhfaW9fc2VjdG9ycyAoU0NTSUJsb2Nr
TGltaXRzKSBpbiBody9zY3NpL3Njc2ktZGlzay5jIHRvIHRvIGFueSBraW5kDQo+ID4gb2YgImR5
bmFtaWMiIGxpbWl0Pw0KPiANCj4gSXQgZGVwZW5kcyBvbiBpZiB3ZSBoYXZlIG90aGVyIGJsb2Nr
IGRyaXZlcnMgdGhhdCBoYXZlIElPIHNlZ21lbnQvbWF4DQo+IHRyYW5zZmVyIHNpemVzLA0KPiB0
aGF0IHdlIG5lZWQgdG8gZW5mb3JjZSwgb3RoZXIgdGhhbiB0aGUgU0dfSU8gY2FzZS4NCj4gDQo+
IEtub3dpbmcgdGhhdCB0aGUgY29tbWl0IHRoYXQgYWRkZWQgdGhlc2UgbGltaXRzIHRvIGZpbGUt
cG9zaXgsIHdoaWNoIEkgd2FzDQo+IGZpeGluZyBpcyByZWxhdGl2ZWx5DQo+IG5ldywgSSBndWVz
cyB0aGVyZSBhcmUgb3RoZXIgY2FzZXMgZm9yIHRoZXNlIGxpbWl0cy4NCj4gDQo+IEknbGwgY2hl
Y2sgdGhpcyB0b21vcnJvdy4NCj4gDQo+ID4NCj4gPiBFaXRoZXIgd2F5IEkgY2FuIGFkZCBhbm90
aGVyIGZpZWxkIChgbWF4X3B3cml0ZWAsIG1heWJlPykgdG8NCj4gPiBCbG9ja0xpbWl0cywgYXMg
YW4gaW5mcmFzdHJ1Y3R1cmUvaGludCwgYnV0IHdoYXQgc2hvdWxkIGJlIHN3aXRjaGVkIHRvDQo+
ID4gaXQsIGFuZCB3aGF0IHZhbHVlIHNob3VsZCBlYWNoIGJsb2NrIGRyaXZlciBzZXQgaXQgdG8s
IGlzIHByb2JhYmx5DQo+ID4gYmV5b25kIHdoYXQgSSBjYW4gdGFrZS4NCj4gDQo+IEltcGxlbWVu
dGF0aW9uIHdpc2UsIEkgdGhpbmsgSSBjYW4gZG8gdGhpcywgYnV0IEknbGwgd2FpdCBmZXcgZGF5
cyBmb3IgdGhlDQo+IGZlZWRiYWNrIG9uIG15IHByb3Bvc2FsLg0KPiANCj4gVGhhbmtzIGZvciBm
aW5kaW5nIHRoaXMgYnVnIQ0KDQpUaGVyZSB3YXMgYWxzbyBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjAwODExMjI1MTIyLjE3MzQyLTItZG1pdHJ5LmZvbWljaGV2QHdkYy5j
b20vDQpwb3N0ZWQgdGhyZWUgd2Vla3MgYWdvLCBidXQsIHNlZW1pbmdseSwgaXQgd2FzIGlnbm9y
ZWQuLi4gc29ycnkgaWYgdGhpcw0KYnVnIGlzIGFscmVhZHkgYmVpbmcgZml4ZWQgaW4gYSBkaWZm
ZXJlbnQgd2F5LCBidXQgSSB0aGluayB0aGUgZml4IHByZXNlbnRlZA0KaW4gdGhhdCBwYXRjaCBp
cyB3b3J0aCBjb25zaWRlcmluZy4NCg0KVmVyeSBiZXN0LA0KRG1pdHJ5DQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gCU1heGltIExldml0c2t5DQo+IA0KPiA+DQo+ID4gSU1ITyBteSBwYXRjaGVz
IHNob3VsZCBiZSBtZXJnZWQgZmlyc3QgKHRoZXkgYXJlIHJlYWxseSBqdXN0IGZpeGluZyBhDQo+
ID4gcmVncmVzc2lvbiBhbmQgc29tZSBidWdzKS4gSWYgYW55b25lIGZpbmRzIGl0IG5lY2Vzc2Fy
eSBhbmQgaXMgY2FwYWJsZQ0KPiA+IGFuZCB3aWxsaW5nIHRvIGZpeCB0aGUgaW5zdWZmaWNpZW5j
eSBvZiBCbG9ja0xpbWl0cywgdGhleSBjYW4gZG8gaXQNCj4gPiBhZnRlcndhcmRzIHdpdGggYW5v
dGhlciBwYXRjaCBzZXJpZXMgYXMgYW4gaW1wcm92ZW1lbnQuIEkgY2FuIGFkZCBhDQo+ID4gcGF0
Y2ggdG8gcmVtb3ZlIHRoZSBjbGFtcGluZyBpbiBuYmQvc2VydmVyLmMgYXMgYSBwZXJoYXBzLXRl
bXBvcmFyeQ0KPiA+IG1lYXN1cmUgdG8gYWRkcmVzcyB0aGUgb3JpZ2luYWwgaXNzdWUsIGlmIGRl
c2lyZWQuDQo+ID4NCj4gPiBPbiBTdW4sIDYgU2VwIDIwMjAgYXQgMjA6NTMsIE1heGltIExldml0
c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPg0KPiB3cm90ZToNCj4gPiA+IE9uIFN1biwgMjAyMC0w
OS0wNiBhdCAxOTowNCArMDgwMCwgVG9tIFlhbiB3cm90ZToNCj4gPiA+ID4gTWF5YmUgeW91IHdh
bnQgdG8gYWRkIHNvbWUgY29uZGl0aW9uIGZvciB0aGlzOg0KPiA+ID4gPiBodHRwczovL2dpdGh1
Yi5jb20vcWVtdS9xZW11L2Jsb2IvdjUuMS4wL25iZC9zZXJ2ZXIuYyNMNjU5DQo+ID4gPiA+IE9y
IG5vdCBjbGFtcCBpdCBhdCBhbGwuDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFN1biwgNiBTZXAgMjAy
MCBhdCAxODo1OCwgVG9tIFlhbiA8dG9tLnR5ODlAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4g
PiBJbiBjb21taXQgODY3ZWNjZmVkODRmOTZiNTRmNGE0MzJjNTEwYTAyYzJjZTAzYjQzMCwgTGV2
aXRza3kNCj4gYXBwZWFycw0KPiA+ID4gPiA+IHRvIGhhdmUgYXNzdW1lZCB0aGF0IHRoZSBvbmx5
ICJTQ1NJIFBhc3N0aHJvdWdoIiBpcyBgLWRldmljZQ0KPiA+ID4gPiA+IHNjc2ktZ2VuZXJpY2As
IHdoaWxlIHRoZSBmYWN0IGlzIHRoZXJlJ3MgYWxzbyBgLWRldmljZSBzY3NpLWJsb2NrYA0KPiA+
ID4gPiA+IChwYXNzdGhyb3VnaCB3aXRob3V0IHRoZSBzZyBkcml2ZXIpLiBVbmxpa2UgYC1kZXZp
Y2Ugc2NzaS1oZGAsIGdldHRpbmcNCj4gPiA+ID4gPiBtYXhfc2VjdG9ycyBpcyBuZWNlc3Nhcnkg
dG8gaXQgKG1vcmUgcHJlY2lzZWx5LCBod19tYXhfc2VjdG9ycw0KPiBtaWdodA0KPiA+ID4gPiA+
IHdoYXQgbWF0dGVycywgYnV0IEJMS1NFQ1RHRVQgcmVwb3J0cyBtYXhfc2VjdG9ycywgc28pLg0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gSSdtIHVuc3VyZSBhYm91dCBob3cgcWVtdS1uYmQgd29ya3Ms
IGJ1dCB0aGUgY29tbWl0IGNsZWFybHkNCj4gd2Fzbid0IHRoZQ0KPiA+ID4gPiA+IHJpZ2h0IGFw
cHJvYWNoIHRvIGZpeCB0aGUgb3JpZ2luYWwgaXNzdWUgaXQgYWRkcmVzc2VzLiAoSXQgc2hvdWxk
IGZvcg0KPiA+ID4gPiA+IGV4YW1wbGUgaWdub3JlIHRoZSBtYXhfdHJhbnNmZXIgaWYgaXQgd2ls
bCBuZXZlciBtYXR0ZXIgaW4gdG8gaXQsIG9yDQo+ID4gPiA+ID4gb3ZlcnJpZGVzIGl0IGluIGNl
cnRhaW4gY2FzZXM7IHdoZW4gSSBnbGltcHNlZCBvdmVyDQo+ID4gPiA+ID4gaHR0cHM6Ly9idWd6
aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNjQ3MTA0LCBJIGRvbid0IHNlZQ0KPiBo
b3cNCj4gPiA+ID4gPiBpdCBjb3VsZCBiZSBmaWxlLXBvc2l4IHByb2JsZW0gd2hlbiBpdCBpcyBy
ZXBvcnRpbmcgdGhlIHJpZ2h0IHRoaW5nLA0KPiA+ID4gPiA+IHJlZ2FyZGxlc3Mgb2Ygd2hldGhl
ciAicmVtb3ZpbmciIHRoZSBjb2RlIGhlbHBzLikNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgZG9u
J3QgdGhpbmsgd2Ugd2FudCB0byAibWFyayIgYC1kZXZpY2Ugc2NzaS1ibG9ja2AgYXMgc2cgZWl0
aGVyLiBJdA0KPiA+ID4gPiA+IHdpbGwgcHJvYmFibHkgYnJpbmcgZXZlbiBtb3JlIHVuZXhwZWN0
ZWQgcHJvYmxlbXMsIGJlY2F1c2UgdGhleQ0KPiBhcmUNCj4gPiA+ID4gPiBsaXRlcmFsbHkgZGlm
ZmVyZW50IHNldHMgb2YgdGhpbmdzIGJlaGluZCB0aGUgc2NlbmUgLyBpbiB0aGUga2VybmVsLg0K
PiA+ID4NCj4gPiA+IFllcywgSSBkaWQgb3Zlcmxvb2sgdGhlIGZhY3QgdGhhdCBzY3NpLWJsb2Nr
IGlzIGtpbmQgb2YgaHlicmlkIHBhc3N0aG91Z2gNCj4gZGV2aWNlLA0KPiA+ID4gZG9pbmcgU0df
SU8gZm9yIHNvbWUgdGhpbmdzIGFuZCByZWd1bGFyIElPIGZvciBvdGhlcnMuDQo+ID4gPg0KPiA+
ID4gSSBkb24ndCB0aGluayB0aGF0IG15IGFwcHJvYWNoIHdhcyB3cm9uZyB3YXkgdG8gZml4IHRo
ZSBwcm9ibGVtLCBidXQgYXMNCj4geW91IGZvdW5kDQo+ID4gPiBvdXQsIGFidXNpbmcgJ2JzLT5z
ZycgaGFjayAod2hpY2ggSSB3b3VsZCBiZSB2ZXJ5IGhhcHB5IHRvIHJlbW92ZQ0KPiBjb21wbGV0
ZWx5KQ0KPiA+ID4gd2Fzbid0IGEgZ29vZCBpZGVhLg0KPiA+ID4gSSBhY3R1YWx5IHdhcyBhd2Fy
ZSBvZiBzY3NpLWJsb2NrIGFuZCB0aGF0IGl0IGRvZXMgU0dfSU8gYnV0IGl0DQo+ID4gPiB3YXMg
Zm9yZ290dGVuIHNvbWUgd2hlcmUgb24gdGhlIHdheS4NCj4gPiA+DQo+ID4gPiBTbyBpbiBzdW1t
YXJ5IHdoYXQgdGhlIHByb2JsZW0gaXMgYW5kIHdoYXQgSSB0aGluayBpcyB0aGUgcmlnaHQgc29s
dXRpb246DQo+ID4gPg0KPiA+ID4NCj4gPiA+IEVhY2ggcWVtdSBibG9jayBkcml2ZXIgZXhwb3Nl
cyBibG9jayBsaW1pdHMgYW5kIGFzc3VtZXMgdGhhdCB0aGV5IGFyZQ0KPiB0aGUgc2FtZQ0KPiA+
ID4gZm9yIHR3byBJTyBpbnRlcmZhY2VzIHRoZSBibG9jayBkcml2ZXIgY2FuIGV4cG9zZToNCj4g
PiA+DQo+ID4gPiAxLiBSZWd1bGFyIHFlbXUgYmxrX3ByZWFkL3B3cml0ZSBhbGlrZSBmdW5jdGlv
bnMNCj4gPiA+IDIuIGJsa19pb2N0bCAodGlueSB3cmFwcGVyIGFnYWluc3QgU0dfSU8pLCBzdXBw
b3J0ZWQgYnkgcG9zaXgtcmF3IG9uDQo+ID4gPiAgICBob3N0IGJsb2NrIGRldmljZXMvc2cgY2hh
ciBkZXZpY2VzLCBhbmQgYnkgaXNjc2kNCj4gPiA+DQo+ID4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0
IHRoZXNlIHR3byBpbnRlcmZhY2VzIGNhbiBoYXZlIGRpZmZlcmVudCBibG9jayBsaW1pdHMuDQo+
ID4gPg0KPiA+ID4gSSBkb24ndCBrbm93IGFib3V0IGlzY3NpLCBidXQgZm9yIGZpbGVzLCBkb2lu
ZyByZWd1bGFyIElPIGlzIGFsd2F5cyB1bmxpbWl0ZWQsDQo+ID4gPiBzaW5jZSBpdCBwYXNzZXMg
dGhyb3VnaCB0aGUga2VybmVsIGJsb2NrIGxheWVyIGFuZCBzZWdlbWVudGVkIHRoZXJlIG9uDQo+
ID4gPiBkZW1hbmQgd2hpY2ggaXMgZmFzdGVyIHRoYXQgZG9pbmcgaXQgaW4gdXNlcnNwYWNlLCB3
aGlsZSBTR19JTyBpcyBwYXNzZWQNCj4gYXMgaXMNCj4gPiA+IHRvIHRoZSB1bmRlcmx5aW5nIFND
U0kgZGV2aWNlIGFuZCBsYWNrcyB0aGlzIHNlZ21lbnRhdGlvbi4NCj4gPiA+DQo+ID4gPiBSZWdh
cmRsZXNzIG9mIGhvdyBOQkQgdXNlcyB0aGVzZSBsaW1pdHMsIEkgdGhpbmsgdGhhdCB0aGVzZSBs
aW1pdHMgc2hvdWxkDQo+IGJlIGNvcnJlY3RseQ0KPiA+ID4gZXhwb3NlZCBieSB0aGUgYmxvY2sg
ZHJpdmVycywgYW5kIHRoZXJlZm9yZSBJIHByb3Bvc2UgaXMgdGhhdCBlYWNoIHFlbXUNCj4gYmxv
Y2sgZHJpdmVyDQo+ID4gPiB3b3VsZCBleHBvc2UgYSBwYWlyIG9mIGJsb2NrIGxpbWl0cy4NCj4g
PiA+IE9uZSBmb3IgdGhlIHJlZ3VsYXIgYmxvY2sgSU8sIGFuZCBvdGhlciBmb3IgU0dfSU8uDQo+
ID4gPg0KPiA+ID4gVGhlbiBibG9jayBkcml2ZXIgY2xpZW50cyAobGlrZSBzY3NpIGRldmljZXMg
dGhhdCB5b3UgbWVudGlvbiwgbmJkLCBldGMpDQo+ID4gPiBjYW4gY2hvb3NlIHdoaWNoIGxpbWl0
IHRvIHVzZSwgZGVwZW5kaW5nIG9uIHdoaWNoIElPIGFwaSB0aGV5IHVzZS4NCj4gPiA+IFRoZSBz
Y3NpLWdlbmVyaWMsIGFuZCBzY3NpLWJsb2NrIGNhbiB1c2UgdGhlIFNHX0lPIGxpbWl0cywNCj4g
PiA+IHdoaWxlIHRoZSByZXN0ICBjYW4gdXNlIHRoZSBub3JtYWwgKHVubGltaXRlZCBmb3IgZmls
ZSBJL08pIGxpbWl0cywgaW5jbHVkaW5nDQo+IHRoZSBOQkQuDQo+ID4gPg0KPiA+ID4gQmVzdCBy
ZWdhcmRzLA0KPiA+ID4gICAgICAgICBNYXhpbSBMZXZpdHNreQ0KPiA+ID4NCj4gPiA+ID4gPiBP
biBGcmksIDQgU2VwIDIwMjAgYXQgMTA6MDksIFRvbSBZYW4gPHRvbS50eTg5QGdtYWlsLmNvbT4g
d3JvdGU6DQo+ID4gPiA+ID4gPiBzZyBkZXZpY2VzIGhhdmUgZGlmZmVyZW50IG1ham9yL21pbm9y
IHRoYW4gdGhlaXIgY29ycmVzcG9uZGluZw0KPiA+ID4gPiA+ID4gYmxvY2sgZGV2aWNlcy4gVXNp
bmcgc3lzZnMgdG8gZ2V0IG1heCBzZWdtZW50cyBuZXZlciByZWFsbHkgd29ya2VkDQo+ID4gPiA+
ID4gPiBmb3IgdGhlbS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBGb3J0dW5hdGVseSB0aGUg
c2cgZHJpdmVyIHByb3ZpZGVzIGFuIGlvY3RsIHRvIGdldCBzZ190YWJsZXNpemUsDQo+ID4gPiA+
ID4gPiB3aGljaCBpcyBhcHBhcmVudGx5IGVxdWl2YWxlbnQgdG8gbWF4IHNlZ21lbnRzLg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRvbSBZYW4gPHRvbS50eTg5QGdt
YWlsLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gIGJsb2NrL2ZpbGUtcG9zaXgu
YyB8IDE3ICsrKysrKysrKysrKysrKystDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvYmxvY2svZmlsZS1wb3NpeC5jIGIvYmxvY2svZmlsZS1wb3NpeC5jDQo+ID4g
PiA+ID4gPiBpbmRleCA0MTFhMjNjZjk5Li45ZTM3NTk0MTQ1IDEwMDY0NA0KPiA+ID4gPiA+ID4g
LS0tIGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+ID4gPiA+ID4gPiArKysgYi9ibG9jay9maWxlLXBv
c2l4LmMNCj4gPiA+ID4gPiA+IEBAIC0xMTc4LDYgKzExNzgsMjEgQEAgc3RhdGljIGludA0KPiBz
Z19nZXRfbWF4X3RyYW5zZmVyX2xlbmd0aChpbnQgZmQpDQo+ID4gPiA+ID4gPiAgI2VuZGlmDQo+
ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IHNnX2dl
dF9tYXhfc2VnbWVudHMoaW50IGZkKQ0KPiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ICsjaWZk
ZWYgU0dfR0VUX1NHX1RBQkxFU0laRQ0KPiA+ID4gPiA+ID4gKyAgICBsb25nIG1heF9zZWdtZW50
cyA9IDA7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgIGlmIChpb2N0bChmZCwgU0df
R0VUX1NHX1RBQkxFU0laRSwgJm1heF9zZWdtZW50cykgPT0gMCkgew0KPiA+ID4gPiA+ID4gKyAg
ICAgICAgcmV0dXJuIG1heF9zZWdtZW50czsNCj4gPiA+ID4gPiA+ICsgICAgfSBlbHNlIHsNCj4g
PiA+ID4gPiA+ICsgICAgICAgIHJldHVybiAtZXJybm87DQo+ID4gPiA+ID4gPiArICAgIH0NCj4g
PiA+ID4gPiA+ICsjZWxzZQ0KPiA+ID4gPiA+ID4gKyAgICByZXR1cm4gLUVOT1NZUzsNCj4gPiA+
ID4gPiA+ICsjZW5kaWYNCj4gPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
PiAgc3RhdGljIGludCBnZXRfbWF4X3RyYW5zZmVyX2xlbmd0aChpbnQgZmQpDQo+ID4gPiA+ID4g
PiAgew0KPiA+ID4gPiA+ID4gICNpZiBkZWZpbmVkKEJMS1NFQ1RHRVQpICYmIGRlZmluZWQoQkxL
U1NaR0VUKQ0KPiA+ID4gPiA+ID4gQEAgLTEyNjgsNyArMTI4Myw3IEBAIHN0YXRpYyB2b2lkDQo+
IGhkZXZfcmVmcmVzaF9saW1pdHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCkN
Cj4gPiA+ID4gPiA+ICAgICAgICAgIGJzLT5ibC5tYXhfdHJhbnNmZXIgPSBwb3cyZmxvb3IocmV0
KTsNCj4gPiA+ID4gPiA+ICAgICAgfQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0gICAgcmV0
ID0gZ2V0X21heF9zZWdtZW50cyhzLT5mZCk7DQo+ID4gPiA+ID4gPiArICAgIHJldCA9IGJzLT5z
ZyA/IHNnX2dldF9tYXhfc2VnbWVudHMocy0+ZmQpIDoNCj4gZ2V0X21heF9zZWdtZW50cyhzLT5m
ZCk7DQo+ID4gPiA+ID4gPiAgICAgIGlmIChyZXQgPiAwKSB7DQo+ID4gPiA+ID4gPiAgICAgICAg
ICBicy0+YmwubWF4X3RyYW5zZmVyID0gTUlOX05PTl9aRVJPKGJzLT5ibC5tYXhfdHJhbnNmZXIs
DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldCAqIHFlbXVfcmVhbF9ob3N0X3BhZ2Vfc2l6ZSk7DQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4g
PiA+ID4gMi4yOC4wDQo+ID4gPiA+ID4gPg0KPiANCj4gDQoNCg==

