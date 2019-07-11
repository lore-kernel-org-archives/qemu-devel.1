Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C52DC74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C67208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 06:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C67208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlSfC-0006hP-Hh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 02:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45994)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hlSeS-0006F6-Gx
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hlSeR-0002fQ-8e
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:33:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:43136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hlSeR-0002SZ-09
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 02:33:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 23:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; d="scan'208";a="167938850"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2019 23:33:50 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 23:33:49 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 23:33:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.174]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 14:25:48 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <zhexu@redhat.com>
Thread-Topic: [RFC v1 04/18] intel_iommu: add "sm_model" option
Thread-Index: AQHVM+ykW0tId7lQvkS+qMkTYXVuu6bBCoMAgAK56DCAAFabgIAA322Q
Date: Thu, 11 Jul 2019 06:25:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439F2C5FD@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-5-git-send-email-yi.l.liu@intel.com>
 <20190709021554.GB5178@xz-x1>
 <A2975661238FB949B60364EF0F2C257439F2A6D3@SHSMSX104.ccr.corp.intel.com>
 <20190711010347.GI5178@xz-x1>
In-Reply-To: <20190711010347.GI5178@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWIwMWQwMjctOWEyYi00NWJhLWE4ZjEtZjk5ZmJmZWUwMjJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaExNenhVVFNcL2p2alk1Z3Jmb053ZmFibzlnSElBdFYyS1B6REppcHRlNjVndXppSFBIWTlKU3NscmVNdTliZ00ifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnpoZXh1QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdWx5IDExLCAyMDE5IDk6MDQgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50
ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MSAwNC8xOF0gaW50ZWxfaW9tbXU6IGFkZCAi
c21fbW9kZWwiIG9wdGlvbg0KPiANCj4gT24gV2VkLCBKdWwgMTAsIDIwMTkgYXQgMTI6MTQ6NDRQ
TSArMDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+ID4gRnJvbTogUGV0ZXIgWHUgW21haWx0bzp6
aGV4dUByZWRoYXQuY29tXQ0KPiA+ID4gU2VudDogVHVlc2RheSwgSnVseSA5LCAyMDE5IDEwOjE2
IEFNDQo+ID4gPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gPiBTdWJq
ZWN0OiBSZTogW1JGQyB2MSAwNC8xOF0gaW50ZWxfaW9tbXU6IGFkZCAic21fbW9kZWwiIG9wdGlv
bg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgSnVsIDA1LCAyMDE5IGF0IDA3OjAxOjM3UE0gKzA4MDAs
IExpdSBZaSBMIHdyb3RlOg0KPiA+ID4gPiBJbnRlbCBWVC1kIDMuMCBpbnRyb2R1Y2VzIHNjYWxh
YmxlIG1vZGUsIGFuZCBpdCBoYXMgYSBidW5jaCBvZg0KPiA+ID4gPiBjYXBhYmlsaXRpZXMgcmVs
YXRlZCB0byBzY2FsYWJsZSBtb2RlIHRyYW5zbGF0aW9uLCB0aHVzIHRoZXJlIGFyZQ0KPiA+ID4g
PiBtdWx0aXBsZSBjb21iaW5hdGlvbnMuIFdoaWxlIHRoaXMgdklPTU1VIGltcGxlbWVudGF0aW9u
IHdhbnRzDQo+ID4gPiA+IHNpbXBsaWZ5IGl0IGZvciB1c2VyIGJ5IHByb3ZpZGluZyB0eXBpY2Fs
IGNvbWJpbmF0aW9ucy4NCj4gPiA+ID4gVXNlciBjb3VsZCBjb25maWcgaXQgYnkgInNtX21vZGVs
IiBvcHRpb24uIFRoZSB1c2FnZSBpcyBhcw0KPiA+ID4gPiBiZWxvdzoNCj4gPiA+ID4NCj4gPiA+
ID4gIi1kZXZpY2UgaW50ZWwtaW9tbXUseC1zY2FsYWJsZS1tb2RlPW9uLHNtX21vZGVsPVsibGVn
YWN5Inwic2NhbGFibGUiXSINCj4gPiA+DQo+ID4gPiBJcyBpdCBhIHJlcXVpcmVtZW50IHRvIHNw
bGl0IGludG8gdHdvIHBhcmFtZXRlcnMsIGluc3RlYWQgb2YganVzdA0KPiA+ID4gZXhwb3Npbmcg
ZXZlcnl0aGluZyBhYm91dCBzY2FsYWJsZSBtb2RlIHdoZW4geC1zY2FsYWJsZS1tb2RlIGlzIHNl
dD8NCj4gPg0KPiA+IHllcywgaXQgaXMuIFNjYWxhYmxlIG1vZGUgaGFzIG11bHRpcGxlIGNhcGFi
aWxpdGllcy4gQW5kIHdlIHdhbnQgdG8NCj4gPiBzdXBwb3J0IHRoZSBtb3N0IHR5cGljYWwgY29t
YmluYXRpb25zIHRvIHNpbXBsaWZ5IHNvZnR3YXJlLiBlLmcuDQo+ID4gY3VycmVudCBzY2FsYWJs
ZSBtb2RlIHZJT01NVSBleHBvc2VzIG9ubHkgMm5kIGxldmVsIHRyYW5zbGF0aW9uIHRvDQo+ID4g
Z3Vlc3QsIGFuZCBndWVzdCBJT1ZBIHN1cHBvcnQgaXMgdmlhIHNoYWRvd2luZyBndWVzdCAybmQg
bGV2ZWwgcGFnZQ0KPiA+IHRhYmxlLiBXZSBoYXZlIHBsYW4gdG8gbW92ZSBJT1ZBIGZyb20gMm5k
IGxldmVsIHBhZ2UgdGFibGUgdG8gMXN0DQo+ID4gbGV2ZWwgcGFnZSB0YWJsZSwgdGh1cyBndWVz
dCBJT1ZBIGNhbiBiZSBzdXBwb3J0ZWQgd2l0aCBuZXN0ZWQNCj4gPiB0cmFuc2xhdGlvbi4gQW5k
IHRoaXMgYWxzbyBhZGRyZXNzZXMgdGhlIGNvLWV4aXN0ZW5jZSBpc3N1ZSBvZiBndWVzdA0KPiA+
IFNWQSBhbmQgZ3Vlc3QgSU9WQS4gU28gaW4gZnV0dXJlIHdlIHdpbGwgaGF2ZSBzY2FsYWJsZSBt
b2RlIHZJT01NVQ0KPiA+IGV4cG9zZSAxc3QgbGV2ZWwgdHJhbnNsYXRpb24gb25seS4gVG8gZGlm
ZmVyZW50aWF0ZSB0aGlzIGNvbmZpZyB3aXRoIGN1cnJlbnQgdklPTU1VLA0KPiB3ZSBuZWVkIGFu
IGV4dHJhIG9wdGlvbiB0byBjb250cm9sIGl0LiBCdXQgeWVzLCBpdCBpcyBzdGlsbCBzY2FsYWJs
ZSBtb2RlIHZJT01NVS4NCj4gPiBqdXN0IGhhcyBkaWZmZXJlbnQgY2FwYWJpbGl0eSBleHBvc2Vk
IHRvIGd1ZXN0Lg0KPiANCj4gSSBzZWUuICBUaGFua3MgZm9yIGV4cGxhaW5pbmcuDQoNCnlvdSBh
cmUgd2VsY29tZS4gOi0pDQoNCj4gDQo+ID4NCj4gPiBCVFcuIGRvIHlvdSBrbm93IGlmIEkgY2Fu
IGFkZCBzdWItb3B0aW9ucyB1bmRlciAieC1zY2FsYWJsZS1tb2RlIj8gSQ0KPiA+IHRoaW5rIHRo
YXQgbWF5IGRlbW9uc3RyYXRlIHRoZSBkZXBlbmRlbmN5IGJldHRlci4NCj4gDQo+IEknbSBub3Qg
YW4gZXhwZXJ0IG9mIHRoYXQsIGJ1dCBJIHRoaW5rIGF0IGxlYXN0IHdlIGNhbiBtYWtlIGl0IGEg
c3RyaW5nIHBhcmFtZXRlcg0KPiBkZXBlbmRzIG9uIHdoYXQgeW91IHByZWZlciwgdGhlbiB3ZSBj
YW4gZG8gIngtc2NhbGFibGUtbW9kZT1sZWdhY3l8bW9kZXJuIi4gIE9yDQo+IGtlZXAgdGhpcyB3
b3VsZCBiZSBmaW5lIHRvby4NCg0KaG1tbSwgaXQncyBhIGdvb2QgaWRlYS4gSWYgd2UgYWdyZWUg
dG8gY2hhbmdlIHgtc2NhbGFibGUtbW9kZSB0byBiZSBhIHN0cmluZw0KcGFyYW1ldGVyLiBJIHRo
aW5rIEkgY2FuIGNoYW5nZSBpdC4NCg0KPiA+DQo+ID4gPiA+DQo+ID4gPiA+ICAtICJsZWdhY3ki
OiBnaXZlcyBzdXBwb3J0IGZvciBTTCBwYWdlIHRhYmxlDQo+ID4gPiA+ICAtICJzY2FsYWJsZSI6
IGdpdmVzIHN1cHBvcnQgZm9yIEZMIHBhZ2UgdGFibGUsIHBhc2lkLCB2aXJ0dWFsDQo+ID4gPiA+
IGNvbW1hbmQNCj4gPiA+ID4gIC0gZGVmYXVsdCB0byBiZSAibGVnYWN5IiBpZiAieC1zY2FsYWJs
ZS1tb2RlPW9uIHdoaWxlIG5vIHNtX21vZGVsIGlzDQo+ID4gPiA+ICAgIGNvbmZpZ3VyZWQNCj4g
PiA+ID4NCj4gPiA+ID4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiA+
ID4gPiBDYzogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+
ID4gQ2M6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiA+ID4gQ2M6IFlpIFN1biA8
eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWkg
TCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlp
Lnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBody9pMzg2L2lu
dGVsX2lvbW11LmMgICAgICAgICAgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+
ID4gPiA+ICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMiArKw0KPiA+ID4gPiBp
bmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMSArDQo+ID4gPiA+ICAzIGZpbGVzIGNo
YW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
YyBpbmRleA0KPiA+ID4gPiA0NGIxMjMxLi4zMTYwYTA1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+ID4gPiA+IEBAIC0zMDE0LDYgKzMwMTQsNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3Bl
cnRpZXNbXSA9IHsNCj4gPiA+ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJjYWNoaW5nLW1vZGUi
LCBJbnRlbElPTU1VU3RhdGUsDQo+ID4gPiA+IGNhY2hpbmdfbW9kZSwNCj4gPiA+IEZBTFNFKSwN
Cj4gPiA+ID4gICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LXNjYWxhYmxlLW1vZGUiLCBJbnRlbElP
TU1VU3RhdGUsDQo+ID4gPiA+IHNjYWxhYmxlX21vZGUsDQo+ID4gPiBGQUxTRSksDQo+ID4gPiA+
ICAgICAgREVGSU5FX1BST1BfQk9PTCgiZG1hLWRyYWluIiwgSW50ZWxJT01NVVN0YXRlLCBkbWFf
ZHJhaW4sDQo+ID4gPiA+IHRydWUpLA0KPiA+ID4gPiArICAgIERFRklORV9QUk9QX1NUUklORygi
c21fbW9kZWwiLCBJbnRlbElPTU1VU3RhdGUsIHNtX21vZGVsKSwNCj4gPiA+DQo+ID4gPiBDYW4g
ZG8gJ3MvLS9fLycgdG8gZm9sbG93IHRoZSByZXN0IGlmIHdlIG5lZWQgaXQuDQo+ID4NCj4gPiBE
byB5b3UgbWVhbiBzdWItb3B0aW9ucyBhZnRlciAieC1zY2FsYWJsZS1tb2RlIj8NCj4gDQo+IE5v
LCBJIG9ubHkgbWVhbiAic20tbW9kZWwiLiA6KQ0KDQpnb3QgaXQuIGlmIHdlIG1vZGlmeSB4LXNj
YWxhYmxlLW1vZGUgdG8gYmUgc3RyaW5nLCB0aGVuIHNtLW1vZGVsIHdvdWxkIGJlDQpyZW1vdmVk
Lg0KDQpSZWdhcmRzLA0KWWkgTGl1DQoNCj4gUmVnYXJkcywNCj4gDQo+IC0tDQo+IFBldGVyIFh1
DQo=

