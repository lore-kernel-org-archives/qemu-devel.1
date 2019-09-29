Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC89CC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 01:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A621214AE
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 01:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A621214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iENl4-0004iS-L5
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 21:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iENkE-0004C7-Qq
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 21:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iENkC-0004DY-O6
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 21:11:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:42512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iENkC-0003pl-D3
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 21:11:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Sep 2019 18:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,561,1559545200"; d="scan'208";a="220235309"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2019 18:11:15 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Sep 2019 18:11:15 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Sep 2019 18:11:15 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.119]) with mapi id 14.03.0439.000;
 Sun, 29 Sep 2019 09:11:13 +0800
From: "Zhang, Qi1" <qi1.zhang@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Thread-Topic: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Thread-Index: AQHVdPGo8xxlixx6u0uh+e2QWzPmzKc+hHCAgAChAlD//5d9gIADHjyg
Date: Sun, 29 Sep 2019 01:11:12 +0000
Message-ID: <215440059103624D9AD9D1DCACBF45DD3E853A42@shsmsx102.ccr.corp.intel.com>
References: <20190927045838.2968-1-qi1.zhang@intel.com>
 <20190927061011.GB9412@xz-x1>
 <215440059103624D9AD9D1DCACBF45DD3E84E270@shsmsx102.ccr.corp.intel.com>
 <20190927093223.GC9412@xz-x1>
In-Reply-To: <20190927093223.GC9412@xz-x1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzFlNjIzYzgtYjYyMC00MzAwLTgxMjQtY2FkYjY1NTdmY2I2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidk9NQUZlZWZxdThkXC9CXC9QMVE0ZE9oenhiUXZmRERxb0R0cUd3bkkrOGlvdThoamEzR1pyeGQ0U0hnMCsxMWlFIn0=
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
eEByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyNywgMjAxOSA1OjMyIFBN
DQo+IFRvOiBaaGFuZywgUWkxIDxxaTEuemhhbmdAaW50ZWwuY29tPg0KPiBDYzogcWVtdS1kZXZl
bEBub25nbnUub3JnOyBlaGFia29zdEByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsNCj4gcGJv
bnppbmlAcmVkaGF0LmNvbTsgcnRoQHR3aWRkbGUubmV0OyBRaSwgWWFkb25nIDx5YWRvbmcucWlA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBpbnRlbF9pb21tdTogVE0gZmll
bGQgc2hvdWxkIG5vdCBiZSBpbiByZXNlcnZlZCBiaXRzDQo+IA0KPiBPbiBGcmksIFNlcCAyNywg
MjAxOSBhdCAwODowMzoyMUFNICswMDAwLCBaaGFuZywgUWkxIHdyb3RlOg0KPiA+DQo+ID4NCj4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQZXRlciBYdSA8cGV0
ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyNywgMjAxOSAy
OjEwIFBNDQo+ID4gPiBUbzogWmhhbmcsIFFpMSA8cWkxLnpoYW5nQGludGVsLmNvbT4NCj4gPiA+
IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGVoYWJrb3N0QHJlZGhhdC5jb207IG1zdEByZWRo
YXQuY29tOw0KPiA+ID4gcGJvbnppbmlAcmVkaGF0LmNvbTsgcnRoQHR3aWRkbGUubmV0DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBpbnRlbF9pb21tdTogVE0gZmllbGQgc2hvdWxkIG5v
dCBiZSBpbg0KPiA+ID4gcmVzZXJ2ZWQgYml0cw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgU2VwIDI3
LCAyMDE5IGF0IDEyOjU4OjM4UE0gKzA4MDAsIHFpMS56aGFuZ0BpbnRlbC5jb20gd3JvdGU6DQo+
ID4gPiA+IEZyb206ICJaaGFuZywgUWkiIDxxaTEuemhhbmdAaW50ZWwuY29tPg0KPiA+ID4gPg0K
PiA+ID4gPiBXaGVuIGR0IGlzIHN1cHBvcnRlZCwgVE0gZmllbGQgc2hvdWxkIG5vdCBiZSBSZXNl
cnZlZCgwKS4NCj4gPiA+ID4NCj4gPiA+ID4gUmVmZXIgdG8gVlQtZCBTcGVjIDkuOA0KPiA+ID4g
Pg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZywgUWkgPHFpMS56aGFuZ0BpbnRlbC5jb20+
DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFFpLCBZYWRvbmcgPHlhZG9uZy5xaUBpbnRlbC5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwg
MTIgKysrKysrLS0tLS0tDQo+ID4gPiA+ICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAyNSArKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDI1IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiAtLS0NCj4gVlREX1NQ
VEVfUEFHRV9MMl9SU1ZEX01BU0socy0NCj4gPiA+ID5hd19iaXRzKTsNCj4gPiA+ID4gLSAgICB2
dGRfcGFnaW5nX2VudHJ5X3JzdmRfZmllbGRbM10gPQ0KPiA+ID4gPmF3X2JpdHMpOw0KPiA+ID4g
PiArICAgIHZ0ZF9wYWdpbmdfZW50cnlfcnN2ZF9maWVsZFs1XSA9DQo+ID4gPiBWVERfU1BURV9M
UEFHRV9MMV9SU1ZEX01BU0socy0+YXdfYml0cywgeDg2X2lvbW11LQ0KPiA+ID4gPmR0X3N1cHBv
cnRlZCk7DQo+ID4gPiA+ICsgICAgdnRkX3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkWzZdID0NCj4g
PiA+IFZURF9TUFRFX0xQQUdFX0wyX1JTVkRfTUFTSyhzLT5hd19iaXRzLCB4ODZfaW9tbXUtDQo+
ID4gPiA+ZHRfc3VwcG9ydGVkKTsNCj4gPiA+ID4gKyAgICB2dGRfcGFnaW5nX2VudHJ5X3JzdmRf
ZmllbGRbN10gPQ0KPiA+ID4gPiArIFZURF9TUFRFX0xQQUdFX0wzX1JTVkRfTUFTSyhzLT5hd19i
aXRzLCB4ODZfaW9tbXUtDQo+ID4gPiA+ZHRfc3VwcG9ydGVkKTsNCj4gPiA+ID4gICAgICB2dGRf
cGFnaW5nX2VudHJ5X3JzdmRfZmllbGRbOF0gPQ0KPiA+ID4gPlZURF9TUFRFX0xQQUdFX0w0X1JT
VkRfTUFTSyhzLT5hd19iaXRzKTsNCj4gPiA+DQo+ID4gPiBTaG91bGQgdGhpcyBUTSBiaXQgb25s
eSBhZmZlY3RzIGxlYXZlcz8gIFNheSwgZW50cnkgMSAoNEspLCA1ICgyTSksIDYgKDFHKS4NCj4g
PiA+IFdoaWxlIHRoaXMgcmVtaW5kZWQgbWUgdGhhdCBJJ20gdG90YWxseSBjb25mdXNlZCBvbiB3
aHkgd2UgaGF2ZSBoYWQNCj4gPiA+IGVudHJ5IDcsIDggYWZ0ZXIgYWxsLi4uICBBcmUgdGhleSBy
ZWFsbHkgdXNlZD8NCj4gPiBZZXMuIFRNIGJpdCBvbmx5IGFmZmVjdHMuIFRvIHRoaXMgYXJyYXks
IGluZGV4IDEsIDUsNiw3IG1heSBiZSBsZWFmLiBXaWxsIHVwZGF0ZQ0KPiBhIG5ldyBwYXRjaHNl
dCBmb3IgaXQuDQo+IA0KPiBDb3VsZCBJIGFzayB3aHkgaW5kZXggNyBtYXkgYmUgbGVhZj8NCklu
ZGV4IDcgaXMgUERQRSAxRyBHQiBsZWFmLg0KPiANCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ICAg
ICAgaWYgKHg4Nl9pb21tdV9pcl9zdXBwb3J0ZWQoeDg2X2lvbW11KSkgeyBkaWZmIC0tZ2l0DQo+
ID4gPiA+IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+ID4gPiA+IGluZGV4IGMxMjM1YTcwNjMuLjAxZjFhYTZjODYgMTAw
NjQ0DQo+ID4gPiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+ID4g
PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gPiA+ID4gQEAgLTM4Nywx
OSArMzg3LDMxIEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPiA+ID4g
PiAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9MTyAweGZmZmYwMDAwZmZl
MGZmZjgNCj4gPiA+ID4NCj4gPiA+ID4gIC8qIFJzdmQgZmllbGQgbWFza3MgZm9yIHNwdGUgKi8N
Cj4gPiA+ID4gLSNkZWZpbmUgVlREX1NQVEVfUEFHRV9MMV9SU1ZEX01BU0soYXcpIFwNCj4gPiA+
ID4gKyNkZWZpbmUgVlREX1NQVEVfUEFHRV9MMV9SU1ZEX01BU0soYXcsIGR0X3N1cHBvcnRlZCkg
XA0KPiA+ID4gPiArICAgICAgICBkdF9zdXBwb3J0ZWQ/IFwNCj4gPiA+ID4gKyAgICAgICAgKDB4
ODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00gfA0KPiA+ID4gVlRE
X1NMX1RNKSkNCj4gPiA+ID4gKzogXA0KPiA+ID4gPiAgICAgICAgICAoMHg4MDBVTEwgfCB+KFZU
RF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSkpDQo+ID4gPg0KPiA+ID4gVGhpcyBzZWVt
cyBzdHJhbmdlIHRvbyBpbiB0aGF0IH5WVERfSEFXX01BU0soYXcpIHByb2JhYmx5IGNvdmVyZWQN
Cj4gPiA+IGJpdHMNCj4gPiA+IDYzLTQ4IGZvciBhdz09NDggY2FzZSBzbyBpdCBzaG91bGQgYWxy
ZWFkeSBjb3ZlciBWVERfU0xfVE0/DQo+ID4gVlREX1NMX0lHTl9DT00gMHhiZmYwMDAwMDAwMDAw
MDAwVUxMLCBUTSBmaWVsZCBpcyBjbGVhcmVkIGJ5IH4NCj4gPiBWVERfU0xfSUdOX0NPTQ0KPiA+
ID4NCj4gPiA+IE1lYW53aGlsZSB3aGVuIEknbSByZWFkaW5nIHRoZSBzcGVjIEkgc2VlIGF0IGxl
YXN0IGJpdHMgNjEtNTINCj4gPiA+IGlnbm9yZWQgcmF0aGVyIHRoYW4gcmVzZXJ2ZWQuDQo+ID4g
WWVzLiBCaXQgNjF+NTIgaXMgaWdub3JlZC4gU3VjaCBhcyB0aGUgaW5kZXggNSBvZiB0aGlzIGFy
cmF5IGlzIDB4ZmZmODAwMDAwMDgwMC4NCj4gDQo+IE9vcHMsIG15IHBvb3IgZXllIG9idmlvdXNs
eSBkaWRuJ3Qgc2VlIHRoYXQgdGhlICJ+IiBvcGVyYXRvciBpcyBhcHBsaWVkIG92ZXINCj4gdGhl
IHdob2xlIChWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pLi4uIDopDQo+IA0KPiBC
dHcsIHlvdSBzaG91bGQgb25seSB0b3VjaCB1cCB0aGUgbWFjcm9zIHRoYXQgYXJlIGxlYXZlcyBo
ZXJlLg0KPiBOb24tbGVhdmVzIHNob3VsZCBzdGlsbCBrZWVwIHRoYXQgYml0IGFzIHJlc2VydmVk
Lg0KWWVzLiBJIHdpbGwuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAtLQ0KPiBQZXRlciBYdQ0K

