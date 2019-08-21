Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D73C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E501F22CF4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NDzHq9UD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E501F22CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Oy8-0001ps-3P
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0OfK-0004Lz-SU
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1i0ORL-0007N4-RI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:06:09 -0400
Received: from mail-ve1eur02on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::720]:19214
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1i0ORK-0007I3-6H; Wed, 21 Aug 2019 07:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNJrF/c5OWq4l1lQTxJ94Lrh3JQzrvTAhuCxzYDsmOE6dwZsBroeDve8tyrudSVNkRe2vFlSiMEZ81XNElg1x9WjTlcr9+zdDoae2ySjzegl8LyFimamabpet5emwk3QshKYUmhMSympgB1ejU9dthkhgPQ9a37qUoJrPSwp/IBazKz77S9VoHzAjChdZatqfD/goBsG3HWzdHsFYJJ7HUBLgfjHT7wKx10g/HIg7kl5Lg0XErCyAOT8496szzB4oOAXi9Zm466QCkYiAd0EC9W7i8vud82WRclPmdWcP9ni9GhCxDmBFzUP2kwUUGBPCPzlmh4tWT/jv2LJf9MGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEhM3O9yXNoS7yHpS31XVOKhxskLV2lkqCo8YUQzHAU=;
 b=dkl0H6pgc1nu/Ab9FT5lf9h6Fyz2xAsmGmaUoQSxvbHawQCxN7I3s0uLuNma/y2EymErY/2uzhUBAUwKDbZmRD44VTZNT6r2txXcc4eHNnVKCzJYM1HXCw7Q6VO8uk6VCXx58c9MFslJmD13ojRFSRWrDsWI5Maz+0YHsPkdBDGZpjvu0/ZzrS173YF3Vepf6ReeVbSfGPPB7EVICq9Yjx2lW/qjsAjSPpNa3Vhq5x4oLbkUiaypGt0a+3l1gBqiEksQHbvr05xfsL//bJGDFhy8oMIPhlfnyQUfdQmGO9Ox1cuehiz9KKu6xISP/fMOXequhkqZjIspcQojgQu/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEhM3O9yXNoS7yHpS31XVOKhxskLV2lkqCo8YUQzHAU=;
 b=NDzHq9UDdcB1g0fAvJjWtkDTxq5KuwldbIgdN/qdrzvqViyx8Pqpeqmxo9nl25ZaZCpLx/gHTEg7pyASlM+uc6JM2Bb4HqwG/2KbEw2CwSkJO+RWEsCojru3K51Kxne9tV1PCza8lcP9RmpR0tieDuMQmL+QXHYCstExJkijKpw=
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) by
 AM6PR08MB3669.eurprd08.prod.outlook.com (20.177.116.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 11:06:03 +0000
Received: from AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42]) by AM6PR08MB5208.eurprd08.prod.outlook.com
 ([fe80::5820:8ce:9eb2:cc42%3]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 11:06:03 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 4/9] ide: account UNMAP (TRIM) operations
Thread-Index: AQHVC/RVV9UunhmXdkKYvAxq2Fsk0Kb4XDGAgA2sugA=
Date: Wed, 21 Aug 2019 11:06:02 +0000
Message-ID: <ad8b4780-c385-27bf-d087-9a840df1e5de@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
 <20190516143314.81302-5-anton.nefedov@virtuozzo.com>
 <b992ab09-af44-1be7-aab3-18ff1267f853@redhat.com>
In-Reply-To: <b992ab09-af44-1be7-aab3-18ff1267f853@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:7:15::34) To AM6PR08MB5208.eurprd08.prod.outlook.com
 (2603:10a6:20b:eb::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0002e30d-c849-4377-1003-08d726278e09
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB3669; 
x-ms-traffictypediagnostic: AM6PR08MB3669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB36697D2AC8B85F80A358A978F8AA0@AM6PR08MB3669.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(39850400004)(376002)(136003)(189003)(199004)(6512007)(7736002)(2616005)(66446008)(256004)(14444005)(86362001)(102836004)(25786009)(53936002)(31696002)(11346002)(110136005)(54906003)(2501003)(81156014)(4326008)(229853002)(81166006)(26005)(8936002)(6486002)(186003)(71190400001)(71200400001)(476003)(386003)(8676002)(107886003)(446003)(36756003)(305945005)(6246003)(6436002)(6506007)(53546011)(76176011)(6116002)(3846002)(52116002)(5660300002)(2906002)(44832011)(31686004)(14454004)(64756008)(486006)(99286004)(316002)(66066001)(15650500001)(66946007)(478600001)(66476007)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3669;
 H:AM6PR08MB5208.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0rOUKoYkGCprRMuEzWfcTAJkjph/d3nY3dhRRlJZEv87Rv1wNU6L99GqDzzX5q5Mb0A1DQHpUn9HoivuzhhdOz4JNjVCiXYLf1+gF6LDBOXZdmplyUErG+w4flIRS4leoxQ6TmeLIQGe6FyZ2of9MKHnDdcDnjaJA4jK8rWg5UfsbYF0GdBuC/O7/W+NIEIEv5wEfjMfB5T8G+x18smbVlgGOrWVwytnrWuvRRaSTUVNFnny/HRtFOYlv/GNrgZe2AKVu4qjgqwV561xEpt7f9F+LYeItw8xW7fks7KBj0qX4MB2tCcmXZJrbt9EjvTHnsOEq1bGClhzOeEu80WGi/YSvA81JHPmWRkyz7qMo/lNBQPsuqq3tAvH9s8EaHDsQZ07wogUlfpihSCiyL1QhoWa3E+B1CgkQeEaE7MraQM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6219AB0E5F4D0B43B64A381B913A58ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0002e30d-c849-4377-1003-08d726278e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 11:06:02.9430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1T/TG1/EqvbJCdACQRTAooTFVK2/vozwpT1yXSoR6esDI/qz4PrtKUvRVzlgeNwRtDm1Av7xmOSx0DH1XSf3iNSlDg95yEBhxpZvDxSlno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3669
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::720
Subject: Re: [Qemu-devel] [PATCH v8 4/9] ide: account UNMAP (TRIM) operations
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTIvOC8yMDE5IDk6MTYgUE0sIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMTYuMDUuMTkgMTY6
MzMsIEFudG9uIE5lZmVkb3Ygd3JvdGU6DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBOZWZlZG92
IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQo+PiBSZXZpZXdlZC1ieTogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+
PiAgIGh3L2lkZS9jb3JlLmMgfCAxMiArKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaWRlL2NvcmUuYyBiL2h3
L2lkZS9jb3JlLmMNCj4+IGluZGV4IDZhZmFkZjg5NGYuLjNhN2FjOTM3NzcgMTAwNjQ0DQo+PiAt
LS0gYS9ody9pZGUvY29yZS5jDQo+PiArKysgYi9ody9pZGUvY29yZS5jDQo+PiBAQCAtNDQxLDYg
KzQ0MSwxNCBAQCBzdGF0aWMgdm9pZCBpZGVfaXNzdWVfdHJpbV9jYih2b2lkICpvcGFxdWUsIGlu
dCByZXQpDQo+PiAgICAgICBUcmltQUlPQ0IgKmlvY2IgPSBvcGFxdWU7DQo+PiAgICAgICBJREVT
dGF0ZSAqcyA9IGlvY2ItPnM7DQo+PiAgIA0KPj4gKyAgICBpZiAoaW9jYi0+aSA+PSAwKSB7DQo+
PiArICAgICAgICBpZiAocmV0ID49IDApIHsNCj4+ICsgICAgICAgICAgICBibG9ja19hY2N0X2Rv
bmUoYmxrX2dldF9zdGF0cyhzLT5ibGspLCAmcy0+YWNjdCk7DQo+PiArICAgICAgICB9IGVsc2Ug
ew0KPj4gKyAgICAgICAgICAgIGJsb2NrX2FjY3RfZmFpbGVkKGJsa19nZXRfc3RhdHMocy0+Ymxr
KSwgJnMtPmFjY3QpOw0KPiANCj4gSG1tLCBpbiBvdGhlciBwbGFjZXMgKGlkZV9oYW5kbGVfcndf
ZXJyb3IoKSBoZXJlIG9yDQo+IHNjc2lfaGFuZGxlX3J3X2Vycm9yKCkgaW4gc2NzaS1kaXNrKSBv
bmx5IHJlcG9ydCB0aGlzIHdpdGgNCj4gQkxPQ0tfRVJST1JfQUNUSU9OX1JFUE9SVC4NCj4gDQo+
IFNvIEnigJltIHdvbmRlcmluZyB3aGV0aGVyIHRoZSBzYW1lIHNob3VsZCBiZSBkb25lIGhlcmUu
DQo+IA0KDQpNYW55IG90aGVyIHBsYWNlcyBkbyBub3QgY2hlY2sgdGhlIGFjdGlvbjoNCnNjc2lf
e2RtYXxyZWFkfHdyaXRlfV9jb21wbGV0ZSgpLCBody9pZGUvYXRhcGkuYyBjYWxscw0KDQpUaGF0
IGZlZWxzIHNvbWV3aGF0IHdlaXJkIHRvIG1lLCB0byBhY2NvdW50IHRoZSBvcGVyYXRpb24gY29t
cGxldGUgd2hlbg0KaXQncyBub3QuDQooQnV0IEkgZG9uJ3QgcmVhbGx5IGtub3cgdGhlIHVzZSBj
YXNlcyBvZiBCTE9DS19FUlJPUl9BQ1RJT05fSUdOT1JFKS4NCg0KQ2FuIGl0IGJlIHRoYXQgdGhl
IGVycm9yIGFjdGlvbiBpcyBvbmx5IGNoZWNrZWQgc28gdGhhdCB0aGUgb3BlcmF0aW9uIGlzDQpu
b3QgYWNjb3VudGVkIHR3aWNlIChhcyB0aGVyZSBtaWdodCBiZSBibG9ja19hY2N0X2RvbmUoKSBs
YXRlciBpbiB0aGUNCmNvbW1vbiBwYXRoIHdpdGggQUNUSU9OX0lHTk9SRSkNCg0KL0FudG9uDQo=

