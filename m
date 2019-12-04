Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C60CC3E8AE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9CA2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 07:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HllLvLvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9CA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icP3P-00083q-SK
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 02:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icOx4-0006ZD-GK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icOwP-0000c4-BQ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 02:19:20 -0500
Received: from mail-eopbgr40137.outbound.protection.outlook.com
 ([40.107.4.137]:14951 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icOwL-0000BX-HE; Wed, 04 Dec 2019 02:19:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3ex48Y7sNwi90MZfk7EXNBxZNs1Sbwj8wXQOD52rONEXLRiqqANwKhsP+iUoosA/jCbgFbSA1dbZYHM9m9HlOhHt5hwY2iQj7TdJjcFOwXukminL+272ad0M+KN1BpXyg76M5F4dUPDarCmuo7FRsIfv+12lDr4/gkj3+DglzTIxZH9GEplmubVj03veGFbxupuyjwiVKkRzqrfEejkaWpSJXkwO6WqQTIqQ6z4xRRuOAsiZOsIeG6HWcsGOz+BSVoLm80TiHbBfz7nUAatC+167WzTeJrKHFCPwcTuf8lClUJlDebv0n/H4vQCvp7QOP+jVAvy/VB7ZbVnxUjhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC67MNJZF/sC8PQpYXXgegf8Xo82aQpH8jnER1K84WI=;
 b=IkYon2INAAbbNKQtZ5dWjr2uE73rcz4Hc39GDfVtH0apLTFPl+KXeg6ZzTm9jps+IW5DIM+oNdfFh2cN/bOqOcA3eHSEyRDQz2PJdgnNunEg3PDNNqESj0Wj4/29WqKjHozNZZ5oWaLIgh4fW7oJ+chuxoBGk3GAOdqaojX8xZ4lLC1bw14vqaHwLNiEpk8Jc5Y7BME7dUFmfjem1Tr2/JY+s0RXolMuQH87ogVoicAFHmo3OvmVzwaxrPFDRkwvTfAwyt2FXZtKGB5D9SO7MCAgz17V9K3sH74ZBJBXw0crJPiwvGHLqvlgzR8D2GLAM1kKhXgQs5QaP5kNSss7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC67MNJZF/sC8PQpYXXgegf8Xo82aQpH8jnER1K84WI=;
 b=HllLvLvDT1pgL0Dpj0DMN1fFhzy4et/l6bzut8ZWyvx2BQ225BHswkfI0qFypoa1IyjyyBbkLAKSEW+InGHp3x9aTaTbLTm3pzRX4ZreVy/Ty1J0lt5enD4gV8MOWE8bIhS3cbncZWn7FBzJvhuZC68DFWsafsx1MStttRT/5LM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4021.eurprd08.prod.outlook.com (20.179.2.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 07:19:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 07:19:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: pannengyuan <pannengyuan@huawei.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>
Subject: Re: [PATCH V3 1/2] block/nbd: extract the common cleanup code
Thread-Topic: [PATCH V3 1/2] block/nbd: extract the common cleanup code
Thread-Index: AQHVpofDlqkXDK02dkqUyLcdRPJzHaeos+WAgACgUYCAAETrgA==
Date: Wed, 4 Dec 2019 07:19:01 +0000
Message-ID: <08870274-7a29-26ec-e057-b796d11eac4d@virtuozzo.com>
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
 <77f53371-aa58-849a-b0e4-2d6b4e4557d4@virtuozzo.com>
 <7d06d51d-12a5-03e1-d695-8f4faf754bec@huawei.com>
In-Reply-To: <7d06d51d-12a5-03e1-d695-8f4faf754bec@huawei.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191204101859016
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1c90e0c-a2e7-4a98-2905-08d7788a3ccb
x-ms-traffictypediagnostic: AM6PR08MB4021:
x-microsoft-antispam-prvs: <AM6PR08MB40219730AD4926C683BFD6E1C15D0@AM6PR08MB4021.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(136003)(366004)(396003)(199004)(189003)(8936002)(81166006)(6246003)(6436002)(14454004)(478600001)(8676002)(81156014)(6512007)(229853002)(6306002)(31686004)(6486002)(966005)(4326008)(2501003)(71200400001)(71190400001)(316002)(14444005)(110136005)(31696002)(86362001)(2201001)(256004)(25786009)(54906003)(52116002)(76176011)(99286004)(7736002)(5660300002)(2616005)(11346002)(66556008)(64756008)(66446008)(6116002)(66476007)(3846002)(446003)(305945005)(386003)(6506007)(53546011)(102836004)(186003)(26005)(66946007)(7416002)(2906002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4021;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50WygV37K0U7hjrCzl8VmEphsL6sKz0MNe19sokLFPiwt9Uw2v2Gegov5gukr6oHBaLiRDoUlr5Hq6FTv24fXyVtvxAOpwDFMeOADC/htWiML6T/AxZ1OhdxBWX5WsL7iDQPF/CNF/qND0SGU/+aNVCoHB5fhN577z55tUffgsnNUa0R57dW69Bpk/Gif0OOOGwy+zH1XFlqn6MeV30Khd31FcpMsOti4JI8O9seXhBxBrNQLPM8zExNQgMHgkZDhEJUfsz0piGiKS3rKGkehraPv7ILQ9m7BPYH8RRHC8HhxcJ9gL4paAmiwB+fJAKJbq/bzEpED20hBnX2UMdhAe5fLUebFBK+5gWycQ6B3T+tP9fruDb1cP3OYpzLQs2WXmlq4BKSiDj93fzuyGng+QKfNmGNjh4sgV+/ersDaLeqAgF3amoxgBnNIiuuKQPD6w9HfxWWQjII4sqIWvYhYQ850E7kX0J5HtKp1k/CQfg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC48F3ABBA354A428A0C0E8C5EFC92F3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c90e0c-a2e7-4a98-2905-08d7788a3ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 07:19:01.8890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kn4zlBiGEO1zY/pyNIRwUUlezTvAOY4Dr8f0kVHBBWthNiP5TcVliaCnNUKtLrq/KNjfAJ03AhRB0bgme/vet8VjEuOBisRi/gE0tCNteo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4021
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.137
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
Cc: "liyiting@huawei.com" <liyiting@huawei.com>,
 "kuhn.chenqun@huawei.com" <kuhn.chenqun@huawei.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTIuMjAxOSA2OjEyLCBwYW5uZW5neXVhbiB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDE5LzEy
LzQgMTozOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIQ0KPj4N
Cj4+IEZpcnN0LCBwbGVhc2UsIHdoZW4gc2VuZGluZyBtb3JlIHRoYW4gb25lIHBhdGNoLCBjcmVh
dGUgYSBjb3Zlci1sZXR0ZXIuIEFsc28sDQo+PiBzdW1tYXJpemUgKGluIGNvdmVyIGxldHRlcikg
d2hhdCB3YXMgY2hhbmdlZCBzaW5jZSBwcmV2aW91cyB2ZXJzaW9uLg0KPiBJbiBwcmV2aW91cyB2
ZXJzaW9uLCBJIG9ubHkgc2VuZCBvbmUgcGF0Y2goMi8yIGluIHRoaXMgdmVyc2lvbiksIHNvIEkN
Cj4gb25seSBhZGQgYSBjaGFuZ2Ugc3VtbWFyaXplIGluIDIvMiBwYXRjaCBpbiB0aGlzIHZlcnNp
b24uIHNob3VsZCBJIGFkZCBhDQo+IHN1bW1hcml6ZSBpbiAxLzIgcGF0Y2ggdG9vIGlmIDEvMiBw
YXRjaCBpcyBhIG5ldyBvbmU/DQoNClllcywgc29tZXRoaW5nIHNpbXBsZSBsaWtlOg0KDQowMTog
bmV3IHBhdGNoDQowMjogcmViYXNlZCBvbiAwMQ0KDQooYWxzbywgSWYgeW91IGRpZG4ndCByZWFk
IGh0dHBzOi8vd2lraS5xZW11Lm9yZy9Db250cmlidXRlL1N1Ym1pdEFQYXRjaCwgZG8gaXQpDQoN
Cj4gDQo+Pg0KPj4gMjkuMTEuMjAxOSAxMDoyNSwgcGFubmVuZ3l1YW5AaHVhd2VpLmNvbSB3cm90
ZToNCj4+PiBGcm9tOiBQYW5OZW5neXVhbiA8cGFubmVuZ3l1YW5AaHVhd2VpLmNvbT4NCj4+DQo+
PiBTdHJhbmdlIGxpbmUuIENoZWNrIHlvdSBnaXQgcHJlZmVyZW5jZXMuIFN1Y2ggbGluZSBhcHBl
YXJzIChhbmQgbWFrZSBzZW5zZSkNCj4+IHdoZW4geW91IGFyZSBzZW5kaW5nIHBhdGNoZXMgYXV0
aG9yZWQgYnkgc29tZW9uZSBlbHNlLi4gQnV0IGhlcmUgaXMgeW91ciBuYW1lLA0KPj4gdGhlIHNh
bWUgYXMgaW4gZW1haWwncyBGcm9tOi4NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZW1pbmRpbmcu
IEkgd2lsbCBjb3JyZWN0IGl0IGluIG5leHQgdmVyc2lvbi4NCj4gDQo+Pg0KPj4+DQo+Pj4gVGhl
IEJEUlZOQkRTdGF0ZSBjbGVhbnVwIGNvZGUgaXMgY29tbW9uIGluIHR3byBwbGFjZXMsIGFkZA0K
Pj4+IG5iZF9mcmVlX2JkcnZzdGF0ZV9wcm9wKCkgZnVuY3Rpb24gdG8gZG8gdGhlc2UgY2xlYW51
cHMgKHN1Z2dlc3RlZCBieQ0KPj4+IFN0ZWZhbm8gR2FyemFyZWxsYSkuDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBQYW5OZW5neXVhbiA8cGFubmVuZ3l1YW5AaHVhd2VpLmNvbT4NCj4+DQo+PiBS
ZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0
dW96em8uY29tPg0KPj4NCj4+PiAtLS0NCj4+PiAgICBibG9jay9uYmQuYyB8IDIzICsrKysrKysr
KysrKystLS0tLS0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyks
IDEwIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrL25iZC5jIGIvYmxv
Y2svbmJkLmMNCj4+PiBpbmRleCAxMjM5NzYxLi41ODA1OTc5IDEwMDY0NA0KPj4+IC0tLSBhL2Js
b2NrL25iZC5jDQo+Pj4gKysrIGIvYmxvY2svbmJkLmMNCj4+PiBAQCAtOTQsNiArOTQsOCBAQCB0
eXBlZGVmIHN0cnVjdCBCRFJWTkJEU3RhdGUgew0KPj4+ICAgIA0KPj4+ICAgIHN0YXRpYyBpbnQg
bmJkX2NsaWVudF9jb25uZWN0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBFcnJvciAqKmVycnApOw0K
Pj4+ICAgIA0KPj4+ICtzdGF0aWMgdm9pZCBuYmRfZnJlZV9iZHJ2c3RhdGVfcHJvcChCRFJWTkJE
U3RhdGUgKnMpOw0KPj4+ICsNCj4+PiAgICBzdGF0aWMgdm9pZCBuYmRfY2hhbm5lbF9lcnJvcihC
RFJWTkJEU3RhdGUgKnMsIGludCByZXQpDQo+Pj4gICAgew0KPj4+ICAgICAgICBpZiAocmV0ID09
IC1FSU8pIHsNCj4+PiBAQCAtMTQ4Niw2ICsxNDg4LDE1IEBAIHN0YXRpYyBpbnQgbmJkX2NsaWVu
dF9jb25uZWN0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBFcnJvciAqKmVycnApDQo+Pj4gICAgICAg
IH0NCj4+PiAgICB9DQo+Pj4gICAgDQo+Pj4gK3N0YXRpYyB2b2lkIG5iZF9mcmVlX2JkcnZzdGF0
ZV9wcm9wKEJEUlZOQkRTdGF0ZSAqcykNCj4+PiArew0KPj4+ICsgICAgb2JqZWN0X3VucmVmKE9C
SkVDVChzLT50bHNjcmVkcykpOw0KPj4+ICsgICAgcWFwaV9mcmVlX1NvY2tldEFkZHJlc3Mocy0+
c2FkZHIpOw0KPj4+ICsgICAgZ19mcmVlKHMtPmV4cG9ydCk7DQo+Pj4gKyAgICBnX2ZyZWUocy0+
dGxzY3JlZHNpZCk7DQo+Pj4gKyAgICBnX2ZyZWUocy0+eF9kaXJ0eV9iaXRtYXApOw0KPj4+ICt9
DQo+Pj4gKw0KPj4+ICAgIC8qDQo+Pj4gICAgICogUGFyc2UgbmJkX29wZW4gb3B0aW9ucw0KPj4+
ICAgICAqLw0KPj4+IEBAIC0xODU1LDEwICsxODY2LDcgQEAgc3RhdGljIGludCBuYmRfcHJvY2Vz
c19vcHRpb25zKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRGljdCAqb3B0aW9ucywNCj4+PiAgICAN
Cj4+PiAgICAgZXJyb3I6DQo+Pj4gICAgICAgIGlmIChyZXQgPCAwKSB7DQo+Pj4gLSAgICAgICAg
b2JqZWN0X3VucmVmKE9CSkVDVChzLT50bHNjcmVkcykpOw0KPj4+IC0gICAgICAgIHFhcGlfZnJl
ZV9Tb2NrZXRBZGRyZXNzKHMtPnNhZGRyKTsNCj4+PiAtICAgICAgICBnX2ZyZWUocy0+ZXhwb3J0
KTsNCj4+PiAtICAgICAgICBnX2ZyZWUocy0+dGxzY3JlZHNpZCk7DQo+Pj4gKyAgICAgICAgbmJk
X2ZyZWVfYmRydnN0YXRlX3Byb3Aocyk7DQo+Pj4gICAgICAgIH0NCj4+PiAgICAgICAgcWVtdV9v
cHRzX2RlbChvcHRzKTsNCj4+PiAgICAgICAgcmV0dXJuIHJldDsNCj4+PiBAQCAtMTkzNywxMiAr
MTk0NSw3IEBAIHN0YXRpYyB2b2lkIG5iZF9jbG9zZShCbG9ja0RyaXZlclN0YXRlICpicykNCj4+
PiAgICAgICAgQkRSVk5CRFN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4+PiAgICANCj4+PiAgICAg
ICAgbmJkX2NsaWVudF9jbG9zZShicyk7DQo+Pj4gLQ0KPj4+IC0gICAgb2JqZWN0X3VucmVmKE9C
SkVDVChzLT50bHNjcmVkcykpOw0KPj4+IC0gICAgcWFwaV9mcmVlX1NvY2tldEFkZHJlc3Mocy0+
c2FkZHIpOw0KPj4+IC0gICAgZ19mcmVlKHMtPmV4cG9ydCk7DQo+Pj4gLSAgICBnX2ZyZWUocy0+
dGxzY3JlZHNpZCk7DQo+Pj4gLSAgICBnX2ZyZWUocy0+eF9kaXJ0eV9iaXRtYXApOw0KPj4+ICsg
ICAgbmJkX2ZyZWVfYmRydnN0YXRlX3Byb3Aocyk7DQo+Pj4gICAgfQ0KPj4+ICAgIA0KPj4+ICAg
IHN0YXRpYyBpbnQ2NF90IG5iZF9nZXRsZW5ndGgoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4N
Cj4+DQo+Pg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

