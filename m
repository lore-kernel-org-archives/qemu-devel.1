Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5C9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 22:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E11206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 22:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tDqntz+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E11206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idM9j-0007Bi-UX
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 17:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idM8A-0006Ls-4t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 17:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idM88-0001p2-Kc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 17:31:21 -0500
Received: from mail-eopbgr20090.outbound.protection.outlook.com
 ([40.107.2.90]:26436 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idM83-00018q-0o; Fri, 06 Dec 2019 17:31:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7x8mvGSs4i9qHbjycRHXKS5fv/CP3GeUYyqId9pcNo0w7GFUw9xThfzzpcrjJQqVZPxuc0nn3KlTB/X1f0TdPuk+ob/W9NADxlFhWuYncH1ElcEM/1VdfoPxyEPE76IgrqJRY1onhw9Gy+nYn6d1FVba6XfbQkRN6tNo6cpqZkM2bhNTpMOrwQ4waPjHDAGqjLkY2umbjT45ziRRyoVq4o9C7ciS5shm69cvFJBVerFS148IqvENMkkExM6GajbsL0z8fd3WrrgnTl1TfZbaKXy0GxdKzvz7utc3FT6tuGjN0GIE2IeB7R7VAy8Z+SpXeo/O9QO6lbGBsuX0pq0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LL6h6U+YKIIiL4/m6ybu1Da1zTZ9hUd8tr5fjU0yoQ=;
 b=AW9lxVujne6LmS6H0Sy8E+NwxG/4WhfkVMySKTPl4j2vEwZOmq9fTHODTBgiQPv3kcOzsz9jg7EchGw7nR0K0iy6sLdEBiKGlJ8kDYg5No2DdBfB68VzkkSGtwzXPm6l1uDpNRLlBPldGdqcrvew6QDVeMMJCW6XS3ItShwnpHQLOvZrMYjXGJ7NJNa364FObh/m/1PVcoapfTzZmzztu4lcts5jUMzXZEzic0NMrrDSOMhEPNvVdY14xCIRLVimLPCknk3QbBKBjHq+tNyj90fdRj7YFuCc7h/TK7B7h3diTmp1Hg6EfwmU+LEmdbdqrIxU95Ndm/MXMNDj2YGKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LL6h6U+YKIIiL4/m6ybu1Da1zTZ9hUd8tr5fjU0yoQ=;
 b=tDqntz+fV7nt+D0hDR8kyjGQT9fJDW53qFWaFuq7iPOQaWorlHooAFXX+Mq/adgDLoi6jRiQ8Rxgc3ggGsLE1fFJQU10Hs47HuxQ9MT/x8FRVL9YjJCBbO3nqNzYzkbG8CmlxUyBqoj7fpzUg1z6EcqkfRsk5cwDa9Twbcgsn5w=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4642.eurprd08.prod.outlook.com (10.255.22.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 6 Dec 2019 22:31:11 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 22:31:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2] migration/dirty-bitmaps: change bitmap enumeration
 method
Thread-Topic: [PATCH v2] migration/dirty-bitmaps: change bitmap enumeration
 method
Thread-Index: AQHVCpJiO5csnRf0D0OxXxQO3Uu316eu9JAA
Date: Fri, 6 Dec 2019 22:31:11 +0000
Message-ID: <aab4e1c7-37eb-5b3e-26d2-fca33ba87662@virtuozzo.com>
References: <20190514201926.10407-1-jsnow@redhat.com>
In-Reply-To: <20190514201926.10407-1-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0081.eurprd07.prod.outlook.com
 (2603:10a6:3:64::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191207013108646
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab1e41c1-719a-4189-9024-08d77a9bfed3
x-ms-traffictypediagnostic: AM6PR08MB4642:
x-microsoft-antispam-prvs: <AM6PR08MB4642F655126539471B4B3343C15F0@AM6PR08MB4642.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39850400004)(396003)(346002)(366004)(189003)(199004)(8936002)(71190400001)(110136005)(99286004)(66446008)(66556008)(66476007)(31696002)(316002)(86362001)(66946007)(64756008)(305945005)(54906003)(5660300002)(71200400001)(4326008)(52116002)(81156014)(6486002)(81166006)(36756003)(8676002)(31686004)(6512007)(76176011)(2616005)(102836004)(229853002)(478600001)(966005)(6506007)(26005)(2906002)(186003)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4642;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAoVdcMcbMG0IjQSXoJ6wdR78rlIQtxduF6EeRpcWKCSXMbor/0IeH0dwNEsNyZpZt+1+2HGorFjjVsiscKqIRqpCgZo0ktAGL50tdn6JaWmXW6C7GZ9+PWWdFNgj6SiuMcNK9UgFyqCEgA+jFAzLuX7jDnf78Tvbyl/CRe5vA2YdxD9m0BFVybXHxOqYtc9DarvpRNZc9qIBy6+aqtNxdYBvvVIPsKziaZvKlZwAT1/rOlLnHekn3LzqdPkPEP4tGDAVy8h1GSJ8QVyk0zAWFBjcvmmyuW3seXhMN5WjhSjMpnslZAWkqGOEg1ygOCy7/Fvvz6AuBrQlXfwa7PxVQ5DkynMQz2Ldde/Sq43Df22UVb5x0bwMilJUCm5BIbXarkXyDPKYbByaSkFQZRc67EzplK5fGhLvjU9ETYSIDfvT4rvoMY3zeblbix06k6JXnELpoLxbnsCGvCxv3deRLU0BtmHACM6F7woQ/5DdE/CkzEKrClGW4opyitzGUzQdRFk1MW6EiWN7DknqlC3zA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7063E9C597F6042887782F2FFD628CE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1e41c1-719a-4189-9024-08d77a9bfed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 22:31:11.1431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1NJ/XbpnzLr4CJYqM750QWnC7G5i29X6+l3NIcia+4zfW5G0xbzR4GOJAfkyoIau+FSxuIHVS/+qHG6GL+yjVgKkCnIyqZFcTqPk7gzKfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4642
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.90
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 aihua liang <aliang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDUuMjAxOSAyMzoxOSwgSm9obiBTbm93IHdyb3RlOg0KPiBTaGlmdCBmcm9tIGxvb2tpbmcg
YXQgZXZlcnkgcm9vdCBCRFMgdG8gKmV2ZXJ5KiBCRFMuIFRoaXMgd2lsbCBtaWdyYXRlDQo+IGJp
dG1hcHMgdGhhdCBhcmUgYXR0YWNoZWQgdG8gYmxvY2tkZXYgY3JlYXRlZCBub2RlcyBpbnN0ZWFk
IG9mIGp1c3Qgb25lcw0KPiBhdHRhY2hlZCB0byBlbXVsYXRlZCBzdG9yYWdlIGRldmljZXMuDQo+
IA0KPiBOb3RlIHRoYXQgdGhpcyB3aWxsIG5vdCBtaWdyYXRlIGFub255bW91cyBvciBpbnRlcm5h
bC11c2UgYml0bWFwcywgYXMNCj4gdGhvc2UgYXJlIGRlZmluZWQgYXMgaGF2aW5nIG5vIG5hbWUu
DQo+IA0KPiBUaGlzIHdpbGwgYWxzbyBmaXggdGhlIENvdmVyaXR5IGlzc3VlcyBQZXRlciBNYXlk
ZWxsIGhhcyBiZWVuIGFza2luZw0KPiBhYm91dCBmb3IgdGhlIHBhc3Qgc2V2ZXJhbCByZWxlYXNl
cywgYXMgd2VsbCBhcyBmaXhpbmcgYSByZWFsIGJ1Zy4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBQZXRl
ciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFJlcG9ydGVkLWJ5OiBDb3Zl
cml0eSDwn5iFDQoNCldoYXQgd2FzIHRoZSBjb3Zlcml0eSBudW1iZXIgKEkgZG9uJ3QgYmVsaWV2
ZSB0aGF0IGl0IHdhcyBzbWlsZTopPw0KDQpEbyBzb21lb25lIGtub3csIHRoYXQgdGhpcyBwYXRj
aCBmaXhlcyB2ZXJ5LXZlcnktdmVyeSB0ZXJyaWJsZSBidWc/DQoNCkJlZm9yZSB0aGlzIHBhdGNo
LCBoZXJlIHdlcmUgYmRydl9uZXh0LWJhc2VkIGxvb3AsIHdpdGggZXhpc3RzIGZyb20gaXQsDQpi
dXQgbm90IHVzaW5nIGJkcnZfbmV4dF9jbGVhbnVwKCkuIFRoaXMgbGVhZHMgdG8gbGVha2VkIChp
bmNyZW1lbnRlZCkgcmVmY250IG9mDQpiZHMgb24gYW55IGZhaWx1cmUgZHVyaW5nIHRoaXMgbG9v
cCENCg0KTm93IHdlIGZhY2VkIHRoaXMgYnVnLCBpbiBSaGVsLWJhc2VkIFFlbXUsIHNvIEkgc3Ry
b25nbHkgcmVjb21tZW5kIHRvIGZpeCBpdCBpbiBSaGVsLg0KDQo+IFJlcG9ydGVkLWJ5OiBhaWh1
YSBsaWFuZyA8YWxpYW5nQHJlZGhhdC5jb20+DQo+IEZpeGVzOiBodHRwczovL2J1Z3ppbGxhLnJl
ZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE2NTI0OTANCj4gRml4ZXM6IENvdmVyaXR5IENJRCAx
MzkwNjI1DQo+IENDOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgbWln
cmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jIHwgMTQgKysrKy0tLS0tLS0tLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9taWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMgYi9taWdyYXRpb24vYmxvY2st
ZGlydHktYml0bWFwLmMNCj4gaW5kZXggZDFiYjg2M2NiNi4uNGE4OTZhMDllYiAxMDA2NDQNCj4g
LS0tIGEvbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+ICsrKyBiL21pZ3JhdGlvbi9i
bG9jay1kaXJ0eS1iaXRtYXAuYw0KPiBAQCAtMjczLDcgKzI3Myw2IEBAIHN0YXRpYyBpbnQgaW5p
dF9kaXJ0eV9iaXRtYXBfbWlncmF0aW9uKHZvaWQpDQo+ICAgICAgIEJsb2NrRHJpdmVyU3RhdGUg
KmJzOw0KPiAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcDsNCj4gICAgICAgRGlydHlCaXRt
YXBNaWdCaXRtYXBTdGF0ZSAqZGJtczsNCj4gLSAgICBCZHJ2TmV4dEl0ZXJhdG9yIGl0Ow0KPiAg
ICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gICANCj4gICAgICAgZGlydHlfYml0bWFw
X21pZ19zdGF0ZS5idWxrX2NvbXBsZXRlZCA9IGZhbHNlOw0KPiBAQCAtMjgxLDEzICsyODAsOCBA
QCBzdGF0aWMgaW50IGluaXRfZGlydHlfYml0bWFwX21pZ3JhdGlvbih2b2lkKQ0KPiAgICAgICBk
aXJ0eV9iaXRtYXBfbWlnX3N0YXRlLnByZXZfYml0bWFwID0gTlVMTDsNCj4gICAgICAgZGlydHlf
Yml0bWFwX21pZ19zdGF0ZS5ub19iaXRtYXBzID0gZmFsc2U7DQo+ICAgDQo+IC0gICAgZm9yIChi
cyA9IGJkcnZfZmlyc3QoJml0KTsgYnM7IGJzID0gYmRydl9uZXh0KCZpdCkpIHsNCj4gLSAgICAg
ICAgY29uc3QgY2hhciAqZHJpdmVfbmFtZSA9IGJkcnZfZ2V0X2RldmljZV9vcl9ub2RlX25hbWUo
YnMpOw0KPiAtDQo+IC0gICAgICAgIC8qIHNraXAgYXV0b21hdGljYWxseSBpbnNlcnRlZCBub2Rl
cyAqLw0KPiAtICAgICAgICB3aGlsZSAoYnMgJiYgYnMtPmRydiAmJiBicy0+aW1wbGljaXQpIHsN
Cj4gLSAgICAgICAgICAgIGJzID0gYmFja2luZ19icyhicyk7DQo+IC0gICAgICAgIH0NCj4gKyAg
ICBmb3IgKGJzID0gYmRydl9uZXh0X2FsbF9zdGF0ZXMoTlVMTCk7IGJzOyBicyA9IGJkcnZfbmV4
dF9hbGxfc3RhdGVzKGJzKSkgew0KPiArICAgICAgICBjb25zdCBjaGFyICpuYW1lID0gYmRydl9n
ZXRfZGV2aWNlX29yX25vZGVfbmFtZShicyk7DQo+ICAgDQo+ICAgICAgICAgICBmb3IgKGJpdG1h
cCA9IGJkcnZfZGlydHlfYml0bWFwX25leHQoYnMsIE5VTEwpOyBiaXRtYXA7DQo+ICAgICAgICAg
ICAgICAgIGJpdG1hcCA9IGJkcnZfZGlydHlfYml0bWFwX25leHQoYnMsIGJpdG1hcCkpDQo+IEBA
IC0yOTYsNyArMjkwLDcgQEAgc3RhdGljIGludCBpbml0X2RpcnR5X2JpdG1hcF9taWdyYXRpb24o
dm9pZCkNCj4gICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICAgICAgICAgICAgICAgfQ0K
PiAgIA0KPiAtICAgICAgICAgICAgaWYgKGRyaXZlX25hbWUgPT0gTlVMTCkgew0KPiArICAgICAg
ICAgICAgaWYgKCFuYW1lIHx8IHN0cmNtcChuYW1lLCAiIikgPT0gMCkgew0KPiAgICAgICAgICAg
ICAgICAgICBlcnJvcl9yZXBvcnQoIkZvdW5kIGJpdG1hcCAnJXMnIGluIHVubmFtZWQgbm9kZSAl
cC4gSXQgY2FuJ3QgIg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImJlIG1pZ3Jh
dGVkIiwgYmRydl9kaXJ0eV9iaXRtYXBfbmFtZShiaXRtYXApLCBicyk7DQo+ICAgICAgICAgICAg
ICAgICAgIGdvdG8gZmFpbDsNCj4gQEAgLTMxMyw3ICszMDcsNyBAQCBzdGF0aWMgaW50IGluaXRf
ZGlydHlfYml0bWFwX21pZ3JhdGlvbih2b2lkKQ0KPiAgIA0KPiAgICAgICAgICAgICAgIGRibXMg
PSBnX25ldzAoRGlydHlCaXRtYXBNaWdCaXRtYXBTdGF0ZSwgMSk7DQo+ICAgICAgICAgICAgICAg
ZGJtcy0+YnMgPSBiczsNCj4gLSAgICAgICAgICAgIGRibXMtPm5vZGVfbmFtZSA9IGRyaXZlX25h
bWU7DQo+ICsgICAgICAgICAgICBkYm1zLT5ub2RlX25hbWUgPSBuYW1lOw0KPiAgICAgICAgICAg
ICAgIGRibXMtPmJpdG1hcCA9IGJpdG1hcDsNCj4gICAgICAgICAgICAgICBkYm1zLT50b3RhbF9z
ZWN0b3JzID0gYmRydl9uYl9zZWN0b3JzKGJzKTsNCj4gICAgICAgICAgICAgICBkYm1zLT5zZWN0
b3JzX3Blcl9jaHVuayA9IENIVU5LX1NJWkUgKiA4ICoNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

