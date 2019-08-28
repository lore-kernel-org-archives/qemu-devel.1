Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB1EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB05022CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F7L9QyJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB05022CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2yva-0005iO-Ij
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 10:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2yun-0005Cj-J9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2yum-0002Nz-80
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:27:13 -0400
Received: from mail-eopbgr10092.outbound.protection.outlook.com
 ([40.107.1.92]:62081 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2yuk-0002LH-Gn; Wed, 28 Aug 2019 10:27:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVraFLscPtji6fB2nYh9e0+qukmAhiPG8DnRdxsjpGMqWkksdE7iT8ikMIKJStHKYmVNasJZiKtBPgV6Nq1EZk6Hial5VWGHSi1tdn8V942vxu4erqOSUOskXYSP7SSsCQpd7hk4s6GX07gVbgMAMa3wWsfjBDmK/5ZUWgKzoiRryDAI0cTMwOWm7Gfg4k92plHI9m1J7EDHvbOPeKWQWPdP774ln4sES6uJ488BZwFzZQZTS5D4SejbX3OfDDuzW2HbwgitUHCa2F+jZhT3YC09xN8ZoFlTOM2JsDU8KxS222JeYUvAb9Fn2i9NWHgYM0mVYSfhiq6U4H1X2gQbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK54pxxaMfabTAMBdkS/bjdqHn8TgGA/o+jjGIwpuzk=;
 b=IX58m8Vn7QT0L85C1N77EoRBTie/t1nyvW60kaw5xIecl9gVbHT0fMBTgCyVCISAL93NKjOyaH+8HFH+Z1c3iH67pfyvMjLtvwRlXRVy9PR6+6Q6hjTzNAVUArQc2lhvmK0K/n6AbYgFbUd0SF4ttu+CTzmd70KtJHFbfQWexdtnAmQO7kr79vhqpkFFmXWaqjePsYbd3bDXQSlMgW2NEhqI1SpgslLqM/lzSMMBFDGgAeEh3MBFGeAI0T33W0jGe4sXFDHEqdR3728b1ZXpWkbZjKv1cKB61T956v/3dxMTIfjMtfCu41/ytI8a3Fn0LzvxwzoxZIXYUqe4ie+VKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK54pxxaMfabTAMBdkS/bjdqHn8TgGA/o+jjGIwpuzk=;
 b=F7L9QyJX6tv6JnePqPFqapXUA3VahdGtGy04Meu4qiBILo4D31mbIkxqEx1onxXId/M9GkniJOEYRyqhnF2QePgfUh4NAnq9cBw4auqupeftNWHFErqmZfzXmXv6zuv8u6qiP0LyvTBop/JF0cohjB4t4BnvpVAXxl1V2W7XwK4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4108.eurprd08.prod.outlook.com (20.179.12.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 14:27:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 14:27:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v9 02/13] block/backup: split shareable copying part from
 backup_do_cow
Thread-Index: AQHVXCk1aC5c0ePewk6TVmfq99Gnx6cQn6OAgAABXIA=
Date: Wed, 28 Aug 2019 14:27:06 +0000
Message-ID: <5989858c-4c50-d3e5-fc17-5d1e772613f2@virtuozzo.com>
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-3-vsementsov@virtuozzo.com>
 <6c22ee44-4875-92e5-273b-53276cdec860@redhat.com>
In-Reply-To: <6c22ee44-4875-92e5-273b-53276cdec860@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0083.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190828172703827
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79fcfd77-79e6-4a1e-cb35-08d72bc3cd85
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4108; 
x-ms-traffictypediagnostic: DB8PR08MB4108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB410874F9C30D0F3074188CA9C1A30@DB8PR08MB4108.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(376002)(366004)(39840400004)(396003)(189003)(199004)(11346002)(8936002)(66946007)(5660300002)(54906003)(110136005)(229853002)(316002)(66066001)(14454004)(256004)(14444005)(64756008)(7736002)(478600001)(53936002)(386003)(66556008)(6506007)(36756003)(6116002)(53546011)(3846002)(66446008)(31686004)(52116002)(6436002)(6246003)(107886003)(76176011)(66476007)(446003)(99286004)(102836004)(486006)(26005)(6512007)(2906002)(305945005)(71190400001)(71200400001)(6486002)(186003)(8676002)(4326008)(86362001)(81166006)(81156014)(31696002)(2501003)(7416002)(476003)(2616005)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4108;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fzOK4NN3CfZneNubgMDTum+kSJhP0kACOnXhcXayRvoMTOP9XX0N1wiSqGIKTGTWXfSyjgN+ZW4bni5uA4OmfwOLuCJ4jHDlbV0IOCgJ/MMP05nzlp2/UnQM/+3y8KN0SeMgmZnNLWsvDpD2mfHb+w9Q4dAY+8aK6idGEtk970LbadfnyGSfvRJxS9LtKqGjhPzLSPPTyCb2lilRwMf5FC0GgtQcgNvGACFqJepn/GEAorB8ArO6FUKPiycmNxbiPkP/kPQrT8DdHcT1Of5w7KvKmuXY82bdp4cYatA4X0HmagfXcAoZ3ueqq8zZMvN5X7/jfdVrWt6U/2pWauOlGXS3F4MlqFFW9oFFRT7V1wejl0mUT2FRJ8LeR9pgDEQIZgeUond72HMo2PNGwF/wg3rNOugMvHviB7tStvvBIVE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <978D120DE379B34BACA5236D962930C4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fcfd77-79e6-4a1e-cb35-08d72bc3cd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 14:27:06.4650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tp5r87twCy+SkLBtMjJ37aTwRvo/9bx5CLQZIs3ozYhIbxLrpyVKhr9W4cf8r5EKFshP0IDYxJA0YlynXTvPzLBtIn/N8dULMny6p94VTQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4108
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.92
Subject: Re: [Qemu-devel] [PATCH v9 02/13] block/backup: split shareable
 copying part from backup_do_cow
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDguMjAxOSAxNzoyMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyNi4wOC4xOSAxODoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNwbGl0IGNvcHlpbmcgbG9n
aWMgd2hpY2ggd2lsbCBiZSBzaGFyZWQgd2l0aCBiYWNrdXAtdG9wIGZpbHRlci4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2svYmFja3VwLmMgfCA0NyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+IGluZGV4IDMzYjE0NDMwNWYuLjEz
YTFkODAxNTcgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9iYWNrdXAuYw0KPj4gKysrIGIvYmxvY2sv
YmFja3VwLmMNCj4+IEBAIC0yNDgsMjYgKzI0OCwxOCBAQCBzdGF0aWMgaW50NjRfdCBiYWNrdXBf
Yml0bWFwX3Jlc2V0X3VuYWxsb2NhdGVkKEJhY2t1cEJsb2NrSm9iICpzLA0KPj4gICAgICAgcmV0
dXJuIHJldDsNCj4+ICAgfQ0KPj4gICANCj4+IC1zdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNr
dXBfZG9fY293KEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQ2NF90IG9mZnNldCwgdWludDY0X3QgYnl0ZXMsDQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sICplcnJvcl9pc19yZWFkLA0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpc193cml0ZV9u
b3RpZmllcikNCj4+ICtzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfZG9fY29weShCYWNr
dXBCbG9ja0pvYiAqam9iLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBib29sICplcnJvcl9pc19yZWFkLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaXNfd3JpdGVfbm90aWZpZXIpDQo+
PiAgIHsNCj4+IC0gICAgQ293UmVxdWVzdCBjb3dfcmVxdWVzdDsNCj4+ICAgICAgIGludCByZXQg
PSAwOw0KPj4gLSAgICBpbnQ2NF90IHN0YXJ0LCBlbmQ7IC8qIGJ5dGVzICovDQo+PiArICAgIGlu
dDY0X3Qgc3RhcnQgPSBvZmZzZXQsIGVuZCA9IGJ5dGVzICsgb2Zmc2V0OyAvKiBieXRlcyAqLw0K
PiANCj4gTWF5YmUganVzdCByZW5hbWUgdGhlIOKAnG9mZnNldOKAnSBwYXJhbWV0ZXIgdG8g4oCc
c3RhcnTigJ0sIHJlcGxhY2UgdGhlIOKAnGJ5dGVz4oCdDQo+IHBhcmFtZXRlciBieSBhbiDigJxl
bmTigJ0gcGFyYW1ldGVyLCBhbmQgZHJvcCB0aGlzIGxpbmU/DQo+IA0KDQpJIHJlYWxseSB3YW50
IGZpbmFsIGJsb2NrX2NvcHkgaGF2ZSBtb3JlIGNvbW1vbiBpbiBibG9jay1sYXllciBvZmZzZXQr
Ynl0ZXMNCmludGVyZmFjZS4gU28gYmV0dGVyIHRvIHJlZmFjdG9yIGEgYml0IHRoZSBmdW5jdGlv
biBpdHNlbGYsIGJ1dCBJJ2QgcHJlZmVyDQp0byBkbyBpdCBhcyBhIGZvbGxvdy11cCBhbmQga2Vl
cCB0aGlzIHBhdGNoIHNpbXBsZXIuLg0KDQo+IA0KPj4gICAgICAgdm9pZCAqYm91bmNlX2J1ZmZl
ciA9IE5VTEw7DQo+PiAgICAgICBpbnQ2NF90IHN0YXR1c19ieXRlczsNCj4+ICAgDQo+PiAtICAg
IHFlbXVfY29fcndsb2NrX3JkbG9jaygmam9iLT5mbHVzaF9yd2xvY2spOw0KPj4gLQ0KPj4gLSAg
ICBzdGFydCA9IFFFTVVfQUxJR05fRE9XTihvZmZzZXQsIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+
IC0gICAgZW5kID0gUUVNVV9BTElHTl9VUChieXRlcyArIG9mZnNldCwgam9iLT5jbHVzdGVyX3Np
emUpOw0KPj4gLQ0KPj4gLSAgICB0cmFjZV9iYWNrdXBfZG9fY293X2VudGVyKGpvYiwgc3RhcnQs
IG9mZnNldCwgYnl0ZXMpOw0KPj4gLQ0KPj4gLSAgICB3YWl0X2Zvcl9vdmVybGFwcGluZ19yZXF1
ZXN0cyhqb2IsIHN0YXJ0LCBlbmQpOw0KPj4gLSAgICBjb3dfcmVxdWVzdF9iZWdpbigmY293X3Jl
cXVlc3QsIGpvYiwgc3RhcnQsIGVuZCk7DQo+PiArICAgIGFzc2VydChRRU1VX0lTX0FMSUdORUQo
c3RhcnQsIGpvYi0+Y2x1c3Rlcl9zaXplKSk7DQo+PiArICAgIGFzc2VydChRRU1VX0lTX0FMSUdO
RUQoZW5kLCBqb2ItPmNsdXN0ZXJfc2l6ZSkpOw0KPj4gICANCj4+ICAgICAgIHdoaWxlIChzdGFy
dCA8IGVuZCkgew0KPj4gICAgICAgICAgIGludDY0X3QgZGlydHlfZW5kOw0KPiANCg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

