Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F3BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BEC24697
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BEC24697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7rlV-00038A-U6
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j7rko-0002Ym-5w
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j7rkm-0000v7-At
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:21:21 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2453 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j7rkk-0000sW-Om; Fri, 28 Feb 2020 21:21:20 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id AF7D5AB77B5405CF4E06;
 Sat, 29 Feb 2020 10:21:12 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Feb 2020 10:21:12 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0439.000;
 Sat, 29 Feb 2020 10:21:03 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: RE: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Topic: [PATCH v2 02/13] block/iscsi:Remove redundant statement in
 iscsi_open()
Thread-Index: AQHV7IFlkw7HklI9YUytmY61YTlYXagstmsAgAGL6HCAABCIAIABhb7ggAATXYCAAYIY8A==
Date: Sat, 29 Feb 2020 02:21:02 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B66524B@dggemm531-mbx.china.huawei.com>
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-3-kuhn.chenqun@huawei.com>
 <20200226095444.GB6096@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B6638BE@dggemm531-mbx.china.huawei.com>
 <20200227103054.GB7493@linux.fritz.box>
 <7412CDE03601674DA8197E2EBD8937E83B664140@dggemm531-mbx.china.huawei.com>
 <20200228105509.GB5274@linux.fritz.box>
In-Reply-To: <20200228105509.GB5274@linux.fritz.box>
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
b2xmQHJlZGhhdC5jb21dDQo+U2VudDogRnJpZGF5LCBGZWJydWFyeSAyOCwgMjAyMCA2OjU1IFBN
DQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj5DYzogcWVt
dS1kZXZlbEBub25nbnUub3JnOyBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsNCj5wZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc7IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2Vp
LmNvbT47DQo+RXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+OyBSb25uaWUgU2Fo
bGJlcmcNCj48cm9ubmllc2FobGJlcmdAZ21haWwuY29tPjsgUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT47IFBldGVyDQo+TGlldmVuIDxwbEBrYW1wLmRlPjsgTWF4IFJlaXR6IDxt
cmVpdHpAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEzXSBibG9jay9p
c2NzaTpSZW1vdmUgcmVkdW5kYW50IHN0YXRlbWVudCBpbg0KPmlzY3NpX29wZW4oKQ0KPg0KPkFt
IDI4LjAyLjIwMjAgdW0gMDg6MzAgaGF0IENoZW5xdW4gKGt1aG4pIGdlc2NocmllYmVuOg0KPj4g
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+RnJvbTogS2V2aW4gV29sZiBbbWFpbHRv
Omt3b2xmQHJlZGhhdC5jb21dDQo+PiA+U2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI3LCAyMDIw
IDY6MzEgUE0NCj4+ID5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29t
Pg0KPj4gPkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3Jn
Ow0KPj4gPnBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgWmhhbmdoYWlsaWFuZw0KPj4gPjx6aGFu
Zy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBFdWxlciBSb2JvdA0KPj4gPjxldWxlci5yb2Jv
dEBodWF3ZWkuY29tPjsgUm9ubmllIFNhaGxiZXJnDQo+PHJvbm5pZXNhaGxiZXJnQGdtYWlsLmNv
bT47DQo+PiA+UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IFBldGVyIExpZXZl
biA8cGxAa2FtcC5kZT47IE1heA0KPj4gPlJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+ID5T
dWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEzXSBibG9jay9pc2NzaTpSZW1vdmUgcmVkdW5kYW50
IHN0YXRlbWVudA0KPj4gPmluDQo+PiA+aXNjc2lfb3BlbigpDQo+PiA+DQo+PiA+QW0gMjcuMDIu
MjAyMCB1bSAwMjo0OSBoYXQgQ2hlbnF1biAoa3VobikgZ2VzY2hyaWViZW46DQo+PiA+PiA+LS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4+ID5Gcm9tOiBLZXZpbiBXb2xmIFttYWlsdG86
a3dvbGZAcmVkaGF0LmNvbV0NCj4+ID4+ID5TZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI2LCAy
MDIwIDU6NTUgUE0NCj4+ID4+ID5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3
ZWkuY29tPg0KPj4gPj4gPkNjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBu
b25nbnUub3JnOw0KPj4gPj4gPnBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgWmhhbmdoYWlsaWFu
Zw0KPj4gPj4gPjx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBFdWxlciBSb2JvdA0K
Pj4gPj4gPjxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsgUm9ubmllIFNhaGxiZXJnDQo+PiA+PHJv
bm5pZXNhaGxiZXJnQGdtYWlsLmNvbT47DQo+PiA+PiA+UGFvbG8gQm9uemluaSA8cGJvbnppbmlA
cmVkaGF0LmNvbT47IFBldGVyIExpZXZlbiA8cGxAa2FtcC5kZT47DQo+PiA+PiA+TWF4IFJlaXR6
IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+ID4+ID5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEz
XSBibG9jay9pc2NzaTpSZW1vdmUgcmVkdW5kYW50DQo+PiA+PiA+c3RhdGVtZW50IGluDQo+PiA+
PiA+aXNjc2lfb3BlbigpDQo+PiA+PiA+DQo+PiA+PiA+QW0gMjYuMDIuMjAyMCB1bSAwOTo0NiBo
YXQga3Vobi5jaGVucXVuQGh1YXdlaS5jb20gZ2VzY2hyaWViZW46DQo+PiA+PiA+PiBGcm9tOiBD
aGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+PiA+PiA+Pg0KPj4gPj4gPj4gQ2xh
bmcgc3RhdGljIGNvZGUgYW5hbHl6ZXIgc2hvdyB3YXJuaW5nOg0KPj4gPj4gPj4gICBibG9jay9p
c2NzaS5jOjE5MjA6OTogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdmbGFncycgaXMgbmV2ZXIg
cmVhZA0KPj4gPj4gPj4gICAgICAgICBmbGFncyAmPSB+QkRSVl9PX1JEV1I7DQo+PiA+PiA+PiAg
ICAgICAgIF4gICAgICAgIH5+fn5+fn5+fn5+fg0KPj4gPj4gPj4NCj4+ID4+ID4+IFJlcG9ydGVk
LWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4+ID4+ID4+IFNpZ25l
ZC1vZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+ID4+ID4NCj4+
ID4+ID5IbW0sIEknbSBub3Qgc28gc3VyZSBhYm91dCB0aGlzIG9uZSBiZWNhdXNlIGlmIHdlIHJl
bW92ZSB0aGUgbGluZSwNCj4+ID4+ID5mbGFncyB3aWxsIGJlIGluY29uc2lzdGVudCB3aXRoIGJz
LT5vcGVuX2ZsYWdzLiBJdCBmZWVscyBsaWtlDQo+PiA+PiA+c2V0dGluZyBhIHRyYXAgZm9yIGFu
eW9uZSB3aG8gd2FudHMgdG8gYWRkIGNvZGUgdXNpbmcgZmxhZ3MgaW4gdGhlDQo+ZnV0dXJlLg0K
Pj4gPj4gSGkgS2V2aW4sDQo+PiA+PiBJIGZpbmQgaXQgZXhpc3RzIHNpbmNlIDhmM2JmNTBkMzQw
MzcyNjYuICAgOiAgKQ0KPj4gPg0KPj4gPlllcywgaXQgaGFzIGV4aXN0ZWQgZnJvbSB0aGUgc3Rh
cnQgd2l0aCBhdXRvLXJlYWQtb25seS4NCj4+ID4NCj4+ID4+IEl0J3Mgbm90IGEgYmlnIGRlYWws
ICBqdXN0IHVwc2V0IGNsYW5nIHN0YXRpYyBjb2RlIGFuYWx5emVyLg0KPj4gPj4gQXMgeW91IHNh
aWQsIGl0IGNvdWxkIGJlIGEgdHJhcCBmb3IgdGhlIGZ1dHVyZS4NCj4+ID4NCj4+ID5XaGF0J3Mg
aW50ZXJlc3RpbmcgaXMgdGhhdCB3ZSBkbyBoYXZlIG9uZSB1c2VyIG9mIHRoZSBmbGFncyBsYXRl
ciBpbg0KPj4gPnRoZSBmdW5jdGlvbiwgYnV0IGl0IHVzZXMgYnMtPm9wZW5fZmxhZ3MgaW5zdGVh
ZDoNCj4+ID4NCj4+ID4gICAgcmV0ID0gaXNjc2lfYWxsb2NtYXBfaW5pdChpc2NzaWx1biwgYnMt
Pm9wZW5fZmxhZ3MpOw0KPj4gPg0KPj4gPk1heWJlIHRoaXMgc2hvdWxkIGJlIHVzaW5nIGZsYWdz
PyAoVGhlIHZhbHVlIG9mIHRoZSBiaXRzIHdlJ3JlDQo+PiA+aW50ZXJlc3RlZCBpbiBpcyB0aGUg
c2FtZSwgYnV0IHdoZW4gZmxhZ3MgaXMgcGFzc2VkIGFzIGEgcGFyYW1ldGVyLCBJDQo+PiA+d291
bGQgZXhwZWN0IGl0IHRvIGJlDQo+PiA+dXNlZC4pDQo+PiA+DQo+PiBIaSBLZXZpbiwNCj4+IEkg
aGF2ZSBhIHF1ZXN0aW9uOiBhcmUgJ2ZsYWdzJyBleGFjdGx5IHRoZSBzYW1lIGFzICdicy0+IG9w
ZW5fZmxhZ3MnPw0KPj4gSW4gdGhlIGZ1bmN0aW9uIGJkcnZfb3Blbl9jb21tb24oKSBhdCBibG9j
ay5jIGZpbGUsICB0aGUgZXhpc3RlbmNlIG9mDQo+c3RhdGVtZW50KCBvcGVuX2ZsYWdzID0gYmRy
dl9vcGVuX2ZsYWdzKGJzLCBicy0+b3Blbl9mbGFncyk7ICkgbWFrZXMgdGhlbQ0KPmEgbGl0dGxl
IGRpZmZlcmVudC4NCj4+IFdpbGwgdGhpcyBwbGFjZSBhZmZlY3QgdGhlbSBpbmNvbnNpc3RlbnRs
eSA/DQo+DQo+Tm90IGV4YWN0bHkgdGhlIHNhbWUsIHRoYXQncyB3aHkgSSBzYWlkICJ2YWx1ZSBv
ZiB0aGUgYml0cyB3ZSdyZSBpbnRlcmVzdGVkIGluIGlzDQo+dGhlIHNhbWUiLiBiZHJ2X29wZW5f
ZmxhZ3MoKSBiYXNpY2FsbHkganVzdCBmaWx0ZXJzIG91dCB0aGluZ3MgdGhhdCBhcmUgaGFuZGxl
ZA0KPmJ5IHRoZSBnZW5lcmljIGJsb2NrIGxheWVyIGFuZCBub25lIG9mIHRoZSBibG9jayBkcml2
ZXIncyBidXNpbmVzcy4NCj4NCj5UbyBiZSBwcmVjaXNlLCBpc2NzaV9hbGxvY21hcF9pbml0KCkg
b25seSBjaGVja3MgQkRSVl9PX05PQ0FDSEUsIHdoaWNoIGlzDQo+dGhlIHNhbWUgaW4gYm90aC4N
Cj4NCj4+IElzIGl0IHNhZmVyIGlmIHdlIGFzc2lnbiBicy0+IG9wZW5fZmxhZ3MgdG8gZmxhZ3M/
DQo+DQo+VGhpcyB3b3VsZCBhZGQgYmFjayB0aGUgZmxhZ3MgdGhhdCB3ZSBjb25zY2lvdXNseSBm
aWx0ZXJlZCBvdXQgYmVmb3JlLCBzbyBJDQo+d291bGQgc2F5IG5vLg0KPg0KV2VsbCwgSSBzZWUs
IHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZGV0YWlsZWQgZXhwbGFuYXRpb24hDQoNClRo
YW5rcy4NCg==

