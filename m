Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4CAC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 07:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6809520735
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 07:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6809520735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGe5O-0000Rd-Jm
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 03:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGe4c-0007rz-JV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 03:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jGe4a-0004bZ-UX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 03:34:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2079 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jGe4U-0004Y0-5y; Tue, 24 Mar 2020 03:33:58 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 9AC82E6DE52D4E6F858D;
 Tue, 24 Mar 2020 15:33:48 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 24 Mar 2020 15:33:48 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0487.000;
 Tue, 24 Mar 2020 15:33:47 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH-for-5.0 v2 00/11] misc: Trivial static code analyzer fixes
Thread-Topic: [PATCH-for-5.0 v2 00/11] misc: Trivial static code analyzer fixes
Thread-Index: AQHV/48K2ZlJeIAEFEKXhkI1InUyf6hVun8AgAADyACAAALNgIABj56A
Date: Tue, 24 Mar 2020 07:33:46 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6BE8AD@dggemm511-mbx.china.huawei.com>
References: <20200321144110.5010-1-philmd@redhat.com>
 <1c711740-6166-c730-ef67-d07511add1e6@vivier.eu>
 <262f8318-1590-1c48-f4de-a6482fdc3071@redhat.com>
 <10431e44-880a-cbec-c35e-1d425064c40b@vivier.eu>
In-Reply-To: <10431e44-880a-cbec-c35e-1d425064c40b@vivier.eu>
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
X-Received-From: 45.249.212.189
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
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?utf-8?B?SGVydsOpIFBvdXNzaW5lYXU=?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 John Snow <jsnow@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUWVtdS1kZXZlbCBbbWFpbHRvOnFl
bXUtZGV2ZWwtDQo+Ym91bmNlcytrdWhuLmNoZW5xdW49aHVhd2VpLmNvbUBub25nbnUub3JnXSBP
biBCZWhhbGYgT2YgTGF1cmVudCBWaXZpZXINCj5TZW50OiBNb25kYXksIE1hcmNoIDIzLCAyMDIw
IDEwOjU2IFBNDQo+VG86IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPkNjOiBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0
PjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsNCj5NaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPjsgTWFyayBDYXZlLUF5bGFuZCA8bWFyay5jYXZlLQ0K
PmF5bGFuZEBpbGFuZGUuY28udWs+OyBxZW11LWJsb2NrQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlh
bEBub25nbnUub3JnOw0KPk1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47IEhl
cnbDqSBQb3Vzc2luZWF1DQo+PGhwb3Vzc2luQHJlYWN0b3Mub3JnPjsgSm9lbCBTdGFubGV5IDxq
b2VsQGptcy5pZC5hdT47IE1pY2hhZWwgVG9rYXJldg0KPjxtanRAdGxzLm1zay5ydT47IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBxZW11LQ0KPmFybUBub25nbnUu
b3JnOyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgSm9obiBTbm93DQo+PGpzbm93
QHJlZGhhdC5jb20+OyBEYXZpZCBHaWJzb24gPGRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT47
IEtldmluIFdvbGYNCj48a3dvbGZAcmVkaGF0LmNvbT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdA
YWouaWQuYXU+OyBNYXggUmVpdHoNCj48bXJlaXR6QHJlZGhhdC5jb20+OyBJZ29yIE1pdHN5YW5r
byA8aS5taXRzeWFua29AZ21haWwuY29tPjsgcWVtdS0NCj5wcGNAbm9uZ251Lm9yZzsgUGFvbG8g
Qm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENILWZvci01
LjAgdjIgMDAvMTFdIG1pc2M6IFRyaXZpYWwgc3RhdGljIGNvZGUgYW5hbHl6ZXIgZml4ZXMNCj4N
Cj5MZSAyMy8wMy8yMDIwIMOgIDE1OjQ1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSBhIMOpY3Jp
dMKgOg0KPj4gT24gMy8yMy8yMCAzOjMyIFBNLCBMYXVyZW50IFZpdmllciB3cm90ZToNCj4+PiBM
ZSAyMS8wMy8yMDIwIMOgIDE1OjQwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSBhIMOpY3JpdMKg
Og0KPj4+PiBGaXggdHJpdmlhbCB3YXJuaW5ncyByZXBvcnRlZCBieSB0aGUgQ2xhbmcgc3RhdGlj
IGNvZGUgYW5hbHl6ZXIuDQo+Pj4+DQo+Pj4+IFNpbmNlIHYxOg0KPj4+PiAtIEFkZHJlc3NlZCBN
YXJrdXMvWm9sdGFuL0FsZWtzYW5kYXIgcmV2aWV3IGNvbW1lbnRzDQo+Pj4+DQo+Pj4+IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpICgxMSk6DQo+Pj4+IMKgwqAgYmxvY2s6IEF2b2lkIGRlYWQgYXNz
aWdubWVudA0KPj4+PiDCoMKgIGJsb2NrZGV2OiBSZW1vdmUgZGVhZCBhc3NpZ25tZW50DQo+Pj4+
IMKgwqAgaHcvaTJjL3BtX3NtYnVzOiBSZW1vdmUgZGVhZCBhc3NpZ25tZW50DQo+Pj4+IMKgwqAg
aHcvaW5wdXQvYWRiLWtiZDogUmVtb3ZlIGRlYWQgYXNzaWdubWVudA0KPj4+PiDCoMKgIGh3L2lk
ZS9zaWkzMTEyOiBSZW1vdmUgZGVhZCBhc3NpZ25tZW50DQo+Pj4+IMKgwqAgaHcvaXNhL2k4MjM3
ODogUmVtb3ZlIGRlYWQgYXNzaWdubWVudA0KPj4+PiDCoMKgIGh3L2dwaW8vYXNwZWVkX2dwaW86
IFJlbW92ZSBkZWFkIGFzc2lnbm1lbnQNCj4+Pj4gwqDCoCBody90aW1lci9leHlub3M0MjEwX21j
dDogUmVtb3ZlIGRlYWQgYXNzaWdubWVudHMNCg0KU2FtZSBhcyB0aGlzOg0KaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTQxNTUyNy8NCg0KPj4+PiDCoMKgIGh3L3RpbWVyL3N0
bTMyZjJ4eF90aW1lcjogUmVtb3ZlIGRlYWQgYXNzaWdubWVudA0KPj4+PiDCoMKgIGh3L3RpbWVy
L3B4YTJ4eF90aW1lcjogQWRkIGFzc2VydGlvbiB0byBzaWxlbnQgc3RhdGljIGFuYWx5emVyDQo+
Pj4+IHdhcm5pbmcNCj4+Pj4gwqDCoCBody9zY3NpL2VzcC1wY2k6IFJlbW92ZSBkZWFkIGFzc2ln
bm1lbnQNCg0KU2FtZSBhcyB0aGlzOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMTQxNTUyOS8NCg0KPj4+Pg0KPj4+PiDCoCBibG9jay5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAyICstDQo+Pj4+IMKgIGJsb2NrZGV2LmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0NCj4+Pj4gwqAgaHcvZ3Bpby9hc3BlZWRfZ3Bpby5j
wqDCoMKgwqDCoCB8IDIgKy0NCj4+Pj4gwqAgaHcvaTJjL3BtX3NtYnVzLmPCoMKgwqDCoMKgwqDC
oMKgwqAgfCAxIC0NCj4+Pj4gwqAgaHcvaWRlL3NpaTMxMTIuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgNSArKystLQ0KPj4+PiDCoCBody9pbnB1dC9hZGIta2JkLmPCoMKgwqDCoMKgwqDCoMKgIHwg
NiArLS0tLS0NCj4+Pj4gwqAgaHcvaXNhL2k4MjM3OC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDggKysrKy0tLS0NCj4+Pj4gwqAgaHcvc2NzaS9lc3AtcGNpLmPCoMKgwqDCoMKgwqDCoMKgwqAg
fCAxIC0NCj4+Pj4gwqAgaHcvdGltZXIvZXh5bm9zNDIxMF9tY3QuY8KgIHwgMyAtLS0NCj4+Pj4g
wqAgaHcvdGltZXIvcHhhMnh4X3RpbWVyLmPCoMKgwqAgfCAxICsNCj4+Pj4gwqAgaHcvdGltZXIv
c3RtMzJmMnh4X3RpbWVyLmMgfCAxIC0NCj4+Pj4gwqAgMTEgZmlsZXMgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4NCj4+PiBJIHRoaW5rIHlvdXIg
c2VyaWVzIGNvdmVycyBjYXNlcyBhbHJlYWR5IGNvdmVyZWQgYnk6DQo+Pj4NCj4+PiBbUEFUQ0gg
djMgMDAvMTJdIHJlZHVuZGFudCBjb2RlOiBGaXggd2FybmluZ3MgcmVwb3J0ZWQgYnkgQ2xhbmcN
Cj4+PiBzdGF0aWMgY29kZSBhbmFseXplcg0KPj4+IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8y
MDIwMDMwMjEzMDcxNS4yOTQ0MC0xLWt1aG4uY2gNCj4+DQo+PiBVbmZvcnR1bmF0ZWx5IFtmb3Ig
bWUuLi5dIEkgZG9uJ3QgaGF2ZSB2MyBpbiBteSBJTkJPWC4uLiAqc2lnaCogVGhpcw0KPj4gd2Fz
IDMgd2Vla3MgYWdvLiAqc2lnaCouDQo+Pg0KPj4gSSBjYW4gc2VlIHRoZSBzZXJpZXMgaW4gdGhl
IGFyY2hpdmVzOg0KPj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMjAtMDMvbXNnMDAyMTkuaHRtbA0KPj4gQnV0IEkgY2FuJ3QgZmluZCB0aGUgb3V0Y29t
ZSwgd2FzIGl0IHF1ZXVlZCBpbiB0aGUgdHJpdmlhbCB0cmVlPw0KPj4gQW55IGlkZWEgd2hlbiB0
aGlzIHdpbGwgYmUgbWVyZ2VkIGluIHRoZSBtYXN0ZXIgdHJlZT8NCj4NCj5Tb21lIHBhdGNoZXMg
YXJlIGFscmVhZHkgbWVyZ2VkIHZpYSB0cml2aWFsICgxLCAyIChzaG91bGQgZ28gYnkgU0NTSQ0K
PnF1ZXVlKSAzLCA1LCA2LCA3LCA5LCAxMSAoYnkgVVNCIHF1ZXVlKSwgMTIpLg0KPg0KPkJ1dCBv
dGhlcnMgbmVlZGVkIFItYiB0YWdzIG9yIG5ldyB2ZXJzaW9uLiBJIGRpZG4ndCBjaGVjayB3aGlj
aCBvZiB5b3VyIHBhdGNoZXMNCj5hcmUgYWxyZWFkeSBjb3ZlcmVkIGJ5IHRoaXMgc2VyaWVzLg0K
Pg0KSGksIExhdXJlbnQgYW5kIFBoaWxpcHBlDQoNCiAgICAgIFllcywgdGhlcmUgYXJlIGN1cnJl
bnRseSB0aHJlZSBwYXRjaGVzKCA044CBOCDjgIExMCkgdGhhdCBhcmUgbm90IG1lcmdlZC4gIA0K
QW5kLCBvbmx5IHBhdGNoNCBhbmQgcGF0Y2gxMCAgaGF2ZSB0aGUgc2FtZSBwb2ludHMgYXMgdGhp
cyBzZXJpZXMuDQoNCkkgc2hvdWxkIHVwZGF0ZSBpdCBhZ2FpbiBlYXJsaWVyLg0KDQpUaGFua3Mu
DQo=

