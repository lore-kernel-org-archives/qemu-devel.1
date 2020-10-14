Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E84C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B3C20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B3C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSers-0000Lw-9g
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSeql-0007m4-9W; Wed, 14 Oct 2020 07:21:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2940 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSeqh-0005GZ-RK; Wed, 14 Oct 2020 07:21:42 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 4B615E4C454520B105BC;
 Wed, 14 Oct 2020 19:21:26 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.75]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Wed, 14 Oct 2020 19:21:16 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v2] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Topic: [PATCH v2] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Index: AQHWoV0hzSMk/IMnP02jswbxivecYqmVFqSAgAEuwTCAAAyWgIAAjlMA
Date: Wed, 14 Oct 2020 11:21:15 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B9B8CE0@dggemm531-mbx.china.huawei.com>
References: <20201013123340.1850548-1-kuhn.chenqun@huawei.com>
 <561a0092-3723-a95a-0208-d53cb475a532@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B9B6538@dggemm531-mbx.china.huawei.com>
 <5a6483ec-9cab-58d9-872c-48762e96f768@redhat.com>
In-Reply-To: <5a6483ec-9cab-58d9-872c-48762e96f768@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 06:21:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, Li
 Qiang <liq3ea@gmail.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRZW11LWRldmVsDQo+IFttYWls
dG86cWVtdS1kZXZlbC1ib3VuY2VzK2t1aG4uY2hlbnF1bj1odWF3ZWkuY29tQG5vbmdudS5vcmdd
IE9uDQo+IEJlaGFsZiBPZiBNYXggUmVpdHoNCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE0
LCAyMDIwIDU6MzYgUE0NCj4gVG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2Vp
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcWVtdS10cml2aWFsQG5vbmdudS5vcmcN
Cj4gQ2M6IGZhbUBldXBob24ubmV0OyBnYW5xaXhpbiA8Z2FucWl4aW5AaHVhd2VpLmNvbT47DQo+
IHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbTsgWmhhbmdoYWlsaWFuZw0KPiA8emhhbmcuemhhbmdo
YWlsaWFuZ0BodWF3ZWkuY29tPjsgcWVtdS1ibG9ja0Bub25nbnUub3JnOw0KPiBxdWludGVsYUBy
ZWRoYXQuY29tOyBMaSBRaWFuZyA8bGlxM2VhQGdtYWlsLmNvbT47IGRnaWxiZXJ0QHJlZGhhdC5j
b207DQo+IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT47IHN0ZWZhbmhhQHJlZGhh
dC5jb207IEV1bGVyIFJvYm90DQo+IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsganNub3dAcmVk
aGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtaWdyYXRpb24vYmxvY2stZGlydHkt
Yml0bWFwOiBmaXggdW5pbml0aWFsaXplZCB2YXJpYWJsZQ0KPiB3YXJuaW5nDQo+IA0KPiBPbiAx
NC4xMC4yMCAwMzowMywgQ2hlbnF1biAoa3Vobikgd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBNYXggUmVpdHogW21haWx0bzptcmVp
dHpAcmVkaGF0LmNvbV0NCj4gPj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMywgMjAyMCAxMDo0
NyBQTQ0KPiA+PiBUbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPjsN
Cj4gcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiA+PiBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZw0K
PiA+PiBDYzogdnNlbWVudHNvdkB2aXJ0dW96em8uY29tOyBzdGVmYW5oYUByZWRoYXQuY29tOyBm
YW1AZXVwaG9uLm5ldDsNCj4gPj4gZWJsYWtlQHJlZGhhdC5jb207IGpzbm93QHJlZGhhdC5jb207
IHF1aW50ZWxhQHJlZGhhdC5jb207DQo+ID4+IGRnaWxiZXJ0QHJlZGhhdC5jb207IFpoYW5naGFp
bGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47DQo+ID4+IGdhbnFpeGluIDxn
YW5xaXhpbkBodWF3ZWkuY29tPjsgcWVtdS1ibG9ja0Bub25nbnUub3JnOyBFdWxlciBSb2JvdA0K
PiA+PiA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT47IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZp
dmllci5ldT47IExpDQo+ID4+IFFpYW5nIDxsaXEzZWFAZ21haWwuY29tPg0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIHYyXSBtaWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwOiBmaXgNCj4gPj4g
dW5pbml0aWFsaXplZCB2YXJpYWJsZSB3YXJuaW5nDQo+ID4+DQo+ID4+IE9uIDEzLjEwLjIwIDE0
OjMzLCBDaGVuIFF1biB3cm90ZToNCj4gPj4+IEEgZGVmYXVsdCB2YWx1ZSBpcyBwcm92aWRlZCBm
b3IgdGhlIHZhcmlhYmxlICdiaXRtYXBfbmFtZScgdG8gYXZvaWQNCj4gPj4+IGNvbXBpbGVyDQo+
ID4+IHdhcm5pbmcuDQo+ID4+Pg0KPiA+Pj4gVGhlIGNvbXBpbGVyIHNob3cgd2FybmluZzoNCj4g
Pj4+IG1pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYzoxMDkwOjEzOiB3YXJuaW5nOiDigJhi
aXRtYXBfbmFtZeKAmQ0KPiA+Pj4gbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1
bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ID4+PiAgICAgICAgZ19zdHJsY3B5KHMt
PmJpdG1hcF9uYW1lLCBiaXRtYXBfbmFtZSwNCj4gPj4gc2l6ZW9mKHMtPmJpdG1hcF9uYW1lKSk7
DQo+ID4+Pg0KPiA+Pg0KPiBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+Pj4NCj4gPj4+IFJlcG9ydGVkLWJ5OiBFdWxlciBS
b2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IENoZW4g
UXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gQ2M6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gPj4+
IENjOiBMYXVyZW50IFZpdmllciA8bGF1cmVudEB2aXZpZXIuZXU+DQo+ID4+PiBDYzogTGkgUWlh
bmcgPGxpcTNlYUBnbWFpbC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBtaWdyYXRpb24vYmxvY2st
ZGlydHktYml0bWFwLmMgfCA5ICsrLS0tLS0tLQ0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IE5vIG9iamVjdGlvbnMsIHNl
bWFudGljYWxseSwgYnV0Li4uDQo+ID4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL2Js
b2NrLWRpcnR5LWJpdG1hcC5jDQo+ID4+PiBiL21pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAu
YyBpbmRleCA1YmVmNzkzYWMwLi5iY2I3OWMwNGNlIDEwMDY0NA0KPiA+Pj4gLS0tIGEvbWlncmF0
aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+ID4+PiArKysgYi9taWdyYXRpb24vYmxvY2stZGly
dHktYml0bWFwLmMNCj4gPj4+IEBAIC0xMDY0LDE1ICsxMDY0LDEzIEBAIHN0YXRpYyBpbnQNCj4g
ZGlydHlfYml0bWFwX2xvYWRfaGVhZGVyKFFFTVVGaWxlDQo+ID4+ICpmLCBEQk1Mb2FkU3RhdGUg
KnMsDQo+ID4+PiAgICAgIGFzc2VydChub3RoaW5nIHx8IHMtPmNhbmNlbGxlZCB8fCAhIWFsaWFz
X21hcCA9PQ0KPiA+Pj4gISFiaXRtYXBfYWxpYXNfbWFwKTsNCj4gPj4+DQo+ID4+PiAgICAgIGlm
IChzLT5mbGFncyAmIERJUlRZX0JJVE1BUF9NSUdfRkxBR19CSVRNQVBfTkFNRSkgew0KPiA+Pj4g
LSAgICAgICAgY29uc3QgY2hhciAqYml0bWFwX25hbWU7DQo+ID4+PiAtDQo+ID4+PiAgICAgICAg
ICBpZiAoIXFlbXVfZ2V0X2NvdW50ZWRfc3RyaW5nKGYsIHMtPmJpdG1hcF9hbGlhcykpIHsNCj4g
Pj4+ICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIlVuYWJsZSB0byByZWFkIGJpdG1hcCBhbGlh
cyBzdHJpbmciKTsNCj4gPj4+ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPj4+ICAg
ICAgICAgIH0NCj4gPj4+DQo+ID4+PiAtICAgICAgICBpZiAoIXMtPmNhbmNlbGxlZCkgew0KPiA+
Pj4gLSAgICAgICAgICAgIGlmIChiaXRtYXBfYWxpYXNfbWFwKSB7DQo+ID4+PiArICAgICAgICBj
b25zdCBjaGFyICpiaXRtYXBfbmFtZSA9IHMtPmJpdG1hcF9hbGlhczsNCj4gPj4NCj4gPj4gcWVt
deKAmXMgY29kaW5nIHN0eWxlIG1hbmRhdGVzIGRlY2xhcmF0aW9ucyB0byBiZSBwbGFjZWQgYXQg
dGhlDQo+ID4+IGJlZ2lubmluZyBvZiB0aGVpciBibG9jaywgc28gdGhlIGRlY2xhcmF0aW9uIGhh
cyB0byBzdGF5IHdoZXJlIGl0IGlzLg0KPiA+PiAoUHV0dGluZyB0aGUgYXNzaWdubWVudCBoZXJl
IGxvb2tzIHJlYXNvbmFibGUuKQ0KPiA+Pg0KPiA+IEhpIE1heCwNCj4gPiAgIERlY2xhcmF0aW9u
IHZhcmlhYmxlcyBoZXJlIHRvIGVuc3VyZSB0aGF0IHRoZSBhYm92ZSBleGNlcHRpb25zKFVuYWJs
ZSB0bw0KPiByZWFkIGJpdG1hcCBhbGlhcyBzdHJpbmcpIGFyZSBhdm9pZGVkLg0KPiA+IElmIHRo
ZSBkZWNsYXJhdGlvbiBoYXMgdG8gc3RheSB3aGVyZSBpdCBpcywgaXMgdGhlcmUgYSBwb3NzaWJp
bGl0eSB0aGF0IHRoZQ0KPiBhc3NpZ25tZW50IGZhaWxzPw0KPiANCj4gSSBkb27igJl0IHVuZGVy
c3RhbmQgd2hhdCB5b3UgbWVhbi4gIA0KDQpJIHRoaW5rIG15IGRlc2NyaXB0aW9uIGlzIG5vdCBh
Y2N1cmF0ZS4gRm9yZ2l2ZSBtZSBmb3IgYmVpbmcgYSBub24tbmF0aXZlIEVuZ2xpc2ggc3BlYWtl
ci4NClRoZSB2YXJpYWJsZSAnYml0bWFwX25hbWUnIGFzc2lnbm1lbnQgbWF5YmUgZmFpbGVkIGF0
IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGJsb2NrLCBiZWNhdXNlIHJlYWRpbmcgdGhlICdzLT5iaXRt
YXBfYWxpYXMnIG1heWJlIGZhaWxlZC4NCg0KPkEgZGVjbGFyYXRpb24gd2l0aG91dCBpbml0aWFs
aXphdGlvbiBpc27igJl0DQo+IGFuZCBkb2VzbuKAmXQgY29udGFpbiBhbiBleHByZXNzaW9uLCBp
dCBpc27igJl0IGV2ZW4gYSBzdGF0ZW1lbnQsIHNvIGl0IGhhcyBubyBzaWRlDQo+IGVmZmVjdHMu
WzFdDQo+IA0KPiBQbGFjaW5nIHRoZSBkZWNsYXJhdGlvbiAod2l0aG91dCBhbiBpbml0aWFsaXph
dGlvbikgYXQgdGhlIHRvcCBvZiB0aGUgYmxvY2sgbWFrZXMNCj4gbm8gc2VtYW50aWMgZGlmZmVy
ZW5jZS4NCj4NCkkgc2VlIHdoYXQgeW91IG1lYW4uIFNlcGFyYXRlIHZhcmlhYmxlIGRlY2xhcmF0
aW9ucyBmcm9tIHZhcmlhYmxlIGFzc2lnbm1lbnRzLg0KWW91J3JlIHJpZ2h0ISAgSSB3aWxsIHVw
ZGF0ZSBpdCBsYXRlci4NCg0KVGhhbmtzLA0KQ2hlbiBRdW4NCj4gKEFzIEkgc2FpZCwgSeKAmWQg
a2VlcCB0aGUgYXNzaWdubWVudCDigJxiaXRtYXBfbmFtZSA9IHMtPmJpdG1hcF9hbGlhc+KAnQ0K
PiB3aGVyZSB5b3UgcHV0IGl0LiAgSSB0aGluayBpdCB3b3VsZCB0ZWNobmljYWxseSBhY3R1YWxs
eSBiZSBjb3JyZWN0IHRvIHB1dCBpdCBpbnRvDQo+IHRoZSBkZWNsYXJhdGlvbiBhdCB0aGUgc3Rh
cnQgb2YgdGhlIGJsb2NrIGFzIGFuIGluaXRpYWxpemVyLCBidXQgdGhhdCB3b3VsZCBsb29rDQo+
IHdlaXJkLikNCj4gDQo+IE1heA0KPiANCj4gWzFdIEkgc3VwcG9zZSBleGNlcHRpb25zIGFwcGx5
IGZvciB0eXBlcyB3aXRoIGNvbnN0cnVjdG9ycywgYnV0IHRob3NlIGRvbuKAmXQNCj4gZXhpc3Qg
aW4gcGxhaW4gQy4NCg0K

