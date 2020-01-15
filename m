Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CBC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 02:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FAAC222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 02:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAAC222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irY3s-00087H-Qr
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 21:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1irY3D-0007gR-Dj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 21:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1irY3C-0001cQ-BX
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 21:04:55 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2429 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1irY3C-0001bM-1L
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 21:04:54 -0500
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id D4729E2448E14F5A03A2;
 Wed, 15 Jan 2020 10:04:50 +0800 (CST)
Received: from DGGEMI423-HUB.china.huawei.com (10.1.199.152) by
 dggemi402-hub.china.huawei.com (10.3.17.135) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 10:04:50 +0800
Received: from DGGEMI529-MBX.china.huawei.com ([169.254.6.126]) by
 dggemi423-hub.china.huawei.com ([10.1.199.152]) with mapi id 14.03.0439.000;
 Wed, 15 Jan 2020 10:04:41 +0800
From: fengzhimin <fengzhimin1@huawei.com>
To: Eric Blake <eblake@redhat.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Subject: RE: [PATCH RFC 01/12] migration: Add multiRDMA capability support
Thread-Topic: [PATCH RFC 01/12] migration: Add multiRDMA capability support
Thread-Index: AQHVxqmaVHxXEfJM4USLZDsbao0TcafoSQEAgAK3+PA=
Date: Wed, 15 Jan 2020 02:04:41 +0000
Message-ID: <03C2A65461456D4EBE9E6D4D0D96C583FBC7DE@DGGEMI529-MBX.china.huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-2-fengzhimin1@huawei.com>
 <dddb1f19-381f-ea7e-5200-46f03b1fa0a2@redhat.com>
In-Reply-To: <dddb1f19-381f-ea7e-5200-46f03b1fa0a2@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
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
Cc: "jemmy858585@gmail.com" <jemmy858585@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIGZvciB5b3VyIHJldmlldy4gSSB3aWxsIGZpeCB0aGVzZSBlcnJvcnMgaW4gdGhlIG5l
eHQgdmVyc2lvbihWMikuDQpJIGhvcGUgeW91IGNhbiBidXN5IHNjaGVkdWxlIHRvIGZpbmQgdGlt
ZSB0byBjaGVjayBvdGhlciBwYXRjaGVzIGFib3V0IE11bHRpLVJETUEuDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhhdC5j
b21dIA0KU2VudDogVHVlc2RheSwgSmFudWFyeSAxNCwgMjAyMCAxMjoyNyBBTQ0KVG86IGZlbmd6
aGltaW4gPGZlbmd6aGltaW4xQGh1YXdlaS5jb20+OyBxdWludGVsYUByZWRoYXQuY29tOyBkZ2ls
YmVydEByZWRoYXQuY29tOyBhcm1icnVAcmVkaGF0LmNvbQ0KQ2M6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgWmhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsgamVt
bXk4NTg1ODVAZ21haWwuY29tDQpTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAwMS8xMl0gbWlncmF0
aW9uOiBBZGQgbXVsdGlSRE1BIGNhcGFiaWxpdHkgc3VwcG9ydA0KDQpPbiAxLzgvMjAgMTA6NTkg
UE0sIFpoaW1pbiBGZW5nIHdyb3RlOg0KPiBGcm9tOiBmZW5nemhpbWluIDxmZW5nemhpbWluMUBo
dWF3ZWkuY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTogZmVuZ3poaW1pbiA8ZmVuZ3poaW1pbjFA
aHVhd2VpLmNvbT4NCj4gLS0tDQoNCj4gKysrIGIvcWFwaS9taWdyYXRpb24uanNvbg0KPiBAQCAt
NDIxLDYgKzQyMSw4IEBADQo+ICAgIyBAdmFsaWRhdGUtdXVpZDogU2VuZCB0aGUgVVVJRCBvZiB0
aGUgc291cmNlIHRvIGFsbG93IHRoZSBkZXN0aW5hdGlvbg0KPiAgICMgICAgICAgICAgICAgICAg
IHRvIGVuc3VyZSBpdCBpcyB0aGUgc2FtZS4gKHNpbmNlIDQuMikNCj4gICAjDQo+ICsjIEBtdWx0
aXJkbWE6IFVzZSBtb3JlIHRoYW4gb25lIGNoYW5uZWxzIGZvciByZG1hIG1pZ3JhdGlvbi4gKHNp
bmNlIDQuMikNCg0KV2UndmUgbWlzc2VkIDQuMjsgdGhlIG5leHQgcmVsZWFzZSB3aWxsIGJlIDUu
MC4NCg0KPiArIw0KPiAgICMgU2luY2U6IDEuMg0KPiAgICMjDQo+ICAgeyAnZW51bSc6ICdNaWdy
YXRpb25DYXBhYmlsaXR5JywNCj4gQEAgLTQyOCw3ICs0MzAsNyBAQA0KPiAgICAgICAgICAgICAg
J2NvbXByZXNzJywgJ2V2ZW50cycsICdwb3N0Y29weS1yYW0nLCAneC1jb2xvJywgJ3JlbGVhc2Ut
cmFtJywNCj4gICAgICAgICAgICAgICdibG9jaycsICdyZXR1cm4tcGF0aCcsICdwYXVzZS1iZWZv
cmUtc3dpdGNob3ZlcicsICdtdWx0aWZkJywNCj4gICAgICAgICAgICAgICdkaXJ0eS1iaXRtYXBz
JywgJ3Bvc3Rjb3B5LWJsb2NrdGltZScsICdsYXRlLWJsb2NrLWFjdGl2YXRlJywNCj4gLSAgICAg
ICAgICAgJ3gtaWdub3JlLXNoYXJlZCcsICd2YWxpZGF0ZS11dWlkJyBdIH0NCj4gKyAgICAgICAg
ICAgJ3gtaWdub3JlLXNoYXJlZCcsICd2YWxpZGF0ZS11dWlkJywgJ211bHRpcmRtYScgXSB9DQo+
ICAgDQo+ICAgIyMNCj4gICAjIEBNaWdyYXRpb25DYXBhYmlsaXR5U3RhdHVzOg0KPiANCg0KLS0g
DQpFcmljIEJsYWtlLCBQcmluY2lwYWwgU29mdHdhcmUgRW5naW5lZXINClJlZCBIYXQsIEluYy4g
ICAgICAgICAgICsxLTkxOS0zMDEtMzIyNg0KVmlydHVhbGl6YXRpb246ICBxZW11Lm9yZyB8IGxp
YnZpcnQub3JnDQoNCg==

