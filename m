Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10DDC74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 07:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49AC20838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 07:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49AC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlTXq-0002Mg-Rw
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 03:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hlTX3-0001uU-MI
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 03:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hlTX2-0008PY-DF
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 03:30:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:7717)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hlTX1-0008K4-W0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 03:30:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jul 2019 00:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; d="scan'208";a="193315394"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2019 00:30:16 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jul 2019 00:30:16 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jul 2019 00:30:15 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.60]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 15:24:41 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <zhexu@redhat.com>
Thread-Topic: [RFC v1 10/18] intel_iommu: tag VTDAddressSpace instance with
 PASID
Thread-Index: AQHVM+yp75CJKWp0K0q167GQ/LUaeqbBTKoAgAO8UqA=
Date: Thu, 11 Jul 2019 07:24:40 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439F2C703@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-11-git-send-email-yi.l.liu@intel.com>
 <20190709061240.GF5178@xz-x1>
In-Reply-To: <20190709061240.GF5178@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTM2NThjMGYtM2I5NS00OTRhLWI4ZWItNWJlYTI3ODA5NzViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieTgycGZxMHhqWG5ucjlVdGhNVHhWU0RGWHJ6cnM2ZkI0b1F6SmNkZjJTb0trNUF6R2dnVDBNdmJTMU9PODB0YiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [RFC v1 10/18] intel_iommu: tag VTDAddressSpace
 instance with PASID
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

PiBGcm9tOiBrdm0tb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86a3ZtLW93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmDQo+IE9mIFBldGVyIFh1DQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bHkgOSwgMjAxOSAyOjEzIFBNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtSRkMgdjEgMTAvMThdIGludGVsX2lvbW11OiB0YWcgVlREQWRkcmVz
c1NwYWNlIGluc3RhbmNlIHdpdGggUEFTSUQNCj4gDQo+IE9uIEZyaSwgSnVsIDA1LCAyMDE5IGF0
IDA3OjAxOjQzUE0gKzA4MDAsIExpdSBZaSBMIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyBuZXcgZmllbGRzIGluIFZUREFkZHJlc3NTcGFjZSBmb3IgZnVydGhlciBQQVNJRA0KPiA+
IHN1cHBvcnQgaW4gSW50ZWwgdklPTU1VLiBJbiBvbGQgdGltZSwgZWFjaCBkZXZpY2UgaGFzIGEN
Cj4gPiBWVERBZGRyZXNzU3BhY2UgaW5zdGFuY2UgdG8gc3RhbmQgZm9yIGl0cyBndWVzdCBJT1ZB
IGFkZHJlc3Mgc3BhY2UNCj4gPiB3aGVuIHZJT01NVSBpcyBlbmFibGVkLiBIb3dldmVyLCB3aGVu
IFBBU0lEIGlzIGV4cG9zZWQgdG8gZ3Vlc3QsDQo+ID4gZGV2aWNlIHdpbGwgaGF2ZSBtdWx0aXBs
ZSBhZGRyZXNzIHNwYWNlcyB3aGljaCBhcmUgdGFnZ2VkIHdpdGggUEFTSUQuDQo+ID4gVG8gc3Vp
dCB0aGlzIGNoYW5nZSwgVlREQWRkcmVzc1NwYWNlIHNob3VsZCBiZSB0YWdnZWQgd2l0aCBQQVNJ
RHMgaW4gSW50ZWwNCj4gdklPTU1VLg0KPiA+DQo+ID4gVG8gcmVjb3JkIFBBU0lEIHRhZ2dlZCBW
VERBZGRyZXNzU3BhY2VzLCBhIGhhc2ggdGFibGUgaXMgaW50cm9kdWNlZC4NCj4gPiBUaGUgZGF0
YSBpbiB0aGUgaGFzaCB0YWJsZSBjYW4gYmUgdXNlZCBmb3IgZnV0dXJlIHNhbml0eSBjaGVjayBh
bmQNCj4gPiByZXRyaWV2ZSBwcmV2aW91cyBQQVNJRCBjb25maWdzIG9mIGd1ZXN0IGFuZCBhbHNv
IGZ1dHVyZSBlbXVsYXRlZCBTVkENCj4gPiBETUEgc3VwcG9ydCBmb3IgZW11bGF0ZWQgU1ZBIGNh
cGFibGUgZGV2aWNlcy4gVGhlIGxvb2t1cCBrZXkgaXMgYQ0KPiA+IHN0cmluZyBhbmQgaXRzIGZv
cm1hdCBpcyBhcyBiZWxvdzoNCj4gPg0KPiA+ICJyc3YlMDRkcGFzaWQlMDEwZHNpZCUwNmQiIC0t
IHRvdGFsbHkgMzIgYnl0ZXMNCj4gDQo+IENhbiB3ZSBtYWtlIGl0IHNpbXBseSBhIHN0cnVjdD8N
Cj4gDQo+ICAgICAgICAgc3RydWN0IHBhc2lkX2tleSB7DQo+ICAgICAgICAgICAgICAgICB1aW50
MzJfdCBwYXNpZDsNCj4gICAgICAgICAgICAgICAgIHVpbnQxNl90IHNpZDsNCj4gICAgICAgICB9
DQoNCk5pY2Ugc3VnZ2VzdGlvbi4gTGV0IG1lIHRyeSBpdC4NCg0KPiBBbHNvIEkgdGhpbmsgd2Ug
ZG9uJ3QgbmVlZCB0byBrZWVwIHJlc2VydmVkIGJpdHMgYmVjYXVzZSBpdCdsbCBiZSBhIHN0cnVj
dHVyZSB0aGF0J2xsDQo+IG9ubHkgYmUgdXNlZCBieSBRRU1VIHNvIHdlIGNhbiBleHRlbmQgaXQg
ZWFzaWx5IGluIHRoZSBmdXR1cmUgd2hlbiBuZWNlc3NhcnkuDQoNCklmIHVzaW5nIHN0cnVjdHVy
ZSwgbm8gbmVlZCBpbmRlZWQuIDotKQ0KDQo+IFsuLi5dDQo+IA0KPiA+ICtzdGF0aWMgaW50IHZ0
ZF9wYXNpZF9jYWNoZV9kc2koSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdA0KPiA+ICtkb21h
aW5faWQpIHsNCj4gPiArICAgIFZURFBBU0lEQ2FjaGVJbmZvIHBjX2luZm87DQo+ID4gKw0KPiA+
ICsgICAgdHJhY2VfdnRkX3Bhc2lkX2NhY2hlX2RzaShkb21haW5faWQpOw0KPiA+ICsNCj4gPiAr
ICAgIHBjX2luZm8uZmxhZ3MgPSBWVERfUEFTSURfQ0FDSEVfRE9NU0k7DQo+ID4gKyAgICBwY19p
bmZvLmRvbWFpbl9pZCA9IGRvbWFpbl9pZDsNCj4gPiArDQo+ID4gKyAgICAvKg0KPiA+ICsgICAg
ICogdXNlIGdfaGFzaF90YWJsZV9mb3JlYWNoX3JlbW92ZSgpLCB3aGljaCB3aWxsIGZyZWUgdGhl
DQo+ID4gKyAgICAgKiB2dGRfcGFzaWRfYXMgaW5zdGFuY2VzLg0KPiA+ICsgICAgICovDQo+ID4g
KyAgICBnX2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUocy0+dnRkX3Bhc2lkX2FzLCB2dGRfZmx1
c2hfcGFzaWQsICZwY19pbmZvKTsNCj4gPiArICAgIC8qDQo+ID4gKyAgICAgKiBUT0RPOiBEb21h
aW4gc2VsZWN0aXZlIFBBU0lEIGNhY2hlIGludmFsaWRhdGlvbg0KPiA+ICsgICAgICogbWF5IGJl
IGlzc3VlZCB3cm9uZ2x5IGJ5IHByb2dyYW1tZXIsIHRvIGJlIHNhZmUsDQo+ID4gKyAgICAgKiBh
ZnRlciBpbnZhbGlkYXRpbmcgdGhlIHBhc2lkIGNhY2hlcywgZW11bGF0b3INCj4gPiArICAgICAq
IG5lZWRzIHRvIHJlcGxheSB0aGUgcGFzaWQgYmluZGluZ3MgYnkgd2Fsa2luZyBndWVzdA0KPiA+
ICsgICAgICogcGFzaWQgZGlyIGFuZCBwYXNpZCB0YWJsZS4NCj4gPiArICAgICAqLw0KPiANCj4g
SXQgc2VlbXMgdG8gbWUgdGhhdCB0aGlzIGlzIHN0aWxsIHVuY2hhbmdlZCBmb3IgdGhlIHdob2xl
IHNlcmllcy4NCj4gSXQncyBmaW5lIGZvciBSRkMsIGJ1dCBqdXN0IGEgcmVtaW5kZXIgdGhhdCBw
bGVhc2UgZWl0aGVyIGNvbW1lbnQgb24gd2h5IHdlIGRvbid0DQo+IGhhdmUgc29tZXRoaW5nIG9y
IGltcGxlbWVudCB3aGF0IHdlIG5lZWQgaGVyZS4uLg0KDQpZZXMsIEkgaGF2ZW7igJl0IGFkZGVk
IGluIHRoaXMgUkZDLiBTbyBsaXN0ZWQgaXQgYXMgYSBUT0RPIGhlcmUuIFRoaXMgd291bGQgYmUg
ZG9uZQ0KYWZ0ZXIgdGhlIHdvcmsgZmxvdyBpcyBjbGVhci4gOi0pDQoNCj4gWy4uLl0NCj4gDQo+
ID4gIC8qIFVubWFwIHRoZSB3aG9sZSByYW5nZSBpbiB0aGUgbm90aWZpZXIncyBzY29wZS4gKi8g
IHN0YXRpYyB2b2lkDQo+ID4gdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNl
ICphcywgSU9NTVVOb3RpZmllciAqbikgIHsgQEANCj4gPiAtMzkxNCw2ICs0MDc2LDggQEAgc3Rh
dGljIHZvaWQgdnRkX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19mcmVlLCBnX2ZyZWUpOw0K
PiA+ICAgICAgcy0+dnRkX2FzX2J5X2J1c3B0ciA9IGdfaGFzaF90YWJsZV9uZXdfZnVsbCh2dGRf
dWludDY0X2hhc2gsDQo+IHZ0ZF91aW50NjRfZXF1YWwsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX2ZyZWUsIGdfZnJlZSk7DQo+ID4gKyAgICBz
LT52dGRfcGFzaWRfYXMgPSBnX2hhc2hfdGFibGVfbmV3X2Z1bGwoJmdfc3RyX2hhc2gsICZnX3N0
cl9lcXVhbCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdfZnJl
ZSwgaGFzaF9wYXNpZF9hc19mcmVlKTsNCj4gDQo+IENhbiB1c2UgZ19mcmVlKCkgYW5kIGRyb3Ag
aGFzaF9wYXNpZF9hc19mcmVlKCk/DQoNCk5pY2UgY2F0Y2guIEkgdXNlZCBoYXNoX3Bhc2lkX2Fz
X2ZyZWUoKSBiZWNhdXNlIG9mIHRoYXQgSSdkIGxpa2UgdG8gZG8gc29tZXRoaW5nIG90aGVyDQp0
aGFuIGZyZWUgdGhlIFZUREFkZHJlc3NTcGFjZSBpbnN0YW5jZS4gZS5nLiBkZXN0cm95IHRoZSBB
ZGRyZXNzU3BhY2UgTWVtb3J5UmVnaW9uDQppbnN0YW5jZXMgYmVmb3JlIGZyZWUgVlREQWRkcmVz
c1NwYWNlIGluc3RhbmNlLiBUaGF0J3MgcmVsYXRlZCB0byBhbm90aGVyIGNvbW1lbnQNCmZyb20g
eW91IGluIGFudGhlciB0aHJlYWQuIDotKQ0KDQpGb3Igbm93LCBJIHRoaW5rIGl0IGlzIGZpbmUg
dG8gZHJvcCBpdCBhbmQganVzdCB1c2UgZ19mcmVlLg0KDQo+IEFsc28sIHRoaXMgcGF0Y2ggb25s
eSB0cmllcyB0byBkcm9wIGVudHJpZXMgb2YgdGhlIGhhc2ggdGFibGUgYnV0IHRoZSBoYXNoIHRh
YmxlIGlzIG5ldmVyDQo+IGluc2VydGVkIG9yIHVzZWQuICBJIHdvdWxkIHN1Z2dlc3QgdGhhdCB5
b3UgcHV0IHRoYXQgcGFydCB0byBiZSB3aXRoIHRoaXMgcGF0Y2ggYXMgYQ0KPiB3aG9sZSBvdGhl
cndpc2UgaXQncyBoYXJkIHRvIGNsYXJpZnkgaG93IHRoaXMgaGFzaCB0YWJsZSB3aWxsIGJlIHVz
ZWQuDQoNCkdvb2Qgc3VnZ2VzdGlvbiwgd2lsbCBtYWtlIGl0IHNvdW5kIGluIG5leHQgdmVyc2lv
bi4NCg0KVGhhbmtzLA0KWWkgTGl1DQoNCj4gUmVnYXJkcywNCj4gDQo+IC0tDQo+IFBldGVyIFh1
DQo=

