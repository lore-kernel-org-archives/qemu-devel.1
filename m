Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC19CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA3A21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA3A21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNx76-0003Bs-P1
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iNwaR-0001La-6d
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iNwaL-0000QO-9z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:12:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:43971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iNwaH-0000P9-Pn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:12:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 03:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; d="scan'208";a="204513645"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 03:12:37 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 03:12:36 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 25 Oct 2019 03:12:36 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.119]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 18:12:35 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
Thread-Topic: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VM
Thread-Index: AQHVimskKWib+KQlOUaXXMOVBk8bu6dql/6AgACL3iA=
Date: Fri, 25 Oct 2019 10:12:34 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0619@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <367adad0-eb05-c950-21d7-755fffacbed6@redhat.com>
In-Reply-To: <367adad0-eb05-c950-21d7-755fffacbed6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDNhN2FjMTUtOWI5Ni00ZWRkLTkwOTMtZjJiNDRjNDA0YTk0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid0haYTNpRGZTcXhjQWZURXB6MzJLamFwdmpzcUVaZDFNWEJcL0N5RmFYYXdrczRRQU9PYmJBNXNBUSsxaEE5dlwvIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
RnJpZGF5LCBPY3RvYmVyIDI1LCAyMDE5IDU6NDkgUE0NCj4gDQo+IA0KPiBPbiAyMDE5LzEwLzI0
IOS4i+WNiDg6MzQsIExpdSBZaSBMIHdyb3RlOg0KPiA+IFNoYXJlZCB2aXJ0dWFsIGFkZHJlc3Mg
KFNWQSksIGEuay5hLCBTaGFyZWQgdmlydHVhbCBtZW1vcnkgKFNWTSkgb24gSW50ZWwNCj4gPiBw
bGF0Zm9ybXMgYWxsb3cgYWRkcmVzcyBzcGFjZSBzaGFyaW5nIGJldHdlZW4gZGV2aWNlIERNQSBh
bmQNCj4gYXBwbGljYXRpb25zLg0KPiANCj4gDQo+IEludGVyZXN0aW5nLCBzbyB0aGUgYmVsb3cg
ZmlndXJlIGRlbW9uc3RyYXRlcyB0aGUgY2FzZSBvZiBWTS4gSSB3b25kZXINCj4gaG93IG11Y2gg
ZGlmZmVyZW5jZXMgaWYgd2UgY29tcGFyZSBpdCB3aXRoIGRvaW5nIFNWTSBiZXR3ZWVuIGRldmlj
ZQ0KPiBhbmQNCj4gYW4gb3JkaW5hcnkgcHJvY2VzcyAoZS5nIGRwZGspPw0KPiANCj4gVGhhbmtz
DQoNCk9uZSBkaWZmZXJlbmNlIGlzIHRoYXQgb3JkaW5hcnkgcHJvY2VzcyByZXF1aXJlcyBvbmx5
IHN0YWdlLTEgdHJhbnNsYXRpb24sDQp3aGlsZSBWTSByZXF1aXJlcyBuZXN0ZWQgdHJhbnNsYXRp
b24uDQoNCj4gDQo+IA0KPiA+IFNWQSBjYW4gcmVkdWNlIHByb2dyYW1taW5nIGNvbXBsZXhpdHkg
YW5kIGVuaGFuY2Ugc2VjdXJpdHkuDQo+ID4gVGhpcyBzZXJpZXMgaXMgaW50ZW5kZWQgdG8gZXhw
b3NlIFNWQSBjYXBhYmlsaXR5IHRvIFZNcy4gaS5lLiBzaGFyZWQgZ3Vlc3QNCj4gPiBhcHBsaWNh
dGlvbiBhZGRyZXNzIHNwYWNlIHdpdGggcGFzc3RocnUgZGV2aWNlcy4gVGhlIHdob2xlIFNWQQ0K
PiB2aXJ0dWFsaXphdGlvbg0KPiA+IHJlcXVpcmVzIFFFTVUvVkZJTy9JT01NVSBjaGFuZ2VzLiBU
aGlzIHNlcmllcyBpbmNsdWRlcyB0aGUgUUVNVQ0KPiBjaGFuZ2VzLCBmb3INCj4gPiBWRklPIGFu
ZCBJT01NVSBjaGFuZ2VzLCB0aGV5IGFyZSBpbiBzZXBhcmF0ZSBzZXJpZXMgKGxpc3RlZCBpbiB0
aGUNCj4gIlJlbGF0ZWQNCj4gPiBzZXJpZXMiKS4NCj4gPg0KPiA+IFRoZSBoaWdoLWxldmVsIGFy
Y2hpdGVjdHVyZSBmb3IgU1ZBIHZpcnR1YWxpemF0aW9uIGlzIGFzIGJlbG93Og0KPiA+DQo+ID4g
ICAgICAuLS0tLS0tLS0tLS0tLS4gIC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+ID4g
ICAgICB8ICAgdklPTU1VICAgIHwgIHwgR3Vlc3QgcHJvY2VzcyBDUjMsIEZMIG9ubHl8DQo+ID4g
ICAgICB8ICAgICAgICAgICAgIHwgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0nDQo+ID4g
ICAgICAuLS0tLS0tLS0tLS0tLS0tLS8NCj4gPiAgICAgIHwgUEFTSUQgRW50cnkgfC0tLSBQQVNJ
RCBjYWNoZSBmbHVzaCAtDQo+ID4gICAgICAnLS0tLS0tLS0tLS0tLScgICAgICAgICAgICAgICAg
ICAgICAgIHwNCj4gPiAgICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
Vg0KPiA+ICAgICAgfCAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgIENSMyBpbiBHUEENCj4g
PiAgICAgICctLS0tLS0tLS0tLS0tJw0KPiA+IEd1ZXN0DQo+ID4gLS0tLS0tfCBTaGFkb3cgfC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tDQo+ID4gICAgICAgIHYgICAgICAgIHYg
ICAgICAgICAgICAgICAgICAgICAgICAgIHYNCj4gPiBIb3N0DQo+ID4gICAgICAuLS0tLS0tLS0t
LS0tLS4gIC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLg0KPiA+ICAgICAgfCAgIHBJT01NVSAgICB8
ICB8IEJpbmQgRkwgZm9yIEdWQS1HUEEgIHwNCj4gPiAgICAgIHwgICAgICAgICAgICAgfCAgJy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0nDQo+ID4gICAgICAuLS0tLS0tLS0tLS0tLS0tLS8gIHwNCj4g
PiAgICAgIHwgUEFTSUQgRW50cnkgfCAgICAgViAoTmVzdGVkIHhsYXRlKQ0KPiA+ICAgICAgJy0t
LS0tLS0tLS0tLS0tLS1cLi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4gPiAgICAg
IHwgICAgICAgICAgICAgfCAgIHxTTCBmb3IgR1BBLUhQQSwgZGVmYXVsdCBkb21haW58DQo+ID4g
ICAgICB8ICAgICAgICAgICAgIHwgICAnLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tJw0K
PiA+ICAgICAgJy0tLS0tLS0tLS0tLS0nDQo+ID4gV2hlcmU6DQo+ID4gICAtIEZMID0gRmlyc3Qg
bGV2ZWwvc3RhZ2Ugb25lIHBhZ2UgdGFibGVzDQo+ID4gICAtIFNMID0gU2Vjb25kIGxldmVsL3N0
YWdlIHR3byBwYWdlIHRhYmxlcw0KPiA+DQo+ID4gVGhlIGNvbXBsZXRlIHZTVkEgdXBzdHJlYW0g
cGF0Y2hlcyBhcmUgZGl2aWRlZCBpbnRvIHRocmVlIHBoYXNlczoNCj4gPiAgICAgIDEuIENvbW1v
biBBUElzIGFuZCBQQ0kgZGV2aWNlIGRpcmVjdCBhc3NpZ25tZW50DQo+ID4gICAgICAyLiBQYWdl
IFJlcXVlc3QgU2VydmljZXMgKFBSUykgc3VwcG9ydA0KPiA+ICAgICAgMy4gTWVkaWF0ZWQgZGV2
aWNlIGFzc2lnbm1lbnQNCj4gPg0KPiA+IFRoaXMgUkZDIHBhdGNoc2V0IGlzIGFpbWluZyBmb3Ig
dGhlIHBoYXNlIDEuIFdvcmtzIHRvZ2V0aGVyIHdpdGggdGhlIFZULWQNCj4gPiBkcml2ZXJbMV0g
Y2hhbmdlcyBhbmQgVkZJTyBjaGFuZ2VzWzJdLg0KPiA+DQo+ID4gUmVsYXRlZCBzZXJpZXM6DQo+
ID4gWzFdIFtQQVRDSCB2NiAwMC8xMF0gTmVzdGVkIFNoYXJlZCBWaXJ0dWFsIEFkZHJlc3MgKFNW
QSkgVlQtZCBzdXBwb3J0Og0KPiA+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEwLzIyLzk1
Mw0KPiA+IDxUaGlzIHNlcmllcyBpcyBiYXNlZCBvbiB0aGlzIGtlcm5lbCBzZXJpZXMgZnJvbSBK
YWNvYiBQYW4+DQo+ID4NCj4gPiBbMl0gW1JGQyB2MiAwLzNdIHZmaW86IHN1cHBvcnQgU2hhcmVk
IFZpcnR1YWwgQWRkcmVzc2luZyBmcm9tIFlpIExpdQ0KPiA+DQo+ID4gVGhlcmUgYXJlIHJvdWdo
bHkgZm91ciBwYXJ0czoNCj4gPiAgIDEuIEludHJvZHVjZSBJT01NVUNvbnRleHQgYXMgYWJzdHJh
Y3QgbGF5ZXIgYmV0d2VlbiB2SU9NTVUNCj4gZW11bGF0b3IgYW5kDQo+ID4gICAgICBWRklPIHRv
IGF2b2lkIGRpcmVjdCBjYWxsaW5nIGJldHdlZW4gdGhlIHR3bw0KPiA+ICAgMi4gUGFzc2Rvd24g
UEFTSUQgYWxsb2NhdGlvbiBhbmQgZnJlZSB0byBob3N0DQo+ID4gICAzLiBQYXNzZG93biBndWVz
dCBQQVNJRCBiaW5kaW5nIHRvIGhvc3QNCj4gPiAgIDQuIFBhc3Nkb3duIGd1ZXN0IElPTU1VIGNh
Y2hlIGludmFsaWRhdGlvbiB0byBob3N0DQo+ID4NCj4gPiBUaGUgZnVsbCBzZXQgY2FuIGJlIGZv
dW5kIGluIGJlbG93IGxpbms6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2x1eGlzMTk5OS9xZW11
LmdpdDogc3ZhX3Z0ZF92Nl9xZW11X3JmY192Mg0KPiA+DQo+ID4gQ2hhbmdlbG9nOg0KPiA+IAkt
IFJGQyB2MSAtPiB2MjoNCj4gPiAJICBJbnRyb2R1Y2UgSU9NTVVDb250ZXh0IHRvIGFic3RyYWN0
IHRoZSBjb25uZWN0aW9uIGJldHdlZW4NCj4gVkZJTw0KPiA+IAkgIGFuZCB2SU9NTVUgZW11bGF0
b3IsIHdoaWNoIGlzIGEgcmVwbGFjZW1lbnQgb2YgdGhlDQo+IFBDSVBBU0lET3BzDQo+ID4gCSAg
aW4gUkZDIHYxLiBNb2RpZnkgeC1zY2FsYWJsZS1tb2RlIHRvIGJlIHN0cmluZyBvcHRpb24gaW5z
dGVhZCBvZg0KPiA+IAkgIGFkZGluZyBhIG5ldyBvcHRpb24gYXMgUkZDIHYxIGRpZC4gUmVmaW5l
ZCB0aGUgcGFzaWQgY2FjaGUNCj4gbWFuYWdlbWVudA0KPiA+IAkgIGFuZCBhZGRyZXNzZWQgdGhl
IFRPRE9zIG1lbnRpb25lZCBpbiBSRkMgdjEuDQo+ID4gCSAgUkZDIHYxOiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL2NvdmVyLzExMDMzNjU3Lw0KPiA+DQo+ID4gRXJpYyBBdWdlciAoMSk6
DQo+ID4gICAgdXBkYXRlLWxpbnV4LWhlYWRlcnM6IEltcG9ydCBpb21tdS5oDQo+ID4NCj4gPiBM
aXUgWWkgTCAoMjApOg0KPiA+ICAgIGhlYWRlciB1cGRhdGUgVkZJTy9JT01NVSB2U1ZBIEFQSXMg
YWdhaW5zdCA1LjQuMC1yYzMrDQo+ID4gICAgaW50ZWxfaW9tbXU6IG1vZGlmeSB4LXNjYWxhYmxl
LW1vZGUgdG8gYmUgc3RyaW5nIG9wdGlvbg0KPiA+ICAgIHZmaW8vY29tbW9uOiBhZGQgaW9tbXVf
Y3R4X25vdGlmaWVyIGluIGNvbnRhaW5lcg0KPiA+ICAgIGh3L3BjaTogbW9kaWZ5IHBjaV9zZXR1
cF9pb21tdSgpIHRvIHNldCBQQ0lJT01NVU9wcw0KPiA+ICAgIGh3L3BjaTogaW50cm9kdWNlIHBj
aV9kZXZpY2VfaW9tbXVfY29udGV4dCgpDQo+ID4gICAgaW50ZWxfaW9tbXU6IHByb3ZpZGUgZ2V0
X2lvbW11X2NvbnRleHQoKSBjYWxsYmFjaw0KPiA+ICAgIHZmaW8vcGNpOiBhZGQgaW9tbXVfY29u
dGV4dCBub3RpZmllciBmb3IgcGFzaWQgYWxsb2MvZnJlZQ0KPiA+ICAgIGludGVsX2lvbW11OiBh
ZGQgdmlydHVhbCBjb21tYW5kIGNhcGFiaWxpdHkgc3VwcG9ydA0KPiA+ICAgIGludGVsX2lvbW11
OiBwcm9jZXNzIHBhc2lkIGNhY2hlIGludmFsaWRhdGlvbg0KPiA+ICAgIGludGVsX2lvbW11OiBh
ZGQgcHJlc2VudCBiaXQgY2hlY2sgZm9yIHBhc2lkIHRhYmxlIGVudHJpZXMNCj4gPiAgICBpbnRl
bF9pb21tdTogYWRkIFBBU0lEIGNhY2hlIG1hbmFnZW1lbnQgaW5mcmFzdHJ1Y3R1cmUNCj4gPiAg
ICB2ZmlvL3BjaTogYWRkIGlvbW11X2NvbnRleHQgbm90aWZpZXIgZm9yIHBhc2lkIGJpbmQvdW5i
aW5kDQo+ID4gICAgaW50ZWxfaW9tbXU6IGJpbmQvdW5iaW5kIGd1ZXN0IHBhZ2UgdGFibGUgdG8g
aG9zdA0KPiA+ICAgIGludGVsX2lvbW11OiByZXBsYXkgZ3Vlc3QgcGFzaWQgYmluZGluZ3MgdG8g
aG9zdA0KPiA+ICAgIGludGVsX2lvbW11OiByZXBsYXkgcGFzaWQgYmluZHMgYWZ0ZXIgY29udGV4
dCBjYWNoZSBpbnZhbGlkYXRpb24NCj4gPiAgICBpbnRlbF9pb21tdTogZG8gbm90IHBhc3Nkb3du
IHBhc2lkIGJpbmQgZm9yIFBBU0lEICMwDQo+ID4gICAgdmZpby9wY2k6IGFkZCBpb21tdV9jb250
ZXh0IG5vdGlmaWVyIGZvciBQQVNJRC1iYXNlZCBpb3RsYiBmbHVzaA0KPiA+ICAgIGludGVsX2lv
bW11OiBwcm9jZXNzIFBBU0lELWJhc2VkIGlvdGxiIGludmFsaWRhdGlvbg0KPiA+ICAgIGludGVs
X2lvbW11OiBwcm9wYWdhdGUgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uIHRvIGhvc3QN
Cj4gPiAgICBpbnRlbF9pb21tdTogcHJvY2VzcyBQQVNJRC1iYXNlZCBEZXZpY2UtVExCIGludmFs
aWRhdGlvbg0KPiA+DQo+ID4gUGV0ZXIgWHUgKDEpOg0KPiA+ICAgIGh3L2lvbW11OiBpbnRyb2R1
Y2UgSU9NTVVDb250ZXh0DQo+ID4NCj4gPiAgIGh3L01ha2VmaWxlLm9ianMgICAgICAgICAgICAg
ICAgfCAgICAxICsNCj4gPiAgIGh3L2FscGhhL3R5cGhvb24uYyAgICAgICAgICAgICAgfCAgICA2
ICstDQo+ID4gICBody9hcm0vc21tdS1jb21tb24uYyAgICAgICAgICAgIHwgICAgNiArLQ0KPiA+
ICAgaHcvaHBwYS9kaW5vLmMgICAgICAgICAgICAgICAgICB8ICAgIDYgKy0NCj4gPiAgIGh3L2kz
ODYvYW1kX2lvbW11LmMgICAgICAgICAgICAgfCAgICA2ICstDQo+ID4gICBody9pMzg2L2ludGVs
X2lvbW11LmMgICAgICAgICAgIHwgMTI0OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCj4gPiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgfCAgMTA5
ICsrKysNCj4gPiAgIGh3L2kzODYvdHJhY2UtZXZlbnRzICAgICAgICAgICAgfCAgICA2ICsNCj4g
PiAgIGh3L2lvbW11L01ha2VmaWxlLm9ianMgICAgICAgICAgfCAgICAxICsNCj4gPiAgIGh3L2lv
bW11L2lvbW11LmMgICAgICAgICAgICAgICAgfCAgIDY2ICsrKw0KPiA+ICAgaHcvcGNpLWhvc3Qv
ZGVzaWdud2FyZS5jICAgICAgICB8ICAgIDYgKy0NCj4gPiAgIGh3L3BjaS1ob3N0L3BwY2U1MDAu
YyAgICAgICAgICAgfCAgICA2ICstDQo+ID4gICBody9wY2ktaG9zdC9wcmVwLmMgICAgICAgICAg
ICAgIHwgICAgNiArLQ0KPiA+ICAgaHcvcGNpLWhvc3Qvc2FicmUuYyAgICAgICAgICAgICB8ICAg
IDYgKy0NCj4gPiAgIGh3L3BjaS9wY2kuYyAgICAgICAgICAgICAgICAgICAgfCAgIDI3ICstDQo+
ID4gICBody9wcGMvcHBjNDQwX3BjaXguYyAgICAgICAgICAgIHwgICAgNiArLQ0KPiA+ICAgaHcv
cHBjL3NwYXByX3BjaS5jICAgICAgICAgICAgICB8ICAgIDYgKy0NCj4gPiAgIGh3L3MzOTB4L3Mz
OTAtcGNpLWJ1cy5jICAgICAgICAgfCAgICA4ICstDQo+ID4gICBody92ZmlvL2NvbW1vbi5jICAg
ICAgICAgICAgICAgIHwgICAxMCArDQo+ID4gICBody92ZmlvL3BjaS5jICAgICAgICAgICAgICAg
ICAgIHwgIDE0OSArKysrKw0KPiA+ICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggICB8
ICAgNTggKy0NCj4gPiAgIGluY2x1ZGUvaHcvaW9tbXUvaW9tbXUuaCAgICAgICAgfCAgMTEzICsr
KysNCj4gPiAgIGluY2x1ZGUvaHcvcGNpL3BjaS5oICAgICAgICAgICAgfCAgIDEzICstDQo+ID4g
ICBpbmNsdWRlL2h3L3BjaS9wY2lfYnVzLmggICAgICAgIHwgICAgMiArLQ0KPiA+ICAgaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggICB8ICAgIDkgKw0KPiA+ICAgbGludXgtaGVhZGVycy9s
aW51eC9pb21tdS5oICAgICB8ICAzMjQgKysrKysrKysrKw0KPiA+ICAgbGludXgtaGVhZGVycy9s
aW51eC92ZmlvLmggICAgICB8ICAgODMgKysrDQo+ID4gICBzY3JpcHRzL3VwZGF0ZS1saW51eC1o
ZWFkZXJzLnNoIHwgICAgMiArLQ0KPiA+ICAgMjggZmlsZXMgY2hhbmdlZCwgMjIzMiBpbnNlcnRp
b25zKCspLCA1OCBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9pb21t
dS9NYWtlZmlsZS5vYmpzDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaW9tbXUvaW9tbXUu
Yw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaW9tbXUvaW9tbXUuaA0KPiA+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGxpbnV4LWhlYWRlcnMvbGludXgvaW9tbXUuaA0KPiA+DQoN
Cg==

