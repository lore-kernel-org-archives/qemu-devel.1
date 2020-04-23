Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10549C55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEE7208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEE7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWKG-0003G9-2D
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRWJO-000254-NG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRWJN-00014C-1d
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:30:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:8173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRWJL-00011L-T1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:30:16 -0400
IronPort-SDR: +sPSEdCkNLlxnFc0bU8k2HibiqjMCcFU0kNM8KPoci+Mx+/AqOlit0nJ7vTRjW2d9gx9h3XE1I
 R+dqnGeqSFxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 00:30:12 -0700
IronPort-SDR: wDUs1ObBnVK8AJyJFdVey6xgRZ1ZKCZdg3XTSpV1+xGV1o3xHw7fQtAeGAUvisIGEj+HyD14Yi
 ZzsDiiz387HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; d="scan'208";a="457415532"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga006.fm.intel.com with ESMTP; 23 Apr 2020 00:30:12 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 00:29:58 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Apr 2020 15:29:56 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 23 Apr 2020 15:29:56 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Topic: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Index: AQHWDdROWO/1QHY6Ok6COLp0/RhfnqiE5E6A//9+GYCAAIrasP//hQ0AgAHzMCA=
Date: Thu, 23 Apr 2020 07:29:56 +0000
Message-ID: <8d0e2a591f1d48baa84d79e7a0f1cbb6@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
 <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com>	<20200422104325.64659930@luklap>
 <0a075de2dc2f4e8c919478762e9a97da@intel.com> <20200422114020.3d479899@luklap>
In-Reply-To: <20200422114020.3d479899@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.20; envelope-from=chen.zhang@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:30:13
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgU3RyYXViIDxs
dWthc3N0cmF1YjJAd2ViLmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIyLCAyMDIwIDU6
NDAgUE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6IHFl
bXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IExpIFpoaWppYW4NCj4gPGxpemhpamlh
bkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBNYXJj
LQ0KPiBBbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQYW9sbyBC
b256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
M10gbmV0L2NvbG8tY29tcGFyZS5jOiBDcmVhdGUgZXZlbnRfYmggd2l0aCB0aGUgcmlnaHQNCj4g
QWlvQ29udGV4dA0KPiANCj4gT24gV2VkLCAyMiBBcHIgMjAyMCAwOTowMzowMCArMDAwMA0KPiAi
WmhhbmcsIENoZW4iIDxjaGVuLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEx1a2FzIFN0cmF1YiA8bHVrYXNz
dHJhdWIyQHdlYi5kZT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMjIsIDIwMjAgNDo0
MyBQTQ0KPiA+ID4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPiA+
IENjOiBxZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBMaSBaaGlqaWFuDQo+ID4g
PiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT47IE1hcmMtDQo+ID4gPiBBbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhh
dC5jb20+OyBQYW9sbyBCb256aW5pDQo+ID4gPiA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBuZXQvY29sby1jb21wYXJlLmM6IENyZWF0ZSBldmVu
dF9iaCB3aXRoDQo+ID4gPiB0aGUgcmlnaHQgQWlvQ29udGV4dA0KPiA+ID4NCj4gPiA+IE9uIFdl
ZCwgMjIgQXByIDIwMjAgMDg6Mjk6MzkgKzAwMDANCj4gPiA+ICJaaGFuZywgQ2hlbiIgPGNoZW4u
emhhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBMdWthcyBTdHJhdWIgPGx1a2Fzc3RyYXViMkB3
ZWIuZGU+DQo+ID4gPiA+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDksIDIwMjAgMjozNCBBTQ0K
PiA+ID4gPiA+IFRvOiBxZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+ID4gPiA+
ID4gQ2M6IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IExpIFpoaWppYW4NCj4g
PiA+ID4gPiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT47DQo+ID4gPiA+ID4gTWFyYy0gQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tPjsgUGFvbG8gQm9uemluaQ0KPiA+ID4gPiA+IDxwYm9uemluaUByZWRo
YXQuY29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSCAxLzNdIG5ldC9jb2xvLWNvbXBhcmUu
YzogQ3JlYXRlIGV2ZW50X2JoIHdpdGgNCj4gPiA+ID4gPiB0aGUgcmlnaHQgQWlvQ29udGV4dA0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gcWVtdV9iaF9uZXcgd2lsbCBzZXQgdGhlIGJoIHRvIGJlIGV4
ZWN1dGVkIGluIHRoZSBtYWluIGxvb3AuDQo+ID4gPiA+ID4gVGhpcyBjYXVzZXMgcHJvYmxlbXMg
YXMgY29sb19jb21wYXJlX2hhbmRsZV9ldmVudCBhc3N1bWVzIHRoYXQNCj4gPiA+ID4gPiBpdCBo
YXMgZXhjbHVzaXZlIGFjY2VzcyB0aGUgcXVldWVzLCB3aGljaCBhcmUgYWxzbyBhY2Nlc3NlZCBp
bg0KPiA+ID4gPiA+IHRoZSBpb3RocmVhZC4gSXQgYWxzbyBhc3N1bWVzIHRoYXQgaXQgcnVucyBp
biBhIGRpZmZlcmVudCB0aHJlYWQNCj4gPiA+ID4gPiB0aGFuIHRoZSBjYWxsZXIgYW5kIHRha2Vz
IHRoZSBhcHByb3ByaWF0ZSBsb2Nrcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENyZWF0ZSB0aGUg
Ymggd2l0aCB0aGUgQWlvQ29udGV4dCBvZiB0aGUgaW90aHJlYWQgdG8gZnVsZmlsbA0KPiA+ID4g
PiA+IHRoZXNlIGFzc3VtcHRpb25zLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IExvb2tz
IGdvb2QgZm9yIG1lLCBJIGFzc3VtZSBpdCB3aWxsIGluY3JlYXNlIHBlcmZvcm1hbmNlLiBEbyB5
b3UNCj4gPiA+ID4gaGF2ZQ0KPiA+ID4gcmVsYXRlZCBkYXRhPw0KPiA+ID4NCj4gPiA+IE5vLCB0
aGlzIGZpeGVzIHNldmVyYWwgY3Jhc2hlcyBiZWNhdXNlIHRoZSBxdWV1ZXMgd2hlcmUgYWNjZXNz
ZWQNCj4gPiA+IGNvbmN1cnJlbnRseSBmcm9tIG11bHRpcGxlIHRocmVhZHMuIFNvcnJ5IGZvciBt
eSBiYWQgd29yZGluZy4NCj4gPg0KPiA+IENhbiB5b3UgZGVzY3JpYmUgc29tZSBkZXRhaWxzIGFi
b3V0IHRoZSBjcmFzaD8gU3RlcCBieSBzdGVwPw0KPiA+IE1heWJlIEkgY2FuIHJlLXByb2R1Y2Ug
YW5kIHRlc3QgaXQgZm9yIHRoaXMgcGF0Y2guDQo+IA0KPiBUaGVyZSBpcyBubyBjbGVhciB0ZXN0
IGNhc2UuIEZvciBtZSB0aGUgY3Jhc2hlcyBoYXBwZW5lZCBhZnRlciAxLTIwaCBvZg0KPiBydW50
aW1lIHdpdGggbG90cyBvZiBjaGVja3BvaW50cyAoODAwbXMpIGFuZCBzb21lIG5ldHdvcmsgdHJh
ZmZpYy4gVGhlDQo+IGNvcmVkdW1wIGFsd2F5cyBzaG93ZWQgdGhhdCB0d28gdGhyZWFkcyB3aGVy
ZSBkb2luZyBvcGVyYXRpb25zIG9uIHRoZQ0KPiBxdWV1ZXMgc2ltdWx0YW5lb3VzbHkuDQo+IFVu
Zm9ydHVuYXRlbHksIEkgZG9uJ3QgaGF2ZSB0aGUgY29yZWR1bXBzIGFueW1vcmUuDQoNCk9LLCBB
bHRob3VnaCBJIGhhdmUgbm90IGVuY291bnRlcmVkIHRoZSBwcm9ibGVtIHlvdSBkZXNjcmliZWQu
DQpJIGhhdmUgdGVzdCB0aGlzIHBhdGNoLCBsb29rcyBydW5uaW5nIGZpbmUuDQoNClJldmlld2Vk
LWJ5OiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGFuZyBD
aGVuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1a2FzIFN0cmF1Yg0KPiANCj4gPiBUaGFua3MNCj4g
PiBaaGFuZyBDaGVuDQo+ID4NCj4gPiA+DQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gTHVrYXMgU3Ry
YXViDQo+ID4gPg0KPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4gWmhhbmcgQ2hlbg0KPiA+ID4gPg0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2FzIFN0cmF1YiA8bHVrYXNzdHJhdWIyQHdlYi5k
ZT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgbmV0L2NvbG8tY29tcGFyZS5jIHwgMyArKy0N
Cj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jb2xvLWNvbXBhcmUuYyBi
L25ldC9jb2xvLWNvbXBhcmUuYyBpbmRleA0KPiA+ID4gPiA+IDEwYzAyMzlmOWQuLjFkZTQyMjBm
ZTIgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gPiA+ID4g
KysrIGIvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gPiA+ID4gQEAgLTg5MCw2ICs4OTAsNyBAQCBz
dGF0aWMgdm9pZCBjb2xvX2NvbXBhcmVfaGFuZGxlX2V2ZW50KHZvaWQNCj4gPiA+ID4gPiAqb3Bh
cXVlKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIHN0YXRpYyB2b2lkIGNvbG9fY29tcGFyZV9pb3Ro
cmVhZChDb21wYXJlU3RhdGUgKnMpICB7DQo+ID4gPiA+ID4gKyAgICBBaW9Db250ZXh0ICpjdHgg
PSBpb3RocmVhZF9nZXRfYWlvX2NvbnRleHQocy0+aW90aHJlYWQpOw0KPiA+ID4gPiA+ICAgICAg
b2JqZWN0X3JlZihPQkpFQ1Qocy0+aW90aHJlYWQpKTsNCj4gPiA+ID4gPiAgICAgIHMtPndvcmtl
cl9jb250ZXh0ID0NCj4gPiA+ID4gPiBpb3RocmVhZF9nZXRfZ19tYWluX2NvbnRleHQocy0+aW90
aHJlYWQpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQEAgLTkwNiw3ICs5MDcsNyBAQCBzdGF0aWMg
dm9pZA0KPiA+ID4gPiA+IGNvbG9fY29tcGFyZV9pb3RocmVhZChDb21wYXJlU3RhdGUNCj4gPiA+
ICpzKQ0KPiA+ID4gPiA+ICAgICAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICAgICBjb2xvX2Nv
bXBhcmVfdGltZXJfaW5pdChzKTsNCj4gPiA+ID4gPiAtICAgIHMtPmV2ZW50X2JoID0gcWVtdV9i
aF9uZXcoY29sb19jb21wYXJlX2hhbmRsZV9ldmVudCwgcyk7DQo+ID4gPiA+ID4gKyAgICBzLT5l
dmVudF9iaCA9IGFpb19iaF9uZXcoY3R4LCBjb2xvX2NvbXBhcmVfaGFuZGxlX2V2ZW50LA0KPiA+
ID4gPiA+ICsgcyk7DQo+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICBzdGF0aWMg
Y2hhciAqY29tcGFyZV9nZXRfcHJpX2luZGV2KE9iamVjdCAqb2JqLCBFcnJvciAqKmVycnApDQo+
ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiAyLjIwLjENCj4gPiA+ID4NCj4gPg0KDQo=

