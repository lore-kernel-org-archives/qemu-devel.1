Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F93FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 01:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06100222AB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 01:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06100222AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXEsf-0000vg-8K
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 20:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iXEqQ-0008WU-O7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 20:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iXEqP-0002Rn-Ao
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 20:31:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:48325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iXEqL-0002FI-9K; Tue, 19 Nov 2019 20:31:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 17:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,220,1571727600"; d="scan'208";a="231761824"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga004.fm.intel.com with ESMTP; 19 Nov 2019 17:31:36 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 17:31:36 -0800
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Nov 2019 17:31:35 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 17:31:35 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.108]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.127]) with mapi id 14.03.0439.000;
 Wed, 20 Nov 2019 09:31:34 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v7 0/4] colo: Add support for continuous replication
Thread-Topic: [PATCH v7 0/4] colo: Add support for continuous replication
Thread-Index: AQHVinb+3QVJTWIS6EWH6Lp9PLoWz6eI5dGAgAmrJED//6jqAIABNYgw
Date: Wed, 20 Nov 2019 01:31:34 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780630AB3E@shsmsx102.ccr.corp.intel.com>
References: <cover.1571925699.git.lukasstraub2@web.de>
 <20191113173559.0713c27d@luklap>
 <9CFF81C0F6B98A43A459C9EDAD400D7806309C8C@shsmsx102.ccr.corp.intel.com>
 <049fdd65-c654-f619-4de1-5a3fe0a2ad5b@redhat.com>
In-Reply-To: <049fdd65-c654-f619-4de1-5a3fe0a2ad5b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjVkOTcwMmQtNzE3Yy00MjgyLWIxZGUtOTQ0YjMyNDEyZmRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWXo5UVFuY1BZaWZwTFhGdUplM2JlYzNhVDBzWit3b2VNRTdMdlwvXC9QV0t3YWFVQWthYnBVdFNnRUZZZ3NQbzhuIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie
 Changlong <xiechanglong.d@gmail.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTksIDIwMTkgMTE6
MDMgUE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IEx1a2FzIFN0
cmF1Yg0KPiA8bHVrYXNzdHJhdWIyQHdlYi5kZT47IHFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4NCj4gQ2M6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+OyBxZW11LWJsb2Nr
IDxxZW11LQ0KPiBibG9ja0Bub25nbnUub3JnPjsgV2VuIENvbmd5YW5nIDx3ZW5jb25neWFuZzJA
aHVhd2VpLmNvbT47IE1heA0KPiBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+OyBYaWUgQ2hhbmds
b25nIDx4aWVjaGFuZ2xvbmcuZEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcg
MC80XSBjb2xvOiBBZGQgc3VwcG9ydCBmb3IgY29udGludW91cyByZXBsaWNhdGlvbg0KPiANCj4g
DQo+IE9uIDIwMTkvMTEvMTkg5LiL5Y2IODoyOCwgWmhhbmcsIENoZW4gd3JvdGU6DQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTHVrYXMgU3RyYXViIDxs
dWthc3N0cmF1YjJAd2ViLmRlPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMTQsIDIw
MTkgMTI6MzYgQU0NCj4gPj4gVG86IHFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4N
Cj4gPj4gQ2M6IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IEphc29uIFdhbmcN
Cj4gPj4gPGphc293YW5nQHJlZGhhdC5jb20+OyBXZW4gQ29uZ3lhbmcNCj4gPHdlbmNvbmd5YW5n
MkBodWF3ZWkuY29tPjsgWGllDQo+ID4+IENoYW5nbG9uZyA8eGllY2hhbmdsb25nLmRAZ21haWwu
Y29tPjsgS2V2aW4gV29sZg0KPiA8a3dvbGZAcmVkaGF0LmNvbT47DQo+ID4+IE1heCBSZWl0eiA8
bXJlaXR6QHJlZGhhdC5jb20+OyBxZW11LWJsb2NrIDxxZW11LWJsb2NrQG5vbmdudS5vcmc+DQo+
ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMC80XSBjb2xvOiBBZGQgc3VwcG9ydCBmb3IgY29u
dGludW91cw0KPiA+PiByZXBsaWNhdGlvbg0KPiA+Pg0KPiA+PiBPbiBGcmksIDI1IE9jdCAyMDE5
IDE5OjA2OjMxICswMjAwDQo+ID4+IEx1a2FzIFN0cmF1YiA8bHVrYXNzdHJhdWIyQHdlYi5kZT4g
d3JvdGU6DQo+ID4+DQo+ID4+PiBIZWxsbyBFdmVyeW9uZSwNCj4gPj4+IFRoZXNlIFBhdGNoZXMg
YWRkIHN1cHBvcnQgZm9yIGNvbnRpbnVvdXMgcmVwbGljYXRpb24gdG8gY29sby4gVGhpcw0KPiA+
Pj4gbWVhbnMgdGhhdCBhZnRlciB0aGUgUHJpbWFyeSBmYWlscyBhbmQgdGhlIFNlY29uZGFyeSBk
aWQgYSBmYWlsb3ZlciwNCj4gPj4+IHRoZSBTZWNvbmRhcnkgY2FuIHRoZW4gYmVjb21lIFByaW1h
cnkgYW5kIHJlc3VtZSByZXBsaWNhdGlvbiB0byBhDQo+ID4+PiBuZXcNCj4gPj4gU2Vjb25kYXJ5
Lg0KPiA+Pj4gUmVnYXJkcywNCj4gPj4+IEx1a2FzIFN0cmF1Yg0KPiA+Pj4NCj4gPj4+IHY3Og0K
PiA+Pj4gICAtIGNsYXJpZnkgbWVhbmluZyBvZiBpcCdzIGluIGRvY3VtZW50YXRpb24gYW5kIG5v
dGUgdGhhdCBhY3RpdmUgYW5kDQo+IGhpZGRlbg0KPiA+Pj4gICAgIGltYWdlcyBqdXN0IG5lZWQg
dG8gYmUgY3JlYXRlZCBvbmNlDQo+ID4+PiAgIC0gcmV2ZXJ0ZWQgcmVtb3ZhbCBvZiBiZHJ2X2lz
X3Jvb3Rfbm9kZSh0b3BfYnMpIGluIHJlcGxpY2F0aW9uIGFuZA0KPiA+PiBhZGp1c3RlZA0KPiA+
Pj4gICAgIHRoZSB0b3AtaWQ9IHBhcmFtZXRlciBpbiBkb2N1bWVudGF0aW9uIGFjb3JkaW5nbHkN
Cj4gPj4+DQo+ID4+PiB2NjoNCj4gPj4+ICAgLSBkb2N1bWVudGVkIHRoZSBwb3NpdGlvbj0gYW5k
IGluc2VydD0gb3B0aW9ucw0KPiA+Pj4gICAtIHJlbmFtZWQgcmVwbGljYXRpb24gdGVzdA0KPiA+
Pj4gICAtIGNsYXJpZmllZCBkb2N1bWVudGF0aW9uIGJ5IHVzaW5nIGRpZmZlcmVudCBpcCdzIGZv
ciBwcmltYXJ5IGFuZA0KPiA+Pj4gc2Vjb25kYXJ5DQo+ID4+PiAgIC0gYWRkZWQgUmV2aWV3ZWQt
YnkgdGFncw0KPiA+Pj4NCj4gPj4+IHY1Og0KPiA+Pj4gICAtIGNoYW5nZSBzeW50YXggZm9yIHRo
ZSBwb3NpdGlvbj0gcGFyYW1ldGVyDQo+ID4+PiAgIC0gZml4IHNwZWxsaW5nIG1pc3Rha2UNCj4g
Pj4+DQo+ID4+PiB2NDoNCj4gPj4+ICAgLSBmaXggY2hlY2twYXRjaC5wbCB3YXJuaW5ncw0KPiA+
Pj4NCj4gPj4+IHYzOg0KPiA+Pj4gICAtIGFkZCB0ZXN0IGZvciByZXBsaWNhdGlvbiBjaGFuZ2Vz
DQo+ID4+PiAgIC0gY2hlY2sgaWYgdGhlIGZpbHRlciB0byBiZSBpbnNlcnRlZCBiZWZvcmUvYmVo
aW5kIGJlbG9uZ3MgdG8gdGhlDQo+ID4+PiBzYW1lIGludGVyZmFjZQ0KPiA+Pj4gICAtIGZpeCB0
aGUgZXJyb3IgbWVzc2FnZSBmb3IgdGhlIHBvc2l0aW9uPSBwYXJhbWV0ZXINCj4gPj4+ICAgLSBy
ZW5hbWUgdGVybSAiYWZ0ZXIiIC0+ICJiZWhpbmQiIGFuZCB2YXJpYWJsZSAiaW5zZXJ0X2JlZm9y
ZSIgLT4NCj4gPj4gImluc2VydF9iZWZvcmVfZmxhZyINCj4gPj4+ICAgLSBkb2N1bWVudCB0aGUg
cXVvcnVtIG5vZGUgb24gdGhlIHNlY29uZGFyeSBzaWRlDQo+ID4+PiAgIC0gc2ltcGxpZnkgcXVv
cnVtIHBhcmFtZXRlcnMgaW4gZG9jdW1lbnRhdGlvbg0KPiA+Pj4gICAtIHJlbW92ZSB0cmFpbGlu
ZyBzcGFjZXMgaW4gZG9jdW1lbnRhdGlvbg0KPiA+Pj4gICAtIGNsYXJpZnkgdGhlIHRlc3Rpbmcg
cHJvY2VkdXJlIGluIGRvY3VtZW50YXRpb24NCj4gPj4+DQo+ID4+PiB2MjoNCj4gPj4+ICAgLSBm
aXggZW1haWwgZm9ybWF0aW5nDQo+ID4+PiAgIC0gZml4IGNoZWNrcGF0Y2gucGwgd2FybmluZ3MN
Cj4gPj4+ICAgLSBmaXggcGF0Y2hldyBlcnJvcg0KPiA+Pj4gICAtIGNsZWFyZXIgY29tbWl0IG1l
c3NhZ2VzDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IEx1a2FzIFN0cmF1YiAoNCk6DQo+ID4+PiAgICBi
bG9jay9yZXBsaWNhdGlvbi5jOiBJZ25vcmUgcmVxdWVzdHMgYWZ0ZXIgZmFpbG92ZXINCj4gPj4+
ICAgIHRlc3RzL3Rlc3QtcmVwbGljYXRpb24uYzogQWRkIHRlc3QgZm9yIGZvciBzZWNvbmRhcnkg
bm9kZSBjb250aW51aW5nDQo+ID4+PiAgICAgIHJlcGxpY2F0aW9uDQo+ID4+PiAgICBuZXQvZmls
dGVyLmM6IEFkZCBPcHRpb25zIHRvIGluc2VydCBmaWx0ZXJzIGFueXdoZXJlIGluIHRoZSBmaWx0
ZXINCj4gPj4+ICAgICAgbGlzdA0KPiA+Pj4gICAgY29sbzogVXBkYXRlIERvY3VtZW50YXRpb24g
Zm9yIGNvbnRpbnVvdXMgcmVwbGljYXRpb24NCj4gPj4+DQo+ID4+PiAgIGJsb2NrL3JlcGxpY2F0
aW9uLmMgICAgICAgIHwgIDM1ICsrKysrLQ0KPiA+Pj4gICBkb2NzL0NPTE8tRlQudHh0ICAgICAg
ICAgICB8IDIyNCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLQ0KPiA+
Pj4gICBkb2NzL2Jsb2NrLXJlcGxpY2F0aW9uLnR4dCB8ICAyOCArKystLQ0KPiA+Pj4gICBpbmNs
dWRlL25ldC9maWx0ZXIuaCAgICAgICB8ICAgMiArDQo+ID4+PiAgIG5ldC9maWx0ZXIuYyAgICAg
ICAgICAgICAgIHwgIDkyICsrKysrKysrKysrKysrLQ0KPiA+Pj4gICBxZW11LW9wdGlvbnMuaHgg
ICAgICAgICAgICB8ICAzMSArKysrLQ0KPiA+Pj4gICB0ZXN0cy90ZXN0LXJlcGxpY2F0aW9uLmMg
ICB8ICA1MiArKysrKysrKysNCj4gPj4+ICAgNyBmaWxlcyBjaGFuZ2VkLCAzODkgaW5zZXJ0aW9u
cygrKSwgNzUgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+PiBIZWxsbyBFdmVyeW9uZSwNCj4gPj4g
U28gSSBndWVzcyB0aGlzIGlzIHJlYWR5IGZvciBtZXJnaW5nIG9yIHdpbGwgdGhhdCBoYXZlIHRv
IHdhaXQgdW50aWwNCj4gPj4gdGhlIDQuMiByZWxlYXNlIGlzIGRvbmU/DQo+ID4gRHVlIHRvIFFl
bXUgNC4yIHJlbGVhc2Ugc2NoZWR1bGUsIGFmdGVyIHNvZnQgZmVhdHVyZSBmcmVlemUoT2N0Mjkp
IHRoZQ0KPiBtYXN0ZXIgYnJhbmNoIGRvZXMgbm90IGFjY2VwdCBmZWF0dXJlIGNoYW5nZXMuDQo+
ID4gQnV0IEkgZG9uJ3Qga25vdyBpZiBzdWItbWFpbnRhaW5lcihibG9jayBvciBuZXQpIGNhbiBx
dWV1ZSB0aGlzIHNlcmllcyBmaXJzdA0KPiB0aGVuIG1lcmdlIGl0IGFmdGVyIDQuMiByZWxlYXNl
Pw0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gWmhhbmcgQ2hlbg0KPiANCj4gDQo+IFdpbGwgdHJ5IHRv
IHF1ZXVlIHRoaXMgc2VyaWVzLg0KDQpUaGFuayB5b3UgSmFzb25+DQoNClRoYW5rcw0KWmhhbmcg
Q2hlbg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+IA0KPiA+DQo+ID4+IFJlZ2FyZHMsDQo+ID4+IEx1
a2FzIFN0cmF1Yg0KDQo=

