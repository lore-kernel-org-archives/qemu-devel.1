Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978EAC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A75216C8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DLGUGNvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A75216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hslQg-00056t-OF
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49933)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hslQD-0004Tk-Ui
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hslQC-0000g9-NS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:01:25 -0400
Received: from mail-eopbgr140093.outbound.protection.outlook.com
 ([40.107.14.93]:9349 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hslQC-0000f9-3c; Wed, 31 Jul 2019 06:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDQ1i/PugSV4PjKByOPisOO1/EGB6AFlQxbBra9YGhO0/elt3vd1p3R/3UOwu3yXtcdEgimJss4ox2JuLAC03Y0AoGR7yzsPFYM9VSspx+7/oebrFPwit8m0X91TGkQdSdL3s5WNua77PaLDZ7tpmI1vP72YfHzf38FXSX/eUNmF4DDtLL5HziAuBdDR4exArXXYP6TRPwRkjsj/5xuYtab8rwow932HmVD3eFpUGcFZ5LUdCd0L8BachbeDIMFPtCMRafa5NfdqxNYEMUoWtnOMBHKLwFfg2LKKMW5ud9IAdA1K6+EyMt6ePo+bNF2MB5IDEjxS0q1FcrbDI77hWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdnqnJrxWN7gjRVR4hC2SHf+uZAxqsIB5dSQxwVwD6Y=;
 b=GQHSVxCqXRv4Uvse2UqqllT/PbgrhHyveHaoMp9FFaiamZ1DAGmW4Op5yvzqhEYDfnt2C6avXyrzuZqIBTogJYHN1E9F0vML5VaIvsACtsXgiHkxCWw12kPVSfYtSjP2PquT9i+F5wB9p1PkH2Fka8Axee4pQlbDK5cJEKHor/3Ov8p2loPcnFyurdzEI0a3ipFwbRTZLE1GM/jcfSYh+/JIjTAeOQ1B5z2PGoywfehud0kkYulkVW25DAzy0+DyxA+PwFaKt5CGCR2q1606FB1aTT4cBBulBNaliPVJSamx7Vyr301udmSUh+vpxzXHoC5d8QJnpyyKDTaNHgqMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdnqnJrxWN7gjRVR4hC2SHf+uZAxqsIB5dSQxwVwD6Y=;
 b=DLGUGNvgQ5b2X/qnWqzZJb0Zj9rX544Bu/2e7uBIyDfXK2b3HrWvIDO4wqJc5fqnKtvVjUmfbZdRYOtgYKtL4tlGESzKKqruPR5vqoIYaTR8WDhz+8iLcLSqqS7IYkOjZi8XGBlL2lEoGkouoDvpW4/bSILXqWUQmGPyc9kM5CE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4076.eurprd08.prod.outlook.com (20.179.12.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 10:01:20 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 10:01:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 1/3] block/backup: deal with zero detection
Thread-Index: AQHVRvRy+TXY0QGIQkWxUwQMtXaphKbjfpMAgAEBTwA=
Date: Wed, 31 Jul 2019 10:01:20 +0000
Message-ID: <6c4d1b26-925b-c7a1-dbe3-9cae2ab0e3d6@virtuozzo.com>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <20190730163251.755248-2-vsementsov@virtuozzo.com>
 <f13fdafd-34d2-3079-ab17-78cdb7e9f428@redhat.com>
In-Reply-To: <f13fdafd-34d2-3079-ab17-78cdb7e9f428@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0050.eurprd04.prod.outlook.com
 (2603:10a6:3:19::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190731130118750
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a63b127b-3d61-4938-b05b-08d7159e099e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4076; 
x-ms-traffictypediagnostic: DB8PR08MB4076:
x-microsoft-antispam-prvs: <DB8PR08MB407621B6341156D8E24008F3C1DF0@DB8PR08MB4076.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39850400004)(189003)(199004)(81156014)(4326008)(68736007)(66946007)(110136005)(6436002)(25786009)(107886003)(6246003)(446003)(71200400001)(316002)(6116002)(256004)(476003)(64756008)(31696002)(53936002)(2501003)(66476007)(66446008)(3846002)(229853002)(54906003)(36756003)(86362001)(6512007)(52116002)(66556008)(478600001)(8676002)(99286004)(53546011)(102836004)(2616005)(6486002)(305945005)(8936002)(11346002)(486006)(26005)(76176011)(186003)(2906002)(5660300002)(66066001)(6506007)(31686004)(386003)(81166006)(14444005)(14454004)(71190400001)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4076;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K1nX89bSUoXvGUAVtNFSgJgQ/ZbqdKF/F6vUpgUBpHnkK+el5l5orwYfJnSB3Nv2rU39XedQkXqQYj8uLZmtm6PrjjuxBrMd3B+/yCntckBNOiyisomD/Sf6sqSty1m32l98mXWgQklqZp6xF21rjR4H1GaNzcTwXYduFFI8HQOyRmeR9k1pPwl67Bj9GPFo+iUcnFTNvM6o+XTIkmgWxwT6n9rWbp4C8LdQxXuy1zHct3dSckfjB3+wMt41rjoUe9SCau2ITvu0C9BI1J6RALtTDviTlYILq0DAndtaJPwgmdMYSkoTAOQNSE9C7eqPBO3d7qOgi0MmcNDw9heBH42rCEvOZEdyBEnrKykYZ0Z8wYfHJ1HUihNSDW74IbIq04uBh89hNG+I9+Q16v6R3AtSCv+Lg6PwD4mCVKg++IE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <691A94EB83F7524E957C2BCC6BF55DA0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63b127b-3d61-4938-b05b-08d7159e099e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 10:01:20.7776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4076
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.93
Subject: Re: [Qemu-devel] [PATCH 1/3] block/backup: deal with zero detection
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDcuMjAxOSAyMTo0MCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMzAvMTkg
MTI6MzIgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBXZSBoYXZl
IGRldGVjdF96ZXJvZXMgb3B0aW9uLCBzbyBhdCBsZWFzdCBmb3IgYmxvY2tkZXYtYmFja3VwIHVz
ZXINCj4+IHNob3VsZCBkZWZpbmUgaXQgaWYgemVyby1kZXRlY3Rpb24gaXMgbmVlZGVkLiBGb3Ig
ZHJpdmUtYmFja3VwIGxlYXZlDQo+PiBkZXRlY3Rpb24gZW5hYmxlZCBieSBkZWZhdWx0IGJ1dCBk
byBpdCB0aHJvdWdoIGV4aXN0aW5nIG9wdGlvbiBpbnN0ZWFkDQo+PiBvZiBvcGVuLWNvZGluZy4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2svYmFja3VwLmMgfCAxNSAr
KysrKystLS0tLS0tLS0NCj4+ICAgYmxvY2tkZXYuYyAgICAgfCAgOCArKysrLS0tLQ0KPj4gICAy
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+PiBpbmRleCA3
MTVlMWQzYmU4Li5mNGFhZjA4ZGYzIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4+
ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+PiBAQCAtMTEwLDcgKzExMCwxMCBAQCBzdGF0aWMgaW50
IGNvcm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9ja0pv
YiAqam9iLA0KPj4gICAgICAgQmxvY2tCYWNrZW5kICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+
PiAgICAgICBpbnQgbmJ5dGVzOw0KPj4gICAgICAgaW50IHJlYWRfZmxhZ3MgPSBpc193cml0ZV9u
b3RpZmllciA/IEJEUlZfUkVRX05PX1NFUklBTElTSU5HIDogMDsNCj4+IC0gICAgaW50IHdyaXRl
X2ZsYWdzID0gam9iLT5zZXJpYWxpemVfdGFyZ2V0X3dyaXRlcyA/IEJEUlZfUkVRX1NFUklBTElT
SU5HIDogMDsNCj4+ICsgICAgaW50IHdyaXRlX2ZsYWdzID0NCj4+ICsgICAgICAgICAgICAoam9i
LT5zZXJpYWxpemVfdGFyZ2V0X3dyaXRlcyA/IEJEUlZfUkVRX1NFUklBTElTSU5HIDogMCkgfA0K
Pj4gKyAgICAgICAgICAgIChqb2ItPmNvbXByZXNzID8gQkRSVl9SRVFfV1JJVEVfQ09NUFJFU1NF
RCA6IDApOw0KPj4gKw0KPj4gICANCj4+ICAgICAgIGFzc2VydChRRU1VX0lTX0FMSUdORUQoc3Rh
cnQsIGpvYi0+Y2x1c3Rlcl9zaXplKSk7DQo+PiAgICAgICBoYml0bWFwX3Jlc2V0KGpvYi0+Y29w
eV9iaXRtYXAsIHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+PiBAQCAtMTI4LDE0ICsxMzEs
OCBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZl
cihCYWNrdXBCbG9ja0pvYiAqam9iLA0KPj4gICAgICAgICAgIGdvdG8gZmFpbDsNCj4+ICAgICAg
IH0NCj4+ICAgDQo+PiAtICAgIGlmIChidWZmZXJfaXNfemVybygqYm91bmNlX2J1ZmZlciwgbmJ5
dGVzKSkgew0KPj4gLSAgICAgICAgcmV0ID0gYmxrX2NvX3B3cml0ZV96ZXJvZXMoam9iLT50YXJn
ZXQsIHN0YXJ0LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmJ5dGVz
LCB3cml0ZV9mbGFncyB8IEJEUlZfUkVRX01BWV9VTk1BUCk7DQo+PiAtICAgIH0gZWxzZSB7DQo+
PiAtICAgICAgICByZXQgPSBibGtfY29fcHdyaXRlKGpvYi0+dGFyZ2V0LCBzdGFydCwNCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbmJ5dGVzLCAqYm91bmNlX2J1ZmZlciwgd3JpdGVf
ZmxhZ3MgfA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAoam9iLT5jb21wcmVzcyA/
IEJEUlZfUkVRX1dSSVRFX0NPTVBSRVNTRUQgOiAwKSk7DQo+PiAtICAgIH0NCj4+ICsgICAgcmV0
ID0gYmxrX2NvX3B3cml0ZShqb2ItPnRhcmdldCwgc3RhcnQsIG5ieXRlcywgKmJvdW5jZV9idWZm
ZXIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVfZmxhZ3MpOw0KPj4gICAgICAg
aWYgKHJldCA8IDApIHsNCj4+ICAgICAgICAgICB0cmFjZV9iYWNrdXBfZG9fY293X3dyaXRlX2Zh
aWwoam9iLCBzdGFydCwgcmV0KTsNCj4+ICAgICAgICAgICBpZiAoZXJyb3JfaXNfcmVhZCkgew0K
Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5jDQo+PiBpbmRleCA0ZDE0MWU5
YTFmLi5hOTRkNzU0NTA0IDEwMDY0NA0KPj4gLS0tIGEvYmxvY2tkZXYuYw0KPj4gKysrIGIvYmxv
Y2tkZXYuYw0KPj4gQEAgLTM0MzQsNyArMzQzNCw3IEBAIHN0YXRpYyBCbG9ja0pvYiAqZG9fZHJp
dmVfYmFja3VwKERyaXZlQmFja3VwICpiYWNrdXAsIEpvYlR4biAqdHhuLA0KPj4gICAgICAgQmxv
Y2tKb2IgKmpvYiA9IE5VTEw7DQo+PiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJtYXAgPSBOVUxM
Ow0KPj4gICAgICAgQWlvQ29udGV4dCAqYWlvX2NvbnRleHQ7DQo+PiAtICAgIFFEaWN0ICpvcHRp
b25zID0gTlVMTDsNCj4+ICsgICAgUURpY3QgKm9wdGlvbnM7DQo+PiAgICAgICBFcnJvciAqbG9j
YWxfZXJyID0gTlVMTDsNCj4+ICAgICAgIGludCBmbGFncywgam9iX2ZsYWdzID0gSk9CX0RFRkFV
TFQ7DQo+PiAgICAgICBpbnQ2NF90IHNpemU7DQo+PiBAQCAtMzUyOSwxMCArMzUyOSwxMCBAQCBz
dGF0aWMgQmxvY2tKb2IgKmRvX2RyaXZlX2JhY2t1cChEcml2ZUJhY2t1cCAqYmFja3VwLCBKb2JU
eG4gKnR4biwNCj4+ICAgICAgICAgICBnb3RvIG91dDsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiAr
ICAgIG9wdGlvbnMgPSBxZGljdF9uZXcoKTsNCj4+ICsgICAgcWRpY3RfcHV0X3N0cihvcHRpb25z
LCAiZGlzY2FyZCIsICJ1bm1hcCIpOw0KPj4gKyAgICBxZGljdF9wdXRfc3RyKG9wdGlvbnMsICJk
ZXRlY3QtemVyb2VzIiwgInVubWFwIik7DQo+PiAgICAgICBpZiAoYmFja3VwLT5mb3JtYXQpIHsN
Cj4+IC0gICAgICAgIGlmICghb3B0aW9ucykgew0KPj4gLSAgICAgICAgICAgIG9wdGlvbnMgPSBx
ZGljdF9uZXcoKTsNCj4+IC0gICAgICAgIH0NCj4+ICAgICAgICAgICBxZGljdF9wdXRfc3RyKG9w
dGlvbnMsICJkcml2ZXIiLCBiYWNrdXAtPmZvcm1hdCk7DQo+PiAgICAgICB9DQo+PiAgIA0KPj4N
Cj4gDQo+IEknbSBsZXNzIHN1cmUgb2YgdGhpcyBvbmUgcGVyc29uYWxseS4gSXMgaXQgcmlnaHQg
dG8gYWx3YXlzIHRyeSB0byBzZXQNCj4gdW5tYXAgb24gdGhlIHRhcmdldD8NCj4gDQo+IEkgbGlr
ZSB0aGUgaWRlYSBvZiByZW1vdmluZyBzcGVjaWFsIGNhc2VzIGFuZCBoYW5kbGluZyB0aGluZ3Mg
bW9yZQ0KPiBjZW50cmFsbHkgdGhvdWdoLCBidXQgSSdsbCB3YW50IE1heCAob3IgS2V2aW4pIHRv
IHRha2UgYSBwZWVrLg0KPiANCj4gLS1qcw0KPiANCg0KDQpJZiBub2JvZHkgbWluZHMgSSdkIGFn
cmVlIHdpdGggeW91IHRvIGRyb3AgemVybyBkZXRlY3RpbmcgZnJvbSBib3RoIGJhY2t1cHMuDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

