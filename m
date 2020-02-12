Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A3C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49DE206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 07:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49DE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1mGD-000645-31
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 02:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j1mF7-00059h-F7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j1mF5-0004oc-Dc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:15:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:19059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j1mF5-0004l8-4W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 02:15:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 23:15:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="347463606"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2020 23:15:22 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 23:15:22 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 23:15:21 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.138]) with mapi id 14.03.0439.000;
 Wed, 12 Feb 2020 15:15:14 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Topic: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Index: AQHV1p1ISlCEZJtKwkqCei/mecuDIagDpFsAgADzWWCAES39gIABZmlA
Date: Wed, 12 Feb 2020 07:15:13 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1BA4D8@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-4-git-send-email-yi.l.liu@intel.com>
 <20200131040644.GG15210@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A199306@SHSMSX104.ccr.corp.intel.com>
 <20200211165843.GG984290@xz-x1>
In-Reply-To: <20200211165843.GG984290@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzhjOWE0OTEtM2I3My00YTljLTljYzMtYzM4MTc1M2M0N2ZjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWlwvOGdpMFZPUWNjU3lvZTF6T05YeTVjUjdKKzBQZnNLcEJtcjIza1o3UVdZRUVkKzhDTVNRTWZPc1pyQmRBczIifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi
 Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, 
 Yi Y" <yi.y.sun@intel.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCj4gRnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDEyLCAyMDIwIDEyOjU5IEFNDQo+IFRvOiBMaXUsIFlpIEwg
PHlpLmwubGl1QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgdjMgMDMvMjVdIGh3L2lv
bW11OiBpbnRyb2R1Y2UgSU9NTVVDb250ZXh0DQo+IA0KPiBPbiBGcmksIEphbiAzMSwgMjAyMCBh
dCAxMTo0MjoxM0FNICswMDAwLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gPiBJJ20gbm90IHZlcnkg
Y2xlYXIgb24gdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZW4gYW4gSU9NTVVDb250ZXh0IGFuZCBhDQo+
ID4gPiBEdWFsU3RhZ2VJT01NVU9iamVjdC4gIENhbiB0aGVyZSBiZSBtYW55IElPTU1VQ29udGV4
dHMgdG8gYQ0KPiA+ID4gRHVhbFN0YWdlSU9NTVVPQmplY3Q/ICBUaGUgb3RoZXIgd2F5IGFyb3Vu
ZD8gIE9yIGlzIGl0IGp1c3QNCj4gPiA+IHplcm8tb3Itb25lIER1YWxTdGFnZUlPTU1VT2JqZWN0
cyB0byBhbiBJT01NVUNvbnRleHQ/DQo+ID4NCj4gPiBJdCBpcyBwb3NzaWJsZS4gQXMgdGhlIGJl
bG93IHBhdGNoIHNob3dzLCBEdWFsU3RhZ2VJT01NVU9iamVjdCBpcyBwZXIgdmZpbw0KPiA+IGNv
bnRhaW5lci4gSU9NTVVDb250ZXh0IGNhbiBiZSBlaXRoZXIgcGVyLWRldmljZSBvciBzaGFyZWQg
YWNyb3NzIGRldmljZXMsDQo+ID4gaXQgZGVwZW5kcyBvbiB2ZW5kb3Igc3BlY2lmaWMgdklPTU1V
IGVtdWxhdG9ycy4NCj4gDQo+IElzIHRoZXJlIGFuIGV4YW1wbGUgd2hlbiBhbiBJT01NVUNvbnRl
eHQgY2FuIGJlIG5vdCBwZXItZGV2aWNlPw0KDQpObywgSSBkb27igJl0IGhhdmUgc3VjaCBleGFt
cGxlIHNvIGZhci4gQnV0IGFzIElPTU1VQ29udGV4dCBpcyBnb3QgZnJvbQ0KcGNpX2RldmljZV9p
b21tdV9jb250ZXh0KCksICBpbiBjb25jZXB0IGl0IHBvc3NpYmxlIHRvIGJlIG5vdCBwZXItZGV2
aWNlLg0KSXQgaXMga2luZCBvZiBsZWF2ZSB0byB2SU9NTVUgdG8gZGVjaWRlIGlmIGRpZmZlcmVu
dCBkZXZpY2VzIGNvdWxkIHNoYXJlIGENCnNpbmdsZSBJT01NVUNvbnRleHQuDQoNCj4gSXQgbWFr
ZXMgc2Vuc2UgdG8gbWUgdG8gaGF2ZSBhbiBvYmplY3QgdGhhdCBpcyBwZXItY29udGFpbmVyIChp
biB5b3VyDQo+IGNhc2UsIHRoZSBEdWFsU3RhZ2VJT01NVU9iamVjdCwgSUlVQyksIHRoZW4gd2Ug
Y2FuIGNvbm5lY3QgdGhhdCBvYmplY3QNCj4gdG8gYSBkZXZpY2UuICBIb3dldmVyIEknbSBhIGJp
dCBjb25mdXNlZCBvbiB3aHkgd2UndmUgZ290IHR3byBhYnN0cmFjdA0KPiBsYXllcnMgKHRoZSBv
dGhlciBvbmUgaXMgSU9NTVVDb250ZXh0KT8gIFRoYXQgd2FzIHByZXZpb3VzbHkgZm9yIHRoZQ0K
PiB3aG9sZSBTVkEgbmV3IEFQSXMsIG5vdyBpdCdzIGFsbCBtb3ZlZCBvdmVyIHRvIHRoZSBvdGhl
ciBuZXcgb2JqZWN0LA0KPiB0aGVuIElPTU1VQ29udGV4dCBvbmx5IHJlZ2lzdGVyL3VucmVnaXN0
ZXIuLi4NCg0KWW91ciB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QuIEFjdHVhbGx5LCBJIGFsc28g
c3RydWdnbGVkIG9uIGFkZGluZyB0d28NCmFic3RyYWN0IGxheWVyLiBCdXQsIHlvdSBrbm93LCB0
aGVyZSBhcmUgdHdvIGZ1bmN0aW9uIGNhbGxpbmcgcmVxdWlyZW1lbnRzDQphcm91bmQgdlNWQSBl
bmFibGluZy4gRmlyc3Qgb25lIGlzIGV4cGxpY2l0IG1ldGhvZCBmb3IgdklPTU1VIGNhbGxzIGlu
dG8NClZGSU8gKHBhc2lkIGFsbG9jYXRpb24sIGJpbmQgZ3Vlc3QgcGFnZSB0YWJsZSwgY2FjaGUg
aW52YWxpZGF0ZSkuIFNlY29uZA0Kb25lIGlzIGV4cGxpY2l0IG1ldGhvZCBmb3IgVkZJTyBjYWxs
cyBpbnRvIHZJT01NVSAoRE1BIGZhdWx0L1BSUSBpbmplY3Rpb24NCndoaWNoIGlzIG5vdCBpbmNs
dWRlZCBpbiB0aGlzIHNlcmllcyB5ZXQsIGJ1dCB3aWxsIGJlIHVwc3RyZWFtZWQgbGF0ZXIpLiAN
ClNvIEkgYWRkZWQgdGhlIER1YWxTdGFnZUlPTU1VT2JqZWN0IHRvIGNvdmVyIHZJT01NVSB0byBW
RklPIGNhbGxpbmdzLCBhbmQNCklPTU1VQ29udGV4dCB0byBjb3ZlciBWRklPIHRvIHZJT01NVSBj
YWxsaW5ncy4gQXMgSU9NTVVDb250ZXh0IGNvdmVycyBWRklPDQp0byB2SU9NTVUgY2FsbGluZ3Ms
IHNvIEkgbWFkZSBpdCBpbmNsdWRlIHJlZ2lzdGVyL3VucmVnaXN0ZXIuDQoNCj4gQ2FuIHdlIHB1
dCB0aGUgcmVnL3VucmVnDQo+IHByb2NlZHVyZXMgaW50byBEdWFsU3RhZ2VJT01NVU9iamVjdCBh
cyB3ZWxsPyAgVGhlbiB3ZSBkcm9wIHRoZQ0KPiBJT01NVUNvbnRleHQgKG9yIHNheSwga2VlcCBJ
T01NVUNvbnRleHQgYW5kIGRyb3AgRHVhbFN0YWdlSU9NTVVPYmplY3QNCj4gYnV0IGxldCBJT01N
VUNvbnRleHQgdG8gYmUgcGVyLXZmaW8tY29udGFpbmVyLCB0aGUgbWFqb3IgZGlmZmVyZW5jZSBp
cw0KPiB0aGUgbmFtaW5nIGhlcmUsIHNheSwgUEFTSUQgYWxsb2NhdGlvbiBkb2VzIG5vdCBzZWVt
IHRvIGJlIHJlbGF0ZWQgdG8NCj4gZHVhbC1zdGFnZSBhdCBhbGwpLg0KPg0KPiBCZXNpZGVzIHRo
YXQsIG5vdCBzdXJlIEkgcmVhZCBpdCByaWdodC4uLiBidXQgZXZlbiB3aXRoIHlvdXIgY3VycmVu
dA0KPiBzZXJpZXMsIHRoZSBjb250YWluZXItPmlvbW11X2N0eCB3aWxsIGFsd2F5cyBvbmx5IGJl
IGJvdW5kIHRvIHRoZQ0KPiBmaXJzdCBkZXZpY2UgY3JlYXRlZCB3aXRoaW4gdGhhdCBjb250YWlu
ZXIsIHNpbmNlIHlvdSd2ZSBnb3Q6DQo+IA0KPiAgICAgZ3JvdXAgPSB2ZmlvX2dldF9ncm91cChn
cm91cGlkLCBwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UocGRldiksDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBjaV9kZXZpY2VfaW9tbXVfY29udGV4dChwZGV2KSwgZXJycCk7
DQo+IA0KPiBBbmQ6DQo+IA0KPiAgICAgaWYgKHZmaW9fY29ubmVjdF9jb250YWluZXIoZ3JvdXAs
IGFzLCBpb21tdV9jdHgsIGVycnApKSB7DQo+ICAgICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCAi
ZmFpbGVkIHRvIHNldHVwIGNvbnRhaW5lciBmb3IgZ3JvdXAgJWQ6ICIsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICBncm91cGlkKTsNCj4gICAgICAgICBnb3RvIGNsb3NlX2ZkX2V4aXQ7DQo+ICAg
ICB9DQo+IA0KPiBUaGUgaW9tbXVfY3R4IHdpbGwgYmUgc2V0IHRvIGNvbnRhaW5lci0+aW9tbXVf
Y3R4IGlmIHRoZXJlJ3Mgbm8NCj4gZXhpc3RpbmcgY29udGFpbmVyLg0KDQp5ZXMsIGl0J3MgdHJ1
ZS4gTWF5IG5lZWQgdG8gYWRkIGEgaW9tbXVfY3R4IGxpc3QgaW4gVkZJTyBjb250YWluZXIgb3IN
CmFkZCBjaGVjayBvbiB0aGUgaW5wdXQgaW9tbXVfY3R4IG9mIHZmaW9fZ2V0X2dyb3VwKCkgaWYg
c3RpY2tpbmcgb24gdGhpcw0KZGlyZWN0aW9uLg0KDQpXaGlsZSBjb25zaWRlcmluZyB5b3VyIHN1
Z2dlc3Rpb24gb24gZHJvcHBpbmcgb25lIG9mIHRoZSB0d28gYWJzdHJhY3QNCmxheWVycy4gSSBj
YW1lIHVwIGEgbmV3IHByb3Bvc2FsIGFzIGJlbG93Og0KDQpXZSBtYXkgZHJvcCB0aGUgSU9NTVVD
b250ZXh0IGluIHRoaXMgc2VyaWVzLCBhbmQgcmVuYW1lIER1YWxTdGFnZUlPTU1VT2JqZWN0DQp0
byBIb3N0SU9NTVVDb250ZXh0LCB3aGljaCBpcyBwZXItdmZpby1jb250YWluZXIuIEFkZCBhbiBp
bnRlcmZhY2UgaW4gUENJDQpsYXllcihlLmcuIGFuIGNhbGxiYWNrIGluICBQQ0lEZXZpY2UpIHRv
IGxldCB2SU9NTVUgZ2V0IEhvc3RJT01NVUNvbnRleHQuDQpJIHRoaW5rIHRoaXMgY291bGQgY292
ZXIgdGhlIHJlcXVpcmVtZW50IG9mIHByb3ZpZGluZyBleHBsaWNpdCBtZXRob2QgZm9yDQp2SU9N
TVUgdG8gY2FsbCBpbnRvIFZGSU8gYW5kIHRoZW4gcHJvZ3JhbSBob3N0IElPTU1VLg0KDQpXaGls
ZSBmb3IgdGhlIHJlcXVpcmVtZW50IG9mIFZGSU8gdG8gdklPTU1VIGNhbGxpbmdzIChlLmcuIFBS
USksIEkgdGhpbmsgaXQNCmNvdWxkIGJlIGRvbmUgdmlhIFBDSSBsYXllciBieSBhZGRpbmcgYW4g
b3BlcmF0aW9uIGluIFBDSUlPTU1VT3BzLiBUaG91Z2h0cz8NCg0KVGhhbmtzLA0KWWkgTGl1DQoN
Cg==

