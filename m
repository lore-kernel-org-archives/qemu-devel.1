Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C94C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC756208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t912Q5jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC756208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iah2s-0002gE-R9
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iagzP-0008K8-MN
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iagzM-0004GY-2s
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:11:17 -0500
Received: from mail-eopbgr40106.outbound.protection.outlook.com
 ([40.107.4.106]:41863 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iagzK-00041h-BV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:11:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6WRYTTsch8HHaEsLO0ywFZ/KI5U68xdwE8j7IUaEgB6QVaGcaEnScnqM2UWza5BeDuBBksexySHrbOghuiwvD18WhApnPwot6SMK0mySlkQ4kZR4AUfotaxFbR/W+gjY8FiBtbZbu72+aElROsZAYtD1HAV7QoALph7GkvcJAnkYiUehPu1R/1f/8TZ+M2sjBIG4eD42DtK2GQjYPiQzdavgXynjhTJfzb+yGP5jyeihhYlNMgC3JGDTT3nl8XyDHtjrrfR2Yg0MMhhD6JSdTPJeZd7pNUErs4XsLA4NR4y7YDQPeT6kOT6Wb9V08DByOBmQvvQmMKIkXbnMX078Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcHWtAUWSFOJMTBUEUQRoMt4VpqoQMtjduSfZzY0i9s=;
 b=L9nWlfQ+Rw6hyDkWrvkGhjiGDCZxc5wc7owO1kZYp3L8Mzi1EjxBYufyXoZRGkxxhrhf41mugZ3VsLRdnKHauL2VQfp3ejNEuEqISAaZ/r8WBSglnkyUR1o7b8R7IfB0v1Cwl+9pJeFJh89vhcXp25UFUz01nsUjFl9hPoJi2Dqo4Um3JoRB9ifY58uzSv4RJ4nByi78CmJ/y4NFo4IiK3LqQo9SX1seALRigKDOYbTG0gnIxwaUBl1+VNNSfIAJ5SNltAKZmcyYBUjUhUxQen5tccnEuEwB8QjrA1154O7F/JTbMS/nLozbQ01012wBHbWqNN5tLBht+KAs3YLKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcHWtAUWSFOJMTBUEUQRoMt4VpqoQMtjduSfZzY0i9s=;
 b=t912Q5jbKjj9AZXRK7x9u4Wfi7qe3XTkCH0rBQfAa7dSScMVlPqykNWrIB5LPKlo7CUy3Lrkiy+Nif8ZdpYP0LV4Cr/zlQ0gr5SD+EXj4+8cVNJWprE53ZdaQWh71XcrwLP3A+ow4wgtxXSK8VasLlasvyvScqToEJpSVNLojpk=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3400.eurprd08.prod.outlook.com (20.177.112.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 14:11:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 14:11:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] hw/core/loader-fit: fix freeing errp in fit_load_fdt
Thread-Topic: [PATCH v6] hw/core/loader-fit: fix freeing errp in fit_load_fdt
Thread-Index: AQHVpVDHCu/hcnUjHUWYtvuOQu9NH6eiMNjUgAACNYA=
Date: Fri, 29 Nov 2019 14:11:09 +0000
Message-ID: <4fcd8245-790e-220d-366b-ce25743dddc8@virtuozzo.com>
References: <20191127183016.13852-1-vsementsov@virtuozzo.com>
 <87muceeq5l.fsf@dusky.pond.sub.org>
In-Reply-To: <87muceeq5l.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0159.eurprd06.prod.outlook.com
 (2603:10a6:7:16::46) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129171107062
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eddf5e3c-6bff-4970-cfcc-08d774d5fb8b
x-ms-traffictypediagnostic: AM6PR08MB3400:
x-microsoft-antispam-prvs: <AM6PR08MB3400668397E55287FCABE3EBC1460@AM6PR08MB3400.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39840400004)(199004)(189003)(66556008)(66476007)(66446008)(66946007)(31686004)(14444005)(81166006)(81156014)(8676002)(8936002)(256004)(25786009)(99286004)(64756008)(6116002)(3846002)(5660300002)(14454004)(478600001)(66066001)(2906002)(386003)(6506007)(7736002)(102836004)(86362001)(6512007)(36756003)(26005)(76176011)(186003)(4326008)(52116002)(6246003)(6916009)(305945005)(2616005)(6486002)(31696002)(54906003)(11346002)(446003)(71200400001)(71190400001)(229853002)(6436002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3400;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +1NF3SdkRRubFpbkFZNHP3XbjAQ7pdOCD20cQppwpDil0BQHqSc56ojWDSnvLQ4VObANT0MdyR0iQygGm0WKeAVVYyfPdHNB4jae6Ts5EhPlTQ/gi2p/hQHXBr0gzO1JCh6vLYQowR8zh+ULHo2M/KsYJxVDVtK+yepNhe90ADO2A0HBhIx/y8H+80aW2NhwTG7G70LTfgYQC7jWH51EBihBH5Lc8P3L9hh+TzAVA+bbxaAG4PnHgCqMEmdG6nfYPVqQIIuCJRDNFWylU2RqQfqFun7dVmN/sO8L5hGOAJgEjVT+q02oY/Z1GGlX6aDQesUPNsDWwYNkcfQiv7FXFNP4a20q8i5RkU/8rvpt2uNXbi4TKh7hZAYvIaAhyNL/rxZICq2XOcipiuBOWbaYM61IwvHBlIqcd2auwea1HUpm7mJYwhJmtQnM9AraaylH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <944C18B5E36BC44C891E8E7109F382C1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddf5e3c-6bff-4970-cfcc-08d774d5fb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 14:11:09.4663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u3R3nO6fPFD0EJkc7NIbLaaDPHhX4gd/iPS5qYQwHtZkHiEPyo/tsNLkI4gsogbo9jKaGG/7kdDqncOt/lwS7hnp2Xb4ViZEPL+yzobceHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3400
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.106
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSAxNzowMywgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IGZpdF9sb2FkX2ZkdCBmb3JnZXQgdG8gY2hlY2sgdGhhdCBlcnJwIGlzIG5vdCBOVUxMIGFu
ZCB0byB6ZXJvIGl0IGFmdGVyDQo+PiBmcmVlaW5nLiBGaXggaXQuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KPj4gUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4g
LS0tDQo+PiAgIGh3L2NvcmUvbG9hZGVyLWZpdC5jIHwgNSArKysrLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L2NvcmUvbG9hZGVyLWZpdC5jIGIvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+IGluZGV4IDk1
M2IxNmJjODIuLjNlZTlmYjJmMmUgMTAwNjQ0DQo+PiAtLS0gYS9ody9jb3JlL2xvYWRlci1maXQu
Yw0KPj4gKysrIGIvaHcvY29yZS9sb2FkZXItZml0LmMNCj4+IEBAIC0yMDAsNyArMjAwLDEwIEBA
IHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNv
bnN0IHZvaWQgKml0YiwNCj4+ICAgICAgIGVyciA9IGZpdF9pbWFnZV9hZGRyKGl0YiwgaW1nX29m
ZiwgImxvYWQiLCAmbG9hZF9hZGRyLCBlcnJwKTsNCj4+ICAgICAgIGlmIChlcnIgPT0gLUVOT0VO
VCkgew0KPj4gICAgICAgICAgIGxvYWRfYWRkciA9IFJPVU5EX1VQKGtlcm5lbF9lbmQsIDY0ICog
S2lCKSArICgxMCAqIE1pQik7DQo+PiAtICAgICAgICBlcnJvcl9mcmVlKCplcnJwKTsNCj4+ICsg
ICAgICAgIGlmIChlcnJwKSB7DQo+PiArICAgICAgICAgICAgZXJyb3JfZnJlZSgqZXJycCk7DQo+
PiArICAgICAgICAgICAgKmVycnAgPSBOVUxMOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICAgfSBl
bHNlIGlmIChlcnIpIHsNCj4+ICAgICAgICAgICBlcnJvcl9wcmVwZW5kKGVycnAsICJ1bmFibGUg
dG8gcmVhZCBGRFQgbG9hZCBhZGRyZXNzIGZyb20gRklUOiAiKTsNCj4+ICAgICAgICAgICByZXQg
PSBlcnI7DQo+IA0KPiBUaGlzIGZpeGVzIGxhdGVudCBidWdzIHdoZW4gZml0X2ltYWdlX2FkZHIo
KSBmYWlscyB3aXRoIEVOT0VOVDoNCj4gDQo+ICogSWYgYSBjYWxsZXIgcGFzc2VzIGEgbnVsbCBA
ZXJycCwgd2UgY3Jhc2ggZGVyZWZlcmVuY2luZyBpdA0KPiANCj4gKiBFbHNlLCB3ZSBwYXNzIGEg
ZGFuZ2xpbmcgRXJyb3IgKiB0byB0aGUgY2FsbGVyLCBhbmQgcmV0dXJuIHN1Y2Nlc3MuDQo+ICAg
IElmIGEgY2FsbGVyIGRlcmVmZXJlbmNlcyB0aGUgRXJyb3IgKiByZWdhcmRsZXNzLCB3ZSBoYXZl
IGENCj4gICAgdXNlLWFmdGVyLWZyZWUuDQo+IA0KPiBOb3QgZml4ZWQ6DQo+IA0KPiAqIElmIGEg
Y2FsbGVyIHBhc3NlcyAmZXJyb3JfYWJvcnQgb3IgJmVycm9yX2ZhdGFsLCB3ZSBkaWUgaW5zdGVh
ZCBvZg0KPiAgICB0YWtpbmcgdGhlIHJlY292ZXJ5IHBhdGguDQoNCk5vLCBpZiBpdCBpcyBlcnJv
cl9hYm9ydCBvciBlcnJvcl9mYXRhbCwgd2Ugd2lsbCBub3QgcmVhY2ggdGhpcyBwb2ludCwgdGhl
IGV4ZWN1dGlvbg0KZmluaXNoZWQgYmVmb3JlLCB3aGVuIGVycm9yIHdhcyBzZXQuDQoNCj4gDQo+
IFdlIG5lZWQgdG8gdXNlIGEgbG9jYWxfZXJyIGhlcmUuDQo+IA0KPiBJJ2xsIHNlYXJjaCBmb3Ig
dGhlIHBhdHRlcm4sIGFuZCBwb3N0IGZpeChlcykuDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

