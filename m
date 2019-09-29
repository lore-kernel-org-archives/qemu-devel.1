Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF3C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 02:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F682146E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 02:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F682146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEOgO-0007xa-I1
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 22:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iEOf8-00075p-0v
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iEOf6-0001eS-Ai
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:10:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:28116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iEOf6-0001cU-3T
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:10:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Sep 2019 19:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,561,1559545200"; d="scan'208";a="184436042"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga008.jf.intel.com with ESMTP; 28 Sep 2019 19:10:07 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Sep 2019 19:10:07 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Sep 2019 19:10:07 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.165]) with mapi id 14.03.0439.000;
 Sun, 29 Sep 2019 10:10:05 +0800
From: "Zhang, Qi1" <qi1.zhang@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Thread-Topic: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Thread-Index: AQHVdPGo8xxlixx6u0uh+e2QWzPmzKc+hHCAgAChAlD//5d9gIADHjyg//+IrwCAAIdjEA==
Date: Sun, 29 Sep 2019 02:10:05 +0000
Message-ID: <215440059103624D9AD9D1DCACBF45DD3E856A78@shsmsx102.ccr.corp.intel.com>
References: <20190927045838.2968-1-qi1.zhang@intel.com>
 <20190927061011.GB9412@xz-x1>
 <215440059103624D9AD9D1DCACBF45DD3E84E270@shsmsx102.ccr.corp.intel.com>
 <20190927093223.GC9412@xz-x1>
 <215440059103624D9AD9D1DCACBF45DD3E853A42@shsmsx102.ccr.corp.intel.com>
 <20190929020220.GA8286@xz-x1>
In-Reply-To: <20190929020220.GA8286@xz-x1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTZkZjQ1YTEtYmNlYi00ZTIxLWFhY2QtOWJmODk0MGFjZTUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWEhDOEtSY3NwRlRHNHJiUXJqaHhObTZNdXF3SVl4TENOMUd1Nm5UTFFHeWc0YkFcL255SmdldyswRWlWT1JJSmkifQ==
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Qi,
 Yadong" <yadong.qi@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgWHUgPHBldGVy
eEByZWRoYXQuY29tPg0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJlciAyOSwgMjAxOSAxMDowMiBB
TQ0KPiBUbzogWmhhbmcsIFFpMSA8cWkxLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgZWhhYmtvc3RAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207DQo+IHBi
b256aW5pQHJlZGhhdC5jb207IHJ0aEB0d2lkZGxlLm5ldDsgUWksIFlhZG9uZyA8eWFkb25nLnFp
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gaW50ZWxfaW9tbXU6IFRNIGZp
ZWxkIHNob3VsZCBub3QgYmUgaW4gcmVzZXJ2ZWQgYml0cw0KPiANCj4gT24gU3VuLCBTZXAgMjks
IDIwMTkgYXQgMDE6MTE6MTJBTSArMDAwMCwgWmhhbmcsIFFpMSB3cm90ZToNCj4gPg0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUGV0ZXIgWHUgPHBl
dGVyeEByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMTkg
NTozMiBQTQ0KPiA+ID4gVG86IFpoYW5nLCBRaTEgPHFpMS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
PiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBlaGFia29zdEByZWRoYXQuY29tOyBtc3RAcmVk
aGF0LmNvbTsNCj4gPiA+IHBib256aW5pQHJlZGhhdC5jb207IHJ0aEB0d2lkZGxlLm5ldDsgUWks
IFlhZG9uZw0KPiA+ID4gPHlhZG9uZy5xaUBpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIFYyXSBpbnRlbF9pb21tdTogVE0gZmllbGQgc2hvdWxkIG5vdCBiZSBpbg0KPiA+ID4g
cmVzZXJ2ZWQgYml0cw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgU2VwIDI3LCAyMDE5IGF0IDA4OjAz
OjIxQU0gKzAwMDAsIFpoYW5nLCBRaTEgd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBQZXRlciBYdSA8
cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjcs
IDIwMTkgMjoxMCBQTQ0KPiA+ID4gPiA+IFRvOiBaaGFuZywgUWkxIDxxaTEuemhhbmdAaW50ZWwu
Y29tPg0KPiA+ID4gPiA+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGVoYWJrb3N0QHJlZGhh
dC5jb207DQo+IG1zdEByZWRoYXQuY29tOw0KPiA+ID4gPiA+IHBib256aW5pQHJlZGhhdC5jb207
IHJ0aEB0d2lkZGxlLm5ldA0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIGludGVs
X2lvbW11OiBUTSBmaWVsZCBzaG91bGQgbm90IGJlIGluDQo+ID4gPiA+ID4gcmVzZXJ2ZWQgYml0
cw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gRnJpLCBTZXAgMjcsIDIwMTkgYXQgMTI6NTg6MzhQ
TSArMDgwMCwgcWkxLnpoYW5nQGludGVsLmNvbSB3cm90ZToNCj4gPiA+ID4gPiA+IEZyb206ICJa
aGFuZywgUWkiIDxxaTEuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IFdoZW4gZHQgaXMgc3VwcG9ydGVkLCBUTSBmaWVsZCBzaG91bGQgbm90IGJlIFJlc2VydmVkKDAp
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJlZmVyIHRvIFZULWQgU3BlYyA5LjgNCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZywgUWkgPHFpMS56aGFuZ0Bp
bnRlbC5jb20+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBRaSwgWWFkb25nIDx5YWRvbmcu
cWlAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jICAgICAgICAgIHwgMTIgKysrKysrLS0tLS0tDQo+ID4gPiA+ID4gPiAgaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMjUgKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0K
PiA+ID4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pDQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+IFZURF9TUFRFX1BBR0VfTDJfUlNWRF9NQVNL
KHMtDQo+ID4gPiA+ID4gPmF3X2JpdHMpOw0KPiA+ID4gPiA+ID4gLSAgICB2dGRfcGFnaW5nX2Vu
dHJ5X3JzdmRfZmllbGRbM10gPQ0KPiA+ID4gPiA+ID5hd19iaXRzKTsNCj4gPiA+ID4gPiA+ICsg
ICAgdnRkX3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkWzVdID0NCj4gPiA+ID4gPiBWVERfU1BURV9M
UEFHRV9MMV9SU1ZEX01BU0socy0+YXdfYml0cywgeDg2X2lvbW11LQ0KPiA+ID4gPiA+ID5kdF9z
dXBwb3J0ZWQpOw0KPiA+ID4gPiA+ID4gKyAgICB2dGRfcGFnaW5nX2VudHJ5X3JzdmRfZmllbGRb
Nl0gPQ0KPiA+ID4gPiA+IFZURF9TUFRFX0xQQUdFX0wyX1JTVkRfTUFTSyhzLT5hd19iaXRzLCB4
ODZfaW9tbXUtDQo+ID4gPiA+ID4gPmR0X3N1cHBvcnRlZCk7DQo+ID4gPiA+ID4gPiArICAgIHZ0
ZF9wYWdpbmdfZW50cnlfcnN2ZF9maWVsZFs3XSA9DQo+ID4gPiA+ID4gPiArIFZURF9TUFRFX0xQ
QUdFX0wzX1JTVkRfTUFTSyhzLT5hd19iaXRzLCB4ODZfaW9tbXUtDQo+ID4gPiA+ID4gPmR0X3N1
cHBvcnRlZCk7DQo+ID4gPiA+ID4gPiAgICAgIHZ0ZF9wYWdpbmdfZW50cnlfcnN2ZF9maWVsZFs4
XSA9DQo+ID4gPiA+ID4gPlZURF9TUFRFX0xQQUdFX0w0X1JTVkRfTUFTSyhzLT5hd19iaXRzKTsN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNob3VsZCB0aGlzIFRNIGJpdCBvbmx5IGFmZmVjdHMgbGVh
dmVzPyAgU2F5LCBlbnRyeSAxICg0SyksIDUgKDJNKSwgNg0KPiAoMUcpLg0KPiANCj4gWzFdDQo+
IA0KPiA+ID4gPiA+IFdoaWxlIHRoaXMgcmVtaW5kZWQgbWUgdGhhdCBJJ20gdG90YWxseSBjb25m
dXNlZCBvbiB3aHkgd2UgaGF2ZQ0KPiA+ID4gPiA+IGhhZCBlbnRyeSA3LCA4IGFmdGVyIGFsbC4u
LiAgQXJlIHRoZXkgcmVhbGx5IHVzZWQ/DQo+ID4gPiA+IFllcy4gVE0gYml0IG9ubHkgYWZmZWN0
cy4gVG8gdGhpcyBhcnJheSwgaW5kZXggMSwgNSw2LDcgbWF5IGJlDQo+ID4gPiA+IGxlYWYuIFdp
bGwgdXBkYXRlDQo+ID4gPiBhIG5ldyBwYXRjaHNldCBmb3IgaXQuDQo+ID4gPg0KPiA+ID4gQ291
bGQgSSBhc2sgd2h5IGluZGV4IDcgbWF5IGJlIGxlYWY/DQo+ID4gSW5kZXggNyBpcyBQRFBFIDFH
IEdCIGxlYWYuDQo+IA0KPiBJIHRob3VnaHQgMUcgd2FzIGluZGV4IDYuICBJJ3ZlIGxpc3RlZCBt
eSB1bmRlcnN0YW5kaW5nIGFib3ZlIFsxXS4NCj4gV291bGQgeW91IHBsZWFzZSBkb3VibGUgY29u
ZmlybT8gIFRoYW5rcywNCkNoZWNrIHRoZSBleGlzdGluZyBmdW5jdGlvbi4gV2hlbiBsZXZlbCBp
cyAzIFZURF9TTF9QRFBfTEVWRUwgYW5kIHRoZSBlbnRyeSBpcyBsZWFmLCBpdCBpcyBQRFBFIDFH
IGxlYWYgYW5kIHRoZSBjb3JyZXNwb25kaW5nIGluZGV4IG9mIHRoaXMgYXJyYXkgNy4NCg0Kc3Rh
dGljIGJvb2wgdnRkX3NscHRlX25vbnplcm9fcnN2ZCh1aW50NjRfdCBzbHB0ZSwgdWludDMyX3Qg
bGV2ZWwpDQp7DQogICAgaWYgKHNscHRlICYgVlREX1NMX1BUX1BBR0VfU0laRV9NQVNLKSB7DQog
ICAgICAgIC8qIE1heWJlIGxhcmdlIHBhZ2UgKi8NCiAgICAgICAgcmV0dXJuIHNscHRlICYgdnRk
X3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkW2xldmVsICsgNF07DQogICAgfSBlbHNlIHsNCiAgICAg
ICAgcmV0dXJuIHNscHRlICYgdnRkX3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkW2xldmVsXTsNCiAg
ICB9DQp9DQo+IA0KPiAtLQ0KPiBQZXRlciBYdQ0K

