Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55EC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5659621929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ciWtGcI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5659621929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAt47-0001Tj-EV
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAt2q-0000nf-8j
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAt2o-0005SD-TM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:48:12 -0400
Received: from mail-eopbgr00126.outbound.protection.outlook.com
 ([40.107.0.126]:11904 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAt2e-0005OG-PZ; Thu, 19 Sep 2019 05:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGHRuIKSGIp+0bIZfVyl8cvG3VaI4Qt+Hrc2jYN4h4x+ro2CyngrDd64WF5W/cWn9RJFILqwchLs+ot3B0z8wD8SLdyZv/emXB3QEZaQA3hXupkO3R+esNYkoQC9eRfVPiuX/WW26sv2Wya66GjwhWrC21q6iXfKRr0ommvN6XdAJeoc8Djosp0pzS7QTrIpbDWRrKS2zimnAWZ5H7efYJGrRMi6LEugA5TkCg2FNGHww/urNZN+V3yNB0eH/MtIF+qtKzi/jCUXdA9A8e9dC6pBKFTbWo2G1jpYfGXhE0ybOWCCO5OwqCdsZQ77zJYmNk6SS6SYgF73P60G0XPyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8KyAgZ5Q5Xg5/inO4RW2kXkSKNv3vrg35dxGX3wi6o=;
 b=DsXuEY84XCn3q7dlRQvVCsbyjbVlklhQ+4HQo/DpxHUUjibfN9ftuQo3VS2yLN3epixy6LrNiG294PtAFj9zq7Uys23W1j31Ir9pXlPGBhsir9OpYnYn1i6X2e3vPFntYi/3HOVSucZ6+Uj3Ege/XFr45Xx9mAwCuGz6z2wcRN2PBNK3fsWC5dqc8TB0fiY/lvHRbSA2IbAv64548Yyxooy2G2NJiyH2J6IA5xkOoWk3q75S4t3b7r/2MYqgOlaM9Wzecns1f0Y3RCnpirJSwU9ZQi4LtuYJbQAAACEyB+PkchRpQfLpltbb13+G9JCLZOEPT9ZgcpOvPgKSdRxvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8KyAgZ5Q5Xg5/inO4RW2kXkSKNv3vrg35dxGX3wi6o=;
 b=ciWtGcI5pvl1HfKZk9A2FlMlHbN3LTYESE/QnkhuRkOrRSgqEorlDsDpa3cdchVqSF9s2zkxxLyg7VZ329FejkHoiFgFLN4WEQfsJScYZSvRLh2c+cfKSISexOCdeqpbxu/3kPz2ys7ALDnkSx+8yawOrjy/e2tAaedfWE6UhlE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5387.eurprd08.prod.outlook.com (52.133.241.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Thu, 19 Sep 2019 09:47:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 09:47:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcxq6KAgAEOLgCAAAiJgA==
Date: Thu, 19 Sep 2019 09:47:57 +0000
Message-ID: <9c9ac60c-3843-ccd6-c027-9f61a0bd4195@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
In-Reply-To: <20190919091720.GB10163@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919124753838
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b58c521-7a80-4d66-78a1-08d73ce6737e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5387; 
x-ms-traffictypediagnostic: DB8PR08MB5387:
x-microsoft-antispam-prvs: <DB8PR08MB5387CBA05EF2829857C67568C1890@DB8PR08MB5387.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39850400004)(346002)(366004)(376002)(189003)(199004)(446003)(11346002)(486006)(476003)(2616005)(4326008)(71200400001)(66476007)(66556008)(64756008)(6246003)(316002)(110136005)(66446008)(54906003)(5660300002)(81166006)(81156014)(8676002)(256004)(14444005)(6436002)(6512007)(31696002)(86362001)(6486002)(71190400001)(229853002)(8936002)(36756003)(66066001)(478600001)(7736002)(99286004)(6116002)(3846002)(305945005)(31686004)(14454004)(2906002)(7416002)(7406005)(102836004)(53546011)(6506007)(386003)(66946007)(186003)(26005)(52116002)(25786009)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5387;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jFslK/6Uo0K6uBbD1ByVoQZChGjDv/5GeDebnnzqNKTBrm8UXDObz3oSknXwymeyh6pJn/X4IzvkBGljuH6+j4rNki2VdKJIxAicrdY8L5H37ASbHhptup+gUZ72B4sJaiw6Y/94/7XaghpS8bARrHsCqodw26UqjPo1L02cS/ckiJmQJXnH5+zuPZ6UddIAKxtB6IJikN2DJwnYY62geLsYufwd4TyYN/jaJKeZiGVa86kjn+S/ICFUmkL/ucSuIs7IjfY6MtcgOzjuai58qw+891OW5b2GzUztx2x38ANvLBEgDEQir07iWOIO7QxKAriUFFpt6jf7jgD1/LcA9+FrqtI03sNppkMvSfL/DDfufiECUBRvxyu1G3TW/aszd/GAUnHy6JeJCgdlgLztwKipD4QgQ8UaXT55XgHCn0c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2064904818705469AAD33DE8A4A3B81@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b58c521-7a80-4d66-78a1-08d73ce6737e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 09:47:57.5098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWrbeu1oenwnnpiNntRnKdSGprvpvpGcSVVEp2JFkH2kvyoBm0urKcSFjpbdybHigmDpwQ3QioQTl/SADJ3/AOD11CRI9DTzM/ekjfzT2Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5387
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.126
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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

MTkuMDkuMjAxOSAxMjoxNywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTguMDkuMjAxOSB1bSAx
OToxMCBoYXQgRXJpYyBCbGFrZSBnZXNjaHJpZWJlbjoNCj4+IE9uIDkvMTgvMTkgODowMiBBTSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+PiArICovDQo+Pj4gKyNkZWZp
bmUgTUFLRV9FUlJQX1NBRkUoZXJycCkgXA0KPj4+ICtnX2F1dG8oRXJyb3JQcm9wYWdhdGlvblN0
cnVjdCkgKF9fYXV0b19lcnJwX3Byb3ApID0gey5lcnJwID0gKGVycnApfTsgXA0KPj4+ICtpZiAo
KGVycnApID09IE5VTEwgfHwgKihlcnJwKSA9PSBlcnJvcl9hYm9ydCB8fCAqKGVycnApID09IGVy
cm9yX2ZhdGFsKSB7IFwNCj4+PiArICAgIChlcnJwKSA9ICZfX2F1dG9fZXJycF9wcm9wLmxvY2Fs
X2VycjsgXA0KPj4+ICt9DQo+Pg0KPj4gTm90IHdyaXR0ZW4gdG8gdGFrZSBhIHRyYWlsaW5nIHNl
bWljb2xvbiBpbiB0aGUgY2FsbGVyLg0KPj4NCj4+IFlvdSBjb3VsZCBldmVuIHNldCBfX2F1dG9f
ZXJycF9wcm9wIHVuY29uZGl0aW9uYWxseSByYXRoZXIgdGhhbiB0cnlpbmcNCj4+IHRvIHJldXNl
IGluY29taW5nIGVycnAgKHRoZSBkaWZmZXJlbmNlIGJlaW5nIHRoYXQgZXJyb3JfcHJvcGFnYXRl
KCkgZ2V0cw0KPj4gY2FsbGVkIG1vcmUgZnJlcXVlbnRseSkuDQo+IA0KPiBJIHRoaW5rIHRoaXMg
ZGlmZmVyZW5jZSBpcyBhY3R1YWxseSBhIHByb2JsZW0uDQo+IA0KPiBXaGVuIGRlYnVnZ2luZyB0
aGluZ3MsIEkgaGF0ZSBlcnJvcl9wcm9wYWdhdGUoKS4gSXQgbWVhbnMgdGhhdCB0aGUgRXJyb3IN
Cj4gKHNwZWNpZmljYWxseSBpdHMgZmllbGRzIHNyYy9mdW5jL2xpbmUpIHBvaW50cyB0byB0aGUg
b3V0ZXJtb3N0DQo+IGVycm9yX3Byb3BhZ2F0ZSgpIHJhdGhlciB0aGFuIHRoZSBwbGFjZSB3aGVy
ZSB0aGUgZXJyb3IgcmVhbGx5IGhhcHBlbmVkLg0KDQpIbW0sIG5ldmVyIHRlc3RlZCBpdCwgYnV0
IGxvb2tpbmcgYXQgdGhlIGNvZGUgSSBjYW4ndCB1bmRlcnN0YW5kIGhvdyBjYW4gdGhhdA0KYmUu
IHNyYy9mdW5jL2xpbmUgYXJlIHNldCBpbiBlcnJvcl9zZXRnLi4gYW5kIGluIGVycm9yX3Byb3Bh
Z2F0ZSgpIHdlIGp1c3QNCnNldCB0aGUgZXJycCBvZiB0aGUgY2FsbGVyLCBzcmMvZnVuYy9saW5l
IHVuY2hhbmdlZC4NCg0KU3RpbGwsIEkgc2VlIHRoYXQgdGhlc2UgdXNlZnVsIGZpZWxkcyBhcmUg
cHJpbnRlZCBvbmx5IGZvciBlcnJvcl9hYm9ydCwgZm9yDQp3aGljaCB3ZSB1c3VhbGx5IGhhdmUg
Y29yZWR1bXAsIHdoaWNoIHByb3ZpZGVzIGEgbG90IG1vcmUgaW5mb3JtYXRpb24uDQoNCj4gSXQg
YWxzbyBtYWtlcyBlcnJvcl9hYm9ydCBjb21wbGV0ZWx5IHVzZWxlc3MgYmVjYXVzZSBhdCB0aGUg
cG9pbnQgd2hlcmUNCj4gdGhlIHByb2Nlc3MgZ2V0cyBhYm9ydGVkLCB0aGUgaW50ZXJlc3Rpbmcg
aW5mb3JtYXRpb24gaXMgYWxyZWFkeSBsb3N0Lg0KDQpBaGEsIHVuZGVyc3RhbmQgdGhpcyBwb2lu
dCwgZXJyb3JfYWJvcnQganVzdCBkb24ndCB3b3JrIGFzIGRlc2lyZWQsIGlmDQp3ZSBzd2FwIGl0
IGJ5IGxvY2FsX2Vyci4gQW5kIHdlIGNhbiBmaXggaXQgYnkgdXNpbmcgbWFjcm86IG5ldmVyIGNy
ZWF0ZQ0KbG9jYWxfZXJyIGZvciBlcnJvcl9hYm9ydCwgbGV0IGl0IGFib3J0IGV4YWN0bHkgb24g
ZXJyb3Jfc2V0Zy4NCg0KPiANCj4gU28gSSdkIHJlYWxseSBsaWtlIHRvIHJlc3RyaWN0IHRoZSB1
c2Ugb2YgZXJyb3JfcHJvcGFnYXRlKCkgdG8gcGxhY2VzDQo+IHdoZXJlIGl0J3MgYWJzb2x1dGVs
eSBuZWNlc3NhcnkuIFVubGVzcywgb2YgY291cnNlLCB5b3UgY2FuIGZpeCB0aGVzZQ0KPiBwcmFj
dGljYWwgcHJvYmxlbXMgdGhhdCBlcnJvcl9wcm9wYWdhdGUoKSBjYXVzZXMgZm9yIGRlYnVnZ2lu
Zy4NCj4gDQo+IEluIGZhY3QsIGluIHRoZSBjb250ZXh0IG9mIEdyZWcncyBzZXJpZXMsIEkgdGhp
bmsgd2UgcmVhbGx5IG9ubHkgbmVlZCB0bw0KPiBzdXBwb3J0IGhpbnRzIGZvciBlcnJvcl9mYXRh
bCwgd2hpY2ggYXJlIGNhc2VzIHRoYXQgdXNlcnMgYXJlIHN1cHBvc2VkDQo+IHRvIHNlZS4gV2Ug
c2hvdWxkIGV4Y2x1ZGUgZXJyb3JfYWJvcnQgaW4gTUFLRV9FUlJQX1NBRkUoKSBiZWNhdXNlIHRo
ZXNlDQo+IGFyZSB0aGluZ3MgdGhhdCBhcmUgbmV2ZXIgc3VwcG9zZWQgdG8gaGFwcGVuLiBBIGdv
b2Qgc3RhY2sgdHJhY2UgaXMgbW9yZQ0KPiBpbXBvcnRhbnQgdGhlcmUgdGhhbiBhZGRpbmcgYSBo
aW50IHRvIHRoZSBtZXNzYWdlLg0KPiANCg0KQWdyZWVkDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

