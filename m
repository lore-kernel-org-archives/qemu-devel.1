Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2352C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEEF2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZE2Gdk/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEEF2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PH3-0007gl-V5
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i8PGG-00075W-S6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i8PGF-0005nu-9q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:35:48 -0400
Received: from mail-eopbgr140110.outbound.protection.outlook.com
 ([40.107.14.110]:19854 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i8PGE-0005mV-IL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM8EpZmmk63DpslZyxuWX9bPA+RUwsIHDuPzRN2+nTw7f+OB5Paw+Ojyjd3LmQDrlr0h/0hWQVcnMp8IJhom0b6UaQ9h08GOuwbBHlGBlG8F2qy9QrQasw3cVSqowsNpeL1xBCG0DojEIhtoX4AoqKoO0LXRFa73uY2QtE0SGdjfcXUAVwXIu6tpu686NrMjR67U2tg+ZizLcs/NdjbfEUy7vyYowd6I/4cqBFeViQo5KD/ORet4oRHT2lBdfLJPeBquEJU6rHBs1bTgv25hSsq/opkI8gIrzHt2WVY7jEr+XZSmJdsUS9AY/6gGREZ6TaIUp//Pz05rdUCaIy16RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTz7yLKmSj+fS1EKLl/Q3Ba2q1RB0+KMTauEvuUnnD8=;
 b=La+nBunLVqwFjBlxWanN3t/1acJOzLgYavostn4imRx9uDvyS9YHVENZKL+9wwdR84SAftFzqVeNLTaWJHrmQFx5L1fHNVMn4XeP1OWJGE3uE9kLPY9X8MhvlnP8QFVzskExjql/eeAF2kQQTrp/QNqaQJsAnW82r+4pYtkFh7TkcANPmwQeKv/DXarziKFywZ71yywJoaiaed3syp5yD/t1JMjrYCWnRlBXGREOGmDHpQhX9n5smxFLOhcb8LCKfArVzntRc2bZfg/5nSgfhK8D/3NXJIrZDe+lo9gqwEKZeMRfLmpnE0X5KpYGQMQAJs16U2PGYkkzA+76K2IfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTz7yLKmSj+fS1EKLl/Q3Ba2q1RB0+KMTauEvuUnnD8=;
 b=ZE2Gdk/ObG7lKU1+p7AlHqYQ3vvLXD3p5hqhVQsxNodICaiem0yf8ZzoFBNzvRRHI4uGhEbrPLRHbYAM0lEdItsZDRUtpjJDDpCyTMDIdAY9Ms/NGkWLNkccIo7Aq0/lpMRka8F8ylMFeYop5OrYQ7A5fvOefcURolcPz5FURYg=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2603.eurprd08.prod.outlook.com (10.175.35.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 13:35:42 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 13:35:42 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Mark Syms <Mark.Syms@citrix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] Valgrind confused by queue macros
Thread-Index: AdVn2TTmG0WDoKwzR2+3/z64vpIPIABHZ/4AAB4I2oA=
Date: Thu, 12 Sep 2019 13:35:42 +0000
Message-ID: <9406b1ac-05fe-0455-f923-895a151baa99@virtuozzo.com>
References: <e2cce2353aa44e2481f01b96ee1e6028@AMSPEX02CL01.citrite.net>
 <5c016081-6ba6-5ae1-524a-6e45c92e9822@redhat.com>
In-Reply-To: <5c016081-6ba6-5ae1-524a-6e45c92e9822@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0036.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::25) To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 803ac028-56f2-4af0-d865-08d737861b99
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2603; 
x-ms-traffictypediagnostic: HE1PR0802MB2603:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0802MB2603830BC09BE3BE3EA3E02CF4B00@HE1PR0802MB2603.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(376002)(136003)(346002)(189003)(199004)(54906003)(11346002)(476003)(110136005)(66066001)(52116002)(99286004)(76176011)(2616005)(6512007)(5660300002)(44832011)(316002)(53936002)(386003)(6506007)(53546011)(102836004)(4326008)(107886003)(6436002)(486006)(8676002)(6246003)(3846002)(2501003)(2906002)(8936002)(6486002)(186003)(446003)(305945005)(26005)(81156014)(81166006)(229853002)(14454004)(71190400001)(66946007)(36756003)(31686004)(66556008)(71200400001)(86362001)(66476007)(66446008)(64756008)(31696002)(6116002)(478600001)(25786009)(7736002)(256004)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2603;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8TiVs22FjrAWU3dShgYnSwctSKCG6RzP5fpZmeGly8hQI7PTD21+Le2eUvNSoPaYxWXuyyXiFx9XioCXsy4U7R9OavlWLSnmC8iVItm3+Dkb7xwY8LBdXKNlurls14JSTkFWP+/5G6zhr4nCQWxqJiS93Fc/jst9T7gXYCBpQJ9dlbGrSorlO4puxOXz/okqV7OF1BMU/2esx7WqkHPLeLtddva73nYTPDOKaR3NbfIL9xvG+xtZC9M2SVfsc3SXN0wxs8RHOhKRUMZGwopXPeZRhK3Hgd+qU/xZ/bo5SiPX6e1zVo8Axpo6+s2bwR5gvEPzTxc05EfMMe5Mr+s6sfDCVJYl9o3/tbDk9wT+LV/Z1n6GCFzf3tONh32EULqSJFi03hdr4FYNXD+ocrlhdA9phYd2zNE8bPy6Pk7Afhs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D99510B4BA2D9443A66662E168979CEB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803ac028-56f2-4af0-d865-08d737861b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:35:42.6386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyeRWdwE7lNUV4AslswZ+WJ33WVKs6zqMz/Bg7qsys3ogwb8FLePW6szsomU1IRgd17t1w6MczExD0oXOrL0cF7lcJbKiA9vHyO6Tp6gy2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2603
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.110
Subject: Re: [Qemu-devel] Valgrind confused by queue macros
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDEyLzA5LzIwMTkgMDI6MTUsIEpvaG4gU25vdyB3cm90ZToNCj4gDQo+IA0KPiBPbiA5
LzEwLzE5IDk6MjcgQU0sIE1hcmsgU3ltcyB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IFdoaWxlIHRy
eWluZyB0byB0cmFjayBkb3duIGFuIGlzc3VlIGluIHVzaW5nIHFlbXUgNC4xIHdpdGggc29tZSBk
ZXZlbG9wbWVudCBmZWF0dXJlcyB3ZSBuZWVkZWQvd2FudGVkIHRvIHJ1biB2YWxncmluZCBvbiBp
dCB0byBmaW5kIGEgbWVtb3J5IGVycm9yLiBVbmZvcnR1bmF0ZWx5IHRoZSBmb3JtIG9mIHRoZSBx
dWV1ZSBtYWNyb3Mgc2VlbXMgdG8gcmVhbGx5IGNvbmZ1c2UgdmFsZ3JpbmQgYW5kIGNhdXNlIGl0
IHRvIHJlcG9ydCBtYW55ICIgVXNlIG9mIHVuaW5pdGlhbGlzZWQgdmFsdWUgIiBlcnJvcnMuDQo+
Pg0KPj4gQXMgYW4gZXhhbXBsZSwgaW4gcWVtdV9haW9fY29yb3V0aW5lX2VudGVyIC0NCj4+DQo+
PiBVc2Ugb2YgdW5pbml0aWFsaXNlZCB2YWx1ZSBvZiBzaXplIDgNCj4+ICAgICBhdCAweDY5RTdF
NTogcWVtdV9haW9fY29yb3V0aW5lX2VudGVyIChxZW11LWNvcm91dGluZS5jOjEwOSkNCj4+DQo+
PiBDb25kaXRpb25hbCBqdW1wIG9yIG1vdmUgZGVwZW5kcyBvbiB1bmluaXRpYWxpc2VkIHZhbHVl
KHMpDQo+PiAgICAgYXQgMHg2OUU3RkE6IHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlciAocWVtdS1j
b3JvdXRpbmUuYzoxMTIpDQo+Pg0KPj4gVXNlIG9mIHVuaW5pdGlhbGlzZWQgdmFsdWUgb2Ygc2l6
ZSA4DQo+PiAgICAgYXQgMHg2OUU4MDA6IHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlciAocWVtdS1j
b3JvdXRpbmUuYzoxMTgpDQo+Pg0KPj4gVXNlIG9mIHVuaW5pdGlhbGlzZWQgdmFsdWUgb2Ygc2l6
ZSA4DQo+PiAgICAgYXQgMHg2OUU4MDk6IHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlciAocWVtdS1j
b3JvdXRpbmUuYzoxMjApDQo+Pg0KPj4gVXNlIG9mIHVuaW5pdGlhbGlzZWQgdmFsdWUgb2Ygc2l6
ZSA4DQo+PiAgICAgYXQgMHg2OUU4MjI6IHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlciAocWVtdS1j
b3JvdXRpbmUuYzoxMjIpDQo+Pg0KPj4gVXNlIG9mIHVuaW5pdGlhbGlzZWQgdmFsdWUgb2Ygc2l6
ZSA4DQo+PiAgICAgYXQgMHg2OUU4M0E6IHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlciAocWVtdS1j
b3JvdXRpbmUuYzoxMzQpDQo+Pg0KPj4gVXNlIG9mIHVuaW5pdGlhbGlzZWQgdmFsdWUgb2Ygc2l6
ZSA4DQo+PiAgICAgYXQgMHg2OUU4NDU6IHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlciAocWVtdS1j
b3JvdXRpbmUuYzoxMzkpDQo+Pg0KPj4gVGhpcyBzZWVtcyB0byB1bHRpbWF0ZWx5IHJlc3VsdCBm
cm9tIGl0IHRoaW5raW5nIHRoYXQgcGVuZGluZyBpcyBub3QgaW5pdGlhbGlzZWQgYnkgdGhpcyBs
aW5lDQo+Pg0KPj4gICAgICBRU0lNUExFUV9IRUFEKCwgQ29yb3V0aW5lKSBwZW5kaW5nID0gUVNJ
TVBMRVFfSEVBRF9JTklUSUFMSVpFUihwZW5kaW5nKTsNCj4+DQo+PiBBcyB0aGlzIGlzc3VlIGlu
IGl0c2VsZiBhY2NvdW50cyBmb3IgNyBlcnJvcnMgZXZlcnkgdGltZSB0aGF0IHFlbXVfYWlvX2Nv
cm91dGluZV9lbnRlciBpcyBjYWxsZWQgKHdoaWNoIGlzIGZyZXF1ZW50bHkpIHZhbGdyaW5kIHZl
cnkgc29vbiBnaXZlcyB1cCBhbmQgc2F5cyB0aGUgY29kZSBpcyB0b28gYnJva2VuIHRvIHJlcG9y
dCBlcnJvcnMgb24gLSB1bmxlc3MgdGhhdCBpcyB5b3UgZGlzYWJsZSB0aGUgZXJyb3ItbGltaXQg
d2hpY2ggaXMgd2hhdCB3ZSd2ZSBkb25lIGJ1dCB0aGVuIHlvdSBzdGlsbCBoYXZlIHRvIGlkZW50
aWZ5IHRoZSByZWFsIGVycm9ycyBpbiB0aGUgbWlkZGxlIG9mIHRoZXNlIG9uZXMuDQo+Pg0KPj4g
Tm90IHN1cmUgd2hhdCBpdCBpcyBhYm91dCB0aGUgbWFjcm9zIGluIHRoZSBpbml0aWFsaXNhdGlv
biBsaW5lIHRoYXQgY2F1c2UgdmFsZ3JpbmQgdG8gdGhpbmsgaXQgaXNuJ3QgaW5pdGlhbGlzZWQs
IHdoaWxzdCB0aGVyZSBpcyBhIHNtYWxsIGFtb3VudCBvZiBtYWNybyBtYWdpYyBpbiB0aGVyZSBp
dCBsb29rcyBsaWtlIGl0IGRvZXMgYWN0dWFsbHkgcmVzdWx0IGluIHRoaW5ncyBiZWluZyBjb3Jy
ZWN0bHkgaW5pdGlhbGlzZWQuDQo+Pg0KPj4gVGhpcyBpcyB1c2luZyB2YWxncmluZCAzLjEzLjAt
MTMuZWw3IG9uIGEgQ2VudE9TIDcgc3lzdGVtLg0KPj4NCj4+IEFueSBjbHVlcyBhYm91dCBob3cg
dG8gcmVzb2x2ZSB0aGlzPyBPciBpcyBpdCBqdXN0IGEgZmFjdCBvZiBsaWZlIHRoYXQgdmFsZ3Jp
bmQgaXMgbmV2ZXIgZ29pbmcgdG8gYmUgaGFwcHkgd2l0aCB0aGlzIGNvZGU/DQo+Pg0KPj4gVGhh
bmtzLA0KPj4NCj4+IE1hcmsuDQo+Pg0KPiANCj4gSSBoYXZlbid0IHVzZWQgdmFsZ3JpbmQgb24g
YSAicmVhbCIgcnVuIG9mIFFFTVUgaW4gc29tZSB0aW1lLCB1c3VhbGx5DQo+IHVzaW5nIGl0IGZv
ciB0aGUgdGVzdCBzdWl0ZSBpbnN0ZWFkLg0KPiANCj4gSW4gdGhpcyBjYXNlLCBhcmUgeW91IHN1
cmUgaXQncyBjaG9raW5nIG9uIHRoZSBtYWNybyBhbmQgbm90IGdldHRpbmcNCj4gY29uZnVzZWQg
YWJvdXQgYWxsIG9mIHRoZSBzdGFjayBzd2FwcyB0aGF0IFFFTVUgaXMgZG9pbmcgaW4gdGhlDQo+
IGNvcm91dGluZSBtb2R1bGU/DQo+IA0KPiBDQ2luZyBzb21lIGZvbGtzIHdobyBoYXZlIHdvcmtl
ZCBvbiB2YWxncmluZCBzdXBwb3J0IGluIHRoZSBwYXN0LCB0aGV5DQo+IG1pZ2h0IGhhdmUgYSBt
b3JlIHRhcmdldGVkIGlkZWEuDQo+IA0KPiAtLWpzDQo+IA0KDQpUaGUgJ2djYyAtRSB1dGlsL3Fl
bXUtY29yb3V0aW5lLmMnIHNob3dzIHRoZSBleHBsaWNpdCBpbml0aWFsaXphdGlvbiBhcyANCnRo
aXM6DQoNCnZvaWQgcWVtdV9haW9fY29yb3V0aW5lX2VudGVyKEFpb0NvbnRleHQgKmN0eCwgQ29y
b3V0aW5lICpjbykNCnsNCiAgICAgc3RydWN0IHsgc3RydWN0IENvcm91dGluZSAqc3FoX2ZpcnN0
OyBzdHJ1Y3QgQ29yb3V0aW5lICoqc3FoX2xhc3Q7IA0KfSBwZW5kaW5nID0geyAoKHZvaWQgKikw
KSwgJihwZW5kaW5nKS5zcWhfZmlyc3QgfTsNCi4uLg0KDQpQbGVhc2Ugc2VuZCB0aGUgY29tbWFu
ZCB5b3UgcmFuIHRoZSBWYWxncmluZCB3aXRoIHRvIHNlZSB0aGUgb3B0aW9ucy4NCklmIHlvdSBj
YW4gcmVwcm9kdWNlIHRoZSBjYXNlIHJ1bm5pbmcgdGhlIFZhbGdyaW5kIHdpdGggdGhlIG9wdGlv
bnMgDQondHJhY2stb3JpZ2lucz15ZXMnIGFuZCAnLS1sb2ctZmlsZT1uYW1lLmxvZycsIHRoZSBy
ZXN1bHRpbmcgbG9nIGZpbGVzIA0Kd2lsbCBiZSBoZWxwZnVsLg0KDQpUaGFua3MsDQpBbmRyZXkN
Ci0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

