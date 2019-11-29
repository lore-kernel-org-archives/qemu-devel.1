Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7DBC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095672176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LBQW2dhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095672176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahGX-0003GU-7x
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iah5e-00053u-3s
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iah5Z-0006KU-53
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:17:43 -0500
Received: from mail-he1eur02on0722.outbound.protection.outlook.com
 ([2a01:111:f400:fe05::722]:4078
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iah5Y-00064C-T2; Fri, 29 Nov 2019 09:17:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPGjctGi0ObsfRLgY8W6JVAuStufHfPIHOZX62KE4/i8KRSp2QPcn5zants4LFE/+d6WvLmLKTKidJb2FdvDo83G4DXlcPK/JyzpBNfZguX/UwT/BaycjekximOsl8EMbLFNoxWOyNDKhq6NXNchEa/RwAqO25JOgnh8Ui9vTm2LhpsMIVnIMph3owuf2+CJgWRyutkJf2mfSlTVlRRPLGjaDnFSdcI9V5DV/dKgUQy2XQllaRkBzw8ktCk8uCZ1MSYh0ytwgoS+ENjNmS8pSpf1Z86jutYRqCDJj+aFRDj5jy/LpUEM3AdsYcH02uvv2h8lgo2OT7DkhLEv7mIs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvWJCe7wF+Dy7BOmazRmeKWlZ+l0MbX+QvAdlX1zUkc=;
 b=BdQHVB9HD2whCCW33zeMOBZhbFFDt88pygJjXRe2KG3Iw8qXSthdzf74i972Wg8RulR2VpEnKariupH+SNZHxlva3BziUF4YLFzBvh3dNtr6TSb8gSRC4lmI6ASB/x69hs1RwfaJerB5hsZqQpvKzvrmCAO11kXWfrHHzr3q181cOld3IftCaXKDTHtE41fTnNhQkrZMxZTaFscAwqoI0+i6TFTXSikOyGGhm3T0bsoeKt8tFgU1/PoKFl5UpwGx+qx7nLqactn16BFTagHkh0yXBl1q2jwFmOpZVz0uufEYeb6JioIFMpxYLiIiGFbi7u7G+A3NIlYaZks9F/J7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvWJCe7wF+Dy7BOmazRmeKWlZ+l0MbX+QvAdlX1zUkc=;
 b=LBQW2dhi1FS4Yizw67dFdVYWSJDQOoEaDkAMdUjHVITTgT3dIt2ljNXJRV8B4stplcrCxWftEPDhrNZajBVAqoIwrD0zWAJccZmgxztz/+IkLdUrDlcuJJLiblLGLySW+LqKqc55uMQ54IwsGSURaYxzNxZyYNu8eBMDxKWpxSI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3400.eurprd08.prod.outlook.com (20.177.112.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 14:17:36 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 14:17:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
Thread-Topic: [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
Thread-Index: AQHVpVYYOOqrL+0ML0i4F9pC4GQXY6eiJjTSgAAOm4A=
Date: Fri, 29 Nov 2019 14:17:35 +0000
Message-ID: <2c082987-6d6b-557f-2b9d-28643c445a0c@virtuozzo.com>
References: <20191127190840.15773-1-vsementsov@virtuozzo.com>
 <878snyu85p.fsf@dusky.pond.sub.org>
In-Reply-To: <878snyu85p.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::28) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129171733210
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f6d1ea7-6714-4d2a-2b2a-08d774d6e1d6
x-ms-traffictypediagnostic: AM6PR08MB3400:
x-microsoft-antispam-prvs: <AM6PR08MB34003F544B4171BDEAB24680C1460@AM6PR08MB3400.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39840400004)(199004)(189003)(66556008)(66476007)(66446008)(66946007)(31686004)(14444005)(81166006)(81156014)(8676002)(8936002)(256004)(25786009)(99286004)(64756008)(6116002)(3846002)(5660300002)(14454004)(478600001)(66066001)(2906002)(386003)(6506007)(7736002)(102836004)(86362001)(6512007)(36756003)(26005)(76176011)(186003)(4326008)(52116002)(6246003)(6916009)(305945005)(2616005)(6486002)(31696002)(54906003)(11346002)(446003)(71200400001)(71190400001)(229853002)(6436002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3400;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJ9e597XISphEgloDabBFZvaOTToh8Gri7qp1Bi735EGPn2xRVgwbc4gBoITq5Wzm32JOYqSkoJTFwdZ0JoWt0nhicUy9f+y3jsKT9Ekr7VC/4zKwcOSZtFVDfS9QoLeUMWpU2/1Kgja12eLUF9oYs7/ZB6rfAKPTeMNEQouX3B8helu1op+DWClNuRvH5II1AQOAMGeeCPk1Am8RuCl3tUtK3on0bjdPPWl7pfLw0RparXA7OpJ7pMOTt1vcwWhd/FuSOA23Vk5UN+W2ZcYWvVXniXRkZyLAxtkh8Ld3Gzwifwfuudli28DDYuVLxqCmBckGOBuaih0QMFJwjfk+49nKVy+VGRWAsJZC18E+ci/mheID6ibGt5/PNf9ITgeYHJm7JMSkBDhNm1oqDGnC+4cKSTkuQnozPpnGQkF+NkFN4fxcFLXlnvTIHNcAJ9X
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A29F862D1092274DA9906CBD1268DFA5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6d1ea7-6714-4d2a-2b2a-08d774d6e1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 14:17:35.8316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kNE/CGvGuxer+4K9P+ZnLAI2DVmm1GjAyokavYcRa3ZWG5YYBiCdUUZQrBrEzvF5qdLALw1OrvTf7uaNQwisoSnohLqfOoYj24MNSrTJNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3400
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe05::722
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSAxNjoyNSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IE1ha2UgbmJkX2l0ZXJfY2hhbm5lbF9lcnJvciBlcnJwIGhhbmRsZXIgd2VsbCBmb3JtZWQ6
DQo+PiByZW5hbWUgbG9jYWxfZXJyIHRvIGVycnBfaW4sIGFzIGl0IGlzIElOLXBhcmFtZXRlciBo
ZXJlICh3aGljaCBpcw0KPj4gdW51c3VhbCBmb3IgRXJyb3IqKikuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KPj4gUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4g
LS0tDQo+Pg0KPj4gdjY6IGZpeCBjb21taXQgbWVzc2FnZQ0KPj4gICAgICBhZGQgRXJpYydzIHIt
Yg0KPj4NCj4+ICAgYmxvY2svbmJkLmMgfCAxMCArKysrKy0tLS0tDQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2Jsb2NrL25iZC5jIGIvYmxvY2svbmJkLmMNCj4+IGluZGV4IDVmMThmNzhhOTQuLjM0NWJmOTAy
ZTMgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9uYmQuYw0KPj4gKysrIGIvYmxvY2svbmJkLmMNCj4+
IEBAIC04NjQsMTggKzg2NCwxOCBAQCB0eXBlZGVmIHN0cnVjdCBOQkRSZXBseUNodW5rSXRlciB7
DQo+PiAgIH0gTkJEUmVwbHlDaHVua0l0ZXI7DQo+PiAgIA0KPj4gICBzdGF0aWMgdm9pZCBuYmRf
aXRlcl9jaGFubmVsX2Vycm9yKE5CRFJlcGx5Q2h1bmtJdGVyICppdGVyLA0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHJldCwgRXJyb3IgKipsb2NhbF9lcnIpDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcmV0LCBFcnJvciAqKmVy
cnBfaW4pDQo+PiAgIHsNCj4+IC0gICAgYXNzZXJ0KHJldCA8IDApOw0KPj4gKyAgICBhc3NlcnQo
cmV0IDwgMCAmJiBlcnJwX2luICYmICplcnJwX2luKTsNCj4+ICAgDQo+PiAgICAgICBpZiAoIWl0
ZXItPnJldCkgew0KPj4gICAgICAgICAgIGl0ZXItPnJldCA9IHJldDsNCj4+IC0gICAgICAgIGVy
cm9yX3Byb3BhZ2F0ZSgmaXRlci0+ZXJyLCAqbG9jYWxfZXJyKTsNCj4+ICsgICAgICAgIGVycm9y
X3Byb3BhZ2F0ZSgmaXRlci0+ZXJyLCAqZXJycF9pbik7DQo+PiAgICAgICB9IGVsc2Ugew0KPj4g
LSAgICAgICAgZXJyb3JfZnJlZSgqbG9jYWxfZXJyKTsNCj4+ICsgICAgICAgIGVycm9yX2ZyZWUo
KmVycnBfaW4pOw0KPj4gICAgICAgfQ0KPj4gICANCj4+IC0gICAgKmxvY2FsX2VyciA9IE5VTEw7
DQo+PiArICAgICplcnJwX2luID0gTlVMTDsNCj4gDQo+IFRoaXMgb25lIGlzIGFjdHVhbGx5IGlu
L291dC4NCj4gDQo+IElmIHdlIHVzZSB0aGUgY29udmVudGlvbg0KPiANCj4gICAgICBBbnkgRXJy
b3IgKiogcGFyYW1ldGVyIG1lYW50IGZvciBwYXNzaW5nIGFuIGVycm9yIHRvIHRoZSBjYWxsZXIg
bXVzdA0KPiAgICAgIGJlIG5hbWVkIEBlcnJwLiAgTm8gb3RoZXIgRXJyb3IgKiogcGFyYW1ldGVy
IG1heSBiZSBuYW1lZCBAZXJycC4NCj4gDQo+IHRoZW4gdGhlIG9sZCBuYW1lIGlzIGFzIGdvb2Qg
YXMgdGhlIG5ldyBvbmUuICBCdXQgdGhlIG5ldyBvbmUncyAiaW4iDQo+IHN1Z2dlc3Rpb24gaXMg
bWlzbGVhZGluZy4NCj4gDQoNCkFncmVlZC4gRG8geW91IGhhdmUgYSBzdWdnZXN0aW9uIGhvdyB0
byByZW5hbWUgZXJycCBpbiBzdWNoIGNhc2VzICh1c2luZw0KbG9jYWxfZXJyIGluIGdlbmVyYWwg
d2lsbCBiZSBtaXNsZWFkaW5nIHRvbykuLg0KDQpNYXliZSwgImZpbGxlZF9lcnJwIiA/IFNlZW1z
IHRvbyBsb25nLi4NCiJzZXRfZXJycCIgaXMgc2hvcnRlciwgYnV0IG5vIG9uZSB3aWxsIGd1ZXNz
IHRoYXQgdGhpcyBpcyB0aGUgdGhpcmQgZm9ybSBvZiB0aGUgdmVyYi4uDQoNCj4+ICAgfQ0KPj4g
ICANCj4+ICAgc3RhdGljIHZvaWQgbmJkX2l0ZXJfcmVxdWVzdF9lcnJvcihOQkRSZXBseUNodW5r
SXRlciAqaXRlciwgaW50IHJldCkNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

