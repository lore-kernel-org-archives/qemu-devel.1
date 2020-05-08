Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA990C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B4220746
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B4220746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtHo-0007zh-Nb
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 23:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWtH1-0007aN-O6
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:02:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:23870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWtGy-0002TU-Re
 for qemu-devel@nongnu.org; Thu, 07 May 2020 23:02:02 -0400
IronPort-SDR: RrtGeXEP7JRbb5jfUHN03zVJ927/hGwitTG5SlBwiHird5B/UIai77wBnMrTblbDdaaxnTZr0H
 EK9C/Txt6qIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 20:01:57 -0700
IronPort-SDR: MLLpU74iAF1OeyfjNk60GC6h3aAnXIKnQiG0F1fFGF25gc7HzvZ/CnesrSRQLHJmiAiW3kChNu
 d3dzOJqiPlwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; d="scan'208";a="278811520"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga002.jf.intel.com with ESMTP; 07 May 2020 20:01:57 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 20:01:57 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 May 2020 11:01:54 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Fri, 8 May 2020 11:01:54 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
 and finalize
Thread-Topic: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
 and finalize
Thread-Index: AQHWIf7Cka4G08x9BkqXms8e2TNTRKicoIKA//+pEoCAATuqMA==
Date: Fri, 8 May 2020 03:01:54 +0000
Message-ID: <510971f05e5f448daa935466a682f54f@intel.com>
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
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=chen.zhang@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 23:01:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
cmVzX2V2ZW50IG1heSBjYWxsIHRoZSB1bmluaXRpYWxpemVkIGV2ZW50X2JoLg0KDQpBcyB3ZSBk
aXNjdXNzZWQgb24gNS82LCByZW1vdmUgY29sby1jb21wYXJlIGR1cmluZyBjaGVja3BvaW50IGlz
IGFuIGlsbGVnYWwgb3BlcmF0aW9uLg0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiANCj4gUmVn
YXJkcywNCj4gTHVrYXMgU3RyYXViDQo+IA0KPiA+IE9yIGN1cnJlbnQgY29kZSBoYXZlIHNvbWUg
aXNzdWU/DQo+ID4NCj4gPiBUaGFua3MNCj4gPiBaaGFuZyBDaGVuDQo+ID4NCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBTdHJhdWIgPGx1a2Fzc3RyYXViMkB3ZWIuZGU+DQo+ID4g
PiAtLS0NCj4gPiA+ICBuZXQvY29sby1jb21wYXJlLmMgfCA0NQ0KPiA+ID4gKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDIzIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9uZXQvY29sby1jb21wYXJlLmMgYi9uZXQvY29sby1jb21wYXJlLmMgaW5kZXgNCj4gPiA+
IGM3NTcyZDc1ZTkuLjZmODBiY2VjZTYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvY29sby1jb21w
YXJlLmMNCj4gPiA+ICsrKyBiL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+ID4gQEAgLTEyODMsMTUg
KzEyODMsNiBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gY29sb19jb21wYXJlX2NvbXBsZXRlKFVzZXJD
cmVhdGFibGUgKnVjLCBFcnJvciAqKmVycnApDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcy0+dm5ldF9oZHIpOw0KPiA+ID4gICAgICB9DQo+ID4gPg0KPiA+ID4gLSAgICBxZW11
X211dGV4X2xvY2soJmNvbG9fY29tcGFyZV9tdXRleCk7DQo+ID4gPiAtICAgIGlmICghY29sb19j
b21wYXJlX2FjdGl2ZSkgew0KPiA+ID4gLSAgICAgICAgcWVtdV9tdXRleF9pbml0KCZldmVudF9t
dHgpOw0KPiA+ID4gLSAgICAgICAgcWVtdV9jb25kX2luaXQoJmV2ZW50X2NvbXBsZXRlX2NvbmQp
Ow0KPiA+ID4gLSAgICAgICAgY29sb19jb21wYXJlX2FjdGl2ZSA9IHRydWU7DQo+ID4gPiAtICAg
IH0NCj4gPiA+IC0gICAgUVRBSUxRX0lOU0VSVF9UQUlMKCZuZXRfY29tcGFyZXMsIHMsIG5leHQp
Ow0KPiA+ID4gLSAgICBxZW11X211dGV4X3VubG9jaygmY29sb19jb21wYXJlX211dGV4KTsNCj4g
PiA+IC0NCj4gPiA+ICAgICAgcy0+b3V0X3NlbmRjby5zID0gczsNCj4gPiA+ICAgICAgcy0+b3V0
X3NlbmRjby5jaHIgPSAmcy0+Y2hyX291dDsNCj4gPiA+ICAgICAgcy0+b3V0X3NlbmRjby5ub3Rp
ZnlfcmVtb3RlX2ZyYW1lID0gZmFsc2U7IEBAIC0xMzEyLDYgKzEzMDMsMTYNCj4gPiA+IEBAIHN0
YXRpYyB2b2lkIGNvbG9fY29tcGFyZV9jb21wbGV0ZShVc2VyQ3JlYXRhYmxlICp1YywgRXJyb3Ig
KiplcnJwKQ0KPiA+ID4NCj4gPiA+IGNvbm5lY3Rpb25fZGVzdHJveSk7DQo+ID4gPg0KPiA+ID4g
ICAgICBjb2xvX2NvbXBhcmVfaW90aHJlYWQocyk7DQo+ID4gPiArDQo+ID4gPiArICAgIHFlbXVf
bXV0ZXhfbG9jaygmY29sb19jb21wYXJlX211dGV4KTsNCj4gPiA+ICsgICAgaWYgKCFjb2xvX2Nv
bXBhcmVfYWN0aXZlKSB7DQo+ID4gPiArICAgICAgICBxZW11X211dGV4X2luaXQoJmV2ZW50X210
eCk7DQo+ID4gPiArICAgICAgICBxZW11X2NvbmRfaW5pdCgmZXZlbnRfY29tcGxldGVfY29uZCk7
DQo+ID4gPiArICAgICAgICBjb2xvX2NvbXBhcmVfYWN0aXZlID0gdHJ1ZTsNCj4gPiA+ICsgICAg
fQ0KPiA+ID4gKyAgICBRVEFJTFFfSU5TRVJUX1RBSUwoJm5ldF9jb21wYXJlcywgcywgbmV4dCk7
DQo+ID4gPiArICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZjb2xvX2NvbXBhcmVfbXV0ZXgpOw0KPiA+
ID4gKw0KPiA+ID4gICAgICByZXR1cm47DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IEBAIC0xMzg0
LDE5ICsxMzg1LDYgQEAgc3RhdGljIHZvaWQgY29sb19jb21wYXJlX2ZpbmFsaXplKE9iamVjdCAq
b2JqKQ0KPiA+ID4gICAgICBDb21wYXJlU3RhdGUgKnMgPSBDT0xPX0NPTVBBUkUob2JqKTsNCj4g
PiA+ICAgICAgQ29tcGFyZVN0YXRlICp0bXAgPSBOVUxMOw0KPiA+ID4NCj4gPiA+IC0gICAgcWVt
dV9jaHJfZmVfZGVpbml0KCZzLT5jaHJfcHJpX2luLCBmYWxzZSk7DQo+ID4gPiAtICAgIHFlbXVf
Y2hyX2ZlX2RlaW5pdCgmcy0+Y2hyX3NlY19pbiwgZmFsc2UpOw0KPiA+ID4gLSAgICBxZW11X2No
cl9mZV9kZWluaXQoJnMtPmNocl9vdXQsIGZhbHNlKTsNCj4gPiA+IC0gICAgaWYgKHMtPm5vdGlm
eV9kZXYpIHsNCj4gPiA+IC0gICAgICAgIHFlbXVfY2hyX2ZlX2RlaW5pdCgmcy0+Y2hyX25vdGlm
eV9kZXYsIGZhbHNlKTsNCj4gPiA+IC0gICAgfQ0KPiA+ID4gLQ0KPiA+ID4gLSAgICBpZiAocy0+
aW90aHJlYWQpIHsNCj4gPiA+IC0gICAgICAgIGNvbG9fY29tcGFyZV90aW1lcl9kZWwocyk7DQo+
ID4gPiAtICAgIH0NCj4gPiA+IC0NCj4gPiA+IC0gICAgcWVtdV9iaF9kZWxldGUocy0+ZXZlbnRf
YmgpOw0KPiA+ID4gLQ0KPiA+ID4gICAgICBxZW11X211dGV4X2xvY2soJmNvbG9fY29tcGFyZV9t
dXRleCk7DQo+ID4gPiAgICAgIFFUQUlMUV9GT1JFQUNIKHRtcCwgJm5ldF9jb21wYXJlcywgbmV4
dCkgew0KPiA+ID4gICAgICAgICAgaWYgKHRtcCA9PSBzKSB7DQo+ID4gPiBAQCAtMTQxMSw2ICsx
Mzk5LDE5IEBAIHN0YXRpYyB2b2lkIGNvbG9fY29tcGFyZV9maW5hbGl6ZShPYmplY3QgKm9iaikN
Cj4gPiA+ICAgICAgfQ0KPiA+ID4gICAgICBxZW11X211dGV4X3VubG9jaygmY29sb19jb21wYXJl
X211dGV4KTsNCj4gPiA+DQo+ID4gPiArICAgIHFlbXVfY2hyX2ZlX2RlaW5pdCgmcy0+Y2hyX3By
aV9pbiwgZmFsc2UpOw0KPiA+ID4gKyAgICBxZW11X2Nocl9mZV9kZWluaXQoJnMtPmNocl9zZWNf
aW4sIGZhbHNlKTsNCj4gPiA+ICsgICAgcWVtdV9jaHJfZmVfZGVpbml0KCZzLT5jaHJfb3V0LCBm
YWxzZSk7DQo+ID4gPiArICAgIGlmIChzLT5ub3RpZnlfZGV2KSB7DQo+ID4gPiArICAgICAgICBx
ZW11X2Nocl9mZV9kZWluaXQoJnMtPmNocl9ub3RpZnlfZGV2LCBmYWxzZSk7DQo+ID4gPiArICAg
IH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgaWYgKHMtPmlvdGhyZWFkKSB7DQo+ID4gPiArICAgICAg
ICBjb2xvX2NvbXBhcmVfdGltZXJfZGVsKHMpOw0KPiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4g
PiArICAgIHFlbXVfYmhfZGVsZXRlKHMtPmV2ZW50X2JoKTsNCj4gPiA+ICsNCj4gPiA+ICAgICAg
QWlvQ29udGV4dCAqY3R4ID0gaW90aHJlYWRfZ2V0X2Fpb19jb250ZXh0KHMtPmlvdGhyZWFkKTsN
Cj4gPiA+ICAgICAgYWlvX2NvbnRleHRfYWNxdWlyZShjdHgpOw0KPiA+ID4gICAgICBBSU9fV0FJ
VF9XSElMRShjdHgsICFzLT5vdXRfc2VuZGNvLmRvbmUpOw0KPiA+ID4gLS0NCj4gPiA+IDIuMjAu
MQ0KDQo=

