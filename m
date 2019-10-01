Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C485C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407392086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qQv5DGlQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407392086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45361 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLdr-0004pH-77
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFLX1-0005Yf-Lu
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFLX0-0006Y9-Cf
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:01:47 -0400
Received: from mail-eopbgr130108.outbound.protection.outlook.com
 ([40.107.13.108]:45568 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFLWn-0006Pd-6y; Tue, 01 Oct 2019 13:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdjmK3TH0TK00GWylf03iBn+2n7hCh8ShgL4S4WdOraNMnGwop/DNTrOnPO+/la0ZVMSpblwGEnXwEZgKwWgTZR/D1Zjp1qCPCYqSZSj4kaEdSXwWrLX/VW6EqWgGz0rt6oKvMpqZssjs6Kf0N/RTRD5tR1EPJ56fuQ1Qn4lQphu8+H3yC8R2Fm2eWBvOY9qBcOxWS+5DtYNfy7BrcWIrhfyo4B8e4zJaOUzO46ZM4WovaK4J0gBtRTfaleAKeHKozETp+zp6+IODnHCEGhgMmwSyHummSDqXi7ea7tbxtDhElE/gtgQsICxlyBTUrYWmjAT+KBpYL7PGZ2zz4g9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OjW1by2mWMAkYMl3ms0D8s3cbWftzOzHuRtM4+N1eo=;
 b=CLtuWngS4vptthazMTEvwg+E0DrLDGfPeZnsPPgVWyle3rRUo102l3J2ZpSI/SplXfL0kzAtw/CXz8Wj7yEL1j93WkrXtI26lgUq9i8YannODvA5b8G0OyZvdUdPzgcxjvnXuJQlfnmommd/bodlQ/V34OoFCHm7Wtl1KZgr71ajZf315UszGCuOxFoe+16ELk8E8x9ps6NBeeHkp303TJ0T2Ckk/CZZ973f3ynF/7Y3QpOnF855OdR5N797+vxUKx+KT6DdWxQtVaOyfGCbDuzi/DcGF8F9vXzqvwi6LasN8WdAoga7Vuf81hrRMJJ+RqB1E1UwPbKbQvjJLr/NqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OjW1by2mWMAkYMl3ms0D8s3cbWftzOzHuRtM4+N1eo=;
 b=qQv5DGlQqtRoPNpb/YOJMYwiY8NaluIm1oESwGXD8yqGeHsvVw0FmoSrfIvcOdnvVDtSVKdjqWy78lfj/Ip1FOqv4BRtweL+Ispqy/RCaSzAUd9a2ec/sUwGUP5Wprehjq1CVnrOFXQ0jhK4urzV1qwQYUFTuBqIMgOuNUw1Kzk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5259.eurprd08.prod.outlook.com (20.179.15.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 17:01:30 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 17:01:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 05/31] scripts: add script to fix
 error_append_hint/error_prepend usage
Thread-Topic: [PATCH v4 05/31] scripts: add script to fix
 error_append_hint/error_prepend usage
Thread-Index: AQHVeHBjzF1lxlZN2U+wmo61d0343KdF9+KAgAAK9IA=
Date: Tue, 1 Oct 2019 17:01:29 +0000
Message-ID: <ee73f70e-61f5-19d5-0da6-dbc357b60af1@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-6-vsementsov@virtuozzo.com>
 <cc20df9c-75e4-6139-c6ff-de0622b59104@redhat.com>
In-Reply-To: <cc20df9c-75e4-6139-c6ff-de0622b59104@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0004.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001200125111
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d2406d4-1fde-48fb-5275-08d746910107
x-ms-traffictypediagnostic: DB8PR08MB5259:
x-microsoft-antispam-prvs: <DB8PR08MB5259F2F591CFC72D5539DFE2C19D0@DB8PR08MB5259.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(189003)(199004)(25786009)(66946007)(31696002)(36756003)(6512007)(5660300002)(31686004)(6436002)(2906002)(478600001)(6116002)(3846002)(7736002)(4326008)(305945005)(7406005)(6486002)(66476007)(64756008)(229853002)(66446008)(66556008)(6246003)(2501003)(8936002)(53546011)(26005)(186003)(99286004)(7416002)(476003)(110136005)(486006)(11346002)(8676002)(446003)(52116002)(316002)(81166006)(71200400001)(81156014)(2616005)(54906003)(86362001)(71190400001)(66066001)(386003)(14454004)(14444005)(256004)(6506007)(102836004)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5259;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MAA82XRVgPlRc05MYmTWoJhtqMkBxtCRr+HDCWtxWKNTn79e8T9jlEaQRYP4WqKznxCRC0nMdSyoIO7Q8coMSRxqbnAank4Mk0IYqWRwyJjGXnytSQVRTuP5Q/rKugDjBW8ZSgF2dz1SDBLv3W5ERA5cn8agcrVw91F+3Hayra1R4A8MoZ3DUeejnFLvaaTJsg6BU7wS9v4M2Ur7nYjrD4ek/rsovuUPUoF+/4TsoEO2CyvgB/gkyKnD41qFaLBt/X4WBcrF6QdeJ2eCJabzX7amRaDwtcwRcYxGlEh3xJ3zj/bv7QCyUQzv+10ORFwunCBeoD+7lucz1+MWINNoJC/Y5FmHObChRiQz441zEz5LvOKtFskavPEB8RVWya8l9FsPNe6OZnohm31V2rWuju2X+TGUcO1XfJt0NdLWzk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0657E8B5F413F4FB877B0F4185213BB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2406d4-1fde-48fb-5275-08d746910107
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 17:01:29.8934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sn44L3FHVh1/C0Ho5MvMs9y+aX3r11nUD0ict228fXAHXqS9+hiTx/MW+Apni83hjetFH1yi5AUDsf/8oBIcQkQCABkBtkmzmvjLUZ8YRno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5259
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.108
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxOToyMiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMS8xOSAxMDo1MiBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGVycm9yX2FwcGVuZF9o
aW50IGFuZCBlcnJvcl9wcmVwZW5kIHdpbGwgbm90IHdvcmssIGlmIGVycnAgPT0NCj4+ICZmYXRh
bF9lcnJvciwgYXMgcHJvZ3JhbSB3aWxsIGV4aXQgYmVmb3JlIGVycm9yX2FwcGVuZF9oaW50IG9y
DQo+PiBlcnJvcl9wcmVwZW5kIGNhbGwuIEZpeCB0aGlzIGJ5IHVzZSBvZiBzcGVjaWFsIG1hY3Jv
DQo+PiBFUlJQX0FVVE9fUFJPUEFHQVRFLg0KPiANCj4gVGhpcyBwYXRjaCBkb2Vzbid0IGFjdHVh
bGx5IGZpeCBhbnkgY29kZSwgYnV0IGFkZHMgdGhlIHNjcmlwdCB0byBlbmFibGUgYXV0b21hdGlu
ZyB0aGUgZml4aW5nIG9mIHRoZSBjb2RlIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy7CoCBUd2Vha2lu
ZyB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gbWFrZSB0aGF0IHBvaW50IGNsZWFyIG1pZ2h0IGJlIGhl
bHBmdWwuDQoNCkhtbSwgc28sIG1heWJlLCBzd2l0Y2ggIkZpeCB0aGlzIGJ5IHVzZSAuLi4iIHRv
DQoNClRvIGZpeCBjb2RlIHdpdGggaGVscCBvZiB0aGlzIHNjcmlwdCBkbw0Kc3BhdGNoIC0tc3At
ZmlsZSBzY3JpcHRzL2NvY2NpbmVsbGUvZml4LWVycm9yLWFkZC1pbmZvLmNvY2NpIEZJTEVfVE9f
RklYDQoNCg0KPiANCj4gDQo+PiDCoCBzY3JpcHRzL2NvY2NpbmVsbGUvZml4LWVycm9yLWFkZC1p
bmZvLmNvY2NpIHwgMjggKysrKysrKysrKysrKysrKysrKysrDQo+PiDCoCAxIGZpbGUgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKQ0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNjcmlwdHMvY29j
Y2luZWxsZS9maXgtZXJyb3ItYWRkLWluZm8uY29jY2kNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvc2Ny
aXB0cy9jb2NjaW5lbGxlL2ZpeC1lcnJvci1hZGQtaW5mby5jb2NjaSBiL3NjcmlwdHMvY29jY2lu
ZWxsZS9maXgtZXJyb3ItYWRkLWluZm8uY29jY2kNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
PiBpbmRleCAwMDAwMDAwMDAwLi4zNGZhM2JlNzIwDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9zY3JpcHRzL2NvY2NpbmVsbGUvZml4LWVycm9yLWFkZC1pbmZvLmNvY2NpDQo+PiBAQCAtMCww
ICsxLDI4IEBADQo+PiArQHJ1bGUwQA0KPj4gKy8vIEFkZCBpbnZvY2F0aW9uIHRvIGVycnAtZnVu
Y3Rpb25zDQo+PiAraWRlbnRpZmllciBmbjsNCj4+ICtAQA0KPj4gKw0KPj4gKyBmbiguLi4sIEVy
cm9yICoqZXJycCwgLi4uKQ0KPj4gKyB7DQo+PiArK8KgwqAgRVJSUF9BVVRPX1BST1BBR0FURSgp
Ow0KPj4gK8KgwqDCoCA8Ky4uLg0KPj4gKygNCj4+ICvCoMKgwqAgZXJyb3JfYXBwZW5kX2hpbnQo
ZXJycCwgLi4uKTsNCj4+ICt8DQo+PiArwqDCoMKgIGVycm9yX3ByZXBlbmQoZXJycCwgLi4uKTsN
Cj4+ICspDQo+IA0KPiBTbywgZm9yIG5vdywgeW91IGFyZW4ndCBhZGRyZXNzaW5nIGFueSAqZXJy
cCB1c2FnZSwgb3IgYW55IHBvdGVudGlhbCBjbGVhbnVwcyBvZiBlcnJvcl9wcm9wYWdhdGUuwqAg
QnV0IHRoYXQncyBva2F5OyB5b3VyIGNvdmVyIGxldHRlciBkaWQgY2FsbCBvdXQgdGhhdCB5b3Ug
d2VyZSBvbmx5IGFkZHJlc3NpbmcgMSBwYXJ0IG91dCBvZiAzIHBvdGVudGlhbCB1c2VzIGp1c3Qg
dG8gZ2V0IHNvbWUgbW90aW9uLCBiYXNlZCBvbiB0aGUgc2l6ZSBvZiB0aGUgZWZmb3J0Lg0KPiAN
Cj4+ICvCoMKgwqAgLi4uKz4NCj4+ICsgfQ0KPj4gKw0KPj4gK0BADQo+PiArLy8gRHJvcCBkb3Vi
bGVkIGludm9jYXRpb24NCj4+ICtpZGVudGlmaWVyIHJ1bGUwLmZuOw0KPj4gK0BADQo+PiArDQo+
PiArIGZuKC4uLikNCj4+ICt7DQo+PiArwqDCoMKgIEVSUlBfQVVUT19QUk9QQUdBVEUoKTsNCj4+
ICstwqDCoCBFUlJQX0FVVE9fUFJPUEFHQVRFKCk7DQo+PiArwqDCoMKgIC4uLg0KPj4gK30NCj4+
DQo+IA0KPiBUaGlzIGxvb2tzIGlkZW1wb3RlbnQgb25jZSBhIGZpbGUgaXMgcGF0Y2hlZCwgYW5k
IHNhZmUgdG8gcmVydW4gYXMgbWFueSB0aW1lcyBpbiB0aGUgZnV0dXJlIGFzIG5lZWRlZC7CoCBJ
J20gc3RpbGwgaG9waW5nIHdlIGNhbiBmaW5kIGEgd2F5IHRvIG1ha2Ugc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIGFsc28gZG8gYSBzYW5pdHkgY2hlY2ssIGJ1dCBhcyBpdCdzIGhhcmRlciB0byBwYXJz
ZSBDIGluIHBlcmwgdGhhbiBpbiBDb2NjaW5lbGxlLCBJIGNhbiBsaXZlIHdpdGgganVzdCB0aGUg
LmNvY2NpIHNjcmlwdCBpbi10cmVlIGFzIGxvbmcgYXMgd2UgcmVtZW1iZXIgdG8gbWFudWFsbHkg
cnVuIGl0IHBlcmlvZGljYWxseS4NCg0Kc2NyaXB0cy9jaGVja3BhdGNoLnBsIGlzIHNvIHVuZnJp
ZW5kbHkuLiBBbmQgdG8gcnVuIGNvY2NpbmVsbGUgc2NyaXB0cyB3ZSBuZWVkDQp3b3JraW5nIGRp
cmVjdG9yeSwgbm90IGp1c3QgcGF0Y2ggZmlsZXMuDQoNCkkgaW1hZ2luZSB0aGUgZm9sbG93aW5n
Og0KDQptb3ZlIHNjcmlwdHMvY2hlY2twYXRjaC5wbCB0byBzY3JpcHRzL2NoZWNrcGF0Y2ggZGly
DQoNCkNyZWF0ZSBzY3JpcHRzL2NoZWNrcGF0Y2gucHkgKG9yIHB5dGhvbi9jaGVja3BhdGNoLnB5
LCBJIGRvbid0DQprbm93IHdoYXQgaXMgdGhlIGlkZWEgb2YgcHl0aG9uLyBkaXIpLCB3aGljaCB3
aWxsIHdvcmsgb25seSBvbg0KY29tbWl0cyBvciBvbiBwYXRjaCBmaWxlcyB3aXRoIHNwZWNpZmll
ZCBiYXNlIChtYXN0ZXIgYnkgZGVmYXVsdCksDQppdCB3aWxsIGNyZWF0ZSB0ZW1wb3Jhcnkgd29y
a3RyZWUsIGNoZWNrb3V0IGNvcnJlc3BvbmRpbmcgY29tbWl0DQphbmQgdGhlbiBydW4gc2NyaXB0
cyBmcm9tIHNjcmlwdHMvY2hlY2twYXRjaC8sIGF0IGxlYXN0IGl0IHdvdWxkIGJlDQpjaGVja3Bh
dGNoLnBsIGFuZCBjb2NjaW5lbGxlLnNoICh3aGljaCB3aWxsIHJ1biBzb21lIGNvY2NpbmVsbGUN
CnNjcmlwdHMgZnJvbSBjb2NjaW5lbGxlIGRpcikuLg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogRXJp
YyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

