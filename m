Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5841EC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 09:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2639C2072B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 09:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2639C2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it6c4-0005iT-Az
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 04:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1it6bS-0005EA-CM
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 04:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1it6bQ-0001YH-68
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 04:10:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:54487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1it6bP-0001S1-SP
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 04:10:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jan 2020 01:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,337,1574150400"; d="scan'208";a="426452065"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga006.fm.intel.com with ESMTP; 19 Jan 2020 01:10:26 -0800
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 19 Jan 2020 01:10:25 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 19 Jan 2020 17:10:23 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Sun, 19 Jan 2020 17:10:23 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH V4 0/5] Introduce Advanced Watch Dog module
Thread-Topic: [PATCH V4 0/5] Introduce Advanced Watch Dog module
Thread-Index: AQHVtNkQRvIivFPjlkOOUrHE3VnstKfevUyAgBKjcBA=
Date: Sun, 19 Jan 2020 09:10:23 +0000
Message-ID: <0502a0db0a17484c9220b3a63c40b397@intel.com>
References: <20191217124554.30818-1-chen.zhang@intel.com>
 <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
In-Reply-To: <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzg4ZmM2ODctOWVjNy00NzBkLWFmNDUtNzVlZjc4Y2NlY2QxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQnhwZFVhS1wvRlJ3OVFxQ1Bqc1BWWFwvdElxVDZWN2NLUzBHODIrKys4N2JGcFwvTFh2bEYrQnlCdEVHcGIwWU9UOCJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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

SGl+DQoNCkFueW9uZSBoYXZlIGNvbW1lbnRzIGFib3V0IHRoaXMgbW9kdWxlPw0KV2UgaGF2ZSBz
b21lIGNsaWVudHMgYWxyZWFkeSB0cnkgdG8gdXNlIHRoaXMgbW9kdWxlIHdpdGggQ09MTy4gUGxl
YXNlIHJldmlldyB0aGlzIHBhcnQuDQpJZiBubyBvbmUgd2FudCB0byBtYWludGFpbiB0aGlzIG1v
ZHVsZSwgSSBjYW4gbWFpbnRhaW4gdGhpcyBtb2R1bGUgbXlzZWxmLg0KDQpUaGFua3MNClpoYW5n
IENoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRZW11LWRldmVs
IDxxZW11LWRldmVsLQ0KPiBib3VuY2VzK2NoZW4uemhhbmc9aW50ZWwuY29tQG5vbmdudS5vcmc+
IE9uIEJlaGFsZiBPZiBaaGFuZywgQ2hlbg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDcsIDIw
MjAgMTI6MzMgUE0NCj4gVG86IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBQYW9s
byBCb256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPjsgUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEByZWRoYXQuY29tPjsNCj4gcWVtdS1kZXYgPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz4NCj4gQ2M6IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggVjQgMC81XSBJbnRyb2R1Y2UgQWR2YW5jZWQgV2F0Y2ggRG9nIG1vZHVsZQ0KPiAN
Cj4gSGkgQWxsLA0KPiANCj4gTm8gbmV3cyBmb3IgYSB3aGlsZSBhYm91dCB0aGlzIHNlcmllcy4N
Cj4gDQo+IFRoaXMgdmVyc2lvbiBhbHJlYWR5IGFkZCBuZXcgZG9jcyB0byBhZGRyZXNzIFBhb2xv
J3MgY29tbWVudHMuDQo+IA0KPiBQbGVhc2UgZ2l2ZSBtZSBtb3JlIGNvbW1lbnRzLg0KPiANCj4g
DQo+IFRoYW5rcw0KPiANCj4gWmhhbmcgQ2hlbg0KPiANCj4gDQo+IE9uIDEyLzE3LzIwMTkgODo0
NSBQTSwgWmhhbmcsIENoZW4gd3JvdGU6DQo+ID4gRnJvbTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFu
Z0BpbnRlbC5jb20+DQo+ID4NCj4gPiBBZHZhbmNlZCBXYXRjaCBEb2cgaXMgYW4gdW5pdmVyc2Fs
IG1vbml0b3JpbmcgbW9kdWxlIG9uIFZNTSBzaWRlLCBpdA0KPiA+IGNhbiBiZSB1c2VkIHRvIGRl
dGVjdCBuZXR3b3JrIGRvd24oVk1NIHRvIGd1ZXN0LCBWTU0gdG8gVk1NLCBWTU0NCj4gdG8NCj4g
PiBhbm90aGVyIHJlbW90ZSBzZXJ2ZXIpIGFuZCBkbyBwcmV2aW91c2x5IHNldCBvcGVyYXRpb24u
IEN1cnJlbnQgQVdEDQo+ID4gcGF0Y2gganVzdCBhY2NlcHQgYW55IGlucHV0IGFzIHRoZSBzaWdu
YWwgdG8gcmVmcmVzaCB0aGUgd2F0Y2hkb2cNCj4gPiB0aW1lciwgYW5kIHdlIGNhbiBhbHNvIG1h
a2UgYSBjZXJ0YWluIGludGVyYWN0aXZlIHByb3RvY29sIGhlcmUuIEZvcg0KPiA+IHRoZSBvdXRw
dXRzLCB1c2VyIGNhbiBwcmUtd3JpdGUgc29tZSBjb21tYW5kIG9yIHNvbWUgbWVzc2FnZXMgaW4g
dGhlDQo+ID4gQVdEIG9wdC1zY3JpcHQuIFdlIG5vdGljZWQgdGhhdCB0aGVyZSBpcyBubyB3YXkg
Zm9yIFZNTSBjb21tdW5pY2F0ZQ0KPiA+IGRpcmVjdGx5LCBtYXliZSBzb21lIHBlb3BsZSB0aGlu
ayB3ZSBkb24ndCBuZWVkIHN1Y2ggdGhpbmdzKHVwIGxheWVyDQo+ID4gc29mdHdhcmUgbGlrZSBv
cGVuc3RhY2sgY2FuIGhhbmRsZSBpdCkuIHNvIHdlIGVuZ2FnZWQgd2l0aCByZWFsDQo+ID4gY3Vz
dG9tZXIgZm91bmQgdGhhdCB0aGV5IG5lZWQgYSBsaWdodHdlaWdodCBhbmQgZWZmaWNpZW50IG1l
Y2hhbmlzbSB0bw0KPiA+IHNvbHZlIHNvbWUgcHJhY3RpY2FsIHByb2JsZW1zLA0KPiA+DQo+ID4g
Rm9yIGV4YW1wbGUgRWRnZSBDb21wdXRpbmcgY2FzZXModGhleSB0aGluayBoaWdoIGxldmVsIHNv
ZnR3YXJlIGlzIHRvbw0KPiA+IGhlYXZ5IHRvIHVzZSBpbiBFZGdlIG9yIGl0IGlzIGhhcmQgdG8g
bWFuYWdlIGFuZCBjb21iaW5lIHdpdGggVk0gaW5zdGFuY2UpLg0KPiA+IEl0IG1ha2UgdXNlciBo
YXZlIGJhc2ljIFZNL0hvc3QgbmV0d29yayBtb25pdG9yaW5nIHRvb2xzIGFuZCBiYXNpYw0KPiA+
IGZhbHNlIHRvbGVyYW5jZSBhbmQgcmVjb3Zlcnkgc29sdXRpb24uLg0KPiA+DQo+ID4gUGxlYXNl
IHNlZSB0aGUgZGV0YWlsIGRvY3VtZW50YXRpb24gaW4gdGhlIGxhc3QgcGF0Y2guDQo+ID4NCj4g
PiBWNDoNCj4gPiAgIC0gQWRkIG1vcmUgaW50cm9kdWN0aW9uIGluIHFlbXUtb3B0aW9ucy5oeA0K
PiA+ICAgLSBBZGRyZXNzZWQgUGFvbG8ncyBjb21tZW50cyBhZGQgZG9jcy9hd2QudHh0IGZvciB0
aGUgQVdEIG1vZHVsZQ0KPiBkZXRhaWwuDQo+ID4NCj4gPiBWMzoNCj4gPiAgIC0gUmViYXNlZCBv
biBRZW11IDQuMi4wLXJjMSBjb2RlLg0KPiA+ICAgLSBGaXggY29tbWl0IG1lc3NhZ2UgaXNzdWUu
DQo+ID4NCj4gPiBWMjoNCj4gPiAgIC0gQWRkcmVzc2VkIFBoaWxpcHBlIGNvbW1lbnRzIGFkZCBj
b25maWd1cmUgc2VsZWN0b3IgZm9yIEFXRC4NCj4gPg0KPiA+IEluaXRpYWw6DQo+ID4gICAtIElu
aXRpYWwgdmVyc2lvbi4NCj4gPg0KPiA+DQo+ID4gWmhhbmcgQ2hlbiAoNSk6DQo+ID4gICAgbmV0
L2F3ZC5jOiBJbnRyb2R1Y2UgQWR2YW5jZWQgV2F0Y2ggRG9nIG1vZHVsZSBmcmFtZXdvcmsNCj4g
PiAgICBuZXQvYXdkLmM6IEluaXRhaWxpemUgaW5wdXQvb3V0cHV0IGNoYXJkZXYNCj4gPiAgICBu
ZXQvYXdkLmM6IExvYWQgYWR2YW5jZWQgd2F0Y2ggZG9nIHdvcmtlciB0aHJlYWQgam9iDQo+ID4g
ICAgdmwuYzogTWFrZSBBZHZhbmNlZCBXYXRjaCBEb2cgZGVsYXllZCBpbml0aWFsaXphdGlvbg0K
PiA+ICAgIGRvY3MvYXdkLnR4dDogQWRkIGRvYyB0byBpbnRyb2R1Y2UgQWR2YW5jZWQgV2F0Y2hE
b2coQVdEKSBtb2R1bGUNCj4gPg0KPiA+ICAgY29uZmlndXJlICAgICAgICAgfCAgIDkgKw0KPiA+
ICAgZG9jcy9hd2QudHh0ICAgICAgfCAgODggKysrKysrKysrDQo+ID4gICBuZXQvTWFrZWZpbGUu
b2JqcyB8ICAgMSArDQo+ID4gICBuZXQvYXdkLmMgICAgICAgICB8IDQ5MQ0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBxZW11LW9wdGlvbnMu
aHggICB8ICAyMCArKw0KPiA+ICAgdmwuYyAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+ICAgNiBm
aWxlcyBjaGFuZ2VkLCA2MTYgaW5zZXJ0aW9ucygrKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRvY3MvYXdkLnR4dA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IG5ldC9hd2QuYw0KPiA+DQoN
Cg==

