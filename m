Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E50BC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F6720B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EO1ibTh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F6720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvzfq-0006Nh-2M
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58930)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvzfA-0005oV-Q4
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvzf9-0007EP-Ly
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:50:12 -0400
Received: from mail-eopbgr00114.outbound.protection.outlook.com
 ([40.107.0.114]:50754 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvzf9-0007DV-4j; Fri, 09 Aug 2019 03:50:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZeC4FwpKirU6uT1F61cvaHq8jMY9QdYZ1+4pn2Cc0PDgm3IjlZ4boKco6vADDxBjWZczuuxjeS1l11rHZJbSANqw3YRh6tgOtmYGydbpyMyyq//ortEw3EI6RbHS8Low93VWD7fLQP+K+T2K5hwZdXuh9Th5B970Tw6BR+t8jpvB3dHR2BiIfdsMdqwHPRiYqsAjVWyrTCdepe8sooE/uYyWnuuL0T/hirv3xPdpW79aKS5ipSAfrdTFCkkm5q5Xr5c+AxvhUns/DGlHdVUsZB93rRBLUkSVZpsleQK/SZmWWPy+Dj3qW571QjXFmWyUAM+tZ0R+ge2DKbpWQObwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daMF7eof8/4mWQru2UL0q8eLuu45ckJpZN9jhtMc0MY=;
 b=Gl2FSgyT3G5y8zdshCzYmYYBlEEfmkcPd8oACxCy2bn+nCa9jSfL7IU7u3wfr0dz4KZrbbM5W+1Z2NYbUi7CVz32sv4Wm/t2Gdv8NV/p1MWbAcGI7MlUOezcXSNXyPEmPmq359JTWniQaLbHNM0ae3h6GwjIVzPv+cFRCYHUjtuWv6PXkyMpoqMGiZ5DIUCY2z5ee9vALpV8FwVSm4CATXDt5/fgj2cO//jPsOHoNSkH19bdmWvWaNWG35N2BW4sPq8D9V6m0BJqcRjOLSTv00H4uYacDTW8JReCVqnAFFLg/+vYWdJZSoyDsCVHb6FqAuMZXImhO0AYdMQwFVBEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daMF7eof8/4mWQru2UL0q8eLuu45ckJpZN9jhtMc0MY=;
 b=EO1ibTh3xfkJaPMSkFbSSVxTIsdgkjU/hxmjI552ZDA1gJRjRhFxtYbyLONZ6fUDygnYRJPyW1xClomXwwiXw3kYHWRAVFcYthXo/lX9OIRekZXJIx+KUwXT/nyvIrxPYgZI+XALrelFLZMYpePvTFEUpV51SVKXl+2O97WsD9E=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5002.eurprd08.prod.outlook.com (10.255.17.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 07:50:05 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 07:50:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 4/8] block/backup: improve unallocated clusters skipping
Thread-Index: AQHVTPc5s/npQfEhfkGoVKrBP/0JC6bv+juAgAJ58AA=
Date: Fri, 9 Aug 2019 07:50:05 +0000
Message-ID: <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
 <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
In-Reply-To: <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0372.eurprd05.prod.outlook.com
 (2603:10a6:7:94::31) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809105002899
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1f2f72b-eff6-4969-0c73-08d71c9e3131
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5002; 
x-ms-traffictypediagnostic: DB8PR08MB5002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5002EF4BD4FC08DD014A63DFC1D60@DB8PR08MB5002.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(346002)(366004)(376002)(189003)(199004)(6246003)(7736002)(5660300002)(107886003)(478600001)(53936002)(6436002)(14454004)(36756003)(4326008)(99286004)(229853002)(31686004)(25786009)(6512007)(52116002)(66556008)(8676002)(3846002)(14444005)(256004)(66446008)(76176011)(26005)(6116002)(54906003)(486006)(110136005)(66476007)(81156014)(81166006)(64756008)(316002)(305945005)(6486002)(2501003)(446003)(66946007)(66066001)(102836004)(6506007)(386003)(8936002)(53546011)(31696002)(86362001)(186003)(71190400001)(71200400001)(2906002)(2616005)(11346002)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5002;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pOTzkpdGJM5txNBi36UxoD7c+AqESjB6rZ5J2VxBahh5NIAd6rM5i2SvJjx31EpoBjVwcbIG6mjhMYSYgaNIvybKlwFbKVaAfBlYRMkvIL5W8Y0dFBn0OrscIH+cs9bRI3Xdaf/BnS6oEu/fQqHK+n1Vb+1oEmfpq9oholphq7t485BCb9WFDsZEoDcHwb9IllBASMRIbqgj8HxFwF1pdhPxdfY0HQ6G/2u4rnBI+dLgjV+d6+EuuQ6Q12+geRutPdPq0TTOp03c+zpz+aBljpthgFPhKCvapWS1LgpEHoI35O0iWmOFLSdfNKliTZezuppk0K7WqgSefnjSuctdXOwWpEcE8LeiLYcOP6x4ZX2eHBQCkgOo0XWt+VyU1U4606HuQw3zcFLfRBpz/hf0CgFEJzPQY5RwQPUY4UKISXc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC7B4266B0D1774A9E339E98F0C73EE6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f2f72b-eff6-4969-0c73-08d71c9e3131
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 07:50:05.4044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USUjxaI7TWwCqq4G/XPYK+28vb0LbtDTsl6yA92bA0rVbGlrNe2ZxTPRfTgkXk6LnSOHXb07FQNAkyenbfYxhg0G+deowT0Flu0vGIIU5V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5002
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.114
Subject: Re: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated
 clusters skipping
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDguMjAxOSAyMTowMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNy4wOC4xOSAxMDowNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IExpbWl0IGJsb2NrX3N0YXR1
cyBxdWVyeWluZyB0byByZXF1ZXN0IGJvdW5kcyBvbiB3cml0ZSBub3RpZmllciB0bw0KPj4gYXZv
aWQgZXh0cmEgc2Vla2luZy4NCj4gDQo+IEkgZG9u4oCZdCB1bmRlcnN0YW5kIHRoaXMgcmVhc29u
aW5nLiAgQ2hlY2tpbmcgd2hldGhlciBzb21ldGhpbmcgaXMNCj4gYWxsb2NhdGVkIGZvciBxY293
MiBzaG91bGQganVzdCBtZWFuIGFuIEwyIGNhY2hlIGxvb2t1cC4gIFdoaWNoIHdlIGhhdmUNCj4g
dG8gZG8gYW55d2F5IHdoZW4gd2UgdHJ5IHRvIGNvcHkgZGF0YSBvZmYgdGhlIHNvdXJjZS4NCg0K
QnV0IGZvciByYXcgaXQncyBzZWVraW5nLiBJIHRoaW5rIHdlIGp1c3Qgc2hvdWxkbid0IGRvIGFu
eSB1bm5lY2Vzc2FyeSBvcGVyYXRpb25zDQppbiBjb3B5LWJlZm9yZS13cml0ZSBoYW5kbGluZy4g
U28gaW5zdGVhZCBvZiBjYWxsaW5nDQpibG9ja19zdGF0dXMocmVxdWVzdF9zdGFydCwgZGlza19l
bmQpIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gY2FsbA0KYmxvY2tfc3RhdHVzKHJlcXVlc3Rfc3Rh
cnQsIHJlcXVlc3RfZW5kKS4gQW5kIGl0IGlzIG1vcmUgYXBwbGljYWJsZSBmb3IgcmV1c2luZyB0
aGlzDQpjb2RlIHRvby4NCg0KPiANCj4gSSBjb3VsZCB1bmRlcnN0YW5kIHNheWluZyB0aGlzIG1h
a2VzIHRoZSBjb2RlIGVhc2llciwgYnV0IEkgYWN0dWFsbHkNCj4gZG9u4oCZdCB0aGluayBpdCBk
b2VzLiAgSWYgeW91IGltcGxlbWVudGVkIGNoZWNraW5nIHRoZSBhbGxvY2F0aW9uIHN0YXR1cw0K
PiBvbmx5IGZvciBhcmVhcyB3aGVyZSB0aGUgYml0bWFwIGlzIHJlc2V0ICh3aGljaCBJIHRoaW5r
IHRoaXMgcGF0Y2gNCj4gc2hvdWxkKSwgdGhlbiBpdOKAmWQganVzdCBkdXBsaWNhdGUgdGhlIGV4
aXN0aW5nIGxvb3AuDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGJsb2NrL2Jh
Y2t1cC5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+PiBpbmRleCAx
MWUyN2M4NDRkLi5hNGQzN2QyZDYyIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4+
ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+IA0KPiBbLi4uXQ0KPiANCj4+IEBAIC0yNjcsNiArMjY3
LDE4IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9kb19jb3coQmFja3VwQmxvY2tK
b2IgKmpvYiwNCj4+ICAgICAgIHdhaXRfZm9yX292ZXJsYXBwaW5nX3JlcXVlc3RzKGpvYiwgc3Rh
cnQsIGVuZCk7DQo+PiAgICAgICBjb3dfcmVxdWVzdF9iZWdpbigmY293X3JlcXVlc3QsIGpvYiwg
c3RhcnQsIGVuZCk7DQo+PiAgIA0KPj4gKyAgICBpZiAoam9iLT5pbml0aWFsaXppbmdfYml0bWFw
KSB7DQo+PiArICAgICAgICBpbnQ2NF90IG9mZiwgY2h1bms7DQo+PiArDQo+PiArICAgICAgICBm
b3IgKG9mZiA9IG9mZnNldDsgb2Zmc2V0IDwgZW5kOyBvZmZzZXQgKz0gY2h1bmspIHsNCj4gDQo+
IFRoaXMgaXMgd2hhdCBJ4oCZbSByZWZlcnJpbmcgdG8sIEkgdGhpbmsgdGhpcyBsb29wIHNob3Vs
ZCBza2lwIGFyZWFzIHRoYXQNCj4gYXJlIGNsZWFuLg0KDQpBZ3JlZSwgd2lsbCBkby4NCg0KPiAN
Cj4+ICsgICAgICAgICAgICByZXQgPSBiYWNrdXBfYml0bWFwX3Jlc2V0X3VuYWxsb2NhdGVkKGpv
Yiwgb2ZmLCBlbmQgLSBvZmYsICZjaHVuayk7DQo+PiArICAgICAgICAgICAgaWYgKHJldCA8IDAp
IHsNCj4+ICsgICAgICAgICAgICAgICAgY2h1bmsgPSBqb2ItPmNsdXN0ZXJfc2l6ZTsNCj4+ICsg
ICAgICAgICAgICB9DQo+PiArICAgICAgICB9DQo+PiArICAgIH0NCj4+ICsgICAgcmV0ID0gMDsN
Cj4+ICsNCj4+ICAgICAgIHdoaWxlIChzdGFydCA8IGVuZCkgew0KPj4gICAgICAgICAgIGludDY0
X3QgZGlydHlfZW5kOw0KPj4gICANCj4+IEBAIC0yNzYsMTUgKzI4OCw2IEBAIHN0YXRpYyBpbnQg
Y29yb3V0aW5lX2ZuIGJhY2t1cF9kb19jb3coQmFja3VwQmxvY2tKb2IgKmpvYiwNCj4+ICAgICAg
ICAgICAgICAgY29udGludWU7IC8qIGFscmVhZHkgY29waWVkICovDQo+PiAgICAgICAgICAgfQ0K
Pj4gICANCj4+IC0gICAgICAgIGlmIChqb2ItPmluaXRpYWxpemluZ19iaXRtYXApIHsNCj4+IC0g
ICAgICAgICAgICByZXQgPSBiYWNrdXBfYml0bWFwX3Jlc2V0X3VuYWxsb2NhdGVkKGpvYiwgc3Rh
cnQsICZza2lwX2J5dGVzKTsNCj4+IC0gICAgICAgICAgICBpZiAocmV0ID09IDApIHsNCj4+IC0g
ICAgICAgICAgICAgICAgdHJhY2VfYmFja3VwX2RvX2Nvd19za2lwX3JhbmdlKGpvYiwgc3RhcnQs
IHNraXBfYnl0ZXMpOw0KPj4gLSAgICAgICAgICAgICAgICBzdGFydCArPSBza2lwX2J5dGVzOw0K
Pj4gLSAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+IC0gICAgICAgICAgICB9DQo+PiAtICAg
ICAgICB9DQo+PiAtDQo+PiAgICAgICAgICAgZGlydHlfZW5kID0gYmRydl9kaXJ0eV9iaXRtYXBf
bmV4dF96ZXJvKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbmQgLSBzdGFydCk7DQo+PiAgICAgICAg
ICAgaWYgKGRpcnR5X2VuZCA8IDApIHsNCj4gDQo+IEhtLCB5b3UgcmVzb2x2ZWQgdGhhdCBjb25m
bGljdCBkaWZmZXJlbnRseSBmcm9tIG1lLg0KPiANCj4gSSBkZWNpZGVkIHRoZSBiZHJ2X2RpcnR5
X2JpdG1hcF9uZXh0X3plcm8oKSBjYWxsIHNob3VsZCBnbyBiZWZvcmUgdGhlDQo+IGJhY2t1cF9i
aXRtYXBfcmVzZXRfdW5hbGxvY2F0ZWQoKSBjYWxsIHNvIHRoYXQgd2UgY2FuIHRoZW4gZG8gYQ0K
PiANCj4gICAgZGlydHlfZW5kID0gTUlOKGRpcnR5X2VuZCwgc3RhcnQgKyBza2lwX2J5dGVzKTsN
Cj4gDQo+IGJlY2F1c2Ugd2UgcHJvYmFibHkgZG9u4oCZdCB3YW50IHRvIGNvcHkgYW55dGhpbmcg
cGFzdCB3aGF0DQo+IGJhY2t1cF9iaXRtYXBfcmVzZXRfdW5hbGxvY2F0ZWQoKSBoYXMgaW5xdWly
ZWQuDQo+IA0KPiANCj4gQnV0IHRoZW4gYWdhaW4gdGhpcyBwYXRjaCBlbGltaW5hdGVzIHRoZSBk
aWZmZXJlbmNlIGFueXdheS4uLg0KPiAgPg0KPj4gQEAgLTU0Niw3ICs1NDksOCBAQCBzdGF0aWMg
aW50IGNvcm91dGluZV9mbiBiYWNrdXBfcnVuKEpvYiAqam9iLCBFcnJvciAqKmVycnApDQo+PiAg
ICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+ICAgICAgICAgICAgICAgfQ0KPj4gICANCj4+
IC0gICAgICAgICAgICByZXQgPSBiYWNrdXBfYml0bWFwX3Jlc2V0X3VuYWxsb2NhdGVkKHMsIG9m
ZnNldCwgJmNvdW50KTsNCj4+ICsgICAgICAgICAgICByZXQgPSBiYWNrdXBfYml0bWFwX3Jlc2V0
X3VuYWxsb2NhdGVkKHMsIG9mZnNldCwgcy0+bGVuIC0gb2Zmc2V0LA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNvdW50KTsNCj4+ICAgICAg
ICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+ICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
Pj4gICAgICAgICAgICAgICB9DQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K

