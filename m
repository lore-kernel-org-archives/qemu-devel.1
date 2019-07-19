Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E47C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B1D208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B1D208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41925 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoI8U-0006Jq-OP
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 21:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hoI8K-0005tw-2b
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hoI8I-00037E-Us
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:56:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:36904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hoI8I-00036m-Li
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:56:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jul 2019 18:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,280,1559545200"; d="scan'208";a="319832140"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga004.jf.intel.com with ESMTP; 18 Jul 2019 18:56:24 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 18:56:24 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 18 Jul 2019 18:56:24 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jul 2019 18:56:24 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.240]) with mapi id 14.03.0439.000;
 Fri, 19 Jul 2019 09:56:22 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak
 and code style issue.
Thread-Index: AQHVPUsLqGBEGDJMrk2Ek2iZfotKjqbPpoOAgAACXQCAAASQAIABgfOw
Date: Fri, 19 Jul 2019 01:56:21 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061D0429@shsmsx102.ccr.corp.intel.com>
References: <20190718092219.20081-1-chen.zhang@intel.com>
 <375615d7-7cdf-4711-68fb-47ce3c8cb308@redhat.com>
 <CAFEAcA8oQ0buYaOAXsjzUecDjrsk+=BAtM3bW3skKkTEZ5Ngtg@mail.gmail.com>
 <664c3b23-4d19-cda6-dbd7-4a7195a96ec3@redhat.com>
In-Reply-To: <664c3b23-4d19-cda6-dbd7-4a7195a96ec3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjBlOWU0ZTYtYWU0ZC00MjYwLTllNjYtZGNlODBmODM5OGQ5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieEY3SXk1RjYyZzNLRDgrRGQ5SUlGZ1ZCYVVzWTF2dnUyZHZzdVhBZHFudXFWN3VDTm04c0VBTTM0YXBBUWU5MSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgW21haWx0bzpwaGlsbWRAcmVkaGF0LmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEp1
bHkgMTgsIDIwMTkgNjo1NCBQTQ0KPiBUbzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPg0KPiBDYzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPjsNCj4gSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT47IHFlbXUtZGV2IDxxZW11LWRldmVsQG5vbmdudS5vcmc+Ow0KPiBaaGFu
ZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxd
IFtQQVRDSCBWM10gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5IGxlYWsNCj4gYW5kIGNv
ZGUgc3R5bGUgaXNzdWUuDQo+IA0KPiBPbiA3LzE4LzE5IDEyOjM3IFBNLCBQZXRlciBNYXlkZWxs
IHdyb3RlOg0KPiA+IE9uIFRodSwgMTggSnVsIDIwMTkgYXQgMTE6MjgsIFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4+DQo+ID4+IE9uIDcv
MTgvMTkgMTE6MjIgQU0sIFpoYW5nIENoZW4gd3JvdGU6DQo+ID4+PiBGcm9tOiBaaGFuZyBDaGVu
IDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPj4+DQo+ID4+PiBUaGlzIHBhdGNoIHRvIGZpeCB0
aGUgb3JpZ2luICJjaGFyICpkYXRhIiBtZW5vcnkgbGVhaywgY29kZSBzdHlsZQ0KPiA+Pj4gaXNz
dWUNCj4gPj4NCj4gPj4gIm1lbW9yeSINCg0KT2gsIEkgd2lsbCBmaXggdGhpcyB0eXBvIGluIG5l
eHQgdmVyc2lvbi4NCg0KPiA+Pg0KPiA+Pj4gYW5kIGFkZCBuZWNlc3NhcnkgY2hlY2sgaGVyZS4N
Cj4gPj4+IFJlcG9ydGVkLWJ5OiBDb3Zlcml0eSAoQ0lEIDE0MDI3ODUpDQo+ID4+Pg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+ID4+PiAt
LS0NCj4gPj4+ICBuZXQvY29sby1jb21wYXJlLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL25ldC9jb2xvLWNvbXBhcmUuYyBiL25l
dC9jb2xvLWNvbXBhcmUuYyBpbmRleA0KPiA+Pj4gOTA5ZGQ2YzZlYi4uZmNjY2I0YzZmNiAxMDA2
NDQNCj4gPj4+IC0tLSBhL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+Pj4gKysrIGIvbmV0L2NvbG8t
Y29tcGFyZS5jDQo+ID4+PiBAQCAtMTI3LDYgKzEyNywxNyBAQCBzdGF0aWMgaW50IGNvbXBhcmVf
Y2hyX3NlbmQoQ29tcGFyZVN0YXRlICpzLA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCB2bmV0X2hkcl9sZW4sDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJvb2wgbm90aWZ5X3JlbW90ZV9mcmFtZSk7DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyBi
b29sIHBhY2tldF9tYXRjaGVzX3N0cihjb25zdCBjaGFyICpzdHIsDQo+ID4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQ4X3QgKmJ1ZiwNCj4gPj4NCj4gPj4gWW91IGNhbiB1
c2UgJ3VpbnQ4X3QgKmJ1ZicuDQo+ID4NCj4gPiA/PyB0aGF0IHNlZW1zIHRvIGJlIHRoZSBzYW1l
IGFzIHdoYXQgaXMgd3JpdHRlbi4uLg0KPiANCj4gT29wcyBzb3JyeSwgSSBjb3B5L3Bhc3RlZCBh
bmQgIGRpZCBub3Qgbm90aWNlZCBJIHJlbW92ZWQgdGhlICdjb25zdCcNCj4gd29yZC4gU28gSSBt
ZWFudDogWW91IGNhbiB1c2UgJ2NvbnN0IHVpbnQ4X3QgKmJ1ZicNCg0KT0suDQoNClRoYW5rcw0K
WmhhbmcgQ2hlbg0KDQo+IA0KPiA+Pg0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50MzJfdCBwYWNrZXRfbGVuKSB7DQo+ID4+PiArICAgIGlmIChwYWNrZXRfbGVuICE9
IHN0cmxlbihzdHIpKSB7DQo+ID4+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4+PiArICAg
IH0NCj4gPj4+ICsNCj4gPj4+ICsgICAgcmV0dXJuICFtZW1jbXAoc3RyLCBidWYsIHN0cmxlbihz
dHIpKTsNCj4gPj4NCj4gPj4gSWYgeW91IGRvbid0IHdhbnQgdG8gdXNlIGEgbG9jYWwgdmFyaWFi
bGUgdG8gaG9sZCBzdHJsZW4oc3RyKSwgeW91DQo+ID4+IGNhbiByZXVzZSBwYWNrZXRfbGVuIHNp
bmNlIGl0IGlzIHRoZSBzYW1lIHZhbHVlOg0KPiA+Pg0KPiA+PiAgICAgICAgcmV0dXJuICFtZW1j
bXAoc3RyLCBidWYsIHBhY2tldF9sZW4pOw0KPiA+Pg0KPiA+PiBIb3dldmVyIGl0IG1ha2VzIHRo
ZSByZXZpZXcgaGFyZGVyLCBzbyBJJ2QgcHJlZmVyIHVzaW5nIGEgc3RyX2xlbiBsb2NhbCB2YXIu
DQo+ID4NCj4gPiBJJ20gcHJldHR5IHN1cmUgdGhlIGNvbXBpbGVyIGlzIGdvaW5nIHRvIG9wdGlt
aXNlIHRoZQ0KPiA+IHN0cmxlbigpIGF3YXkgaW50byBhIGNvbXBpbGUgdGltZSBjb25zdGFudCBh
bnl3YXksIHNvIHRoaXMgaXMgc29tZXdoYXQNCj4gPiB1bm5lY2Vzc2FyeSBtaWNyby1vcHRpbWlz
YXRpb24gSSB0aGluay4NCj4gDQo+IEkgd2FzIG5vdCBzdXJlLCBJJ20gZ2xhZCB0byBsZWFybiB0
aGF0IDopDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQaGlsLg0K

