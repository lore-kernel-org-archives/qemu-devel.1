Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007D221781
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UDRY66uJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007D221781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaHz4-0001d2-NU
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaHue-0007mU-93
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaHuX-0003XN-C6
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:24:40 -0500
Received: from mail-eopbgr150110.outbound.protection.outlook.com
 ([40.107.15.110]:8836 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iaHuW-0003EU-EC; Thu, 28 Nov 2019 06:24:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V29p7Hee6RibXjPE/Gw68g7H2pJxuiYzj591hMzEEQSkxraXCA0hzbn65bibhzRVgsURgnfPC5o7fU1YfsMUt8+TmjlVDcP4TsxAdOqH9SlQzmDRSAPIRncn1ctzckYLHpx5EYK5zwA47CDu3WKH9vEmLiNqUZ7rIuUVxSlBH4UNKKQ3LcS6i68SZ2mK14BOpWE3CO0pvUNCzwhxoNdGQnGyi+oHqFRhFwEUirv7AmZVa6WyoR+A8OanmpTKz4zfxR3/GGvCUMaBrFVhJIIGe04DyGTdIiMwSme6mfn8e/P7dzG0sV2WqVnldazJ4o0WS1v2quXkQmM1ZnRBkm/JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E48IwC2VHwO35XlBZuJ6bHezxiA7uZndnzMi36Q7HiU=;
 b=NAekI/XkY/6qnZlReZBeBkqDjFC5DZJkdIzAzsR7cuwBPxJvxm8A0p3ilWQ4BpC3b+lPqL/An+Pp/LTNLZA41OCnfIxwfmqyHksYkkC/YAsC8cFFi07AJ3c6n2iG2nRWf59SJAHAePKjmS06Xvq4kcGDOHHs7Z0UqANfXWGaM8MWqGQ+L4TD4NoVYA52caP+ZIj37SItUUSghYvxnHlduwxFg/LGkCNWblkI5nO+m3hTG/Ko1bIMBSCnbeJl2aJBw/lKzjl2dT5Onaezw3nZiQrSpeASMe4s1Th4wi7oWsMAzFXV1fezPoK/qBl5JJNFsqch4ImZrbqA/zRP1mKLOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E48IwC2VHwO35XlBZuJ6bHezxiA7uZndnzMi36Q7HiU=;
 b=UDRY66uJAMBwclVIbzZBsSx5LdF44p9uDqcEpL5Pvug+Ca0w2ZPzsAArWAiG47vqrlYCLYv+LPATrrrP2i4BS/OOxxwC5PueaIcCRTXXc84AvywGYhcANFuC1BnRUv0VY2js1iiVHzKWzZdmUZu786in2Uh/IX0viDs0PtL9FPI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5125.eurprd08.prod.outlook.com (10.255.120.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 11:24:30 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 11:24:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 02/31] block: Add BdrvChildRole
Thread-Topic: [PATCH for-5.0 02/31] block: Add BdrvChildRole
Thread-Index: AQHVpSYN9F2/RBWt9UO3N3Nh8sSJa6eghTIA///kagCAAAjjgA==
Date: Thu, 28 Nov 2019 11:24:30 +0000
Message-ID: <7ca7fa9d-b464-7ff1-cb28-3ffb52efedb0@virtuozzo.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
 <20191127131624.1062403-3-mreitz@redhat.com>
 <9d6e35ea-eed6-716a-75aa-e8f47f35b6b7@virtuozzo.com>
 <02c29aee-6f92-0648-c60a-875a3d8ca305@redhat.com>
In-Reply-To: <02c29aee-6f92-0648-c60a-875a3d8ca305@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::29) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191128142429139
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dbb98e6-c714-4deb-b953-08d773f58956
x-ms-traffictypediagnostic: AM6PR08MB5125:
x-microsoft-antispam-prvs: <AM6PR08MB5125D2B819F6359219405FB4C1470@AM6PR08MB5125.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(39840400004)(346002)(366004)(189003)(199004)(31686004)(2906002)(186003)(229853002)(71190400001)(71200400001)(66446008)(66476007)(81156014)(8936002)(2501003)(81166006)(53546011)(64756008)(66556008)(7736002)(256004)(8676002)(386003)(6506007)(3846002)(6116002)(305945005)(6436002)(6246003)(66946007)(6486002)(99286004)(6512007)(2616005)(316002)(11346002)(446003)(4326008)(76176011)(52116002)(66066001)(5660300002)(26005)(25786009)(31696002)(86362001)(102836004)(110136005)(54906003)(36756003)(14454004)(478600001)(156123004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5125;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7pKBps4K1Zn/aLdNCw4MXQ6M6A7vmzWAmjPIWcfhFkJ2Tazw+dHsdZRe4HyKjE37mr0kSXIxv4IKK2kIyaCMK2LG3sfYgHRWM99uQKkdwcsX0csivh46GynMVReFwzs44LHDnEkVOZUfrvDmToAumrVRbvjRSVW+5aJQXaA4+S3OYaKsN+D3oqNC5fK0p094wEUMl8yruob13Gj6utHiSmzlKlWkEnSvXq+HRfUB4vluPct+waeeSqXrbGWlAl0QMfqBri3hOx6CaoFLPIV1pbEn+9wrrSbY/dquDW8mbYEPzUJZEiTThxVcfmTKo/gH7lii1ffJ0Xv8xpwCIvYi9dm9b2JtuvgrNVEfACstLTG4wbiBhye3OZS4bI5GUnDOk0RvM/KcyQEZAxinDtgciH+Chq3ZQttFYAVd1rPLkLJcRy+J2/+x0cMYFPWurVj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C31418F223F81E428087232A97398BE9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbb98e6-c714-4deb-b953-08d773f58956
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 11:24:30.6987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYfKENxVXeuCWk7aQs01+DTSSLBe99CWOzoRRa0zbnfAqf2sTpWUGf06M1gEyAniy78hejOrJ9WC1aJn3ZiHUanA61++SibCwrxVQQxUMto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5125
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.110
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTEuMjAxOSAxMzo1MiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOC4xMS4xOSAxMDozMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI3LjExLjIwMTkgMTY6MTUs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBUaGlzIGVudW0gd2lsbCBzdXBwbGVtZW50IEJkcnZDaGls
ZENsYXNzIHdoZW4gaXQgY29tZXMgdG8gd2hhdCByb2xlIChvcg0KPj4+IGNvbWJpbmF0aW9uIG9m
IHJvbGVzKSBhIGNoaWxkIHRha2VzIGZvciBpdHMgcGFyZW50Lg0KPj4+DQo+Pj4gQmVjYXVzZSBl
bXB0eSBlbnVtcyBhcmUgbm90IGFsbG93ZWQsIGxldCB1cyBqdXN0IHN0YXJ0IHdpdGggaXQgZmls
bGVkLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNv
bT4NCj4+PiAtLS0NCj4+PiAgICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmggfCAzOCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzOCBp
bnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9ibG9jay5o
IGIvaW5jbHVkZS9ibG9jay9ibG9jay5oDQo+Pj4gaW5kZXggMzg5NjNlZjIwMy4uMzY4MTdkNTY4
OSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgNCj4+PiArKysgYi9pbmNs
dWRlL2Jsb2NrL2Jsb2NrLmgNCj4+PiBAQCAtMjc5LDYgKzI3OSw0NCBAQCBlbnVtIHsNCj4+PiAg
ICAgICAgREVGQVVMVF9QRVJNX1VOQ0hBTkdFRCAgICAgID0gQkxLX1BFUk1fQUxMICYgfkRFRkFV
TFRfUEVSTV9QQVNTVEhST1VHSCwNCj4+PiAgICB9Ow0KPj4+ICAgIA0KPj4+ICt0eXBlZGVmIGVu
dW0gQmRydkNoaWxkUm9sZSB7DQo+Pg0KPj4gRG9uJ3QgeW91IHdhbnQgdG8gY2FsbCBpdCBqdXN0
IEJkcnZDaGlsZEZsYWdzID8NCj4+IEJlbmVmaXRzOg0KPj4NCj4+IDEuIERvIG5vdCBpbnRlcnNl
Y3Qgd2l0aCBvbGQgQmRydkNoaWxkUm9sZS4NCj4gDQo+IFdlbGwsIHRoYXQgZG9lc27igJl0IGNo
YW5nZSB0aGUgZmFjdCB0aGF0IHRoZSBvbGQgQmRydkNoaWxkUm9sZSBqdXN0DQo+IGRvZXNu4oCZ
dCBkZXNjcmliZSBhIHJvbGUuDQo+IA0KPj4gMi4gSSB0aGluaywgQkRSVl9DSElMRF9TVEFZX0FU
X05PREUgaXMgbm90IGEgcm9sZSwgYnV0IGp1c3QgYSBwcm9wZXJ0eSBvciBmbGFnLi4NCj4gDQo+
IEkgY2FuIGJlIGNvbnZpbmNlZCB0byBsZXQgU1RBWV9BVF9OT0RFIHN0YXkgYSBwcm9wZXJ0eSBv
Zg0KPiBCZHJ2Q2hpbGRDbGFzcy4gOi0pDQoNCm9yIEJkcnZDaGlsZCBpZiB3ZSB3YW50IGl0IHRv
IGJlIHByb3BlcnR5IG9mIG9iamVjdCwgbm90IGNsYXNzLg0KDQo+IA0KPiBXaGF0IEkgZG9u4oCZ
dCBsaWtlIGFib3V0IOKAnEJkcnZDaGlsZEZsYWdz4oCdIGlzIHRoYXQg4oCcZmxhZ3PigJ0gZG9l
c27igJl0IGV4cHJlc3MNCj4gYW55dGhpbmcuICBUaGUgcGVybWlzc2lvbnMgYXJlIGZsYWdzLCB0
b28uDQo+IA0KPiBNYXgNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

