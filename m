Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29312C49EAA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28B820717
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28B820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRv1i-0007PN-NZ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iRuup-0007vO-6V
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iRuun-0000i9-G8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:14:18 -0500
Received: from mga03.intel.com ([134.134.136.65]:19335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iRuun-0000dX-8f
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:14:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Nov 2019 01:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; d="scan'208";a="376625625"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga005.jf.intel.com with ESMTP; 05 Nov 2019 01:14:12 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 01:14:12 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 01:14:10 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 01:14:09 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.41]) with mapi id 14.03.0439.000;
 Tue, 5 Nov 2019 17:14:08 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 03/22] intel_iommu: modify x-scalable-mode to be string
 option
Thread-Topic: [RFC v2 03/22] intel_iommu: modify x-scalable-mode to be
 string option
Thread-Index: AQHVimsn7SVAI/DYekGpKA287OuKO6d17oaAgAZs2aA=
Date: Tue, 5 Nov 2019 09:14:08 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EE30A@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-4-git-send-email-yi.l.liu@intel.com>
 <20191101145753.GC8888@xz-x1.metropole.lan>
In-Reply-To: <20191101145753.GC8888@xz-x1.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmU4OWIyNGItMDVlNS00YTMwLWIwNWYtOTRjYzZhMjkxMmE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZVBqaDhlNzhLVVd0UXBkdDJLSkZJb1lYdGptTjNtbDhLbUVIcW5hU1JVTU43XC9FRzdjczRoV3B0VHl1SEIxelwvIn0=
x-originating-ip: [10.239.127.40]
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlk
YXksIE5vdmVtYmVyIDEsIDIwMTkgMTA6NTggUE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MiAwMy8yMl0gaW50ZWxfaW9tbXU6IG1v
ZGlmeSB4LXNjYWxhYmxlLW1vZGUgdG8gYmUgc3RyaW5nIG9wdGlvbg0KPiANCj4gT24gVGh1LCBP
Y3QgMjQsIDIwMTkgYXQgMDg6MzQ6MjRBTSAtMDQwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gSW50
ZWwgVlQtZCAzLjAgaW50cm9kdWNlcyBzY2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFzIGEgYnVuY2gg
b2YNCj4gPiBjYXBhYmlsaXRpZXMgcmVsYXRlZCB0byBzY2FsYWJsZSBtb2RlIHRyYW5zbGF0aW9u
LCB0aHVzIHRoZXJlIGFyZSBtdWx0aXBsZQ0KPiBjb21iaW5hdGlvbnMuDQo+ID4gV2hpbGUgdGhp
cyB2SU9NTVUgaW1wbGVtZW50YXRpb24gd2FudHMgc2ltcGxpZnkgaXQgZm9yIHVzZXIgYnkNCj4g
PiBwcm92aWRpbmcgdHlwaWNhbCBjb21iaW5hdGlvbnMuIFVzZXIgY291bGQgY29uZmlnIGl0IGJ5
DQo+ID4gIngtc2NhbGFibGUtbW9kZSIgb3B0aW9uLiBUaGUgdXNhZ2UgaXMgYXMgYmVsb3c6DQo+
ID4NCj4gPiAiLWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxhYmxlLW1vZGU9WyJsZWdhY3kifCJt
b2Rlcm4iXSINCj4gPg0KPiA+ICAtICJsZWdhY3kiOiBnaXZlcyBzdXBwb3J0IGZvciBTTCBwYWdl
IHRhYmxlDQo+ID4gIC0gIm1vZGVybiI6IGdpdmVzIHN1cHBvcnQgZm9yIEZMIHBhZ2UgdGFibGUs
IHBhc2lkLCB2aXJ0dWFsIGNvbW1hbmQNCj4gPiAgLSAgaWYgbm90IGNvbmZpZ3VyZWQsIG1lYW5z
IG5vIHNjYWxhYmxlIG1vZGUgc3VwcG9ydCwgaWYgbm90IHByb3Blcg0KPiA+ICAgICBjb25maWd1
cmVkLCB3aWxsIHRocm93IGVycm9yDQo+ID4NCj4gPiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlh
bkBpbnRlbC5jb20+DQo+ID4gQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRl
bC5jb20+DQo+ID4gQ2M6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiBDYzogWWkg
U3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGl1IFlp
IEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnku
c3VuQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5j
ICAgICAgICAgIHwgMTUgKysrKysrKysrKysrKy0tDQo+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCB8ICAzICsrKw0KPiA+IGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8
ICAyICstDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMgaW5kZXgNCj4gPiA3NzFiZWQyLi40YTFhMDdhIDEwMDY0NA0KPiA+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPiA+IEBAIC0zMDE5LDcgKzMwMTksNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3Bl
cnRpZXNbXSA9IHsNCj4gPiAgICAgIERFRklORV9QUk9QX1VJTlQ4KCJhdy1iaXRzIiwgSW50ZWxJ
T01NVVN0YXRlLCBhd19iaXRzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgVlREX0hPU1Rf
QUREUkVTU19XSURUSCksDQo+ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJjYWNoaW5nLW1vZGUi
LCBJbnRlbElPTU1VU3RhdGUsIGNhY2hpbmdfbW9kZSwNCj4gRkFMU0UpLA0KPiA+IC0gICAgREVG
SU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJs
ZV9tb2RlLA0KPiBGQUxTRSksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9TVFJJTkcoIngtc2NhbGFi
bGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwNCj4gPiArIHNjYWxhYmxlX21vZGUpLA0KPiA+ICAg
ICAgREVGSU5FX1BST1BfQk9PTCgiZG1hLWRyYWluIiwgSW50ZWxJT01NVVN0YXRlLCBkbWFfZHJh
aW4sIHRydWUpLA0KPiA+ICAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4gPiAgfTsN
Cj4gPiBAQCAtMzU4MSw3ICszNTgxLDEyIEBAIHN0YXRpYyB2b2lkIHZ0ZF9pbml0KEludGVsSU9N
TVVTdGF0ZSAqcykNCj4gPg0KPiA+ICAgICAgLyogVE9ETzogcmVhZCBjYXAvZWNhcCBmcm9tIGhv
c3QgdG8gZGVjaWRlIHdoaWNoIGNhcCB0byBiZSBleHBvc2VkLiAqLw0KPiA+ICAgICAgaWYgKHMt
PnNjYWxhYmxlX21vZGUpIHsNCj4gPiAtICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMg
fCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0KPiA+ICsgICAgICAgIGlmICghc3RyY21w
KHMtPnNjYWxhYmxlX21vZGUsICJsZWdhY3kiKSkgew0KPiA+ICsgICAgICAgICAgICBzLT5lY2Fw
IHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0KPiA+ICsg
ICAgICAgIH0gZWxzZSBpZiAoIXN0cmNtcChzLT5zY2FsYWJsZV9tb2RlLCAibW9kZXJuIikpIHsN
Cj4gPiArICAgICAgICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9TTVRTIHwgVlREX0VDQVBfU1JT
IHwgVlREX0VDQVBfUEFTSUQNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB8IFZURF9FQ0FQ
X0ZMVFMgfCBWVERfRUNBUF9QU1M7DQo+ID4gKyAgICAgICAgfQ0KPiANCj4gU2hhbGwgd2UgZG8g
dGhpcyBzdHJpbmcgb3Agb25seSBvbmNlIGluIHZ0ZF9kZWNpZGVfY29uZmlnKCkgdGhlbiBrZWVw
IGl0IHNvbWV3aGVyZT8NCg0KQWdyZWVkLiBJJ2xsIG1vdmUgaXQgdG8gdnRkX2RlY2lkZV9jb25m
aWcoKS4NCg0KPiBTb21ldGhpbmcgbGlrZToNCj4gDQo+ICAgLSBzLT5zY2FsYWJsZV9tb2RlX3N0
ciB0byBrZWVwIHRoZSBzdHJpbmcNCj4gICAtIHMtPnNjYWxhYmxlX21vZGUgc3RpbGwgYXMgYSBi
b29sIHRvIGNhY2hlIHRoZSBnbG9iYWwgZW5hYmxlbWVudA0KPiAgIC0gcy0+c2NhbGFibGVfbW9k
ZXJuIGFzIGEgYm9vbCB0byBrZWVwIHRoZSBtb2RlDQo+IA0KPiA/DQoNClNvIHgtc2NhbGFibGUt
bW9kZSBpcyBzdGlsbCBhIHN0cmluZyBvcHRpb24sIGp1c3QgdG8gaGF2ZSBhIG5ldyBmaWVsZCB0
byBzdG9yZSBpdD8NCg0KPiANCj4gVGhlc2UgY291bGQgYmUgdXNlZCBpbiBzb21lIE1NSU8gcGF0
aCAoSSB0aGluaykgYW5kIHBhcnNpbmcgc3RyaW5ncyBhbHdheXMgY291bGQgYmUNCj4gYSBiaXQg
b3ZlcmtpbGwuDQoNCkkgdGhpbmsgc28uIExldCdzIGp1c3QgYWxpZ24gb24gdGhlIGRpcmVjdGlv
biBhYm92ZS4NCg0KUmVnYXJkcywNCllpIExpdQ0KDQo=

