Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC9C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA732076A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA732076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTIDO-000611-42
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTICZ-0005ae-Lj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:22:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:5135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTICW-0001s7-Ez
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:22:50 -0400
IronPort-SDR: osOyRVAHlIlXn1RWZa999M3zcPtwlLU9S1d5lqNHPtEhNdrl9CXby6BWL8dY84QkAckv75n5K3
 n/Ko4vWm+qLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="154333724"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="154333724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:22:42 -0700
IronPort-SDR: QKaijEWTEg0YYtJFEdTzrFgpfR94zrYbBCaPG12rkog2/dA4AsupKf95asa6vXwebqgQkxzUYj
 DGgobHCqAYQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="300579151"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga007.fm.intel.com with ESMTP; 15 Oct 2020 22:22:42 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Oct 2020 22:22:41 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 13:22:39 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 16 Oct 2020 13:22:39 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 00/10] COLO project queued patches 20-Oct
Thread-Topic: [PATCH 00/10] COLO project queued patches 20-Oct
Thread-Index: AQHWofuZjvvdY5FZRE6KB5kr3NlE86mXxw4AgACGqZCAAK7vgIAAiwcw
Date: Fri, 16 Oct 2020 05:22:39 +0000
Message-ID: <45b4e5f7ee65401698f437e5577a89e6@intel.com>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <7638dbe1-9095-28e2-0b5f-2eeaa5e3f98e@redhat.com>
 <f71889f9bb054cdd8c294028878c739c@intel.com>
 <38af8287-393b-1fdb-9fea-d334ff487d33@redhat.com>
In-Reply-To: <38af8287-393b-1fdb-9fea-d334ff487d33@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=chen.zhang@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 01:22:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDE2LCAyMDIwIDEwOjI0
IEFNDQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBxZW11LWRldiA8
cWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBn
bWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTBdIENPTE8gcHJvamVjdCBxdWV1
ZWQgcGF0Y2hlcyAyMC1PY3QNCj4gDQo+IA0KPiBPbiAyMDIwLzEwLzE1IOS4i+WNiDM6NTgsIFpo
YW5nLCBDaGVuIHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IFRo
dXJzZGF5LCBPY3RvYmVyIDE1LCAyMDIwIDM6NTYgUE0NCj4gPj4gVG86IFpoYW5nLCBDaGVuIDxj
aGVuLnpoYW5nQGludGVsLmNvbT47IHFlbXUtZGV2IDxxZW11LQ0KPiA+PiBkZXZlbEBub25nbnUu
b3JnPg0KPiA+PiBDYzogWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAwMC8xMF0gQ09MTyBwcm9qZWN0IHF1ZXVlZCBwYXRjaGVzIDIwLU9j
dA0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyMDIwLzEwLzE0IOS4i+WNiDM6MjUsIFpoYW5nIENoZW4g
d3JvdGU6DQo+ID4+PiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4g
Pj4+DQo+ID4+PiBIaSBKYXNvbiwgdGhpcyBzZXJpZXMgaW5jbHVkZSBsYXRlc3QgQ09MTyByZWxh
dGVkIHBhdGNoZXMuDQo+ID4+PiBwbGVhc2UgY2hlY2sgYW5kIG1lcmdlIGl0Lg0KPiA+Pj4NCj4g
Pj4+IFRoYW5rcw0KPiA+Pj4gWmhhbmcgQ2hlbg0KPiA+Pg0KPiA+PiBIaToNCj4gPj4NCj4gPj4g
SSB3YW50IHRvIG1lcmdlIGJ1dCBJIGRvbid0IGdldCBwYXRjaCAxMC8xMC4NCj4gPj4NCj4gPj4g
SXMgdGhhdCBsb3N0IGR1cmluZyBwb3N0aW5nPw0KPiA+IE9oLCBTb3JyeSBJIG1pc3NlZCBpdC4N
Cj4gPiBBbHJlYWR5IHJlc2VuZCBpdDoNCj4gPiBbUEFUQ0ggMTAvMTBdIG5ldC9jb2xvLWNvbXBh
cmUuYzogSW5jcmVhc2UgZGVmYXVsdCBxdWV1ZWQgcGFja2V0IHNjYW4NCj4gPiBmcmVxdWVuY3kN
Cj4gPg0KPiA+IFRoYW5rcw0KPiA+IENoZW4NCj4gDQo+IA0KPiBJdCBsb29rcyB0byBtZSBQaGls
aXBwZSBoYXMgc29tZSBtaW5vciBjb21tZW50cyBvbiBzb21lIHBhdGNoZXMsIHBsZWFzZQ0KPiBh
ZGRyZXNzIHRoZW0gYW5kIHNlbmQgYSBuZXcgdmVyc2lvbi4NCg0KU3VyZS4gSSB3aWxsIHVwZGF0
ZSB0byBWMi4NCg0KVGhhbmtzDQpDaGVuDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gDQo+ID4NCj4g
Pj4gVGhhbmtzDQo+ID4+DQo+ID4+DQo+ID4+PiBMaSBaaGlqaWFuICgyKToNCj4gPj4+ICAgICBj
b2xvLWNvbXBhcmU6IGZpeCBtaXNzaW5nIGNvbXBhcmVfc2VxIGluaXRpYWxpemF0aW9uDQo+ID4+
PiAgICAgY29sby1jb21wYXJlOiBjaGVjayBtYXJrIGluIG11dHVhbCBleGNsdXNpb24NCj4gPj4+
DQo+ID4+PiBQYW4gTmVuZ3l1YW4gKDEpOg0KPiA+Pj4gICAgIG5ldC9maWx0ZXItcmV3cml0ZXI6
IGRlc3Ryb3kgZ19oYXNoX3RhYmxlIGluDQo+ID4+PiBjb2xvX3Jld3JpdGVyX2NsZWFudXANCj4g
Pj4+DQo+ID4+PiBSYW8sIExlaSAoMyk6DQo+ID4+PiAgICAgT3B0aW1pemUgc2VxX3NvcnRlciBm
dW5jdGlvbiBmb3IgY29sby1jb21wYXJlDQo+ID4+PiAgICAgUmVkdWNlIHRoZSB0aW1lIG9mIGNo
ZWNrcG9pbnQgZm9yIENPTE8NCj4gPj4+ICAgICBGaXggdGhlIHFlbXUgY3Jhc2ggd2hlbiBndWVz
dCBzaHV0ZG93biBpbiBDT0xPIG1vZGUNCj4gPj4+DQo+ID4+PiBaaGFuZyBDaGVuICg0KToNCj4g
Pj4+ICAgICBuZXQvY29sby1jb21wYXJlLmM6IEZpeCBjb21wYXJlX3RpbWVvdXQgZm9ybWF0IGlz
c3VlDQo+ID4+PiAgICAgbmV0L2NvbG8tY29tcGFyZS5jOiBDaGFuZ2UgdGhlIHRpbWVyIGNsb2Nr
IHR5cGUNCj4gPj4+ICAgICBuZXQvY29sby1jb21wYXJlLmM6IEFkZCBzZWNvbmRhcnkgb2xkIHBh
Y2tldCBkZXRlY3Rpb24NCj4gPj4+ICAgICBuZXQvY29sby1jb21wYXJlLmM6IEluY3JlYXNlIGRl
ZmF1bHQgcXVldWVkIHBhY2tldCBzY2FuDQo+ID4+PiBmcmVxdWVuY3kNCj4gPj4+DQo+ID4+PiAg
ICBtaWdyYXRpb24vcmFtLmMgICAgICAgfCAxNCArKysrKysrKysrLQ0KPiA+Pj4gICAgbmV0L2Nv
bG8tY29tcGFyZS5jICAgIHwgNTcgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gLS0NCj4gPj4+ICAgIG5ldC9jb2xvLmMgICAgICAgICAgICB8ICA1ICstLS0NCj4g
Pj4+ICAgIG5ldC9maWx0ZXItcmV3cml0ZXIuYyB8ICAyICsrDQo+ID4+PiAgICBzb2Z0bW11L3Zs
LmMgICAgICAgICAgfCAgMSArDQo+ID4+PiAgICA1IGZpbGVzIGNoYW5nZWQsIDQ2IGluc2VydGlv
bnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCg0K

