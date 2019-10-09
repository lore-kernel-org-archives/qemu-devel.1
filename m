Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A87EECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16605206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E2iWKVV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16605206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIG4z-0006NO-Ji
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI7bb-0000KX-9y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iI7ba-00043D-3i
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:45:59 -0400
Received: from mail-eopbgr130091.outbound.protection.outlook.com
 ([40.107.13.91]:35591 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iI7bO-0003wK-OZ; Wed, 09 Oct 2019 04:45:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIwTg5SCfwZnMTA906hUJK5/vOfyZutouyfZhUjik8HAbcv2eNNMUcB9+BuUsEWpvg+iQLg2F8+QibllJyank7IzYXZ4iCXXg79B8gDEa2ieGbqC/hfQaffsn0dK7cJ6lroJ/zXjpDxB95yqNMcSO/ySDwQQgsQAarhZ78QvImpBPuoScvgKjmwBLGl6v5CNSob6x4OOK0HjvMGY0MqY2ZxU6IvHaUzpKsKEnsTikzvJUueD8YwUfMoI7KRV5RZn83Adoe3mvEfpM6sjuxYDPSWSDf6hk8mizQPdw6PHKs00cWz1PiuzxpTrVMmzw75YCg15/qJ5wt/uyjn08dSVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+FrAXsYGM3ontZCGN9l1VMwtfn51EODt5kR/B+RH/k=;
 b=fe2LW/NMZu0ETqT7j7efjkAX2h48AugwG4ygF1IjsX31T6S7DlyqHTNvX+M9/PHi6Kt/Wa6zLKBbUwaaeGWS70zMIl/kCgI0pMcYIL0Uzi67ZT2vswOlrF0MVaUM8mFAbPgS//YIEI/fz63nJZNQioTrpvz3Zgmz/rLm0eoYN+dvsIRvBOj6PZlMQnef7LZwVqNiwvXvpEdhihe6Kniv7a8G+bQ1M8VC8GYlUm/gmlIgdgWJhC7NqmuIgt8TvCc2QcwGgNW9+xCku8CMVnLHHRrU7Eqx6jXyyNkgqJ8VwqWKSbEAoD9JbU6IWJIuHo8Puutk5CBwbAIvB+uCogbrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+FrAXsYGM3ontZCGN9l1VMwtfn51EODt5kR/B+RH/k=;
 b=E2iWKVV7c7P6fL+FSGsCw43oPuHXsRffyFhJmkYQTXLwUoC3cVKPzn8oOBngr2nhZrZzWf2aX/eOGsPInDgrT3jQwrlMy6DRsdaLnnWa1ph7rCW3x32MwXeMcfmCIwzD51YOpDMj5wqKYtDLVk/9pkdvqJkrbgAqL7hbofVzz5Q=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5052.eurprd08.prod.outlook.com (10.255.18.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 08:45:42 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 08:45:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 00/31] error: auto propagated local_err
Thread-Topic: [PATCH v4 00/31] error: auto propagated local_err
Thread-Index: AQHVeHBjrP5HIXy9eUuF1AJePQl1JqdQY7bDgABF8QD//94LAIAAOrKAgAFIlAA=
Date: Wed, 9 Oct 2019 08:45:42 +0000
Message-ID: <9798f8c1-896d-c304-e3a7-2aee505c3a63@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <87eeznn185.fsf@dusky.pond.sub.org>
 <a449a64d-ca3c-2442-27b3-70b565545a36@virtuozzo.com>
 <20191008113932.18eb4c1d@bahia.lan>
 <7567d46b-f51c-d459-fd54-7841637d0666@virtuozzo.com>
In-Reply-To: <7567d46b-f51c-d459-fd54-7841637d0666@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191009114538151
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e21404d5-7165-4e7b-30cc-08d74c951170
x-ms-traffictypediagnostic: DB8PR08MB5052:
x-microsoft-antispam-prvs: <DB8PR08MB5052255F54F0111DED585CEAC1950@DB8PR08MB5052.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39840400004)(199004)(189003)(53754006)(86362001)(102836004)(66476007)(6246003)(99286004)(64756008)(66556008)(66446008)(71190400001)(71200400001)(76176011)(6506007)(386003)(66946007)(305945005)(229853002)(54906003)(5660300002)(316002)(52116002)(36756003)(7736002)(2906002)(66066001)(4326008)(7406005)(478600001)(6116002)(25786009)(7416002)(3846002)(6486002)(14454004)(6436002)(561944003)(6512007)(31686004)(8936002)(256004)(81156014)(186003)(81166006)(26005)(31696002)(486006)(6916009)(8676002)(446003)(2616005)(476003)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5052;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjGgyMRDFF9Rs1r4S/5rLfQAurSJvEu4kRDhZOK2eXVEann7VBar7tT7mSgbLB97V1ygqARDCe7zqdKoyVsz9mAqEWj2HQLr+cJ2FtunuZ7MwxHyIKHOE1c7qnsXeS0TpoG9ncPwlqgB0t53qefzP8J3uHPtjgPt0jO9i2T8YaJIXvmHOcBgmPttR1QValMeafPBxZOwjoqg4dpx/BEu0xv+1PXt4LCfAuoCvY9roiVGVPqFYIOT63IH2UmdypKQgHScPFqj21G1KbVf7dkoAmaSi2o7jdqqjUH87mmvf4m7Jq4c7BP7Y2pjU+rlZKUnWvq/3epzq1/s8CChxBpv5p3+VnGCwedXP6oX95L5ftQNWxTMTYbOZ1yJQZh/jrFu8F0ozdjj4XBVEdORpSejqbsmGWX8Fyb/lIv8eDQ7AHc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <11210B3B7115F446AE22F7B9D2F87160@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21404d5-7165-4e7b-30cc-08d74c951170
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 08:45:42.6210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ie6Z4o/4Zdibe9zJzlOUOD4lq0bwUVqZL4y0xUP+CPb/AKKLgypU3Vng8PWtK9gW52M3t09dt625v+xBSvWoy5si+p/E0yQG00XhXbbm3/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5052
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.91
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
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTAuMjAxOSAxMzowOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDguMTAuMjAxOSAxMjozOSwgR3JlZyBLdXJ6IHdyb3RlOg0KPj4gT24gVHVlLCA4IE9jdCAyMDE5
IDA4OjQxOjA4ICswMDAwDQo+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPj4NCj4+PiAwOC4xMC4yMDE5IDEwOjMwLCBNYXJr
dXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+Pj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6DQo+Pj4+DQo+Pj4+PiBIaSBhbGwhDQo+
Pj4+Pg0KPj4+Pj4gSGVyZSBpcyBhIHByb3Bvc2FsIG9mIGF1dG8gcHJvcGFnYXRpb24gZm9yIGxv
Y2FsX2VyciwgdG8gbm90IGNhbGwNCj4+Pj4+IGVycm9yX3Byb3BhZ2F0ZSBvbiBldmVyeSBleGl0
IHBvaW50LCB3aGVuIHdlIGRlYWwgd2l0aCBsb2NhbF9lcnIuDQo+Pj4+Pg0KPj4+Pj4gVGhlcmUg
YXJlIGFsc28gdHdvIGlzc3VlcyB3aXRoIGVycnA6DQo+Pj4+Pg0KPj4+Pj4gMS4gZXJyb3JfZmF0
YWwgJiBlcnJvcl9hcHBlbmRfaGludC9lcnJvcl9wcmVwZW5kOiB1c2VyIGNhbid0IHNlZSB0aGlz
DQo+Pj4+PiBhZGRpdGlvbmFsIGluZm8sIGJlY2F1c2UgZXhpdCgpIGhhcHBlbnMgaW4gZXJyb3Jf
c2V0ZyBlYXJsaWVyIHRoYW4gaW5mbw0KPj4+Pj4gaXMgYWRkZWQuIFtSZXBvcnRlZCBieSBHcmVn
IEt1cnpdDQo+Pj4+DQo+Pj4+IEhvdyBpcyB0aGlzIHNlcmllcyByZWxhdGVkIHRvIEdyZWcncyAi
W1BBVENIIDAwLzE3XSBGaXggdXNhZ2Ugb2YNCj4+Pj4gZXJyb3JfYXBwZW5kX2hpbnQoKSI/wqAg
RG8gd2UgbmVlZCBib3RoPw0KPj4+DQo+Pj4gVGhlc2Ugc2VyaWVzIGlzIGEgc3Vic3RpdHV0aW9u
IGZvciBHcmVnJ3MuIFN0aWxsLCB0aGVyZSBhcmUgcHJvYmxlbXMgd2l0aA0KPj4+IGF1dG9tYXRp
b24sIHdoaWNoIEdyZWcgcG9pbnRlZCBpbiAyMS8zMSwgYW5kIEkgZG9uJ3Qga25vdyB3aGF0IHRv
IGRvIG5leHQuDQo+Pj4NCj4+PiBNYXkgYmUsIGp1c3QgY29udGludWUgdG8gcmV2aWV3IHBhdGNo
ZXMgYW5kIGZpeCB0aGVtIGJ5IGhhbmQuIE1heSBiZSB0cnkgdG8NCj4+PiBpbXByb3ZlIGF1dG9t
YXRpb24uLi4NCj4+Pg0KPj4NCj4+IFRoZSBmZWVsaW5nIEkgaGF2ZSBhZnRlciB3b3JraW5nIG9u
IG15IHNlcmllcyBpcyB0aGF0IHRoZSBsaW5lcyB0aGF0IGRlYWwNCj4+IHdpdGggZXJyb3JzIGFy
ZSBtaXhlZCB1cCB3aXRoIHRoZSBmdW5jdGlvbmFsIGNvZGUgaW4gYSB2YXJpZXR5IG9mIHdheXMu
DQo+PiBUaGF0IG1ha2VzIGl0IHZlcnkgZGlmZmljdWx0IGlmIG5vdCBpbXBvc3NpYmxlIHRvIGNv
bWUgd2l0aCBjb2RlIHBhdHRlcm5zDQo+PiBzdWl0YWJsZSBmb3IgYSAxMDAlIGF1dG9tYXRlZCBz
b2x1dGlvbiBJTUhPLg0KPj4NCj4+IE15IHF1ZXN0aW9uaW5nIGlzIG1vcmUgYXJvdW5kIHRoZSBz
ZW1hbnRpY3Mgb2YgZXJyb3JfZmF0YWwgYWN0dWFsbHkuIFdoYXQNCj4+IGRvZXMgcGFzc2luZyAm
ZXJyb3JfZmF0YWwgZ2l2ZXMgdXMgb3ZlciBwYXNzaW5nICZsb2NhbF9lcnIgYW5kIGNhbGxpbmcN
Cj4+IGVycm9yX3JlcG9ydF9lcnIoKStleGl0KCksIGFwYXJ0IGZyb20gYnJlYWtpbmcgZXJyb3Jf
YXBwZW5kX2hpbnQoKSBhbmQNCj4+IGVycm9yX3ByZXBlbmQoKSA/DQo+IA0KPiBBcyBJIHVuZGVy
c3RhbmQsIHRoZSBvbmx5IGJlbmVmaXQgaXMgb25lIGxpbmUgaW5zdGVhZCBvZiBmb3VyOg0KPiAN
Cj4gZnVuYyguLi4sICZlcnJvcl9mYXRhbCk7DQo+IA0KPiBpbnN0ZWFkIG9mDQo+IA0KPiBmdW5j
KC4uLiwgJmxvY2FsX2Vycik7DQo+IGlmIChsb2NhbF9lcnIpIHsNCj4gIMKgwqDCoCBleGl0KDEp
Ow0KPiB9DQo+IA0KPiBCdXQsIGtlZXBpbmcgaW4gbWluZCBhbGwgZGlmZmljdWx0aWVzIGFib3V0
IHRoZXNlIHNlcmllcy4uLiBXZSBjYW4gY29uc2lkZXINCj4gY29udmVyc2lvbiBlcnJvcl9mYXRh
bCAtPiBsb2NhbF9lcnIgdG9vLiBJdCBzZWVtcyBzaW1wbGUgdG8gZG8gd2l0aCBhIGNvY2NpbmVs
bGUNCj4gc2NyaXB0LCBJIGNhbiBzZW5kIGFub3RoZXIgYXV0b21hdGljIHNlcmllcyB0byBsb29r
IGF0IGl0Lg0KPiANCj4gDQo+IEhtbSwgc29tZSBpZGVhcyBhcm91bmQgdGhpczoNCj4gDQo+IDEu
IFdlIGNhbiBnZW5lcmF0ZSBfZmF0YWwgdmVyc2lvbnMgb2YgZnVuY3Rpb25zIGJ5IHB5dGhvbiBz
Y3JpcHQgKHdlJ2xsIGNhbGwgaXQgZnJvbSBNYWtlZmlsZSwgd2UgaGF2ZSBhIGxvdCBvZiBnZW5l
cmF0ZWQgY29kZSBhbnl3YXkpLg0KPiANCj4gYW5kIGNvbnZlcnQNCj4gZnVuYyguLi4sICZsb2Nh
bF9lcnIpOyB0bw0KPiANCj4gZnVuY19mYXRhbCguLi4pOw0KPiANCj4gMi4gVXNlIG1hY3JvIGxp
a2UNCj4gDQo+ICNkZWZpbmUgRkFUQUwoZnVuYywgLi4uKSBkbyB7IEVycm9yICpfX2ZhdGFsX2Vy
ciA9IE5VTEw7IGZ1bmMoX19WQV9BUkdTX18gX19WQV9PUFQoLCksICZfX2ZhdGFsX2Vycik7IGlm
IChfX2ZhdGFsX2VycikgeyBlcnJvcl9yZXBvcnQoX19mYXRhbF9lcnIpOyBleGl0KDEpOyB9IH0g
d2hpbGUgKDApDQo+IA0KPiBhbmQgY29udmVydA0KPiBmdW5jKC4uLiwgJmxvY2FsX2Vycik7IHRv
DQo+IA0KPiBGQVRBTChmdW5jLCAuLi4pOw0KDQpOb3csIEkgdGhpbmssIHRoYXQgd2hhdCB0aGVz
ZSBzZXJpZXMgZG8gaXMgYmV0dGVyLCBhcw0KZnVuYyguLi4sICZmYXRhbF9lcnIpIGFuZCBvbmUg
bWFjcm8gaW52b2NhdGlvbiBhdCBmdW5jdGlvbiBzdGFydA0KaXMgYmV0dGVyIHRoYW4gdG9vIG1h
bnkgZ2VuZXJhdGVkIGZ1bmN0aW9ucy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

