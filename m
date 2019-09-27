Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82121C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE16217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JWt7hWTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE16217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDpnN-0005UM-5U
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 08:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDpiT-00015T-BB
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDpiR-00017L-Pk
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:51:20 -0400
Received: from mail-eopbgr10132.outbound.protection.outlook.com
 ([40.107.1.132]:28549 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDpiQ-00017B-V7; Fri, 27 Sep 2019 08:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgeLa2drf96eMJ8bX30n+Zy/xINVIHK1uiSFX8z2OsFWjEUTG+J1IAS01zYOFmFROaU2mlozgTEs56rmKmdv3+nrJLawt/8nrAm9nk2W6hP1MKc1zvsEQ26nYLRT/asW59mvnPSgDa5a74DX3Irxn5Y3Hn/ybtZ/W26XE2Hx5U5Bt8B4Q7WnxAPIf6NxXajIBgFn/zuii/vZvPBrCTE/C/bj18l9uGxcL7CjVIb47+GGP1yRi8uBNV0nk/ur94a7G1karjZ4h17PYj9v5CMPb1ozl14mGviYO1kFgNetLL9b9qRQbYfEh9yEMz9zQ9TA5Bz3H5fIRQ1o2wBdeb78nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn6uY9fNYHCbRozDmBCMXnMDWAkQFAdPUcdUmJKaOV4=;
 b=mVKEMN66TY5jQOrqMlm7oGJFjtN6vcvgLnOFhiHMFb9xJSUlDilzDfDMlXjWnUAtFgjRUSSiJsLU5wjNQyHbpwYH0KVYbFOa6Si6067yVq+1L2o2P0g6XilpTWPubxovJoTJdU7z4mb1UUTuCNQqrWIOyA9iQNIw/XfCXMUEDw8fNikCPpvPmyMvEVYyVxvThl+eIyDHwwAYU2cax287UMFFRTO2xDw+9DZpAbwqKccZOQrgY2+mzZRWMGBjMJBNOF+oUvnaaP/4yCCHi1J7X+6n08LmRW3v3lQadEqAwIm3FZAc6rOl9yraLhKeNXOmpIzKwIgjyso5YKMDLTm9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn6uY9fNYHCbRozDmBCMXnMDWAkQFAdPUcdUmJKaOV4=;
 b=JWt7hWTaHlM4+OGfQe440SkBbMIaT6CaIyRUgduhjs6h7xWkpiP2elkY+umpaPiGfr+DsE1OF3MoyMAUS4v//B+CdfA4INEI8cxhPcGT+lLMml/sbY6BaWTBEWXBlXr2UDl9G3/LfonSz83UbPFQo1UOW4XGCTVWKlYjJ3SK2rI=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB5089.eurprd08.prod.outlook.com (10.255.29.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 27 Sep 2019 10:38:38 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 10:38:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v4 04/10] iotests.py: add event_wait_log and
 events_wait_log helpers
Thread-Topic: [Qemu-devel] [PATCH v4 04/10] iotests.py: add event_wait_log and
 events_wait_log helpers
Thread-Index: AQHVTSopsvgVlwVKVEeEJ+8OAOZN+qc+43YAgAC/nACAAAIIAA==
Date: Fri, 27 Sep 2019 10:38:38 +0000
Message-ID: <30562b63-0598-101e-5177-1b31cab7f45a@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-5-vsementsov@virtuozzo.com>
 <a578331a-86a6-4636-d055-3cc4c43ba495@redhat.com>
 <62862d28-5183-8af7-f515-36d6c9d8a2e8@virtuozzo.com>
In-Reply-To: <62862d28-5183-8af7-f515-36d6c9d8a2e8@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0048.eurprd09.prod.outlook.com
 (2603:10a6:3:45::16) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927133836036
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fa60e69-dffe-48ac-918d-08d74336db89
x-ms-traffictypediagnostic: AM0PR08MB5089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB508905110B8ED298A49CB8B1C1810@AM0PR08MB5089.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(376002)(346002)(366004)(189003)(199004)(54906003)(14454004)(386003)(31696002)(446003)(11346002)(86362001)(2616005)(486006)(66066001)(31686004)(71190400001)(99286004)(71200400001)(26005)(6116002)(6506007)(102836004)(186003)(53546011)(2906002)(7736002)(5660300002)(305945005)(476003)(25786009)(478600001)(316002)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(81166006)(8936002)(52116002)(3846002)(76176011)(36756003)(6512007)(6436002)(107886003)(110136005)(81156014)(6486002)(256004)(4326008)(14444005)(229853002)(2501003)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5089;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvvH4sTwM+MijOjXBlgXVLWrKaYesT9bLMSBU50RC18NawMS3mWfxfiDwU83VNrnWuaKD+FPW02j1djslMInu2JurUpfwX8FsHsxv9NyDsD++/w/xh9FR0WFRzUtum9rJCW+eps/HbTTZzbIfZA8fRb2t+f5zMArXQI9aJbH4M3SPF0U1y/F2KOVZGMjf8J4gi9CG4Zvn+q9hAKlZOXh+c66uaIw3wHxBA3gwiS36HftYKxS4DYp+kOTtuawES7rWdFRA1IvIJqapLZ/Noh9Jvxf4FpPmsXnFyhlv5hiS527R4rQB3zQNLEAmdtqIqgcClkxGPQI+vMA/nwloLZTJfhnvtifhAQPtGG9rPa7nNw138QyBHu3TUBYsb9RJ7E4ykZ/t0/3D8NTmV3k3cQSRTvpjdCT5b1DQCMBNUNt0Q8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B68CABAABCA2F4EBE5CC29C0A5B18A1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa60e69-dffe-48ac-918d-08d74336db89
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 10:38:38.7516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dKq+K0nDrQzP1o/6YgB41osFvq4Z1pHCPZfjb89N6F29mztSplwGAM0vlPRxDfB+w6xv/OaugCMxCv4ahuzEa3riNLmqYEAbY2bCN8Fflc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5089
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.132
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAxMDozMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjcuMDkuMjAxOSAyOjA1LCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDgvNy8xOSAx
MDoxMiBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiBTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgfCAx
MCArKysrKysrKysrDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSBiL3Rlc3Rz
L3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+Pj4gaW5kZXggY2U3NDE3N2FiMS4uNGFkMjY1ZjE0
MCAxMDA2NDQNCj4+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPj4+ICsr
KyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+Pj4gQEAgLTU0MCw2ICs1NDAsMTYg
QEAgY2xhc3MgVk0ocXRlc3QuUUVNVVF0ZXN0TWFjaGluZSk6DQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGxvZyhyZXN1bHQsIGZpbHRlcnMsIGluZGVudD1pbmRlbnQpDQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiByZXN1bHQNCj4+PiArwqDCoMKgIGRlZiBldmVudF93YWl0X2xvZyhzZWxm
LCBuYW1lLCAqKmt3YXJncyk6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGV2ZW50ID0gc2VsZi5ldmVu
dF93YWl0KG5hbWUsICoqa3dhcmdzKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCBsb2coZXZlbnQsIGZp
bHRlcnM9W2ZpbHRlcl9xbXBfZXZlbnRdKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZXZl
bnQNCj4+PiArDQo+Pj4gK8KgwqDCoCBkZWYgZXZlbnRzX3dhaXRfbG9nKHNlbGYsIGV2ZW50cywg
Kiprd2FyZ3MpOg0KPj4+ICvCoMKgwqDCoMKgwqDCoCBldmVudCA9IHNlbGYuZXZlbnRzX3dhaXQo
ZXZlbnRzLCAqKmt3YXJncykNCj4+PiArwqDCoMKgwqDCoMKgwqAgbG9nKGV2ZW50LCBmaWx0ZXJz
PVtmaWx0ZXJfcW1wX2V2ZW50XSkNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGV2ZW50DQo+
Pj4gKw0KPj4+IMKgwqDCoMKgwqAgIyBSZXR1cm5zIE5vbmUgb24gc3VjY2VzcywgYW5kIGFuIGVy
cm9yIHN0cmluZyBvbiBmYWlsdXJlDQo+Pj4gwqDCoMKgwqDCoCBkZWYgcnVuX2pvYihzZWxmLCBq
b2IsIGF1dG9fZmluYWxpemU9VHJ1ZSwgYXV0b19kaXNtaXNzPUZhbHNlLA0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJlX2ZpbmFsaXplPU5vbmUsIHVzZV9sb2c9VHJ1
ZSwgd2FpdD02MC4wKToNCj4+Pg0KPj4NCj4+IEknbSBub3Qgc3VyZSB0aGVzZSBhcmUgcmVhbGx5
IG5lZWRlZCwgc2luY2UgeW91IGNhbiBqdXN0IGxvZyB0aGUgZXZlbnQNCj4+IHlvdSBnZXQgYWZ0
ZXIgY2FsbGluZyBlaXRoZXIgb2YgdGhlc2UgbWV0aG9kcyBhbnl3YXkuIFRoZXJlJ3Mgbm90aGlu
Zw0KPj4gc3RvcHBpbmcgeW91IGZyb206DQo+Pg0KPj4gYGBgDQo+PiBldmVudCA9IGV2ZW50X3dh
aXRfbG9nKC4uLikNCj4+IGxvZyhmaWx0ZXJfcW1wX2V2ZW50KGV2ZW50KSkNCj4+IGBgYA0KPiAN
Cj4gdHdvIGxpbmVzIHZzIG9uZQ0KPiANCj4gSG0sIGp1c3Qgc2ltcGxlIHdyYXBwZXJzIGxpa2Ug
cW1wX2xvZygpLCB0byBtYWtlIHRlc3QgYSBiaXQgbW9yZSByZWFkYWJsZSwgd2h5IG5vdC4uDQo+
IA0KDQpTdGlsbCBrZWVwaW5nIGluIG1pbmQgaWRlYSBvZiBnbG9iYWwgbG9nZ2luZyB0dXJuIG9u
L29mZiwgaXQgbWF5IGJlIGJhZCB0byBpbmNyZWFzZSBudW1iZXIgb2YgZl9sb2cNCmZ1bmN0aW9u
IHZlcnNpb25zLCBpdCByZW1lbWJlciBtZSB0aGUgcGFpbiB3aXRoIF9sb2NrZWQgQVBJcyBpbiBk
aXJ0eS1iaXRtYXBzLg0KDQpPSywgSSdsbCBkcm9wIGl0Lg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

