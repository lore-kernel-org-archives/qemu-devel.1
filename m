Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A16C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F5A21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QZ2+nGyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F5A21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzAb-00026Q-Gf
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAz6z-0008D3-VG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAz6y-0002RE-6Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:16:53 -0400
Received: from mail-eopbgr80130.outbound.protection.outlook.com
 ([40.107.8.130]:3044 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAz6b-0002CA-UV; Thu, 19 Sep 2019 12:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZTrLCUvVLT15Hd8bIzGo3KkcqkXx4kGrV/iVUxl9K6+jIyYCj0ODpHYhgf+HjiqyqWHmmuzdzbgAsgPpng8fFj2raPLmHxeGpHPUQmZnRVirrnoETJC3NG71RJBKpdT0eI/pE5hXqC3Lwj1p9lzuNpXa5Q6erPAz7KdSZdKTfKNrSZo5OKnHYMZa4q5IY/K0kF4kJz+31Rgz7IPkk0FLRHSXPAcRdr1kYG3jAd5AzFpUr/BSrg9re2ftmnHo7ahPVE5n0D0RXXzt6n/lRbTDZ9msBVr5ypxp8ZRvREI5TJEuqH6itRoxb93V7cmta6U1q+m4k1mnm4XxNVNshXA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxpiWkMi04NvL1m8ZamdFYoXaiJM1IspkZNer/F76Fo=;
 b=f035oVq6Ib4FWXzgI6QGW9+6iGJRP5ksBFwrc4sG+1GycT3lkjqtdcgWniAsf9sNuE7rpT8fIOQPS08pvfl3efAq8CW3I8ytBYuHuBgBzW5SS9eUKW+aCbfBJjpiTexMKHbsfpYJQXb9G/1UgsgTZpAnc8XJHdPDwzbmnJuCdSgFk3vEYtAO4Oanv9akq7Jmii/CyzlVsbHDpd5eIABjMykWDqOEVWreIWD8ToT45TvlQhrE01uIMwYXzYZDyJalAWDxRKE1hE8DJr74rGRYy+YHdHfjlXkR06ZWDtPHrHNJBJudZY/n1AvbLdO01s56S9kkzyKfRC3IRIp2mnLkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxpiWkMi04NvL1m8ZamdFYoXaiJM1IspkZNer/F76Fo=;
 b=QZ2+nGyBImxJhJOuW13oj/LGcpuYWaJmU1Q0jI1rB+22+A8jjZA0Htf3HHX+rvM9qJhUEEb9HujyzLgynhZ3pyQCQYcYSRAFwjYx4tZ9Z1ur+fAN485/UidD6GW2fREJ7J2MG9Y/go8ye2gm0RtkaQBNL/tSI5L+Hp5/TTsDJdU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5244.eurprd08.prod.outlook.com (10.255.17.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Thu, 19 Sep 2019 16:16:25 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 16:16:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC] error: auto propagated local_err
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAEmpAIAACO4AgAAE0QCAAAPuAIAAAY4AgAAJpgCAAAdigIAAByYA
Date: Thu, 19 Sep 2019 16:16:25 +0000
Message-ID: <27eccb19-a514-f44f-240b-1e40852fff8c@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
 <35c972e1-bdb5-cbcb-ed45-6a51f19af98c@virtuozzo.com>
 <696673be-95c8-3f75-551c-26fccd230eb1@virtuozzo.com>
 <152afb5b-8efb-d968-d595-94f58ad02a04@redhat.com>
 <20190919144948.GR20217@redhat.com>
 <b5128e58-8b90-233d-6bb1-cc9009852d8d@redhat.com>
 <20190919155045.GS20217@redhat.com>
In-Reply-To: <20190919155045.GS20217@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::16)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919191620829
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75d9521f-949f-4ba0-2bca-08d73d1cb81e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5244; 
x-ms-traffictypediagnostic: DB8PR08MB5244:
x-microsoft-antispam-prvs: <DB8PR08MB5244BF9C258FBDF941368911C1890@DB8PR08MB5244.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(136003)(39850400004)(376002)(189003)(199004)(66066001)(86362001)(31696002)(31686004)(3846002)(6116002)(36756003)(2906002)(102836004)(229853002)(476003)(11346002)(446003)(53546011)(52116002)(6512007)(6486002)(71190400001)(2616005)(6436002)(71200400001)(6506007)(99286004)(186003)(14454004)(26005)(76176011)(4326008)(386003)(110136005)(316002)(6246003)(25786009)(54906003)(14444005)(7736002)(478600001)(256004)(81166006)(66446008)(8676002)(81156014)(8936002)(7406005)(486006)(5660300002)(7416002)(305945005)(66476007)(66946007)(66556008)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5244;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cltiV6/vK+XqeRIyzHIx5kRb+WUURkpdeWyUVBbPd/Dnmzid8Su60/tYQetHlwQJqWN36niZEXfgLxaXE0ei+m7Qdy7eeXhULcsSH50dif8eJ/3VI2YuIdAMx0BN3JXzgLIoDtzYDROgZ4aaq/gcT6KpJLx5WmFtdX2HvGXhro9/uepW1pIH8jXDeH0iWpm/nkQxy6lmh6Ou4lp+otYTmhnkRN+1MgNdfu6ElgIcbYgGgTK6Pldl+fMMRYXE5D1OM7GeiT0mTOpxvu6OO9PWbM4xYPgfZRcZUPaTNJ7ixJdy1ui4C6R0N+B3HWDGkyLQQJnlwhsAy2TPfcwfnN2E00nP3zKOtrMLTg11LAb1ecedmJsyNAx8g9ieL/oPKot5jfHng0QjnWnaJL4sPQMIn5dWOlkNeeA3TjeoKZQ8pGE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6159C9B1DACADC4AAEB7274C6EB1E408@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d9521f-949f-4ba0-2bca-08d73d1cb81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:16:25.6480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bNrhK7b7XBNknlCHgweRc7J2AKqA8dM976d0WLAh4FkbyPeS3e83SE8jDev+t3/7///D1uAgYJ8pP6QeuBbVscHLUOkvx3++6yuNJRi3jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5244
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.130
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
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxODo1MCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gVGh1LCBT
ZXAgMTksIDIwMTkgYXQgMTA6MjQ6MjBBTSAtMDUwMCwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9u
IDkvMTkvMTkgOTo0OSBBTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+DQo+Pj4+IEFM
V0FZUyB1c2luZyBNQUtFX0VSUlBfU0FGRSgpIG9uIGVudHJ5IHRvIGFueSBmdW5jdGlvbiB0aGF0
IGhhcyBhbiBFcnJvcg0KPj4+PiAqKmVycnAgcGFyYW1ldGVyIGlzIGRpcnQtc2ltcGxlIHRvIGV4
cGxhaW4uICBJdCBoYXMgbm8gcGVyZm9ybWFuY2UNCj4+Pj4gcGVuYWx0eSBpZiB0aGUgdXNlciBw
YXNzZWQgaW4gYSBub3JtYWwgZXJyb3Igb3IgZXJyb3JfYWJvcnQgKHRoZSBjb3N0IG9mDQo+Pj4+
IGFuICdpZicgaGlkZGVuIGluIHRoZSBtYWNybyBpcyBwcm9iYWJseSBuZWdsaWdpYmxlIGNvbXBh
cmVkIHRvDQo+Pj4+IGV2ZXJ5dGhpbmcgZWxzZSB3ZSBkbyksIGFuZCBoYXMgbm8gc2VtYW50aWMg
cGVuYWx0eSBpZiB0aGUgdXNlciBwYXNzZWQNCj4+Pj4gaW4gTlVMTCBvciBlcnJvcl9mYXRhbCAo
d2Ugbm93IGdldCB0aGUgYmVoYXZpb3Igd2Ugd2FudCB3aXRoIGxlc3MNCj4+Pj4gYm9pbGVycGxh
dGUpLg0KPj4+Pg0KPj4+PiBIYXZpbmcgdG8gdGhpbmsgJ2RvZXMgdGhpcyBtZXRob2QgcmVxdWly
ZSBtZSB0byB1c2UgTUFLRV9FUlJQX1NBRkUsIG9yDQo+Pj4+IGNhbiBJIG9taXQgaXQ/JyBkb2Vz
IG5vdCBwcm92aWRlIHRoZSBzYW1lIHNpbXBsaWNpdHkuDQo+Pj4NCj4+PiBUaGUgZmxpcHNpZGUg
aXMgdGhhdCBNQUtFX0VSUlBfU0FGRSBoaWRlcyBhIGJ1bmNoIG9mIGxvZ2ljLCBzbyB5b3UgZG9u
J3QNCj4+PiByZWFsbHkga25vdyB3aGF0IGl0cyBkb2luZyB3aXRob3V0IGxvb2tpbmcgYXQgaXQs
IGFuZCB0aGlzIGlzIFFFTVUNCj4+PiBjdXN0b20gY29uY2VwdCBzbyBvbmUgbW9yZSB0aGluZyB0
byBsZWFybiBmb3IgbmV3IGNvbnRyaWJ1dG9ycy4NCj4+Pg0KPj4+IFdoaWxlIEkgdGhpbmsgaXQg
aXMgYSBuaWNlIHRyaWNrLCBwZXJzb25hbGx5IEkgdGhpbmsgd2Ugd291bGQgYmUgYmV0dGVyDQo+
Pj4gb2ZmIGlmIHdlIHNpbXBseSB1c2VkIGEgY29kZSBwYXR0ZXJuIHdoaWNoIGRvZXMgbm90IHJl
cXVpcmUgZGUtcmVmZXJlbmNpbmcNCj4+PiAnZXJycCcgYXQgYWxsLCBhc2lkZSBmcm9tIGV4Y2Vw
dGlvbmFsIGNhc2VzLiBJT1csIG5vIGFkZGVkIG1hY3JvIGluIDk1JQ0KPj4+IG9mIGFsbCBvdXIg
bWV0aG9kcyB1c2luZyBFcnJvciAqKmVycnAuDQo+Pg0KPj4gSWYgMTAwJSBvZiBvdXIgY2FsbHNp
dGVzIHVzZSB0aGUgbWFjcm8sIHRoZW4gbmV3IGNvbnRyaWJ1dG9ycyB3aWxsDQo+PiBxdWlja2x5
IGxlYXJuIGJ5IG9ic2VydmF0aW9uIGFsb25lIHRoYXQgdGhlIG1hY3JvIHVzYWdlIG11c3QgYmUN
Cj4+IGltcG9ydGFudCBvbiBhbnkgbmV3IGZ1bmN0aW9uIHRha2luZyBFcnJvciAqKmVycnAsIHdo
ZXRoZXIgb3Igbm90IHRoZXkNCj4+IGFjdHVhbGx5IHJlYWQgdGhlIG1hY3JvIHRvIHNlZSB3aGF0
IGl0IGRvZXMuICBJZiBvbmx5IDUlIG9mIG91cg0KPj4gY2FsbHNpdGVzIHVzZSB0aGUgbWFjcm8s
IGl0J3MgaGFyZGVyIHRvIGFyZ3VlIHRoYXQgYSBuZXcgdXNlciB3aWxsIHBpY2sNCj4+IHVwIG9u
IHRoZSBudWFuY2VzIGJ5IG9ic2VydmF0aW9uIGFsb25lIChwcmVzdW1hYmx5LCBvdXIgZG9jcyB3
b3VsZCBhbHNvDQo+PiBzcGVsbCBpdCBvdXQsIGJ1dCB3ZSBrbm93IHRoYXQgbm90IGV2ZXJ5b25l
IHJlYWRzIHRob3NlLi4uKS4NCj4gDQo+IFRvIGdldCBzb21lIHNsaWdodGx5IGxlc3MgbWFkZS11
cCBzdGF0cywgSSBkaWQgc29tZSBzZWFyY2hpbmc6DQo+IA0KPiAgICAtIDQ0MDggIG1ldGhvZHMg
d2l0aCBhbiAnZXJycCcgcGFyYW1ldGVyIGRlY2xhcmVkDQo+IA0KPiAgICAgICBnaXQgZ3JlcCAn
RXJyb3IgXCpcKmVycnAnfCAgd2MgLWwNCj4gDQo+ICAgIC0gNjk2IG1ldGhvZHMgd2l0aCBhbiAn
RXJyb3IgKmxvY2FsJyBkZWNsYXJlZCAod2hhdCBvdGhlciBuYW1lcw0KPiAgICAgIGRvIHdlIHVz
ZSBmb3IgdGhpcz8pDQo+IA0KPiAgICAgICBnaXQgZ3JlcCAnRXJyb3IgXCpsb2NhbCcgfCB3YyAt
bA0KPiANCj4gICAgLSAxMjQzIG1ldGhvZHMgd2l0aCBhbiAnZXJycCcgcGFyYW1ldGVyIHdoaWNo
IGhhdmUgdm9pZA0KPiAgICAgIHJldHVybiB2YWx1ZSAoZnV6enkgbnVtYmVyIC0gbXkgbWF0Y2hp
bmcgaXMgcXVpdGUgY3J1ZGUpDQo+IA0KPiAgICAgICBnaXQgZ3JlcCAnRXJyb3IgXCpcKmVycnAn
fCAgZ3JlcCAtRSAnKF58ICl2b2lkJyB8IHdjIC1sDQo+IA0KPiAgICAtIDExIG1ldGhvZHMgdXNp
bmcgZXJyb3JfYXBwZW5kX2hpbnQgd2l0aCBhIGxvY2FsX2Vycg0KPiANCj4gICAgICAgZ2l0IGdy
ZXAgYXBwZW5kX2hpbnQgfCBncmVwIGxvY2FsIHwgd2MgLWwNCg0Kd2h5IGRvIHlvdSBjb3VudCBv
bmx5IHdpdGggbG9jYWw/IEdyZWcncyBzZXJpZXMgaXMgaGVyZSB0byBicmluZyBsb2NhbCB0byBh
bGwNCmZ1bmN0aW9ucyB3aXRoIGFwcGVuZF9oaW50Og0KDQojIGdpdCBncmVwIGFwcGVuZF9oaW50
IHwgd2MgLWwNCjg1DQoNCihzdGlsbCwgc29tZSBmdW5jdGlvbnMgbWF5IGFwcGVuZF9oaW50IHNl
dmVyYWwgdGltZXMsIHNvIHRoZSBudW1iZXIgc2hvdWxkIGJlIGxlc3MpDQphbmQgZmlsZSBsaXN0
IGlzIGJpZzoNCg0KIyBnaXQgZ3JlcCAtbCBhcHBlbmRfaGludA0KYmxvY2suYw0KYmxvY2svYmFj
a3VwLmMNCmJsb2NrL2RpcnR5LWJpdG1hcC5jDQpibG9jay9maWxlLXBvc2l4LmMNCmJsb2NrL2ds
dXN0ZXIuYw0KYmxvY2svcWNvdy5jDQpibG9jay9xY293Mi5jDQpibG9jay92aGR4LWxvZy5jDQpi
bG9jay92cGMuYw0KY2hhcmRldi9zcGljZS5jDQpody85cGZzLzlwLWxvY2FsLmMNCmh3LzlwZnMv
OXAtcHJveHkuYw0KaHcvYXJtL21zZjItc29jLmMNCmh3L2FybS92aXJ0LmMNCmh3L2F1ZGlvL2lu
dGVsLWhkYS5jDQpody9pbnRjL2FybV9naWN2M19rdm0uYw0KaHcvbWlzYy9tc2YyLXN5c3JlZy5j
DQpody9wY2ktYnJpZGdlL3BjaV9icmlkZ2VfZGV2LmMNCmh3L3BjaS1icmlkZ2UvcGNpZV9yb290
X3BvcnQuYw0KaHcvcHBjL21hY19uZXd3b3JsZC5jDQpody9wcGMvc3BhcHIuYw0KaHcvcHBjL3Nw
YXByX2lycS5jDQpody9wcGMvc3BhcHJfcGNpLmMNCmh3L3JkbWEvdm13L3B2cmRtYV9tYWluLmMN
Cmh3L3MzOTB4L3MzOTAtY2N3LmMNCmh3L3Njc2kvbWVnYXNhcy5jDQpody9zY3NpL21wdHNhcy5j
DQpody9zY3NpL3Njc2ktZGlzay5jDQpody9zY3NpL3Njc2ktZ2VuZXJpYy5jDQpody91c2IvY2Np
ZC1jYXJkLWVtdWxhdGVkLmMNCmh3L3VzYi9oY2QteGhjaS5jDQpody92ZmlvL2NvbW1vbi5jDQpo
dy92ZmlvL3BjaS1xdWlya3MuYw0KaHcvdmZpby9wY2kuYw0KaHcvdmlydGlvL3ZpcnRpby1wY2ku
Yw0KaHcveGVuL3hlbl9wdC5jDQpody94ZW4veGVuX3B0X2NvbmZpZ19pbml0LmMNCmluY2x1ZGUv
cWFwaS9lcnJvci5oDQptaWdyYXRpb24vbWlncmF0aW9uLmMNCm5iZC9jbGllbnQuYw0KbmJkL3Nl
cnZlci5jDQpxZGV2LW1vbml0b3IuYw0KdGFyZ2V0L2FybS9jcHU2NC5jDQp0YXJnZXQvcHBjL2t2
bS5jDQp1dGlsL2Vycm9yLmMNCnV0aWwvcWVtdS1vcHRpb24uYw0KdXRpbC9xZW11LXNvY2tldHMu
Yw0KDQoNCkFsc28sIGNvbnZlcnNpb24gdG8gdXNlIG1hY3JvIGV2ZXJ5d2hlcmUgbWF5IGJlIGRv
bmUgKHNlZW1zIHNvKSBieSBjb2NjaW5lbGxlIHNjcmlwdC4NCkJ1dCBjb252ZXJzaW9uIHdoaWNo
IHlvdSBtZWFuLCBvbmx5IGJ5IGhhbmQgSSB0aGluay4gQ29udmVydGluZyAxMjQzIG1ldGhvZHMg
YnkgaGFuZA0KaXMgYSBodWdlIHRhc2suLg0KDQoNCkkgdGhpbmsgdGhlcmUgYXJlIHRocmVlIGNv
bnNpc3RlbnQgd2F5czoNCg0KMS4gVXNlIG1hY3JvIGV2ZXJ5d2hlcmUNCjIuIERyb3AgZXJyb3Jf
YXBwZW5kX2hpbnQNCjMuIERyb3AgZXJyb3JfZmF0YWwNCg0KDQo+IA0KPiANCj4gVGhpcyBzdWdn
ZXN0cyB0byBtZSwgdGhhdCBpZiB3ZSB1c2VkIHRoZSAncmV0dXJuIDAgLyByZXR1cm4gLTEnIGNv
bnZlbnRpb24NCj4gdG8gaW5kaWNhdGUgZmFpbHVyZSBmb3IgdGhlIG1ldGhvZHMgd2hpY2ggY3Vy
cmVudGx5IHJldHVybiB2b2lkLCB3ZSBjb3VsZA0KPiBwb3RlbnRpYWxseSBvbmx5IGhhdmUgMTEg
Y2FzZXMgd2hlcmUgYSBsb2NhbCBlcnJvciBvYmplY3QgaXMgZ2VudWluZWx5DQo+IG5lZWRlZC4N
Cj4gDQo+IElmIG15IG51bWJlcnMgYXJlIGF0IGFsbCBhY2N1cmF0ZSwgSSBzdGlsbCBiZWxpZXZl
IHdlJ3JlIGJldHRlciBvZmYNCj4gY2hhbmdpbmcgdGhlIHJldHVybiB0eXBlIGFuZCBlbGltaW5h
dGluZyBlc3NlbnRpYWxseSBhbGwgdXNlIG9mIGxvY2FsDQo+IGVycm9yIHZhcmlhYmxlcywgYXMg
dm9pZCBmdW5jcy9sb2NhbCBlcnJvciBvYmplY3RzIGFwcGVhciB0byBiZSB0aGUNCj4gbWlub3Jp
dHkgY29kaW5nIHBhdHRlcm4uDQo+IA0KPiANCj4+PiBUaGVyZSBhcmUgbG90cyBvZiBuZWF0IHRo
aW5ncyB3ZSBjb3VsZCBkbyB3aXRoIGF1dG8tY2xlYW51cCBmdW5jdGlvbnMgd2UNCj4+PiBJIHRo
aW5rIHdlIG5lZWQgdG8gYmUgd2FyeSBvZiBoaWRpbmcgdG9vIG11Y2ggY2xldmVybmVzcyBiZWhp
bmQgbWFjcm9zDQo+Pj4gd2hlbiBkb2luZyBzbyBvdmVyYWxsLg0KPj4NCj4+IFRoZSBiZW5lZml0
IG9mIGdldHRpbmcgcmlkIG9mIHRoZSAnRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7IC4uLg0KPj4g
ZXJyb3JfcHJvcGFnYXRlKCknIGJvaWxlcnBsYXRlIGlzIHdvcnRoIHRoZSBjbGV2ZXJuZXNzLCBp
biBteSBvcGluaW9uLA0KPj4gYnV0IGVzcGVjaWFsbHkgaWYgYWxzbyBhY2NvbXBhbmllZCBieSBD
SSBjb3ZlcmFnZSB0aGF0IHdlIGFiaWRlIGJ5IG91cg0KPj4gbmV3IHJ1bGVzLg0KPiANCj4gQXQg
bGVhc3Qgd2UncmUgYm90aCB3YW50aW5nIHRvIGVsaW1pbmF0ZSB0aGUgbG9jYWwgZXJyb3IgKyBw
cm9wYWdhdGlvbi4NCj4gVGhlIGRpZmZlcmVuY2UgaXMgd2hldGhlciB3ZSdyZSBnZW51aW5lbHkg
ZWxpbWluYXRpbmcgaXQsIG9yIGp1c3QgaGlkaW5nDQo+IGl0IGZyb20gdmlldyB2aWEgYXV0by1j
bGVhbnVwICYgbWFjcm8gbWFnaWMNCj4gDQo+IFJlZ2FyZHMsDQo+IERhbmllbA0KPiANCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

