Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD365C73C64
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 12:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF8220651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 12:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF8220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlBXA-0002TF-Li
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 08:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hlBUr-0001bf-Ha
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hlBUp-0006jU-M5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:14:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:60314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hlBUp-0006fM-D9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:14:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 05:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; d="scan'208";a="364913743"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2019 05:14:47 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 05:14:47 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 05:14:47 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.60]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 20:14:45 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <zhexu@redhat.com>
Thread-Topic: [RFC v1 04/18] intel_iommu: add "sm_model" option
Thread-Index: AQHVM+ykW0tId7lQvkS+qMkTYXVuu6bBCoMAgAK56DA=
Date: Wed, 10 Jul 2019 12:14:44 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439F2A6D3@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-5-git-send-email-yi.l.liu@intel.com>
 <20190709021554.GB5178@xz-x1>
In-Reply-To: <20190709021554.GB5178@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjAxZTY2ZDQtNTA0Yi00ZGEyLTljYzUtY2RiOTk0OTY0MWFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR0pPeGlCRnlBalVITGVmRmVocWNzNTg4TjNReksxdk5ibkFiQjNKK0RidDV4ZXVCV1NobGVcL3lcLytIdm92Z042In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [RFC v1 04/18] intel_iommu: add "sm_model" option
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
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

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnpoZXh1QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgOSwgMjAxOSAxMDoxNiBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYxIDA0LzE4XSBpbnRlbF9pb21tdTogYWRkICJz
bV9tb2RlbCIgb3B0aW9uDQo+IA0KPiBPbiBGcmksIEp1bCAwNSwgMjAxOSBhdCAwNzowMTozN1BN
ICswODAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBJbnRlbCBWVC1kIDMuMCBpbnRyb2R1Y2VzIHNj
YWxhYmxlIG1vZGUsIGFuZCBpdCBoYXMgYSBidW5jaCBvZg0KPiA+IGNhcGFiaWxpdGllcyByZWxh
dGVkIHRvIHNjYWxhYmxlIG1vZGUgdHJhbnNsYXRpb24sIHRodXMgdGhlcmUNCj4gPiBhcmUgbXVs
dGlwbGUgY29tYmluYXRpb25zLiBXaGlsZSB0aGlzIHZJT01NVSBpbXBsZW1lbnRhdGlvbg0KPiA+
IHdhbnRzIHNpbXBsaWZ5IGl0IGZvciB1c2VyIGJ5IHByb3ZpZGluZyB0eXBpY2FsIGNvbWJpbmF0
aW9ucy4NCj4gPiBVc2VyIGNvdWxkIGNvbmZpZyBpdCBieSAic21fbW9kZWwiIG9wdGlvbi4gVGhl
IHVzYWdlIGlzIGFzDQo+ID4gYmVsb3c6DQo+ID4NCj4gPiAiLWRldmljZSBpbnRlbC1pb21tdSx4
LXNjYWxhYmxlLW1vZGU9b24sc21fbW9kZWw9WyJsZWdhY3kifCJzY2FsYWJsZSJdIg0KPiANCj4g
SXMgaXQgYSByZXF1aXJlbWVudCB0byBzcGxpdCBpbnRvIHR3byBwYXJhbWV0ZXJzLCBpbnN0ZWFk
IG9mIGp1c3QNCj4gZXhwb3NpbmcgZXZlcnl0aGluZyBhYm91dCBzY2FsYWJsZSBtb2RlIHdoZW4g
eC1zY2FsYWJsZS1tb2RlIGlzIHNldD8NCg0KeWVzLCBpdCBpcy4gU2NhbGFibGUgbW9kZSBoYXMg
bXVsdGlwbGUgY2FwYWJpbGl0aWVzLiBBbmQgd2Ugd2FudCB0byBzdXBwb3J0DQp0aGUgbW9zdCB0
eXBpY2FsIGNvbWJpbmF0aW9ucyB0byBzaW1wbGlmeSBzb2Z0d2FyZS4gZS5nLiBjdXJyZW50IHNj
YWxhYmxlIG1vZGUNCnZJT01NVSBleHBvc2VzIG9ubHkgMm5kIGxldmVsIHRyYW5zbGF0aW9uIHRv
IGd1ZXN0LCBhbmQgZ3Vlc3QgSU9WQSBzdXBwb3J0DQppcyB2aWEgc2hhZG93aW5nIGd1ZXN0IDJu
ZCBsZXZlbCBwYWdlIHRhYmxlLiBXZSBoYXZlIHBsYW4gdG8gbW92ZSBJT1ZBIGZyb20NCjJuZCBs
ZXZlbCBwYWdlIHRhYmxlIHRvIDFzdCBsZXZlbCBwYWdlIHRhYmxlLCB0aHVzIGd1ZXN0IElPVkEg
Y2FuIGJlIHN1cHBvcnRlZA0Kd2l0aCBuZXN0ZWQgdHJhbnNsYXRpb24uIEFuZCB0aGlzIGFsc28g
YWRkcmVzc2VzIHRoZSBjby1leGlzdGVuY2UgaXNzdWUgb2YgZ3Vlc3QNClNWQSBhbmQgZ3Vlc3Qg
SU9WQS4gU28gaW4gZnV0dXJlIHdlIHdpbGwgaGF2ZSBzY2FsYWJsZSBtb2RlIHZJT01NVSBleHBv
c2UNCjFzdCBsZXZlbCB0cmFuc2xhdGlvbiBvbmx5LiBUbyBkaWZmZXJlbnRpYXRlIHRoaXMgY29u
ZmlnIHdpdGggY3VycmVudCB2SU9NTVUsDQp3ZSBuZWVkIGFuIGV4dHJhIG9wdGlvbiB0byBjb250
cm9sIGl0LiBCdXQgeWVzLCBpdCBpcyBzdGlsbCBzY2FsYWJsZSBtb2RlIHZJT01NVS4NCmp1c3Qg
aGFzIGRpZmZlcmVudCBjYXBhYmlsaXR5IGV4cG9zZWQgdG8gZ3Vlc3QuDQoNCkJUVy4gZG8geW91
IGtub3cgaWYgSSBjYW4gYWRkIHN1Yi1vcHRpb25zIHVuZGVyICJ4LXNjYWxhYmxlLW1vZGUiPyBJ
IHRoaW5rDQp0aGF0IG1heSBkZW1vbnN0cmF0ZSB0aGUgZGVwZW5kZW5jeSBiZXR0ZXIuDQoNCj4g
Pg0KPiA+ICAtICJsZWdhY3kiOiBnaXZlcyBzdXBwb3J0IGZvciBTTCBwYWdlIHRhYmxlDQo+ID4g
IC0gInNjYWxhYmxlIjogZ2l2ZXMgc3VwcG9ydCBmb3IgRkwgcGFnZSB0YWJsZSwgcGFzaWQsIHZp
cnR1YWwgY29tbWFuZA0KPiA+ICAtIGRlZmF1bHQgdG8gYmUgImxlZ2FjeSIgaWYgIngtc2NhbGFi
bGUtbW9kZT1vbiB3aGlsZSBubyBzbV9tb2RlbCBpcw0KPiA+ICAgIGNvbmZpZ3VyZWQNCj4gPg0K
PiA+IENjOiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBDYzogSmFjb2Ig
UGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogUGV0ZXIgWHUgPHBl
dGVyeEByZWRoYXQuY29tPg0KPiA+IENjOiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+IC0t
LQ0KPiA+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAyOCArKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAy
ICsrDQo+ID4gIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAxICsNCj4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+ID4gaW5kZXggNDRiMTIzMS4uMzE2MGEwNSAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiBAQCAtMzAx
NCw2ICszMDE0LDcgQEAgc3RhdGljIFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+ID4g
ICAgICBERUZJTkVfUFJPUF9CT09MKCJjYWNoaW5nLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIGNh
Y2hpbmdfbW9kZSwNCj4gRkFMU0UpLA0KPiA+ICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2Fs
YWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2RlLA0KPiBGQUxTRSksDQo+
ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJkbWEtZHJhaW4iLCBJbnRlbElPTU1VU3RhdGUsIGRt
YV9kcmFpbiwgdHJ1ZSksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9TVFJJTkcoInNtX21vZGVsIiwg
SW50ZWxJT01NVVN0YXRlLCBzbV9tb2RlbCksDQo+IA0KPiBDYW4gZG8gJ3MvLS9fLycgdG8gZm9s
bG93IHRoZSByZXN0IGlmIHdlIG5lZWQgaXQuDQoNCkRvIHlvdSBtZWFuIHN1Yi1vcHRpb25zIGFm
dGVyICJ4LXNjYWxhYmxlLW1vZGUiPw0KDQo+ID4gICAgICBERUZJTkVfUFJPUF9FTkRfT0ZfTElT
VCgpLA0KPiA+ICB9Ow0KPiA+DQo+ID4gQEAgLTM0ODksNiArMzQ5MCwxNCBAQCBzdGF0aWMgdm9p
ZCB2dGRfaW9tbXVfcmVwbGF5KElPTU1VTWVtb3J5UmVnaW9uDQo+ICppb21tdV9tciwgSU9NTVVO
b3RpZmllciAqbikNCj4gPiAgICAgIHJldHVybjsNCj4gPiAgfQ0KPiA+DQo+ID4gK2NvbnN0IGNo
YXIgc21fbW9kZWxfbWFudWFsW10gPQ0KPiA+ICsgICAgICAgICJcIi1kZXZpY2UgaW50ZWwtaW9t
bXUseC1zY2FsYWJsZS1tb2RlPW9uLCINCj4gPiArICAgICAgICAic21fbW9kZWw9W1wibGVnYWN5
XCJ8XCJzY2FsYWJsZVwiXVwiXG4iDQo+ID4gKyAgICAgICAgIiAtIFwibGVnYWN5XCIgZ2l2ZXMg
c3VwcG9ydCBmb3IgU0wgcGFnZSB0YWJsZSBiYXNlZCBJT1ZBXG4iDQo+ID4gKyAgICAgICAgIiAt
IFwic2NhbGFibGVcIiBnaXZlcyBzdXBwb3J0IGZvciBGTCBwYWdlIHRhYmxlIGJhc2VkIElPVkEg
YW5kIFNWQVxuIg0KPiA+ICsgICAgICAgICIgLSBkZWZhdWx0IHRvIGJlIFwibGVnYWN5XCIgaWYg
XCJ4LXNjYWxhYmxlLW1vZGU9b25cIiINCj4gPiArICAgICAgICAiIHdoaWxlIG5vIHNtX21vZGVs
IGlzIGNvbmZpZ3VyZWRcbiI7DQo+ID4gKw0KPiA+ICAvKiBEbyB0aGUgaW5pdGlhbGl6YXRpb24u
IEl0IHdpbGwgYWxzbyBiZSBjYWxsZWQgd2hlbiByZXNldCwgc28gcGF5DQo+ID4gICAqIGF0dGVu
dGlvbiB3aGVuIGFkZGluZyBuZXcgaW5pdGlhbGl6YXRpb24gc3R1ZmYuDQo+ID4gICAqLw0KPiA+
IEBAIC0zNTU3LDkgKzM1NjYsMjYgQEAgc3RhdGljIHZvaWQgdnRkX2luaXQoSW50ZWxJT01NVVN0
YXRlICpzKQ0KPiA+ICAgICAgICAgIHMtPmNhcCB8PSBWVERfQ0FQX0NNOw0KPiA+ICAgICAgfQ0K
PiA+DQo+ID4gKyAgICBpZiAocy0+c21fbW9kZWwgJiYgIXMtPnNjYWxhYmxlX21vZGUpIHsNCj4g
PiArICAgICAgICBwcmludGYoIlxuXCJzbV9tb2RlbFwiIGRlcGVuZHMgb24gXCJ4LXNjYWxhYmxl
LW1vZGVcIlxuIg0KPiA+ICsgICAgICAgICAgICAgICAicGxlYXNlIGNoZWNrIGlmIFwieC1zY2Fs
YWJsZS1tb2RlXCIgaXMgZXhwZWN0ZWRcbiINCj4gPiArICAgICAgICAgICAgICAgIlwic21fbW9k
ZWxcIiBtYW51YWw6XG4lcyIsIHNtX21vZGVsX21hbnVhbCk7DQo+ID4gKyAgICAgICAgZXhpdCgx
KTsNCj4gDQo+IExldCdzIGF2b2lkIGNhbGxpbmcgZXhpdCgpIGRpcmVjdGx5IGNvbnNpZGVyaW5n
IHRoYXQgd2UndmUgaGFkIHRoaW5ncw0KPiBsaWtlIHZ0ZF9kZWNpZGVfY29uZmlnKCkgYWxyZWFk
eSB3aGljaCBhbGxvd3MgYW4gRXJyb3IqKi4gIFdlIGNhbiBhbHNvDQo+IGludHJvZHVjZSB0aGF0
IHRvbyBpbnRvIHZ0ZF9pbml0KCkgYW5kIHBhc3MgdGhlIGVycm9yIHRvIHVwcGVyIHRvDQo+IGhh
bmRsZSB0aGUgZmFpbHVyZS4NCg0Kc3VyZS4NCg0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAg
IC8qIFRPRE86IHJlYWQgY2FwL2VjYXAgZnJvbSBob3N0IHRvIGRlY2lkZSB3aGljaCBjYXAgdG8g
YmUgZXhwb3NlZC4gKi8NCj4gPiAgICAgIGlmIChzLT5zY2FsYWJsZV9tb2RlKSB7DQo+ID4gLSAg
ICAgICAgcy0+ZWNhcCB8PSBWVERfRUNBUF9TTVRTIHwgVlREX0VDQVBfU1JTIHwgVlREX0VDQVBf
U0xUUzsNCj4gPiArICAgICAgICBpZiAoIXMtPnNtX21vZGVsIHx8ICFzdHJjbXAocy0+c21fbW9k
ZWwsICJsZWdhY3kiKSkgew0KPiA+ICsgICAgICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NN
VFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNBUF9TTFRTOw0KPiA+ICsgICAgICAgIH0gZWxzZSBp
ZiAoIXN0cmNtcChzLT5zbV9tb2RlbCwgInNjYWxhYmxlIikpIHsNCj4gPiArICAgICAgICAgICAg
cy0+ZWNhcCB8PSBWVERfRUNBUF9TTVRTIHwgVlREX0VDQVBfU1JTIHwgVlREX0VDQVBfUEFTSUQN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICB8IFZURF9FQ0FQX0ZMVFM7DQo+IA0KPiBEbyB5
b3UgYWxzbyBuZWVkIFZURF9FQ0FQX1NMVFMgaGVyZT8NCg0KQXMgbWVudGlvbmVkIGFib3ZlLCBp
biBsb25nIHRlcm0sIHdlIHdhbnQgdG8gZXhwb3NlIEZMVCB0byBndWVzdCBvbmx5Lg0KDQo+ID4g
KyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgcHJpbnRmKCJcbiEhISEhIEludmFs
aWQgc21fbW9kZWwgY29uZmlnICEhISEhXG4iDQo+ID4gKyAgICAgICAgICAgICAgICAiUGxlYXNl
IGNvbmZpZyBzbV9tb2RlbD1bXCJsZWdhY3lcInxcInNjYWxhYmxlXCJdXG4iDQo+ID4gKyAgICAg
ICAgICAgICAgICAiXCJzbV9tb2RlbFwiIG1hbnVhbDpcbiVzIiwgc21fbW9kZWxfbWFudWFsKTsN
Cj4gPiArICAgICAgICAgICAgZXhpdCgxKTsNCj4gDQo+IFNhbWUgaGVyZS4NCg0KZ290IGl0Lg0K
DQo+IFRoYW5rcywNCj4gDQo+ID4gKyAgICAgICAgfQ0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gICAg
ICB2dGRfcmVzZXRfY2FjaGVzKHMpOw0KPiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gPiBpbmRl
eCBjMTIzNWE3Li5hZGFlMTk4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiA+
IEBAIC0xOTAsOCArMTkwLDEwIEBADQo+ID4gICNkZWZpbmUgVlREX0VDQVBfUFQgICAgICAgICAg
ICAgICAgICgxVUxMIDw8IDYpDQo+ID4gICNkZWZpbmUgVlREX0VDQVBfTUhNViAgICAgICAgICAg
ICAgICgxNVVMTCA8PCAyMCkNCj4gPiAgI2RlZmluZSBWVERfRUNBUF9TUlMgICAgICAgICAgICAg
ICAgKDFVTEwgPDwgMzEpDQo+ID4gKyNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAg
ICgxVUxMIDw8IDQwKQ0KPiA+ICAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAo
MVVMTCA8PCA0MykNCj4gPiAgI2RlZmluZSBWVERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFV
TEwgPDwgNDYpDQo+ID4gKyNkZWZpbmUgVlREX0VDQVBfRkxUUyAgICAgICAgICAgICAgICgxVUxM
IDw8IDQ3KQ0KPiA+DQo+ID4gIC8qIENBUF9SRUcgKi8NCj4gPiAgLyogKG9mZnNldCA+PiA0KSA8
PCAyNCAqLw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBi
L2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+ID4gaW5kZXggMTJmM2QyNi4uYjUxY2M5
ZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPiA+ICsr
KyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+ID4gQEAgLTI3MCw2ICsyNzAsNyBA
QCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4gPiAgICAgIGJvb2wgYnVnZ3lfZWltOyAgICAg
ICAgICAgICAgICAgLyogRm9yY2UgYnVnZ3kgRUlNIHVubGVzcyBlaW09b2ZmICovDQo+ID4gICAg
ICB1aW50OF90IGF3X2JpdHM7ICAgICAgICAgICAgICAgIC8qIEhvc3QvSU9WQSBhZGRyZXNzIHdp
ZHRoIChpbiBiaXRzKSAqLw0KPiA+ICAgICAgYm9vbCBkbWFfZHJhaW47ICAgICAgICAgICAgICAg
ICAvKiBXaGV0aGVyIERNQSByL3cgZHJhaW5pbmcgZW5hYmxlZCAqLw0KPiA+ICsgICAgY2hhciAq
c21fbW9kZWw7ICAgICAgICAgIC8qIGlkZW50aWZ5IGFjdHVhbCBzY2FsYWJsZSBtb2RlIGlvbW11
IG1vZGVsKi8NCj4gPg0KPiA+ICAgICAgLyoNCj4gPiAgICAgICAqIFByb3RlY3RzIElPTU1VIHN0
YXRlcyBpbiBnZW5lcmFsLiAgQ3VycmVudGx5IGl0IHByb3RlY3RzIHRoZQ0KPiA+IC0tDQo+ID4g
Mi43LjQNCj4gPg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IC0tDQo+IFBldGVyIFh1DQoNClRoYW5r
cywNCllpIExpdQ0K

