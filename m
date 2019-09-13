Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C6AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19D920693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h/EqBCzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19D920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mql-0006sx-Mo
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8moP-0004qI-P6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8moO-0006A7-H9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:44:37 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com
 ([40.107.6.133]:63299 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8mo6-00060K-Qx; Fri, 13 Sep 2019 10:44:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8c15U0Urd/J1gtqokdHJA+EAcGNe+kYZ9UQ6kJi4dyciIPJRHS7vPZ+lhNv3eXihS7eeIDweOAKE9aS9IOW0YMisKV/5Xkf+IAaEKjXB+yaMocQ0txEVhJAqX5TPog/xDKczLviQkSGdSVs41KmrkHoClWLmbZXbiambFvrPvcIaQf3dE9l/3p+5fRLG8/BZoft9kaUxMcnut1M2sptPsFQM7bWpPywPkEzK2kR++exBfMJL/XcFX8RmjBrrd7YCyeRfyV/uD7DZBvkQo6XnAImiwC+Z7USVMl3Ifh6euPuWbylRF3unZ26a1TluBBxyp3Bg6Q/6zPDhoeO63hmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scfIvAMI6CBs28GHkrfuoIM4vnPF++vpAps3LZ7W0mA=;
 b=QS/Me6kIIR8SZQ66eTY9Fykw262THKnohIkPTZ2Q9vFwI1dYEnIRrKmyj+nlJrG41Pe5vo6l6KdJN3jvSDug7tQyT1WcfCc+mauJjJcMA7cweAZjob3Yo8JbeZ7pcZEad9PG18bEai/klL2A1f47B0Hc313uXJMAo5JmM0Dm3rcrAw9L0Ku5t6r2vZRyUTwfNNytkRj22qIJrL0J4vRvmBbQ4PXQP9YgnQucjTKRyUL/35nFBjf35R1ANESdWgm2ouvwuQ8VLrGGvPqHzQG2NgP6HHBt6f9OTaJpI5HhBlmsSLWCFsE0vspeegKQrNGPXilcZzCoSW1hYaKzJBxXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scfIvAMI6CBs28GHkrfuoIM4vnPF++vpAps3LZ7W0mA=;
 b=h/EqBCzB0rjrFys24zNSDLntH5h+jW4UWmecEASxTvd0X1FDi0nswNRXUlNErgOAWW0dfBmrSityczVornnb4NGp9VKFOH7kGK43fcCeWbEhFl+b4tfmCJ0duTJzUfiuaJVt5JP5coZCF8AE9IkE+DZJSs1VSYvqjER5qefT9IM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5145.eurprd08.prod.outlook.com (10.255.18.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14; Fri, 13 Sep 2019 14:44:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 14:44:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v4 1/3] block/qcow2: refactoring of threaded
 encryption code
Thread-Index: AQHVajMOj6Verwh1NkqU8HmUL2OtZKcpoxmAgAAByACAAAS5AIAAA4KAgAAB6YA=
Date: Fri, 13 Sep 2019 14:44:16 +0000
Message-ID: <7ab84515-3097-fd0d-4b81-2f10d247f91a@virtuozzo.com>
References: <20190913125909.15348-1-mlevitsk@redhat.com>
 <20190913125909.15348-2-mlevitsk@redhat.com>
 <5d578974-d02d-8b05-8d51-85715d1d4468@virtuozzo.com>
 <5fdc4891c02c7977762bb76fd877e4383e04be0c.camel@redhat.com>
 <20190913142450.GI8312@dhcp-200-226.str.redhat.com>
 <fcde308649669fa3379d8477b06194634e0ccd44.camel@redhat.com>
In-Reply-To: <fcde308649669fa3379d8477b06194634e0ccd44.camel@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0072.eurprd07.prod.outlook.com
 (2603:10a6:3:64::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913174413438
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f61105-dee9-4d46-3001-08d73858da24
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5145; 
x-ms-traffictypediagnostic: DB8PR08MB5145:
x-microsoft-antispam-prvs: <DB8PR08MB5145143132FE95E513A4B8CEC1B30@DB8PR08MB5145.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:247;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39840400004)(199004)(189003)(5660300002)(6512007)(6486002)(3846002)(71190400001)(256004)(6116002)(52116002)(186003)(71200400001)(99286004)(31696002)(86362001)(478600001)(36756003)(76176011)(6246003)(31686004)(102836004)(81166006)(81156014)(26005)(4326008)(229853002)(316002)(66066001)(14454004)(66946007)(446003)(54906003)(66446008)(64756008)(8936002)(66476007)(66556008)(476003)(486006)(2616005)(25786009)(110136005)(11346002)(305945005)(53936002)(2906002)(8676002)(7736002)(386003)(6506007)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5145;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h+xO6shDxxzX9dHD3MY9zBlqeWxP8Sfyc8cV9cWGp32OT7+Z+ebuwjWkLddZDA3Yr94UQDjyfNktmXzFpcdgkf+K2ux9ViXWC7CF9Wzof6GMy3Y6mG+xtGhqRPcUrQ7yUmBVAQdX8/ZvcFDQwss5w90PRARL/EG3nddsH50rn2/5NEa4GMN7Ws6xqKkmrjYyOSbEcvs4e/UsvxRgBoIEJjsBbQbnwoDEvbD9JuUmFrFIdeWQibxrF468Pi6whF50TDCGFr+1rrY8ZX54vUfPicZ9/NbnfIHb5QQOgisyk5G5BmBU3CvywWeaiqEc4IydwmaZ6cgmbXlWDo4OqFxW9zE4uo3DuI2l78bMFEEKhhtE2eCQ1z2VRryTv8WkBOw6YfkZCqEi55PL/ov9lHnPZCnLR6vE2AwkFwqCF59FEU4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F72FF66112C3740B9292CB2398A52E5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f61105-dee9-4d46-3001-08d73858da24
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 14:44:16.5747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5CcsYJkZVNFPWpzt+UVOsRYz5O9aO/+fa5fiKsApl2Y2ooU31p3CACgVLabD6n6nu562/WmQnB/z58iiBhOg2dS6XYHB6F4nPOaVrqmQIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.133
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block/qcow2: refactoring of
 threaded encryption code
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
Cc: Max Reitz <mreitz@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDkuMjAxOSAxNzozNywgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+IE9uIEZyaSwgMjAxOS0w
OS0xMyBhdCAxNjoyNCArMDIwMCwgS2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDEzLjA5LjIwMTkg
dW0gMTY6MDcgaGF0IE1heGltIExldml0c2t5IGdlc2NocmllYmVuOg0KPj4+IE9uIEZyaSwgMjAx
OS0wOS0xMyBhdCAxNDowMSArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+Pj4gMTMuMDkuMjAxOSAxNTo1OSwgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+Pj4+PiBU
aGlzIGNvbW1pdCB0cmllcyB0byBjbGFyaWZ5IGZldyBmdW5jdGlvbiBhcmd1bWVudHMsDQo+Pj4+
PiBhbmQgYWRkIGNvbW1lbnRzIGRlc2NyaWJpbmcgdGhlIGVuY3J5cHQvZGVjcnlwdCBpbnRlcmZh
Y2UNCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXhpbSBMZXZpdHNreSA8bWxldml0c2tA
cmVkaGF0LmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICAgYmxvY2svcWNvdzItY2x1c3Rlci5jIHwg
IDkgKysrKy0tLQ0KPj4+Pj4gICAgYmxvY2svcWNvdzItdGhyZWFkcy5jIHwgNjIgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPj4+Pj4gICAgYmxvY2svcWNvdzIu
YyAgICAgICAgIHwgIDUgKystLQ0KPj4+Pj4gICAgYmxvY2svcWNvdzIuaCAgICAgICAgIHwgIDgg
KysrLS0tDQo+Pj4+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDIzIGRl
bGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi1jbHVzdGVy
LmMgYi9ibG9jay9xY293Mi1jbHVzdGVyLmMNCj4+Pj4+IGluZGV4IGYwOWNjOTkyYWYuLjQ2YjA4
NTRkN2UgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9ibG9jay9xY293Mi1jbHVzdGVyLmMNCj4+Pj4+ICsr
KyBiL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYw0KPj4+Pj4gQEAgLTQ2Myw4ICs0NjMsOCBAQCBzdGF0
aWMgaW50IGNvcm91dGluZV9mbiBkb19wZXJmb3JtX2Nvd19yZWFkKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLA0KPj4+Pj4gICAgfQ0KPj4+Pj4gICAgDQo+Pj4+PiAgICBzdGF0aWMgYm9vbCBjb3JvdXRp
bmVfZm4gZG9fcGVyZm9ybV9jb3dfZW5jcnlwdChCbG9ja0RyaXZlclN0YXRlICpicywNCj4+Pj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRf
dCBzcmNfY2x1c3Rlcl9vZmZzZXQsDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgY2x1c3Rlcl9vZmZzZXQsDQo+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgZ3Vl
c3RfY2x1c3Rlcl9vZmZzZXQsDQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDY0X3QgaG9zdF9jbHVzdGVyX29mZnNldCwNCj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVk
IG9mZnNldF9pbl9jbHVzdGVyLA0KPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqYnVmZmVyLA0KPj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgYnl0ZXMpDQo+
Pj4+PiBAQCAtNDc0LDggKzQ3NCw5IEBAIHN0YXRpYyBib29sIGNvcm91dGluZV9mbiBkb19wZXJm
b3JtX2Nvd19lbmNyeXB0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+Pj4gICAgICAgICAgICBh
c3NlcnQoKG9mZnNldF9pbl9jbHVzdGVyICYgfkJEUlZfU0VDVE9SX01BU0spID09IDApOw0KPj4+
Pj4gICAgICAgICAgICBhc3NlcnQoKGJ5dGVzICYgfkJEUlZfU0VDVE9SX01BU0spID09IDApOw0K
Pj4+Pj4gICAgICAgICAgICBhc3NlcnQocy0+Y3J5cHRvKTsNCj4+Pj4+IC0gICAgICAgIGlmIChx
Y293Ml9jb19lbmNyeXB0KGJzLCBjbHVzdGVyX29mZnNldCwNCj4+Pj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNyY19jbHVzdGVyX29mZnNldCArIG9mZnNldF9pbl9jbHVzdGVyLA0K
Pj4+Pj4gKyAgICAgICAgaWYgKHFjb3cyX2NvX2VuY3J5cHQoYnMsDQo+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBob3N0X2NsdXN0ZXJfb2Zmc2V0ICsgb2Zmc2V0X2luX2NsdXN0
ZXIsDQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBndWVzdF9jbHVzdGVyX29m
ZnNldCArIG9mZnNldF9pbl9jbHVzdGVyLA0KPj4+Pg0KPj4+PiBvb3BzLCBzZWVtcyB5b3UgYWNj
aWRlbnRhbGx5IGZpeGVkIHRoZSBidWcsIHdoaWNoIHlvdSBhcmUgZ29pbmcgdG8gZml4IGluIHRo
ZSBuZXh0DQo+Pj4+IHBhdGNoLCBhcyBub3cgY29ycmVjdCBvZmZzZXRzIGFyZSBnaXZlbiB0byBx
Y293Ml9jb19lbmNyeXB0IDopDQo+Pj4+DQo+Pj4+IGFuZCBuZXh0IHBhdGNoIG5vIGlzIGEgc2lt
cGxlIG5vLWxvZ2ljLWNoYW5nZSByZWZhY3RvcmluZywgc28gYXQgbGVhc3QgY29tbWl0IG1lc3Nh
Z2UNCj4+Pj4gc2hvdWxkIGJlIGNoYW5nZWQuDQo+Pj4NCj4+PiBZZXAgOi0oIEkgYW0gdHJ5aW5n
IG15IGJlc3QgaW4gYWRkaXRpb24gdG8gZml4aW5nIHRoZSBidWcsIGFsc28gY2xhcmlmeSB0aGUg
YXJlYSB0bw0KPj4+IGF2b2lkIHRoaXMgZnJvbSBoYXBwZW5pbmcgYWdhaW4uDQo+Pj4NCj4+PiBX
aGF0IGRvIHlvdSB0aGluayB0aGF0IEkgZm9sZCB0aGVzZSB0d28gcGF0Y2hlcyB0b2dldGhlciBh
ZnRlciBhbGw/DQo+Pg0KPj4gTm8sIGp1c3QgbWFrZSBzdXJlIHRoYXQgeW91ciByZWZhY3Rvcmlu
ZyBwYXRjaCBpcyByZWFsbHkganVzdA0KPj4gcmVmYWN0b3Jpbmcgd2l0aG91dCBzZW1hbnRpYyBj
aGFuZ2UsIGkuZS4gbWFrZSBzdXJlIHRvIHByZXNlcnZlIHRoZSBidWcNCj4+IGluIHRoaXMgcGF0
Y2guDQo+Pg0KPj4gTWF5YmUgeW91IHNob3VsZCBhY3R1YWxseSBoYXZlIHR3byByZWZhY3Rvcmlu
ZyBwYXRjaGVzICh0aGlzIG9uZSB3aXRob3V0DQo+PiB0aGUgYWRkaXRpb24gb2Ygb2Zmc2V0X2lu
X2NsdXN0ZXIsIGFuZCBwYXRjaCAyKSBhbmQgYW4gYWRkaXRpb25hbA0KPj4gb25lLWxpbmVyIGZv
ciB0aGUgYWN0dWFsIGZpeC4NCj4+DQo+PiBLZXZpbg0KPiANCj4gTGV0IG1lIGRvIGl0IHNpbXBs
aWVyIEknbGwganVzdCBzcGxpdCBpdCB0byBvbmUgbGluZXIgcGF0Y2ggdGhhdCBmaXhlcyBpdA0K
PiBhbmQgc2Vjb25kIHBhdGNoIHRoYXQgZG9lcyBhbGwgdGhlIHJlZmFjdG9yaW5nLg0KPiANCg0K
W21lIHR5cGluZyBhY3R1YWxseSB0aGUgc2FtZSBzdWdnZXN0aW9uIGluIHBhcmFsbGVsLCBidXQg
eW91IHdlcmUgdGhlIGZpcnN0XQ0KDQpJIHRoaW5rIGl0J3MgdGhlIGJlc3Q6IGZpcnN0bHkgZml4
IHRoZSBidWcgaW4gYSBzaW1wbGUgcGF0Y2ggYW5kIHRoZW4NCnJlZmFjdG9yIHRvIG1ha2UgY29k
ZSBiZXR0ZXIuDQoNCkkgZXhwZWN0IHNvbWV0aGluZyBsaWtlIHNpbXBseQ0Kcy9jbHVzdGVyX29m
ZnNldC9zdGFydF9vZl9jbHVzdGVyKGNsdXN0ZXJfb2Zmc2V0ICsgb2Zmc2V0X2luX2NsdXN0ZXIp
IGluDQpxY293Ml9jb19lbmNyeXB0IGNhbGwgZnJvbSBkb19wZXJmb3JtX2Nvd19lbmNyeXB0LA0K
eWVzPw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

