Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C953C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC652067B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f6NwOQE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC652067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxqY-0006Cv-9M
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAxhB-0004tz-3q
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAxRw-0001up-OD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:30:26 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:24143 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAxRp-0001nV-NV; Thu, 19 Sep 2019 10:30:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjKgl7Wu3eAEsnYgo7I1uNip5awyVqY6nojV7VHfBSRcTWzKI+VoslOhJIaNsMfbjESBn6mkzwmXDrF1rBoviNRL+rHdKwOdcSOPyxLHGb+FduAMQD/4qcAi/RJHfmLYRbRWO5zCLSQx2se+863DgPiU7UVHSiP98HuyEvhLv7R6PctYW6EcEyw0lJfIKrn9VkD8rRChA3vyQKTeT0B0Oi/nFBUDG4Jp1IQ4SIEkAVEuLx1O/2RMpkksR0FSXFCHS8yMum+P5tcKxISqkIO9BLqMTwTYhvgOrpIngD1mCtOFQ1SonmnHp57YEEELqK9Z2F1d9Lu5/l5Bt4yyIEQVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqAXIk+W6OwXHIHgJ4p8Y3G1hJVHkn7Zd2yhoQg2mXA=;
 b=HYsZKk+EUeslj2DmVefphIo4IR+mBwbLIax92G7Y0+xj9MbO/6WC745Vc0zsfwz3ZNdPfDXJ0ZXQJnp+pMbzWaM+tsOj+Jp9IP1oRPlX1HqwLZZIYBfprQ00J4o5xzsClrS4/pbDOGDk7CB/GyyzU36tBgRavYizI8DAQA1f9o9+k/sCYmzaBM6yxSQzAV8sGvS09E2owVEjQ3m/yFEght7K0Z8afDfLMN0NyWPfc3xpnB3Uz+Ihj/sygbkLp3wmKdQZ+7P22mZ8g9aTEFcpUCKBSeM3oA2cFxakiDzGEDn4q7iewY3Rv2h1p/r5Enll2RCQJvlOwYOzmm98HJDmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqAXIk+W6OwXHIHgJ4p8Y3G1hJVHkn7Zd2yhoQg2mXA=;
 b=f6NwOQE+l2bLWrFWC2exJOfOBy3E/JPjTpMVt3DxSghk4CAcQLioVaIVSAsYZ8fMuu4jEOpufKBl5pznK86krb7/wxT1ltXqdl/WJxFokemA7Q8hcWWMq/X/58iRDdXP9kmxoiPFFUz306pCCIOrm8EtstvJgy0nFhWN5WWV9yE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5466.eurprd08.prod.outlook.com (52.133.242.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 14:30:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 14:30:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC] error: auto propagated local_err
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAEmpAIAACO4AgAAE0QA=
Date: Thu, 19 Sep 2019 14:30:14 +0000
Message-ID: <696673be-95c8-3f75-551c-26fccd230eb1@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
 <35c972e1-bdb5-cbcb-ed45-6a51f19af98c@virtuozzo.com>
In-Reply-To: <35c972e1-bdb5-cbcb-ed45-6a51f19af98c@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::43)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919173010801
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dbedbd6-edf5-47b5-ecb4-08d73d0de2f1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5466; 
x-ms-traffictypediagnostic: DB8PR08MB5466:
x-microsoft-antispam-prvs: <DB8PR08MB54664BD0CC56FDEA69BA030DC1890@DB8PR08MB5466.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(51444003)(54906003)(110136005)(66476007)(66556008)(64756008)(6246003)(66946007)(66446008)(66066001)(6436002)(6486002)(14454004)(6512007)(316002)(4326008)(478600001)(229853002)(2906002)(305945005)(31696002)(7736002)(3846002)(6116002)(7416002)(36756003)(186003)(53546011)(102836004)(386003)(99286004)(52116002)(6506007)(76176011)(31686004)(25786009)(2616005)(11346002)(486006)(446003)(8676002)(81156014)(81166006)(476003)(7406005)(86362001)(8936002)(26005)(71190400001)(5660300002)(71200400001)(14444005)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5466;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b6CCQyUx1msndmnOYp/kwtyWgAm53Eb5kFWmhoSsJk+wQASiTGAaol8H7//5U3IktADdhFX6RlMQ9lo7gkY2vhgvuxqmWgfBdIcx5HG1Ugjd0U5KXulIYvVpX/81jzfVtPFr0UEN5LgBYCykrWg+gNQrjyqN88s9FOBnCK7rer/jHtDgdWf9mnVBVAavLUD8NADUsl/X09CLzvtw2JEwO5Bf1mqjmokF3gZg/H1G+PAY/+WuiwQjju+VY7h7MjJXa1zXvnm6xTpiZzIVROkGV5PA5FDnqGaDZ1VlveDA2K96zllKHIn4bEE2wQhG7uQD0ePr/2PDQ0nYGzmTf98PCGcJcIxDJdHWIZbYQtU+kAYcgWwgdbBDRdy05BD5Krtv5BJhYtheka5ZXwbppV0TNxhAIDnj4y/+Ep/hofwDzhM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B49D2693E9EEC34A8B055D5220893631@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbedbd6-edf5-47b5-ecb4-08d73d0de2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 14:30:14.8890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zk+YFpEqrnjJz+IzUhOscPjtMZZPDwNyGt7eb6Sst61DTvEJN4Mj4uBD+ns48vOoL/WIQq+m8KLwnFdMK9nF8i7uDflKYR7of6gRgG2s6ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5466
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.111
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
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxNzoxMiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTkuMDkuMjAxOSAxNjo0MCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDkvMTkvMTkgNDoxNyBB
TSwgS2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAxOC4wOS4yMDE5IHVtIDE5OjEwIGhhdCBFcmlj
IEJsYWtlIGdlc2NocmllYmVuOg0KPj4+PiBPbiA5LzE4LzE5IDg6MDIgQU0sIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+PiArICovDQo+Pj4+PiArI2RlZmluZSBNQUtF
X0VSUlBfU0FGRShlcnJwKSBcDQo+Pj4+PiArZ19hdXRvKEVycm9yUHJvcGFnYXRpb25TdHJ1Y3Qp
IChfX2F1dG9fZXJycF9wcm9wKSA9IHsuZXJycCA9IChlcnJwKX07IFwNCj4+Pj4+ICtpZiAoKGVy
cnApID09IE5VTEwgfHwgKihlcnJwKSA9PSBlcnJvcl9hYm9ydCB8fCAqKGVycnApID09IGVycm9y
X2ZhdGFsKSB7IFwNCj4+Pj4+ICvCoMKgwqAgKGVycnApID0gJl9fYXV0b19lcnJwX3Byb3AubG9j
YWxfZXJyOyBcDQo+Pj4+PiArfQ0KPj4+Pg0KPj4+PiBOb3Qgd3JpdHRlbiB0byB0YWtlIGEgdHJh
aWxpbmcgc2VtaWNvbG9uIGluIHRoZSBjYWxsZXIuDQo+Pj4+DQo+Pj4+IFlvdSBjb3VsZCBldmVu
IHNldCBfX2F1dG9fZXJycF9wcm9wIHVuY29uZGl0aW9uYWxseSByYXRoZXIgdGhhbiB0cnlpbmcN
Cj4+Pj4gdG8gcmV1c2UgaW5jb21pbmcgZXJycCAodGhlIGRpZmZlcmVuY2UgYmVpbmcgdGhhdCBl
cnJvcl9wcm9wYWdhdGUoKSBnZXRzDQo+Pj4+IGNhbGxlZCBtb3JlIGZyZXF1ZW50bHkpLg0KPj4+
DQo+Pj4gSSB0aGluayB0aGlzIGRpZmZlcmVuY2UgaXMgYWN0dWFsbHkgYSBwcm9ibGVtLg0KPj4+
DQo+Pj4gV2hlbiBkZWJ1Z2dpbmcgdGhpbmdzLCBJIGhhdGUgZXJyb3JfcHJvcGFnYXRlKCkuIEl0
IG1lYW5zIHRoYXQgdGhlIEVycm9yDQo+Pj4gKHNwZWNpZmljYWxseSBpdHMgZmllbGRzIHNyYy9m
dW5jL2xpbmUpIHBvaW50cyB0byB0aGUgb3V0ZXJtb3N0DQo+Pj4gZXJyb3JfcHJvcGFnYXRlKCkg
cmF0aGVyIHRoYW4gdGhlIHBsYWNlIHdoZXJlIHRoZSBlcnJvciByZWFsbHkgaGFwcGVuZWQuDQo+
Pj4gSXQgYWxzbyBtYWtlcyBlcnJvcl9hYm9ydCBjb21wbGV0ZWx5IHVzZWxlc3MgYmVjYXVzZSBh
dCB0aGUgcG9pbnQgd2hlcmUNCj4+PiB0aGUgcHJvY2VzcyBnZXRzIGFib3J0ZWQsIHRoZSBpbnRl
cmVzdGluZyBpbmZvcm1hdGlvbiBpcyBhbHJlYWR5IGxvc3QuDQo+Pg0KPj4gT2theSwgYmFzZWQg
b24gdGhhdCwgSSBzZWUgdGhlIGZvbGxvd2luZyBkZXNpcmFibGUgc2VtYW50aWNzOg0KPj4NCj4+
IENhbGxlcjogb25lIG9mIDQgY2FsbGluZyBwYXJhZGlnbXM6DQo+Pg0KPj4gcGFzcyBlcnJwPU5V
TEwgKHdlIGRvbid0IGNhcmUgYWJvdXQgZmFpbHVyZXMpDQo+PiBwYXNzIGVycnA9JmVycm9yX2Fi
b3J0ICh3ZSB3YW50IHRvIGFib3J0KCkgYXMgc29vbiBhcyBwb3NzaWJsZSBhcyBjbG9zZQ0KPj4g
dG8gdGhlIHJlYWwgcHJvYmxlbSBhcyBwb3NzaWJsZSkNCj4+IHBhc3MgZXJycD0mZXJyb3JfZmF0
YWwgKHdlIHdhbnQgdG8gZXhpdCgpLCBidXQgb25seSBhZnRlciBjb2xsZWN0aW5nIGFzDQo+PiBt
dWNoIGluZm9ybWF0aW9uIGFzIHBvc3NpYmxlKQ0KPj4gcGFzcyBlcnJwID0gYW55dGhpbmcgZWxz
ZSAod2UgYXJlIGNvbGxlY3RpbmcgYW4gZXJyb3IgZm9yIG90aGVyIHJlYXNvbnMsDQo+PiB3ZSBt
YXkgcmVwb3J0IGl0IG9yIGxldCB0aGUgY2FsbGVyIGRlY2lkZSBvciAuLi4pDQo+Pg0KPj4gQ2Fs
bGVlOiB3ZSB3YW50IGEgU0lOR0xFIHBhcmFkaWdtOg0KPj4NCj4+IGZ1bmMgKEVycm9yICoqZXJy
cCkNCj4+IHsNCj4+IMKgwqDCoMKgIE1BS0VfRVJSUF9TQUZFKCk7DQo+Pg0KPj4gwqDCoMKgwqAg
bm93IHdlIGNhbiBwYXNzIGVycnAgdG8gYW55IGNoaWxkIGZ1bmN0aW9uLCB0ZXN0ICcqZXJycCcs
IG9yIGRvDQo+PiBhbnl0aGluZyBlbHNlLCBhbmQgd2UgRE9OJ1QgaGF2ZSB0byBjYWxsIGVycm9y
X3Byb3BhZ2F0ZS4NCj4+DQo+PiBJIHRoaW5rIHRoYXQgbWVhbnMgd2UgbmVlZDoNCj4+DQo+PiAj
ZGVmaW5lIE1BS0VfRVJSUF9TQUZFKCkgXA0KPj4gwqDCoCBnX2F1dG8oLi4uKSBfX2F1dG9fZXJy
cCA9IHsgLmVycnAgPSBlcnJwIH07IFwNCj4+IMKgwqAgZG8geyBcDQo+PiDCoMKgwqDCoCBpZiAo
IWVycnAgfHwgZXJycCA9PSAmZXJyb3JfZmF0YWwpIHsgZXJycCA9ICZfX2F1dG9fZXJycC5sb2Nh
bDsgfSBcDQo+PiDCoMKgIH0gd2hpbGUgKDApDQo+Pg0KPj4gU28gYmFjayB0byB0aGUgY2FsbGVy
IHNlbWFudGljczoNCj4+DQo+PiBpZiB0aGUgY2FsbGVyIHBhc3NlZCBOVUxMLCB3ZSd2ZSByZWRp
cmVjdGVkIGVycnAgbG9jYWxseSBzbyB0aGF0IHdlIGNhbg0KPj4gdXNlICplcnJwIGF0IHdpbGw7
IHRoZSBhdXRvLWNsZWFudXAgd2lsbCBmcmVlIG91ciBsb2NhbCBlcnJvci4NCj4+DQo+PiBpZiB0
aGUgY2FsbGVyIHBhc3NlZCAmZXJyb3JfYWJvcnQsIHdlIGtlZXAgZXJycCB1bmNoYW5nZWQuwqAg
KmVycnAgdGVzdHMNCj4+IHdpbGwgbmV2ZXIgdHJpZ2dlciwgYmVjYXVzZSB3ZSdsbCBoYXZlIGFs
cmVhZHkgYWJvcnRlZCBpbiB0aGUgY2hpbGQgb24NCj4+IHRoZSBvcmlnaW5hbCBlcnJwLCBnaXZp
bmcgZGV2ZWxvcGVycyB0aGUgYmVzdCBzdGFjayB0cmFjZS4NCj4+DQo+PiBpZiB0aGUgY2FsbGVy
IHBhc3NlZCAmZXJyb3JfZmF0YWwsIHdlIHJlZGlyZWN0IGVycnAuwqAgYXV0by1jbGVhbnVwIHdp
bGwNCj4+IHRoZW4gZXJyb3JfcHJvcGFnYXRlIHRoYXQgYmFjayB0byB0aGUgY2FsbGVyLCBwcm9k
dWNpbmcgYXMgbXVjaCBuaWNlDQo+PiBpbmZvcm1hdGlvbiBhcyBwb3NzaWJsZS4NCj4+DQo+PiBp
ZiB0aGUgY2FsbGVyIHBhc3NlZCBhbnl0aGluZyBlbHNlLCB3ZSBrZWVwIGVycnAgdW5jaGFuZ2Vk
LCBzbyBubyBleHRyYQ0KPj4gZXJyb3JfcHJvcGFnYXRlIGluIHRoZSBtaXguDQo+Pg0KPj4+DQo+
Pj4gU28gSSdkIHJlYWxseSBsaWtlIHRvIHJlc3RyaWN0IHRoZSB1c2Ugb2YgZXJyb3JfcHJvcGFn
YXRlKCkgdG8gcGxhY2VzDQo+Pj4gd2hlcmUgaXQncyBhYnNvbHV0ZWx5IG5lY2Vzc2FyeS4gVW5s
ZXNzLCBvZiBjb3Vyc2UsIHlvdSBjYW4gZml4IHRoZXNlDQo+Pj4gcHJhY3RpY2FsIHByb2JsZW1z
IHRoYXQgZXJyb3JfcHJvcGFnYXRlKCkgY2F1c2VzIGZvciBkZWJ1Z2dpbmcuDQo+Pj4NCj4+PiBJ
biBmYWN0LCBpbiB0aGUgY29udGV4dCBvZiBHcmVnJ3Mgc2VyaWVzLCBJIHRoaW5rIHdlIHJlYWxs
eSBvbmx5IG5lZWQgdG8NCj4+PiBzdXBwb3J0IGhpbnRzIGZvciBlcnJvcl9mYXRhbCwgd2hpY2gg
YXJlIGNhc2VzIHRoYXQgdXNlcnMgYXJlIHN1cHBvc2VkDQo+Pj4gdG8gc2VlLiBXZSBzaG91bGQg
ZXhjbHVkZSBlcnJvcl9hYm9ydCBpbiBNQUtFX0VSUlBfU0FGRSgpIGJlY2F1c2UgdGhlc2UNCj4+
PiBhcmUgdGhpbmdzIHRoYXQgYXJlIG5ldmVyIHN1cHBvc2VkIHRvIGhhcHBlbi4gQSBnb29kIHN0
YWNrIHRyYWNlIGlzIG1vcmUNCj4+PiBpbXBvcnRhbnQgdGhlcmUgdGhhbiBhZGRpbmcgYSBoaW50
IHRvIHRoZSBtZXNzYWdlLg0KPj4NCj4+IFdlIGFsc28gd2FudCB0byBoYW5kbGUgdGhlIGNhbGxl
ciBwYXNzaW5nIE5VTEwsIHNvIHRoYXQgd2Ugbm8gbG9uZ2VyDQo+PiBoYXZlIHRvIGludHJvZHVj
ZSAnRXJyb3IgKmxvY2FsX2Vycm9yID0gTlVMTCcgZXZlcnl3aGVyZS4NCj4+DQo+IA0KPiBXaXRo
IG15IHBsYW4gb2YgdHdvIGRpZmZlcmVudCBtYWNybywgSSBhdCBsZWFzdCBtZXNzZWQgdGhlIGNh
c2Ugd2hlbiB3ZSBuZWVkDQo+IGJvdGggZGVyZWZlcmVuY2luZyBhbmQgaGludHMsIHdoaWNoIG1l
YW5zIHRoaXJkIG1hY3JvLCBvciBvbmUgbWFjcm8gd2l0aCBwYXJhbWV0ZXJzLA0KPiBzYXlpbmcg
d2hhdCB0byB3cmFwLg0KPiANCj4gQW5kIG15IGFpbSB3YXMgdG8gZm9sbG93IHRoZSBpZGVhIG9m
ICJkbyBwcm9wYWdhdGlvbiBvbmx5IGlmIGl0IHJlYWxseSBuZWNlc3NhcnkgaW4gdGhpcyBjYXNl
Ii4NCj4gDQo+IEJ1dCBtYXkgYmUgeW91IGFyZSByaWdodCwgYW5kIHdlIHNob3VsZG4ndCBjYXJl
IHNvIG11Y2guDQo+IA0KPiAxLiBXaGF0IGlzIGJhZCwgaWYgd2Ugd3JhcCBOVUxMLCB3aGVuIHdl
IG9ubHkgd2FudCB0byB1c2UgaGludHM/DQo+IFNlZW1zIG5vdGhpbmcuIFNvbWUgZXh0cmEgYWN0
aW9ucyBvbiBlcnJvciBwYXRoLCBidXQgd2hvIGNhcmVzIGFib3V0IGl0Pw0KPiANCj4gMi4gV2hh
dCBpcyBiYWQsIGlmIHdlIHdyYXAgZXJyb3JfZmF0YWwsIHdoZW4gd2Ugb25seSB3YW50IHRvIGRl
cmVmZXJlbmNlLCBhbmQgZG9uJ3QgdXNlIGhpbnRzPw0KPiBTZWVtcyBub3RoaW5nIGFnYWluLCBv
biBlcnJvciBwYXRoIHdlIHdpbGwgcmV0dXJuIGZyb20gaGlnaGVyIGxldmVsLCBhbmQgYSBiaXQg
b2YgZXh0cmEgd29yaywgYnV0IG5vdGhpbmcgd29yc2UuLg0KPiANCj4gU28gSSB0ZW5kIHRvIGFn
cmVlLiBCdXQgaG9uZXN0bHksIEkgZGlkbid0IHVuZGVyc3RhbmQgZmlyc3QgcGFydCBvZiBLZXZp
bidzIHBhcmFncmFwaCBhZ2FpbnN0IHByb3BhZ2F0aW9uLA0KPiBzbywgbWF5IGJlIGhlIGhhdmUg
bW9yZSByZWFzb25zIHRvIG1pbmltaXplIG51bWJlciBvZiBjYXNlcyB3aGVuIHdlIHByb3BhZ2F0
ZS4NCj4gDQo+IFRvIHRoZSBzYW1lIHRvcGljLCBvZiBtaW5pbWl6YXRpb246IHNob3VsZCB3ZSBh
bHdheXMgY2FsbCBNQUtFX0VSUlBfU0FGRSBhdCBmdW5jdGlvbiB0b3AsIG9yIG9ubHkNCj4gaW4g
YmxvY2ssIHdoZXJlIGl0IGlzIG5lZWRlZCAoYXNzdW1lLCB3ZSBkZXJlZmVyZW5jZSBpdCBvbmx5
IGluc2lkZSBzb21lICJpZiIgb3IgIndoaWxlIj8NCj4gS2V2aW4sIGlzIHNvbWV0aGluZyBiYWQg
aW4gcHJvcGFnYXRpb24sIHdoZW4gaXQgbm90IHJlbGF0ZWQgdG8gZXJyb3JfYWJvcnQ/DQo+IA0K
PiANCg0KT3IsIGV2ZW4sIHdlIG1heSB1c2UgTUFLRV9FUlJQX1NBRkUgb24gZXZlcnkgZnVuY3Rp
b24sIHdoaWNoIGhhdmUgRXJyb3IgKiplcnJwIGFyZ3VtZW50LCBldmVuIGlmIHdlIG5laXRoZXIN
CmRlcmVmZXJlbmNlIGl0IG5vciBhcHBlbmQgaGludHM/IElzIGl0IHdoYXQgeW91IHByb3Bvc2Ug
YnkgIlNJTkdMRSBwYXJhZGlnbSI/IEl0J3Mgb2YgY291cnNlIHNpbXBsZXIgdG8gc2NyaXB0LA0K
dG8gY2hlY2sgaW4gY2hlY2twYXRjaCBhbmQgdG8gbWFpbnRhaW4uDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

