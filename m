Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EFECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5D8206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ITJTfD3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5D8206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIx2p-0008Uw-3n
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIwul-0006JD-Nf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIwuk-00082D-D9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:33:11 -0400
Received: from mail-eopbgr50125.outbound.protection.outlook.com
 ([40.107.5.125]:42318 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIwug-00081C-LF; Fri, 11 Oct 2019 11:33:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJj1d+X9FDWQbDEVFv1P7tYoZEnD2tI4rvU4sFyEy8XFxWaL1fsQCZd+C8LjzbgN92J2t3sVn3bytWz7lmOVJOc4qaO2X+eQGw25sOLhBwOc8eyQGJEUH2kITxoD0e1DQa21/KJ4q060D82ILXrj+WyQS0tskwTWk/gp97w/hdKm4CSMd3PM/M5pcaf5gVyyzBwp4lnzBlOecDNuq6kdd1b6eVYH18beba7hNkJZInpRkapFyZtyn4YvTEqOzqydsEaSEAOHuVVw0tQ4Dpq2MmXo42zi5vhAlxrzffksugwNh+earnzZI31tljyarxawhMZMB6QmJHL9+xXnoyYUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQM5je+rc6BplBnPZvBeuua9j9Eh5EE8pwJLW85UYGc=;
 b=AKcurKiij98CJ+qLcZ8Frui2/I0fT7mQbIsdFaRFV36eR6JAXJdvfm0FcSQMkqTN+1ihVXO8N7FtuwSTyv4qvosHPFuz5FO+BMYyYdtGWPeM5pdfuDdiXaEFpg9uC/0PEzTpVPApwTk2mvaHDdPEwKWlLTTVwLLjVD+NzZOfOyBZL5sm/gbef+sd4Awq82nyF835JAi2mm9+aJQ2yEVm6bHLAqUw0KAD8vc7heujkwVD1CvMgIO9w2hyV/kCLXLBv2OIo8q0r0F3juJHyK39do0y99MCly4s3gkxj6fNmHJUMA8ar0MT8nSyg/7pgQwSVzuvQmnzcGxRCpCOu0L9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQM5je+rc6BplBnPZvBeuua9j9Eh5EE8pwJLW85UYGc=;
 b=ITJTfD3f5MZCd+4+AxgGvEqalz1qVZAmDZaUwA7WpSCU0UNFQuJl9TuAB20HhNVsLKwoz5jNHxJ7FbUMH+2dZG59FdIOGuSb3yNCaMeKgAu9cGpvwiQfOcb8GwpMYYr1We/CcnrWmZamF00Xe85aGAGKNODQ/6JHGl7uiZ58xhM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5082.eurprd08.prod.outlook.com (10.255.19.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 11 Oct 2019 15:33:03 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Fri, 11 Oct 2019
 15:33:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 07/31] s390: Fix error_append_hint/error_prepend usage
Thread-Topic: [PATCH v4 07/31] s390: Fix error_append_hint/error_prepend usage
Thread-Index: AQHVeHBiSfEtrNXHwkCkx8xBheQbt6dR+WJtgAOoEAA=
Date: Fri, 11 Oct 2019 15:33:03 +0000
Message-ID: <d43cd773-6383-8edb-c203-06f0ae031d2a@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-8-vsementsov@virtuozzo.com>
 <87muea9xg6.fsf@dusky.pond.sub.org>
In-Reply-To: <87muea9xg6.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0150.eurprd06.prod.outlook.com
 (2603:10a6:7:16::37) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191011183300326
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db38687c-b842-4bf0-844e-08d74e604dfe
x-ms-traffictypediagnostic: DB8PR08MB5082:
x-microsoft-antispam-prvs: <DB8PR08MB5082A7467294E88EDAD29394C1970@DB8PR08MB5082.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39840400004)(376002)(136003)(189003)(199004)(6436002)(386003)(186003)(26005)(31686004)(305945005)(99286004)(6506007)(229853002)(7736002)(66946007)(102836004)(66066001)(66446008)(66476007)(66556008)(64756008)(52116002)(71200400001)(14454004)(76176011)(31696002)(6486002)(71190400001)(36756003)(8676002)(256004)(6246003)(81156014)(2906002)(54906003)(8936002)(81166006)(316002)(6916009)(4326008)(3846002)(86362001)(7416002)(478600001)(476003)(486006)(446003)(11346002)(2616005)(6116002)(25786009)(5660300002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5082;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JdlScW3rhMrcF0/IaCcrEGaSWEidqr8yPSlAP27riYypyvkIQPZmD/CRbOMJr8MNtiVKQNWCvOEZHVJ1G5K+7MJ7xFEK1VeRgkZ6sNeZDBZo1UXGyvLS22uhpyjEhAENBHg078C5aF+U/YTiyO26DD6kOWOQchltU3R/R7KZrfgPSK2qSk2KKpohlVtE1WxHRY9GbdkPdrp5jbhOGlQKj58g/+g0f5a8ySpIce8sOEHDaPwEFgc9TLKHveNHMc2GBgaFfrT72ZChQpoyiY7NfXDISax2CkvudpB1N0jCRJeBYe8dtcLBg+h9jZJPliHGRdmtZzZ5C/lNOvsHrF0MgNMDq552dYkSNVICYicHzrjltNTe2uOdJBeH1TCUv3ZEb3X0/cIU53qXgWwcABfzsp6MDtLBEuQ4e8XJU5ngQbs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBA9F6C04E28A14FB482C7B2CD58D714@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db38687c-b842-4bf0-844e-08d74e604dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 15:33:03.1399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nv65KB8VlQ9G/S0hToj99bBK0WLLae2DxiOrUi/jzDewWjVuIxHenxroZhhwvkJ8kN/8nxZYWLQktrH+61/qjO+lX4dW97qjBSkb+uqcKJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5082
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.125
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
Cc: Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMTAuMjAxOSAxMDo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IElmIHdlIHdhbnQgdG8gYWRkIHNvbWUgaW5mbyB0byBlcnJwIChieSBlcnJvcl9wcmVwZW5k
KCkgb3INCj4+IGVycm9yX2FwcGVuZF9oaW50KCkpLCB3ZSBtdXN0IHVzZSB0aGUgRVJSUF9BVVRP
X1BST1BBR0FURSBtYWNyby4NCj4+IE90aGVyd2lzZSwgdGhpcyBpbmZvIHdpbGwgbm90IGJlIGFk
ZGVkIHdoZW4gZXJycCA9PSAmZmF0YWxfZXJyDQo+PiAodGhlIHByb2dyYW0gd2lsbCBleGl0IHBy
aW9yIHRvIHRoZSBlcnJvcl9hcHBlbmRfaGludCgpIG9yDQo+PiBlcnJvcl9wcmVwZW5kKCkgY2Fs
bCkuICBGaXggc3VjaCBjYXNlcy4NCj4+DQo+PiBUaGlzIGNvbW1pdCAodG9nZXRoZXIgd2l0aCBp
dHMgbmVpZ2hib3JzKSB3YXMgZ2VuZXJhdGVkIGJ5DQo+Pg0KPj4gZ2l0IGdyZXAgLWwgJ2Vycm9y
X1woYXBwZW5kX2hpbnRcfHByZXBlbmRcKShlcnJwJyB8IHdoaWxlIHJlYWQgZjsgZG8gXA0KPj4g
c3BhdGNoIC0tc3AtZmlsZSBzY3JpcHRzL2NvY2NpbmVsbGUvZml4LWVycm9yLWFkZC1pbmZvLmNv
Y2NpIFwNCj4+IC0taW4tcGxhY2UgJGY7IGRvbmUNCj4gDQo+IE1ha2UgdGhhdDoNCj4gDQo+ICAg
ICAgJCBzcGF0Y2ggLS1zcC1maWxlIHNjcmlwdHMvY29jY2luZWxsZS9maXgtZXJyb3ItYWRkLWlu
Zm8uY29jY2kgLS1tYWNyby1maWxlIHNjcmlwdHMvY29jY2ktbWFjcm8tZmlsZS5oIC0taW4tcGxh
Y2UgLS1uby1zaG93LWRpZmYgYGdpdCBncmVwIC1sICdlcnJvcl9cKGFwcGVuZF9oaW50XHxwcmVw
ZW5kXCkoZXJycCcgXCouW2NoXWANCj4gDQo+IEFkZGluZyAtLW1hY3JvLWZpbGUgaXMgZXNzZW50
aWFsLCBhcyBFcmljIG5vdGVkLiAgV2l0aG91dCBpdCwgd2UgbWlzcw0KPiBxY293Ml9zdG9yZV9w
ZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoKSBpbiBQQVRDSCAyMyBhbmQNCj4gbmJkX25lZ290aWF0
ZV9zZW5kX3JlcF92ZXJyKCkgaW4gUEFUQ0ggMjkuICBUaGVyZSBzaG91bGQgYmUgYSB3YXkgdG8N
Cj4gbWFrZSBzcGF0Y2ggd2FybiB3aGVuIGl0IGdpdmVzIHVwIHBhcnNpbmcsIGJ1dCBJIGNhbid0
IGZpbmQgaXQgcmlnaHQNCj4gbm93Lg0KPiANCj4gQXZvaWRpbmcgdGhlIGxvb3AgaXMganVzdCBm
b3Igc3BlZWQgYW5kIHNpbXBsaWNpdHkuDQoNClNlZW1zIHdpdGhvdXQgbG9vcCBpdCBoYW5ncyBv
ciBhdCBsZWFzdCB3b3JrcyBzbG93ZXIuIEFuZCBsb29wIHByb3ZpZGVzIGEga2luZCBvZiBwcm9n
cmVzcywgc28gSSdsbCBrZWVwIHRoZSBsb29wLg0KDQo+IA0KPiAtLW5vLXNob3ctZGlmZiBnb2Vz
IHdlbGwgd2l0aCAtLWluLXBsYWNlLg0KPiANCj4gVGhlIGV2ZW4gc2ltcGxlcg0KPiANCj4gICAg
ICAkIHNwYXRjaCAtLXNwLWZpbGUgc2NyaXB0cy9jb2NjaW5lbGxlL2ZpeC1lcnJvci1hZGQtaW5m
by5jb2NjaSAtLW1hY3JvLWZpbGUgc2NyaXB0cy9jb2NjaS1tYWNyby1maWxlLmggLS1pbi1wbGFj
ZSAtLW5vLXNob3ctZGlmZiAtLXVzZS1naXRncmVwDQo+IA0KPiBtaXNzZXMgaW5jbHVkZS9ibG9j
ay9uYmQuaCdzIG5iZF9yZWFkKCkgaW4gUEFUQ0ggMjMgc29tZWhvdy4NCj4gDQo+IEkgcmVjb21t
ZW5kIHRvIGFkZCB0aGUgc3BhdGNoIGludm9jYXRpb24gdG8gdGhlIGNvY2NpbmVsbGUgc2NyaXB0
J3MNCj4gY29tbWl0IG1lc3NhZ2UsIHRvbyBbUEFUQ0ggMDVdLg0KPiANCj4gWy4uLl0NCj4gDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

