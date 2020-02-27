Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A687C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2059424691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2059424691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57701 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HNV-0007wr-8j
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j7HKy-0005Zt-Td
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j7HKx-0003m8-Qj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:28:16 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2452 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j7HKx-0003kN-Fv; Thu, 27 Feb 2020 06:28:15 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 474BDF77525DAC0001BB;
 Thu, 27 Feb 2020 19:28:12 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Feb 2020 19:28:11 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0439.000;
 Thu, 27 Feb 2020 19:28:05 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: RE: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Topic: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Index: AQHV7IFlkw7HklI9YUytmY61YTlYXagstmsAgAGL6HCAABCIAIAAkGkQ
Date: Thu, 27 Feb 2020 11:28:04 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B663B55@dggemm531-mbx.china.huawei.com>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-3-kuhn.chenqun@huawei.com>
 <20200226095444.GB6096@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B6638BE@dggemm531-mbx.china.huawei.com>
 <20200227103054.GB7493@linux.fritz.box>
In-Reply-To: <20200227103054.GB7493@linux.fritz.box>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogS2V2aW4gV29sZiBbbWFpbHRvOmt3
b2xmQHJlZGhhdC5jb21dDQo+U2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI3LCAyMDIwIDY6MzEg
UE0NCj5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPkNjOiBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnOw0KPnBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgWmhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3
ZWkuY29tPjsNCj5FdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT47IFJvbm5pZSBT
YWhsYmVyZw0KPjxyb25uaWVzYWhsYmVyZ0BnbWFpbC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPjsgUGV0ZXINCj5MaWV2ZW4gPHBsQGthbXAuZGU+OyBNYXggUmVpdHog
PG1yZWl0ekByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIvMTNdIGJsb2Nr
L2lzY3NpOlJlbW92ZSByZWR1bmRhbnQgc3RhdGVtZW50IGluDQo+aXNjc2lfb3BlbigpDQo+DQo+
QW0gMjcuMDIuMjAyMCB1bSAwMjo0OSBoYXQgQ2hlbnF1biAoa3VobikgZ2VzY2hyaWViZW46DQo+
PiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBLZXZpbiBXb2xmIFttYWls
dG86a3dvbGZAcmVkaGF0LmNvbV0NCj4+ID5TZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI2LCAy
MDIwIDU6NTUgUE0NCj4+ID5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWku
Y29tPg0KPj4gPkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUu
b3JnOw0KPj4gPnBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgWmhhbmdoYWlsaWFuZw0KPj4gPjx6
aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBFdWxlciBSb2JvdA0KPj4gPjxldWxlci5y
b2JvdEBodWF3ZWkuY29tPjsgUm9ubmllIFNhaGxiZXJnDQo+PHJvbm5pZXNhaGxiZXJnQGdtYWls
LmNvbT47DQo+PiA+UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFBldGVyIExp
ZXZlbiA8cGxAa2FtcC5kZT47IE1heA0KPj4gPlJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+
ID5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEzXSBibG9jay9pc2NzaTpSZW1vdmUgcmVkdW5k
YW50IHN0YXRlbWVudA0KPj4gPmluDQo+PiA+aXNjc2lfb3BlbigpDQo+PiA+DQo+PiA+QW0gMjYu
MDIuMjAyMCB1bSAwOTo0NiBoYXQga3Vobi5jaGVucXVuQGh1YXdlaS5jb20gZ2VzY2hyaWViZW46
DQo+PiA+PiBGcm9tOiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+PiA+Pg0K
Pj4gPj4gQ2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6ZXIgc2hvdyB3YXJuaW5nOg0KPj4gPj4gICBi
bG9jay9pc2NzaS5jOjE5MjA6OTogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdmbGFncycgaXMg
bmV2ZXIgcmVhZA0KPj4gPj4gICAgICAgICBmbGFncyAmPSB+QkRSVl9PX1JEV1I7DQo+PiA+PiAg
ICAgICAgIF4gICAgICAgIH5+fn5+fn5+fn5+fg0KPj4gPj4NCj4+ID4+IFJlcG9ydGVkLWJ5OiBF
dWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4+ID4+IFNpZ25lZC1vZmYtYnk6
IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+ID4NCj4+ID5IbW0sIEknbSBu
b3Qgc28gc3VyZSBhYm91dCB0aGlzIG9uZSBiZWNhdXNlIGlmIHdlIHJlbW92ZSB0aGUgbGluZSwN
Cj4+ID5mbGFncyB3aWxsIGJlIGluY29uc2lzdGVudCB3aXRoIGJzLT5vcGVuX2ZsYWdzLiBJdCBm
ZWVscyBsaWtlIHNldHRpbmcNCj4+ID5hIHRyYXAgZm9yIGFueW9uZSB3aG8gd2FudHMgdG8gYWRk
IGNvZGUgdXNpbmcgZmxhZ3MgaW4gdGhlIGZ1dHVyZS4NCj4+IEhpIEtldmluLA0KPj4gSSBmaW5k
IGl0IGV4aXN0cyBzaW5jZSA4ZjNiZjUwZDM0MDM3MjY2LiAgIDogICkNCj4NCj5ZZXMsIGl0IGhh
cyBleGlzdGVkIGZyb20gdGhlIHN0YXJ0IHdpdGggYXV0by1yZWFkLW9ubHkuDQo+DQo+PiBJdCdz
IG5vdCBhIGJpZyBkZWFsLCAganVzdCB1cHNldCBjbGFuZyBzdGF0aWMgY29kZSBhbmFseXplci4N
Cj4+IEFzIHlvdSBzYWlkLCBpdCBjb3VsZCBiZSBhIHRyYXAgZm9yIHRoZSBmdXR1cmUuDQo+DQo+
V2hhdCdzIGludGVyZXN0aW5nIGlzIHRoYXQgd2UgZG8gaGF2ZSBvbmUgdXNlciBvZiB0aGUgZmxh
Z3MgbGF0ZXIgaW4gdGhlIGZ1bmN0aW9uLA0KPmJ1dCBpdCB1c2VzIGJzLT5vcGVuX2ZsYWdzIGlu
c3RlYWQ6DQo+DQo+ICAgIHJldCA9IGlzY3NpX2FsbG9jbWFwX2luaXQoaXNjc2lsdW4sIGJzLT5v
cGVuX2ZsYWdzKTsNCj4NCkdvb2QgcG9pbnQsICBJIHRoaW5rIHRoaXMgaXMgZXhhY3RseSB3aGVy
ZSB0aGUgJ2ZsYWdzJyBhcmUgbmVlZGVkIG5vdy4gIA0KSXQgc2hvdWxkIGJlIHJpZ2h0IHRvIGtl
ZXAgaXQgZm9yIHRoZSBmdXR1cmUsIHRvby4NCg0KTGF0ZXIgdmVyc2lvbiwgSSB3aWxsIG1vZGlm
eSBpdC4NCg0KVGhhbmtzLg0KPg0KPk1heWJlIHRoaXMgc2hvdWxkIGJlIHVzaW5nIGZsYWdzPyAo
VGhlIHZhbHVlIG9mIHRoZSBiaXRzIHdlJ3JlIGludGVyZXN0ZWQgaW4gaXMNCj50aGUgc2FtZSwg
YnV0IHdoZW4gZmxhZ3MgaXMgcGFzc2VkIGFzIGEgcGFyYW1ldGVyLCBJIHdvdWxkIGV4cGVjdCBp
dCB0byBiZQ0KPnVzZWQuKQ0K

