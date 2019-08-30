Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BC9C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1E82087F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vTVGV+nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1E82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lML-0003ci-Ce
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lJA-0002OK-ET
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i3lJ7-0008J6-Vf
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:07:35 -0400
Received: from mail-he1eur02on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::724]:23367
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i3lJ3-0007zu-GM; Fri, 30 Aug 2019 14:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwUIu3tNuwdlOf5O4kxSkii0sJHFwogIe6A9YnGl+UreF5v0fB9vKBZnnq/oUDfIdNnMgAC3ZL+njcK/KPUs+Pg7zpFLmZJs4yJJb/eCl4c+AONQbNyybqbeY4gw+zlh1MBGQo7xrUFyTyhw2Bafk4uDjCLcpDFlcF5dbx2lGiNutAf3RadT1K1ioM6FzXTDDaM3lTq20R9N1Qzguj2fFhKmmn/dzTs4VgdpCuBGdkVOzUxSPVKhH4WlMe11fGIZt7aDE+Rjatu7qcErXIKtvlR1MfPuYlWG2cYJ5jdYoMXKMH4aHPQyVZJaloc9MXqDjPg/LdRcMhleaqZPDgNi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1kFAMMfHEfPVxj2xao13shY0DpQQrKsFBTr/09fKuE=;
 b=TxpndtIBSKYqTySGFOdg0b8M1dd07qsBG/68+vgY0EfV1rLb72IH8hfeJzxbf/HtsCXFKctRAnlTeQf1McmqH1EdetpX7v9+THO2MJ5/MS7M1thcnHosBLLV8DQx5T8KCf97JfPhfc2sc/CGTCAQXlAZC+lO0rqUrakKGa3oMtQkNz3Y6EWxYbEWq9obqXhRRGUnQzb9tCZjjhFXxp/5c4a5dSJygc6GVoNgtw2b9nFiEGWttfrYogFyOXOYXchLjIZzWcJR45gYe1JCIK3euMSIN/LWgGlsh5qfsAakNA0hecHZ7uehs2wNazxGmPqA9YelJNEOwCf/eccNINGS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1kFAMMfHEfPVxj2xao13shY0DpQQrKsFBTr/09fKuE=;
 b=vTVGV+nuNyRUGWaJXasPx7dbup4Sz48UkHRgXvjA4Lxeew+WrIE00Jkxq776qCnzoZvodMiratuMeEmFHBZyBCeujGZRQntFKJ639E5EqUNJBTOTJwm1jjTqRt+jlD0e6OsNQXNzk55nx59cJDA0214ejiPeWShaOXmSDurPyMY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5386.eurprd08.prod.outlook.com (52.133.241.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 18:07:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Fri, 30 Aug 2019
 18:07:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
Thread-Index: AQHVWcJnZgUz/ZiSEEiPmfDFNqlCh6cUCAIA
Date: Fri, 30 Aug 2019 18:07:23 +0000
Message-ID: <9476b1d1-47e4-ecfd-eb23-5b2fbc1410e3@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143726.27062-1-eblake@redhat.com>
 <20190823143726.27062-3-eblake@redhat.com>
In-Reply-To: <20190823143726.27062-3-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:7:16::29) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190830210720538
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af6b3d73-06df-47d3-319c-08d72d74e873
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5386; 
x-ms-traffictypediagnostic: DB8PR08MB5386:
x-microsoft-antispam-prvs: <DB8PR08MB538605DA050A744190C63D72C1BD0@DB8PR08MB5386.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(14444005)(31696002)(486006)(229853002)(386003)(14454004)(3846002)(478600001)(7736002)(102836004)(6116002)(2501003)(52116002)(6506007)(5660300002)(36756003)(316002)(8936002)(110136005)(86362001)(6436002)(53936002)(6246003)(2906002)(99286004)(6512007)(11346002)(26005)(31686004)(305945005)(71200400001)(71190400001)(54906003)(64756008)(66556008)(2616005)(6486002)(66066001)(446003)(476003)(66446008)(66476007)(81156014)(81166006)(256004)(186003)(4326008)(25786009)(76176011)(8676002)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5386;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Qk/QTv374GQvfRscXWCaS8z0Ya+UIlTcMh4njzm2BUINrnvMr6kN9ALB75N7VaHrTR3/hDx10pFQVtQBI4EN9EyZVkEJj+F35AtzWFNTJcwuoyLFfGQFKkHDzL1qHvV5pL5nq4jRYsdf/XEdC7pCyR++gVJfvi8pyw8sQaDG0GbcH4qcuZHLKsMmPXUrsBJW0inZTig89No41cLLmp6vFqd68fK7DO3L55U61f2dAnoSLPOJfk8EIa913LOc+dKt57GyIZRPhm+9gmy07Sn9QORO6McAtJPqw89avVRtooKHERRne89U1xlxwcFjMOisI+O4M2ftf3dTXQvVziA3izrK6ZSf25SFeb1Q6zFSGezcZDXXaBVQCXYtLfc84W1Bsj4B1jItGHvnOJKhsBzYtLsRExmPJwUZsldM3jT3fg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <99FE13E853CF4944A369097AF7CDE501@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6b3d73-06df-47d3-319c-08d72d74e873
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:07:23.7885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyPvoUv6dBxtWfOy95pMfqLpc8vGmkoIhmNCIOjkDjB8ryq9pft2AvEzNTRm+X6ZZvU3P5UmOB3twf6NP7PgmNnY3Q3aJnBx3u7nALbC8ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5386
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::724
Subject: Re: [Qemu-devel] [PATCH 2/5] nbd: Prepare for NBD_CMD_FLAG_FAST_ZERO
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
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDguMjAxOSAxNzozNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gQ29tbWl0IGZlMDQ4MGQ2IGFu
ZCBmcmllbmRzIGFkZGVkIEJEUlZfUkVRX05PX0ZBTExCQUNLIGFzIGEgd2F5IHRvDQo+IGF2b2lk
IHdhc3RpbmcgdGltZSBvbiBhIHByZWxpbWluYXJ5IHdyaXRlLXplcm8gcmVxdWVzdCB0aGF0IHdp
bGwgbGF0ZXINCj4gYmUgcmV3cml0dGVuIGJ5IGFjdHVhbCBkYXRhLCBpZiBpdCBpcyBrbm93biB0
aGF0IHRoZSB3cml0ZS16ZXJvDQo+IHJlcXVlc3Qgd2lsbCB1c2UgYSBzbG93IGZhbGxiYWNrOyBi
dXQgaW4gZG9pbmcgc28sIGNvdWxkIG5vdCBvcHRpbWl6ZQ0KPiBmb3IgTkJELiAgVGhlIE5CRCBz
cGVjaWZpY2F0aW9uIGlzIG5vdyBjb25zaWRlcmluZyBhbiBleHRlbnNpb24gdGhhdA0KPiB3aWxs
IGFsbG93IHBhc3Npbmcgb24gdGhvc2Ugc2VtYW50aWNzOyB0aGlzIHBhdGNoIHVwZGF0ZXMgdGhl
IG5ldw0KPiBwcm90b2NvbCBiaXRzIGFuZCAncWVtdS1uYmQgLS1saXN0JyBvdXRwdXQgdG8gcmVj
b2duaXplIHRoZSBiaXQsIGFzDQo+IHdlbGwgYXMgdGhlIG5ldyBlcnJubyB2YWx1ZSBwb3NzaWJs
ZSB3aGVuIHVzaW5nIHRoZSBuZXcgZmxhZzsgd2hpbGUNCj4gdXBjb21pbmcgcGF0Y2hlcyB3aWxs
IGltcHJvdmUgdGhlIGNsaWVudCB0byB1c2UgdGhlIGZlYXR1cmUgd2hlbg0KPiBwcmVzZW50LCBh
bmQgdGhlIHNlcnZlciB0byBhZHZlcnRpc2Ugc3VwcG9ydCBmb3IgaXQuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgZG9jcy9p
bnRlcm9wL25iZC50eHQgfCAzICsrLQ0KPiAgIGluY2x1ZGUvYmxvY2svbmJkLmggIHwgNCArKysr
DQo+ICAgbmJkL2NvbW1vbi5jICAgICAgICAgfCA1ICsrKysrDQo+ICAgbmJkL3NlcnZlci5jICAg
ICAgICAgfCAyICsrDQo+ICAgcWVtdS1uYmQuYyAgICAgICAgICAgfCAxICsNCj4gICA1IGZpbGVz
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kb2NzL2ludGVyb3AvbmJkLnR4dCBiL2RvY3MvaW50ZXJvcC9uYmQudHh0DQo+IGluZGV4
IDZkZmVjN2Y0NzY0Ny4uNDUxMTg4MDk2MThlIDEwMDY0NA0KPiAtLS0gYS9kb2NzL2ludGVyb3Av
bmJkLnR4dA0KPiArKysgYi9kb2NzL2ludGVyb3AvbmJkLnR4dA0KPiBAQCAtNTMsNCArNTMsNSBA
QCB0aGUgb3BlcmF0aW9uIG9mIHRoYXQgZmVhdHVyZS4NCj4gICAqIDIuMTI6IE5CRF9DTURfQkxP
Q0tfU1RBVFVTIGZvciAiYmFzZTphbGxvY2F0aW9uIg0KPiAgICogMy4wOiBOQkRfT1BUX1NUQVJU
VExTIHdpdGggVExTIFByZS1TaGFyZWQgS2V5cyAoUFNLKSwNCj4gICBOQkRfQ01EX0JMT0NLX1NU
QVRVUyBmb3IgInFlbXU6ZGlydHktYml0bWFwOiIsIE5CRF9DTURfQ0FDSEUNCj4gLSogNC4yOiBO
QkRfRkxBR19DQU5fTVVMVElfQ09OTiBmb3Igc2hhcmFibGUgcmVhZC1vbmx5IGV4cG9ydHMNCj4g
KyogNC4yOiBOQkRfRkxBR19DQU5fTVVMVElfQ09OTiBmb3Igc2hhcmFibGUgcmVhZC1vbmx5IGV4
cG9ydHMsDQo+ICtOQkRfQ01EX0ZMQUdfRkFTVF9aRVJPDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2Jsb2NrL25iZC5oIGIvaW5jbHVkZS9ibG9jay9uYmQuaA0KPiBpbmRleCAyYzg3YjQyZGZkNDgu
LjIxNTUwNzQ3Y2YzNSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ibG9jay9uYmQuaA0KPiArKysg
Yi9pbmNsdWRlL2Jsb2NrL25iZC5oDQo+IEBAIC0xNDAsNiArMTQwLDcgQEAgZW51bSB7DQo+ICAg
ICAgIE5CRF9GTEFHX0NBTl9NVUxUSV9DT05OX0JJVCAgICAgPSAgOCwgLyogTXVsdGktY2xpZW50
IGNhY2hlIGNvbnNpc3RlbnQgKi8NCj4gICAgICAgTkJEX0ZMQUdfU0VORF9SRVNJWkVfQklUICAg
ICAgICA9ICA5LCAvKiBTZW5kIHJlc2l6ZSAqLw0KPiAgICAgICBOQkRfRkxBR19TRU5EX0NBQ0hF
X0JJVCAgICAgICAgID0gMTAsIC8qIFNlbmQgQ0FDSEUgKHByZWZldGNoKSAqLw0KPiArICAgIE5C
RF9GTEFHX1NFTkRfRkFTVF9aRVJPX0JJVCAgICAgPSAxMSwgLyogRkFTVF9aRVJPIGZsYWcgZm9y
IFdSSVRFX1pFUk9FUyAqLw0KPiAgIH07DQo+IA0KPiAgICNkZWZpbmUgTkJEX0ZMQUdfSEFTX0ZM
QUdTICAgICAgICAgKDEgPDwgTkJEX0ZMQUdfSEFTX0ZMQUdTX0JJVCkNCj4gQEAgLTE1Myw2ICsx
NTQsNyBAQCBlbnVtIHsNCj4gICAjZGVmaW5lIE5CRF9GTEFHX0NBTl9NVUxUSV9DT05OICAgICgx
IDw8IE5CRF9GTEFHX0NBTl9NVUxUSV9DT05OX0JJVCkNCj4gICAjZGVmaW5lIE5CRF9GTEFHX1NF
TkRfUkVTSVpFICAgICAgICgxIDw8IE5CRF9GTEFHX1NFTkRfUkVTSVpFX0JJVCkNCj4gICAjZGVm
aW5lIE5CRF9GTEFHX1NFTkRfQ0FDSEUgICAgICAgICgxIDw8IE5CRF9GTEFHX1NFTkRfQ0FDSEVf
QklUKQ0KPiArI2RlZmluZSBOQkRfRkxBR19TRU5EX0ZBU1RfWkVSTyAgICAoMSA8PCBOQkRfRkxB
R19TRU5EX0ZBU1RfWkVST19CSVQpDQo+IA0KPiAgIC8qIE5ldy1zdHlsZSBoYW5kc2hha2UgKGds
b2JhbCkgZmxhZ3MsIHNlbnQgZnJvbSBzZXJ2ZXIgdG8gY2xpZW50LCBhbmQNCj4gICAgICBjb250
cm9sIHdoYXQgd2lsbCBoYXBwZW4gZHVyaW5nIGhhbmRzaGFrZSBwaGFzZS4gKi8NCj4gQEAgLTIw
NSw2ICsyMDcsNyBAQCBlbnVtIHsNCj4gICAjZGVmaW5lIE5CRF9DTURfRkxBR19ERiAgICAgICAg
ICgxIDw8IDIpIC8qIGRvbid0IGZyYWdtZW50IHN0cnVjdHVyZWQgcmVhZCAqLw0KPiAgICNkZWZp
bmUgTkJEX0NNRF9GTEFHX1JFUV9PTkUgICAgKDEgPDwgMykgLyogb25seSBvbmUgZXh0ZW50IGlu
IEJMT0NLX1NUQVRVUw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICogcmVwbHkgY2h1bmsgKi8NCj4gKyNkZWZpbmUgTkJEX0NNRF9GTEFHX0ZBU1RfWkVSTyAg
KDEgPDwgNCkgLyogZmFpbCBpZiBXUklURV9aRVJPRVMgaXMgbm90IGZhc3QgKi8NCj4gDQo+ICAg
LyogU3VwcG9ydGVkIHJlcXVlc3QgdHlwZXMgKi8NCj4gICBlbnVtIHsNCj4gQEAgLTI3MCw2ICsy
NzMsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgbmJkX3JlcGx5X3R5cGVfaXNfZXJyb3IoaW50IHR5
cGUpDQo+ICAgI2RlZmluZSBOQkRfRUlOVkFMICAgICAyMg0KPiAgICNkZWZpbmUgTkJEX0VOT1NQ
QyAgICAgMjgNCj4gICAjZGVmaW5lIE5CRF9FT1ZFUkZMT1cgIDc1DQo+ICsjZGVmaW5lIE5CRF9F
Tk9UU1VQICAgIDk1DQo+ICAgI2RlZmluZSBOQkRfRVNIVVRET1dOICAxMDgNCj4gDQo+ICAgLyog
RGV0YWlscyBjb2xsZWN0ZWQgYnkgTkJEX09QVF9FWFBPUlRfTkFNRSBhbmQgTkJEX09QVF9HTyAq
Lw0KPiBkaWZmIC0tZ2l0IGEvbmJkL2NvbW1vbi5jIGIvbmJkL2NvbW1vbi5jDQo+IGluZGV4IGNj
OGIyNzhlNTQxZC4uZGRmZTdkMTE4MzcxIDEwMDY0NA0KPiAtLS0gYS9uYmQvY29tbW9uLmMNCj4g
KysrIGIvbmJkL2NvbW1vbi5jDQo+IEBAIC0yMDEsNiArMjAxLDggQEAgY29uc3QgY2hhciAqbmJk
X2Vycl9sb29rdXAoaW50IGVycikNCj4gICAgICAgICAgIHJldHVybiAiRU5PU1BDIjsNCj4gICAg
ICAgY2FzZSBOQkRfRU9WRVJGTE9XOg0KPiAgICAgICAgICAgcmV0dXJuICJFT1ZFUkZMT1ciOw0K
PiArICAgIGNhc2UgTkJEX0VOT1RTVVA6DQo+ICsgICAgICAgIHJldHVybiAiRU5PVFNVUCI7DQo+
ICAgICAgIGNhc2UgTkJEX0VTSFVURE9XTjoNCj4gICAgICAgICAgIHJldHVybiAiRVNIVVRET1dO
IjsNCj4gICAgICAgZGVmYXVsdDoNCj4gQEAgLTIzMSw2ICsyMzMsOSBAQCBpbnQgbmJkX2Vycm5v
X3RvX3N5c3RlbV9lcnJubyhpbnQgZXJyKQ0KPiAgICAgICBjYXNlIE5CRF9FT1ZFUkZMT1c6DQo+
ICAgICAgICAgICByZXQgPSBFT1ZFUkZMT1c7DQo+ICAgICAgICAgICBicmVhazsNCj4gKyAgICBj
YXNlIE5CRF9FTk9UU1VQOg0KPiArICAgICAgICByZXQgPSBFTk9UU1VQOw0KPiArICAgICAgICBi
cmVhazsNCj4gICAgICAgY2FzZSBOQkRfRVNIVVRET1dOOg0KPiAgICAgICAgICAgcmV0ID0gRVNI
VVRET1dOOw0KPiAgICAgICAgICAgYnJlYWs7DQo+IGRpZmYgLS1naXQgYS9uYmQvc2VydmVyLmMg
Yi9uYmQvc2VydmVyLmMNCj4gaW5kZXggYjU1Nzc4MjhhYTQ0Li45ODFiYzNjYjExNTEgMTAwNjQ0
DQo+IC0tLSBhL25iZC9zZXJ2ZXIuYw0KPiArKysgYi9uYmQvc2VydmVyLmMNCj4gQEAgLTU1LDYg
KzU1LDggQEAgc3RhdGljIGludCBzeXN0ZW1fZXJybm9fdG9fbmJkX2Vycm5vKGludCBlcnIpDQo+
ICAgICAgICAgICByZXR1cm4gTkJEX0VOT1NQQzsNCj4gICAgICAgY2FzZSBFT1ZFUkZMT1c6DQo+
ICAgICAgICAgICByZXR1cm4gTkJEX0VPVkVSRkxPVzsNCj4gKyAgICBjYXNlIEVOT1RTVVA6DQo+
ICsgICAgICAgIHJldHVybiBOQkRfRU5PVFNVUDsNCg0KVGhpcyBtYXkgcHJvdm9rZSByZXR1cm5p
bmcgTkJEX0VOT1RTVVAgaW4gb3RoZXIgY2FzZXMsIG5vdCBvbmx5IG5ldyBvbmUgd2UgYXJlIGdv
aW5nIHRvIGFkZC4NCg0KPiAgICAgICBjYXNlIEVTSFVURE9XTjoNCj4gICAgICAgICAgIHJldHVy
biBOQkRfRVNIVVRET1dOOw0KPiAgICAgICBjYXNlIEVJTlZBTDoNCj4gZGlmZiAtLWdpdCBhL3Fl
bXUtbmJkLmMgYi9xZW11LW5iZC5jDQo+IGluZGV4IDA3OTcwMmJiODM3Zi4uZGNlNTJmNTY0YjVh
IDEwMDY0NA0KPiAtLS0gYS9xZW11LW5iZC5jDQo+ICsrKyBiL3FlbXUtbmJkLmMNCj4gQEAgLTI5
NCw2ICsyOTQsNyBAQCBzdGF0aWMgaW50IHFlbXVfbmJkX2NsaWVudF9saXN0KFNvY2tldEFkZHJl
c3MgKnNhZGRyLCBRQ3J5cHRvVExTQ3JlZHMgKnRscywNCj4gICAgICAgICAgICAgICAgICAgW05C
RF9GTEFHX0NBTl9NVUxUSV9DT05OX0JJVF0gICAgICAgPSAibXVsdGkiLA0KPiAgICAgICAgICAg
ICAgICAgICBbTkJEX0ZMQUdfU0VORF9SRVNJWkVfQklUXSAgICAgICAgICA9ICJyZXNpemUiLA0K
PiAgICAgICAgICAgICAgICAgICBbTkJEX0ZMQUdfU0VORF9DQUNIRV9CSVRdICAgICAgICAgICA9
ICJjYWNoZSIsDQo+ICsgICAgICAgICAgICAgICAgW05CRF9GTEFHX1NFTkRfRkFTVF9aRVJPX0JJ
VF0gICAgICAgPSAiZmFzdC16ZXJvIiwNCj4gICAgICAgICAgICAgICB9Ow0KPiANCj4gICAgICAg
ICAgICAgICBwcmludGYoIiAgc2l6ZTogICUiIFBSSXU2NCAiXG4iLCBsaXN0W2ldLnNpemUpOw0K
PiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

