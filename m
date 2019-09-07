Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D90C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 18:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7583B20854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vy7SWpON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7583B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6fcc-0003W5-G2
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 14:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i6fbV-0002nT-Uo
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 14:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i6fbU-0004Bh-BX
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 14:38:33 -0400
Received: from mail-eopbgr60136.outbound.protection.outlook.com
 ([40.107.6.136]:38054 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i6fbM-00045L-S4; Sat, 07 Sep 2019 14:38:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfquNIwmME+C/qHrYpybP+EVF7/HGoj6w57WT0n6nSRnXiMXhpU7DKU7XpFR2K7SK3XceasChuJVgTvOrhmm7y6y7iKEz6uM2uNjZ8GO2XZscRcP+R8E8bBgsv4c0dokr+R2VExadX+YjP5c7EyI6lPwEehZlFqGDrc0HbvKTx/8u87D2+zi/jfSONI3HkFydYX0LN+A4YO8zP6+k9LML/2VC3GoQll1HWKFmbcDYS9srxuikrsgjt8D03ZwWRPeDZOWZASiyeqr3TAxthbf4FpUfuz4mnmjYGcus2pfielIc/rLRMuT/M4cHSTh9Bv1EZIXeQkNuy3vgOo9ZZWstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdbb3jwcU3ESjRimlPkGfCwyolLZGco61vFmo/zzpvQ=;
 b=RjskM7kK34VBRYJqIJFg9Y9AfhYCfmmY4Jr24RgFTAaLBhso87dlIKLYa2Hoe7qjQhL1/cqVyXGby7XwDn8dMK6JZjoTC48FRaEiD5f6AnthrEKTQMpoRWDYy12Yc8TVYLTSk1VRj/CRJGutDwpIH5LXtu8GFEz3ZkPJSihltM35svDOqHxVPGKiTMIOrDwGczlRJbaDK2OXsPxEbG7LaXH1MhENqy8TpcHXQaPkcWGQKykOuwCLU+6afPqLUraC0wOzo9QMhaVdOZB40dRcVFd0Hc32JbWN39JJid2cSESJ87bmnK7eQiM0G1fV4lCYtsiTW+QLd0XlnUZdJzWEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdbb3jwcU3ESjRimlPkGfCwyolLZGco61vFmo/zzpvQ=;
 b=vy7SWpONc1BU/y67gD5DMfk+s4v4KOGQ/79CJUMKl2uxNQ2U5Xv2btIdulMFPXd7PWMeYXSerPw+ny4D9MU+NgjQUChYYBYjZX1DgK4fguZSOV4j+TUWhwPU10uK+Ffk1R5neqwyB40EnRGaoDc82O8Nb7eCFhRc2yXXAiyf7Ro=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5051.eurprd08.prod.outlook.com (20.179.15.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Sat, 7 Sep 2019 18:38:22 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 18:38:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 2/3] block/qcow2: fix the corruption when rebasing
 luks encrypted files
Thread-Index: AQHVZO1lNyMqSlLM1UGs/tHIE0Vt96cgjPuA
Date: Sat, 7 Sep 2019 18:38:22 +0000
Message-ID: <b5048192-4210-967f-2bfb-9068d4f6f732@virtuozzo.com>
References: <20190906195750.17651-1-mlevitsk@redhat.com>
 <20190906195750.17651-3-mlevitsk@redhat.com>
In-Reply-To: <20190906195750.17651-3-mlevitsk@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0057.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::25) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190907213819290
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b12cc0e0-2211-46df-8018-08d733c28f6c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5051; 
x-ms-traffictypediagnostic: DB8PR08MB5051:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB505181D50BEA826C4B4FCB44C1B50@DB8PR08MB5051.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:41;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(366004)(396003)(136003)(376002)(189003)(199004)(86362001)(110136005)(6116002)(229853002)(66066001)(256004)(8676002)(2501003)(66446008)(25786009)(64756008)(66556008)(66476007)(478600001)(99286004)(81156014)(11346002)(66946007)(52116002)(6246003)(81166006)(486006)(186003)(6486002)(8936002)(4326008)(476003)(5660300002)(71190400001)(71200400001)(446003)(2616005)(3846002)(305945005)(26005)(2906002)(76176011)(7736002)(53936002)(14454004)(966005)(386003)(6506007)(6436002)(31696002)(102836004)(54906003)(31686004)(6512007)(6306002)(316002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5051;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dnEN8Uj5M86W4TaFqtzMPrORtQzzdl44NKLgKFKCYPk3is6hnrF3JqLDtlRmmaCmeg8pKGdv2f8/aNXeOG86uWC6o9kRTxH04O1ZXTIghlBIhXl0rVF63tX3NgEokIC+19EWmpkRl5QJWQ350yqg9qJ7NY3jbG3KC3CBTt+6Ilp8yeVkAX/ogvZVdrTZbRJdGZCCw+lqtt4tznNUlSIVcYAzWRhBSSPj6+wy6l8+fQiAw9NQD9qo3C+SUgwyzQESL9AcZ7j6z+NfUZGcSvFbc7H6qwYGxqvRRqxgZ1HXaJdDcJMwZxUnav8a1sn57NS7uvQCPPgHeeI9x15oJkprUG3tyZYmzMrxdf9qrTJ4Y7LDzx6I75bpo6k+fr5hl+PohpZtmacd2/Mn8tLvZcr6xrjeWZyco5kqVMYeopGmGpI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F23AF59C3F10A4BB72209E1C927222B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12cc0e0-2211-46df-8018-08d733c28f6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 18:38:22.0219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uhq1YbjfYPjlNTu/cNBlNCgx/MaiFMfYxfOuNKZ/+Ci1dxnV+cY42i4rstPQQl8Lk13iqrCZ6wthaDE4nXLNSITq/NtCbwT+gQqNx7Zjmw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5051
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.136
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/qcow2: fix the corruption
 when rebasing luks encrypted files
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
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDkuMjAxOSAyMjo1NywgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+IFRoaXMgZml4ZXMgc3Vi
dGxlIGNvcnJ1cHRpb24gaW50cm9kdWNlZCBieSBsdWtzIHRocmVhZGVkIGVuY3J5cHRpb24NCj4g
aW4gY29tbWl0IDhhYzBmMTVmMzM1DQoNCk15IGZhdWx0LCBJJ20gc29ycnkgOiggQW5kIGdyZWF0
IHRoYW5rcyBmb3IgaW52ZXN0aWdhdGluZyB0aGlzIQ0KDQo+IA0KPiBCdWd6aWxsYTogaHR0cHM6
Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzQ1OTIyDQo+IA0KPiBUaGUg
Y29ycnVwdGlvbiBoYXBwZW5zIHdoZW4gd2UgZG8gYSB3cml0ZSB0aGF0DQo+ICAgICAqIHdyaXRl
cyB0byB0d28gb3IgbW9yZSB1bmFsbG9jYXRlZCBjbHVzdGVycyBhdCBvbmNlDQo+ICAgICAqIGRv
ZXNuJ3QgZnVsbHkgY292ZXIgdGhlIGZpcnN0IHNlY3Rvcg0KPiAgICAgKiBkb2Vzbid0IGZ1bGx5
IGNvdmVyIHRoZSBsYXN0IHNlY3Rvcg0KPiANCj4gSW4gdGhpcyBjYXNlLCB3aGVuIGFsbG9jYXRp
bmcgdGhlIG5ldyBjbHVzdGVycyB3ZSBDT1cgYm90aCBhcmVhcw0KPiBwcmlvciB0byB0aGUgd3Jp
dGUgYW5kIGFmdGVyIHRoZSB3cml0ZSwgYW5kIHdlIGVuY3J5cHQgdGhlbS4NCj4gDQo+IFRoZSBh
Ym92ZSBtZW50aW9uZWQgY29tbWl0IGFjY2lkZW50YWxseSBtYWRlIGl0IHNvIHdlIGVuY3J5cHQg
dGhlDQo+IHNlY29uZCBDT1cgYXJlYSB1c2luZyB0aGUgcGh5c2ljYWwgY2x1c3RlciBvZmZzZXQg
b2YgdGhlIGZpcnN0IGFyZWEuDQo+IA0KPiBGaXggdGhpcyBieToNCj4gICAqIFJlbW92ZSB0aGUg
b2Zmc2V0X2luX2NsdXN0ZXIgcGFyYW1ldGVyIG9mIGRvX3BlcmZvcm1fY293X2VuY3J5cHQsDQo+
ICAgICBzaW5jZSBpdCBpcyBtaXNsZWFkaW5nLiBUaGF0IG9mZnNldCBjYW4gYmUgbGFyZ2VyIHRo
YW4gY2x1c3RlciBzaXplDQo+ICAgICBjdXJyZW50bHkuDQoNCk9oaCwgdHJpY2t5IHRoaW5nLiBG
b3Igc3VyZSBJIG1pc3NlZCB0aGlzIGxvZ2ljLg0KDQo+IA0KPiAgICAgSW5zdGVhZCBqdXN0IGFk
ZCB0aGUgc3RhcnQgYW5kIHRoZSBlbmQgQ09XIGFyZWEgb2Zmc2V0cyB0byBib3RoIGhvc3QNCj4g
ICAgIGFuZCBndWVzdCBvZmZzZXRzIHRoYXQgZG9fcGVyZm9ybV9jb3dfZW5jcnlwdCByZWNlaXZl
cy4NCj4gDQo+ICogIGluIGRvX3BlcmZvcm1fY293X2VuY3J5cHQsIHJlbW92ZSB0aGUgY2x1c3Rl
ciBvZmZzZXQgZnJvbSB0aGUgaG9zdF9vZmZzZXQsDQo+ICAgICBhbmQgdGh1cyBwYXNzIGNvcnJl
Y3RseSB0byB0aGUgcWNvdzJfY29fZW5jcnlwdCwgdGhlIGhvc3QgY2x1c3RlciBvZmZzZXQNCj4g
ICAgIGFuZCBmdWxsIGd1ZXN0IG9mZnNldA0KPiANCj4gSW4gdGhlIGJ1Z3JlcG9ydCB0aGF0IHdh
cyB0cmlnZ2VyZWQgYnkgcmViYXNpbmcgYSBsdWtzIGltYWdlIHRvIG5ldywNCj4gemVybyBmaWxs
ZWQgYmFzZSwgd2hpY2ggbG90IG9mIHN1Y2ggd3JpdGVzLCBhbmQgY2F1c2VzIHNvbWUgZmlsZXMN
Cj4gd2l0aCB6ZXJvIGFyZWFzIHRvIGNvbnRhaW4gZ2FyYmFnZSB0aGVyZSBpbnN0ZWFkLg0KPiBC
dXQgYXMgZGVzY3JpYmVkIGFib3ZlIGl0IGNhbiBoYXBwZW4gZWxzZXdoZXJlIGFzIHdlbGwNCj4g
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tAcmVkaGF0LmNv
bT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gICBibG9jay9xY293Mi1jbHVzdGVyLmMgfCAy
OCArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fj
b3cyLWNsdXN0ZXIuYyBiL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYw0KPiBpbmRleCAxOTg5YjQyM2Rh
Li42ZGYxN2RkMjk2IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9xY293Mi1jbHVzdGVyLmMNCj4gKysr
IGIvYmxvY2svcWNvdzItY2x1c3Rlci5jDQo+IEBAIC00NjMsMjAgKzQ2MywyMCBAQCBzdGF0aWMg
aW50IGNvcm91dGluZV9mbiBkb19wZXJmb3JtX2Nvd19yZWFkKEJsb2NrRHJpdmVyU3RhdGUgKmJz
LA0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgYm9vbCBjb3JvdXRpbmVfZm4gZG9fcGVyZm9ybV9j
b3dfZW5jcnlwdChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGd1ZXN0X2NsdXN0ZXJfb2Zmc2V0
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDY0X3QgaG9zdF9jbHVzdGVyX29mZnNldCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIG9mZnNldF9pbl9jbHVzdGVyLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgZ3Vl
c3Rfb2Zmc2V0LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgaG9zdF9vZmZzZXQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqYnVmZmVyLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGJ5dGVzKQ0KPiAg
IHsNCj4gICAgICAgaWYgKGJ5dGVzICYmIGJzLT5lbmNyeXB0ZWQpIHsNCj4gICAgICAgICAgIEJE
UlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gLSAgICAgICAgYXNzZXJ0KChvZmZzZXRf
aW5fY2x1c3RlciAmIH5CRFJWX1NFQ1RPUl9NQVNLKSA9PSAwKTsNCj4gLSAgICAgICAgYXNzZXJ0
KChieXRlcyAmIH5CRFJWX1NFQ1RPUl9NQVNLKSA9PSAwKTsNCj4gKw0KPiArICAgICAgICBhc3Nl
cnQoUUVNVV9JU19BTElHTkVEKGd1ZXN0X29mZnNldCB8IGhvc3Rfb2Zmc2V0IHwgYnl0ZXMsDQo+
ICsgICAgICAgICAgICAgICBCRFJWX1NFQ1RPUl9TSVpFKSk7DQo+ICAgICAgICAgICBhc3NlcnQo
cy0+Y3J5cHRvKTsNCj4gLSAgICAgICAgaWYgKHFjb3cyX2NvX2VuY3J5cHQoYnMsIGhvc3RfY2x1
c3Rlcl9vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGd1ZXN0X2NsdXN0
ZXJfb2Zmc2V0ICsgb2Zmc2V0X2luX2NsdXN0ZXIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJ1ZmZlciwgYnl0ZXMpIDwgMCkgew0KPiArDQo+ICsgICAgICAgIGlmIChxY293Ml9j
b19lbmNyeXB0KGJzLCBzdGFydF9vZl9jbHVzdGVyKHMsIGhvc3Rfb2Zmc2V0KSwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ3Vlc3Rfb2Zmc2V0LCBidWZmZXIsIGJ5dGVzKSA8IDAp
IHsNCj4gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICAgICAgICB9DQo+ICAgICAg
IH0NCj4gQEAgLTg5MCwxMSArODkwLDE1IEBAIHN0YXRpYyBpbnQgcGVyZm9ybV9jb3coQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsIFFDb3dMMk1ldGEgKm0pDQo+ICAgDQo+ICAgICAgIC8qIEVuY3J5cHQg
dGhlIGRhdGEgaWYgbmVjZXNzYXJ5IGJlZm9yZSB3cml0aW5nIGl0ICovDQo+ICAgICAgIGlmIChi
cy0+ZW5jcnlwdGVkKSB7DQo+IC0gICAgICAgIGlmICghZG9fcGVyZm9ybV9jb3dfZW5jcnlwdChi
cywgbS0+b2Zmc2V0LCBtLT5hbGxvY19vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdGFydC0+b2Zmc2V0LCBzdGFydF9idWZmZXIsDQo+ICsgICAgICAgIGlm
ICghZG9fcGVyZm9ybV9jb3dfZW5jcnlwdChicywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG0tPm9mZnNldCArIHN0YXJ0LT5vZmZzZXQsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBtLT5hbGxvY19vZmZzZXQgKyBzdGFydC0+b2Zmc2V0LA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhcnRfYnVmZmVyLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0LT5uYl9ieXRlcykgfHwN
Cj4gLSAgICAgICAgICAgICFkb19wZXJmb3JtX2Nvd19lbmNyeXB0KGJzLCBtLT5vZmZzZXQsIG0t
PmFsbG9jX29mZnNldCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVu
ZC0+b2Zmc2V0LCBlbmRfYnVmZmVyLCBlbmQtPm5iX2J5dGVzKSkgew0KPiArICAgICAgICAgICAg
IWRvX3BlcmZvcm1fY293X2VuY3J5cHQoYnMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtLT5vZmZzZXQgKyBlbmQtPm9mZnNldCwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG0tPmFsbG9jX29mZnNldCArIGVuZC0+b2Zmc2V0LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5kX2J1ZmZlciwgZW5kLT5uYl9ieXRl
cykpIHsNCj4gICAgICAgICAgICAgICByZXQgPSAtRUlPOw0KPiAgICAgICAgICAgICAgIGdvdG8g
ZmFpbDsNCj4gICAgICAgICAgIH0NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

