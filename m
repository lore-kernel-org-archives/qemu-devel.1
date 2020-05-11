Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E23C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B6720720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 08:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B6720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY3tK-0008Ge-U6
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 04:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jY3sV-0007K2-Nv
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:33:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:52877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jY3sT-0007BB-Fg
 for qemu-devel@nongnu.org; Mon, 11 May 2020 04:33:35 -0400
IronPort-SDR: GDHkwRy38A0yWSAGyqEGjqACFTvoaB+CSca0K6c0hDDqX5SRtdnXYZLaTkb35oDF/sjb8AnKwi
 ZEhjGnmIJqrg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 01:33:31 -0700
IronPort-SDR: bVbCq90EJiJcC9/H+jh8529JnP8bLxtsrmqgqh+o/3+wIdFmNlutYdasXZxds1RTYnRnF/Yu5Q
 bpkJ6+Ixxtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; d="scan'208";a="297614068"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 11 May 2020 01:33:30 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 May 2020 01:33:30 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 May 2020 16:33:28 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Mon, 11 May 2020 16:33:28 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
 and finalize
Thread-Topic: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
 and finalize
Thread-Index: AQHWIf7Cka4G08x9BkqXms8e2TNTRKicoIKA//+pEoCABk/3oA==
Date: Mon, 11 May 2020 08:33:28 +0000
Message-ID: <39a98b8878634a80aaad6ee6e7510274@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <ac784f17537184c3ab8c745a1d593b02bde85738.1588587700.git.lukasstraub2@web.de>
 <83c26ab24d28480d94c45c0a0f49d130@intel.com> <20200507180909.06165172@luklap>
In-Reply-To: <20200507180909.06165172@luklap>
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
Received-SPF: pass client-ip=134.134.136.24; envelope-from=chen.zhang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 04:33:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgU3RyYXViIDxs
dWthc3N0cmF1YjJAd2ViLmRlPg0KPiBTZW50OiBGcmlkYXksIE1heSA4LCAyMDIwIDEyOjA5IEFN
DQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+IENjOiBxZW11LWRl
dmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBMaSBaaGlqaWFuDQo+IDxsaXpoaWppYW5AY24u
ZnVqaXRzdS5jb20+OyBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgTWFyYy0NCj4g
QW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgUGFvbG8gQm9uemlu
aQ0KPiA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA2LzZd
IG5ldC9jb2xvLWNvbXBhcmUuYzogQ29ycmVjdCBvcmRlcmluZyBpbg0KPiBjb21wbGV0ZSBhbmQg
ZmluYWxpemUNCj4gDQo+IE9uIFRodSwgNyBNYXkgMjAyMCAxMzoyNjoxMSArMDAwMA0KPiAiWmhh
bmcsIENoZW4iIDxjaGVuLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEx1a2FzIFN0cmF1YiA8bHVrYXNzdHJh
dWIyQHdlYi5kZT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDQsIDIwMjAgNjoyOCBQTQ0KPiA+
ID4gVG86IHFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPiA+IENjOiBaaGFu
ZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMaSBaaGlqaWFuDQo+ID4gPiA8bGl6aGlq
aWFuQGNuLmZ1aml0c3UuY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IE1h
cmMtDQo+ID4gPiBBbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBQ
YW9sbyBCb256aW5pDQo+ID4gPiA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gPiA+IFN1YmplY3Q6
IFtQQVRDSCB2NCA2LzZdIG5ldC9jb2xvLWNvbXBhcmUuYzogQ29ycmVjdCBvcmRlcmluZyBpbg0K
PiA+ID4gY29tcGxldGUgYW5kIGZpbmFsaXplDQo+ID4gPg0KPiA+ID4gSW4gY29sb19jb21wYXJl
X2NvbXBsZXRlLCBpbnNlcnQgQ29tcGFyZVN0YXRlIGludG8gbmV0X2NvbXBhcmVzDQo+IG9ubHkN
Cj4gPiA+IGFmdGVyIGV2ZXJ5dGhpbmcgaGFzIGJlZW4gaW5pdGlhbGl6ZWQuDQo+ID4gPiBJbiBj
b2xvX2NvbXBhcmVfZmluYWxpemUsIHJlbW92ZSBDb21wYXJlU3RhdGUgZnJvbSBuZXRfY29tcGFy
ZXMNCj4gPiA+IGJlZm9yZSBhbnl0aGluZyBpcyBkZWluaXRpYWxpemVkLg0KPiA+DQo+ID4gUy9k
ZWluaXRpYWxpemVkL2ZpbmFsaXplZA0KPiA+DQo+ID4gSXQgbG9va3Mgbm8gZGVwZW5kZW5jZXMg
b24gZWFjaCBzdGVwIG9uIGluaXRpYWxpemF0aW9uIGFuZCBmaW5hbGl6YXRpb24uDQo+ID4gRG8g
eW91IG1lYW5zIHdlIGp1c3QgbmVlZCBhZGQvcmVtb3ZlIGVhY2ggY29sby1jb21wYXJlIG1vZHVs
ZSBhdCBsYXN0DQo+IGluIGxvZ2ljPw0KPiANCj4gWWVzLiBXaGlsZSBJIGRpZG4ndCBzZWUgYW55
IGNyYXNoZXMgaGVyZSwgdGhlcmUgaXMgdGhlIHBvc3NpYmlsaXR5IHRoYXQgaWYgY29sby0NCj4g
Y29tcGFyZSBpcyByZW1vdmVkIGR1cmluZyBjaGVja3BvaW50LCB0aGUgZGVzdHJveWVkIGV2ZW50
X2JoIGlzIGNhbGxlZA0KPiBmcm9tIGNvbG9fbm90aWZ5X2NvbXBhcmVzX2V2ZW50LiBTYW1lIHdp
dGggY29sb19jb21wYXJlX2NvbXBsZXRlDQo+ICh2ZXJ5IHVubGlrZWx5KSBpZiBjb2xvLWNvbXBh
cmUgaXMgY3JlYXRlZCB3aGlsZSBjb2xvIGlzIHJ1bm5pbmcsDQo+IGNvbG9fbm90aWZ5X2NvbXBh
cmVzX2V2ZW50IG1heSBjYWxsIHRoZSB1bmluaXRpYWxpemVkIGV2ZW50X2JoLg0KPiANCg0KUmV2
aWV3ZWQtYnk6IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KDQpUaGFua3MNClpo
YW5nIENoZW4NCg0KPiBSZWdhcmRzLA0KPiBMdWthcyBTdHJhdWINCj4gDQo+ID4gT3IgY3VycmVu
dCBjb2RlIGhhdmUgc29tZSBpc3N1ZT8NCj4gPg0KPiA+IFRoYW5rcw0KPiA+IFpoYW5nIENoZW4N
Cj4gPg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEx1a2FzIFN0cmF1YiA8bHVrYXNzdHJh
dWIyQHdlYi5kZT4NCj4gPiA+IC0tLQ0KPiA+ID4gIG5ldC9jb2xvLWNvbXBhcmUuYyB8IDQ1DQo+
ID4gPiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jb2xvLWNvbXBhcmUuYyBiL25ldC9jb2xvLWNvbXBh
cmUuYyBpbmRleA0KPiA+ID4gYzc1NzJkNzVlOS4uNmY4MGJjZWNlNiAxMDA2NDQNCj4gPiA+IC0t
LSBhL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+ID4gKysrIGIvbmV0L2NvbG8tY29tcGFyZS5jDQo+
ID4gPiBAQCAtMTI4MywxNSArMTI4Myw2IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiBjb2xvX2NvbXBh
cmVfY29tcGxldGUoVXNlckNyZWF0YWJsZSAqdWMsIEVycm9yICoqZXJycCkNCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzLT52bmV0X2hkcik7DQo+ID4gPiAgICAgIH0NCj4gPiA+
DQo+ID4gPiAtICAgIHFlbXVfbXV0ZXhfbG9jaygmY29sb19jb21wYXJlX211dGV4KTsNCj4gPiA+
IC0gICAgaWYgKCFjb2xvX2NvbXBhcmVfYWN0aXZlKSB7DQo+ID4gPiAtICAgICAgICBxZW11X211
dGV4X2luaXQoJmV2ZW50X210eCk7DQo+ID4gPiAtICAgICAgICBxZW11X2NvbmRfaW5pdCgmZXZl
bnRfY29tcGxldGVfY29uZCk7DQo+ID4gPiAtICAgICAgICBjb2xvX2NvbXBhcmVfYWN0aXZlID0g
dHJ1ZTsNCj4gPiA+IC0gICAgfQ0KPiA+ID4gLSAgICBRVEFJTFFfSU5TRVJUX1RBSUwoJm5ldF9j
b21wYXJlcywgcywgbmV4dCk7DQo+ID4gPiAtICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZjb2xvX2Nv
bXBhcmVfbXV0ZXgpOw0KPiA+ID4gLQ0KPiA+ID4gICAgICBzLT5vdXRfc2VuZGNvLnMgPSBzOw0K
PiA+ID4gICAgICBzLT5vdXRfc2VuZGNvLmNociA9ICZzLT5jaHJfb3V0Ow0KPiA+ID4gICAgICBz
LT5vdXRfc2VuZGNvLm5vdGlmeV9yZW1vdGVfZnJhbWUgPSBmYWxzZTsgQEAgLTEzMTIsNiArMTMw
MywxNg0KPiA+ID4gQEAgc3RhdGljIHZvaWQgY29sb19jb21wYXJlX2NvbXBsZXRlKFVzZXJDcmVh
dGFibGUgKnVjLCBFcnJvciAqKmVycnApDQo+ID4gPg0KPiA+ID4gY29ubmVjdGlvbl9kZXN0cm95
KTsNCj4gPiA+DQo+ID4gPiAgICAgIGNvbG9fY29tcGFyZV9pb3RocmVhZChzKTsNCj4gPiA+ICsN
Cj4gPiA+ICsgICAgcWVtdV9tdXRleF9sb2NrKCZjb2xvX2NvbXBhcmVfbXV0ZXgpOw0KPiA+ID4g
KyAgICBpZiAoIWNvbG9fY29tcGFyZV9hY3RpdmUpIHsNCj4gPiA+ICsgICAgICAgIHFlbXVfbXV0
ZXhfaW5pdCgmZXZlbnRfbXR4KTsNCj4gPiA+ICsgICAgICAgIHFlbXVfY29uZF9pbml0KCZldmVu
dF9jb21wbGV0ZV9jb25kKTsNCj4gPiA+ICsgICAgICAgIGNvbG9fY29tcGFyZV9hY3RpdmUgPSB0
cnVlOw0KPiA+ID4gKyAgICB9DQo+ID4gPiArICAgIFFUQUlMUV9JTlNFUlRfVEFJTCgmbmV0X2Nv
bXBhcmVzLCBzLCBuZXh0KTsNCj4gPiA+ICsgICAgcWVtdV9tdXRleF91bmxvY2soJmNvbG9fY29t
cGFyZV9tdXRleCk7DQo+ID4gPiArDQo+ID4gPiAgICAgIHJldHVybjsNCj4gPiA+ICB9DQo+ID4g
Pg0KPiA+ID4gQEAgLTEzODQsMTkgKzEzODUsNiBAQCBzdGF0aWMgdm9pZCBjb2xvX2NvbXBhcmVf
ZmluYWxpemUoT2JqZWN0ICpvYmopDQo+ID4gPiAgICAgIENvbXBhcmVTdGF0ZSAqcyA9IENPTE9f
Q09NUEFSRShvYmopOw0KPiA+ID4gICAgICBDb21wYXJlU3RhdGUgKnRtcCA9IE5VTEw7DQo+ID4g
Pg0KPiA+ID4gLSAgICBxZW11X2Nocl9mZV9kZWluaXQoJnMtPmNocl9wcmlfaW4sIGZhbHNlKTsN
Cj4gPiA+IC0gICAgcWVtdV9jaHJfZmVfZGVpbml0KCZzLT5jaHJfc2VjX2luLCBmYWxzZSk7DQo+
ID4gPiAtICAgIHFlbXVfY2hyX2ZlX2RlaW5pdCgmcy0+Y2hyX291dCwgZmFsc2UpOw0KPiA+ID4g
LSAgICBpZiAocy0+bm90aWZ5X2Rldikgew0KPiA+ID4gLSAgICAgICAgcWVtdV9jaHJfZmVfZGVp
bml0KCZzLT5jaHJfbm90aWZ5X2RldiwgZmFsc2UpOw0KPiA+ID4gLSAgICB9DQo+ID4gPiAtDQo+
ID4gPiAtICAgIGlmIChzLT5pb3RocmVhZCkgew0KPiA+ID4gLSAgICAgICAgY29sb19jb21wYXJl
X3RpbWVyX2RlbChzKTsNCj4gPiA+IC0gICAgfQ0KPiA+ID4gLQ0KPiA+ID4gLSAgICBxZW11X2Jo
X2RlbGV0ZShzLT5ldmVudF9iaCk7DQo+ID4gPiAtDQo+ID4gPiAgICAgIHFlbXVfbXV0ZXhfbG9j
aygmY29sb19jb21wYXJlX211dGV4KTsNCj4gPiA+ICAgICAgUVRBSUxRX0ZPUkVBQ0godG1wLCAm
bmV0X2NvbXBhcmVzLCBuZXh0KSB7DQo+ID4gPiAgICAgICAgICBpZiAodG1wID09IHMpIHsNCj4g
PiA+IEBAIC0xNDExLDYgKzEzOTksMTkgQEAgc3RhdGljIHZvaWQgY29sb19jb21wYXJlX2ZpbmFs
aXplKE9iamVjdCAqb2JqKQ0KPiA+ID4gICAgICB9DQo+ID4gPiAgICAgIHFlbXVfbXV0ZXhfdW5s
b2NrKCZjb2xvX2NvbXBhcmVfbXV0ZXgpOw0KPiA+ID4NCj4gPiA+ICsgICAgcWVtdV9jaHJfZmVf
ZGVpbml0KCZzLT5jaHJfcHJpX2luLCBmYWxzZSk7DQo+ID4gPiArICAgIHFlbXVfY2hyX2ZlX2Rl
aW5pdCgmcy0+Y2hyX3NlY19pbiwgZmFsc2UpOw0KPiA+ID4gKyAgICBxZW11X2Nocl9mZV9kZWlu
aXQoJnMtPmNocl9vdXQsIGZhbHNlKTsNCj4gPiA+ICsgICAgaWYgKHMtPm5vdGlmeV9kZXYpIHsN
Cj4gPiA+ICsgICAgICAgIHFlbXVfY2hyX2ZlX2RlaW5pdCgmcy0+Y2hyX25vdGlmeV9kZXYsIGZh
bHNlKTsNCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+ID4gKyAgICBpZiAocy0+aW90aHJlYWQp
IHsNCj4gPiA+ICsgICAgICAgIGNvbG9fY29tcGFyZV90aW1lcl9kZWwocyk7DQo+ID4gPiArICAg
IH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgcWVtdV9iaF9kZWxldGUocy0+ZXZlbnRfYmgpOw0KPiA+
ID4gKw0KPiA+ID4gICAgICBBaW9Db250ZXh0ICpjdHggPSBpb3RocmVhZF9nZXRfYWlvX2NvbnRl
eHQocy0+aW90aHJlYWQpOw0KPiA+ID4gICAgICBhaW9fY29udGV4dF9hY3F1aXJlKGN0eCk7DQo+
ID4gPiAgICAgIEFJT19XQUlUX1dISUxFKGN0eCwgIXMtPm91dF9zZW5kY28uZG9uZSk7DQo+ID4g
PiAtLQ0KPiA+ID4gMi4yMC4xDQoNCg==

