Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D798CC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF1424677
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF1424677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24XE-0007X6-SL
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j24WV-00077W-2Y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j24WU-0006Mk-0o
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:46:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:18895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j24WT-0006LI-Ny
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:46:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 18:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; d="scan'208";a="380962571"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga004.jf.intel.com with ESMTP; 12 Feb 2020 18:46:36 -0800
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 18:46:35 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 18:46:35 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.126]) with mapi id 14.03.0439.000;
 Thu, 13 Feb 2020 10:46:33 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Topic: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Index: AQHV1p1ISlCEZJtKwkqCei/mecuDIagDpFsAgADzWWCAES39gIABZmlAgAAbggCAATpJsA==
Date: Thu, 13 Feb 2020 02:46:32 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1BBC65@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-4-git-send-email-yi.l.liu@intel.com>
 <20200131040644.GG15210@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A199306@SHSMSX104.ccr.corp.intel.com>
 <20200211165843.GG984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA4D8@SHSMSX104.ccr.corp.intel.com>
 <20200212155958.GB1083891@xz-x1>
In-Reply-To: <20200212155958.GB1083891@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTE4YzZhOTMtNjg0Yi00ZGU2LWE4NzAtNWMzMWE4MTQ0YjhjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSjlxaThVSGt4dmp0N0RzOXM2TzEzOGgwdWJUSVpDTmRtQmQ1aXlCRFI3QXRCRzhvdFZcL2ZFcmFqY2NiZWc0eHUifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Wu, Hao" <hao.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBG
ZWJydWFyeSAxMywgMjAyMCAxMjowMCBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYzIDAzLzI1XSBody9pb21tdTogaW50cm9kdWNl
IElPTU1VQ29udGV4dA0KPiANCj4gT24gV2VkLCBGZWIgMTIsIDIwMjAgYXQgMDc6MTU6MTNBTSAr
MDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gV2hpbGUgY29uc2lk
ZXJpbmcgeW91ciBzdWdnZXN0aW9uIG9uIGRyb3BwaW5nIG9uZSBvZiB0aGUgdHdvIGFic3RyYWN0
DQo+ID4gbGF5ZXJzLiBJIGNhbWUgdXAgYSBuZXcgcHJvcG9zYWwgYXMgYmVsb3c6DQo+ID4NCj4g
PiBXZSBtYXkgZHJvcCB0aGUgSU9NTVVDb250ZXh0IGluIHRoaXMgc2VyaWVzLCBhbmQgcmVuYW1l
DQo+ID4gRHVhbFN0YWdlSU9NTVVPYmplY3QgdG8gSG9zdElPTU1VQ29udGV4dCwgd2hpY2ggaXMg
cGVyLXZmaW8tY29udGFpbmVyLg0KPiA+IEFkZCBhbiBpbnRlcmZhY2UgaW4gUENJIGxheWVyKGUu
Zy4gYW4gY2FsbGJhY2sgaW4gIFBDSURldmljZSkgdG8gbGV0IHZJT01NVSBnZXQNCj4gSG9zdElP
TU1VQ29udGV4dC4NCj4gPiBJIHRoaW5rIHRoaXMgY291bGQgY292ZXIgdGhlIHJlcXVpcmVtZW50
IG9mIHByb3ZpZGluZyBleHBsaWNpdCBtZXRob2QNCj4gPiBmb3IgdklPTU1VIHRvIGNhbGwgaW50
byBWRklPIGFuZCB0aGVuIHByb2dyYW0gaG9zdCBJT01NVS4NCj4gPg0KPiA+IFdoaWxlIGZvciB0
aGUgcmVxdWlyZW1lbnQgb2YgVkZJTyB0byB2SU9NTVUgY2FsbGluZ3MgKGUuZy4gUFJRKSwgSQ0K
PiA+IHRoaW5rIGl0IGNvdWxkIGJlIGRvbmUgdmlhIFBDSSBsYXllciBieSBhZGRpbmcgYW4gb3Bl
cmF0aW9uIGluIFBDSUlPTU1VT3BzLg0KPiBUaG91Z2h0cz8NCj4gDQo+IEhtbSBzb3VuZHMgZ29v
ZC4gOikNCj4gDQo+IFRoZSB0aGluZyBpcyBmb3IgdGhlIGNhbGxzIHRvIHRoZSBvdGhlciBkaXJl
Y3Rpb24gKGUuZy4gVkZJTyBpbmplY3RpbmcgZmF1bHRzIHRvDQo+IHZJT01NVSksIHRoYXQncyBu
ZWl0aGVyIHBlci1jb250YWluZXIgbm9yIHBlci1kZXZpY2UsIGJ1dCBwZXItdklPTU1VLg0KPiBQ
Q0lJT01NVU9wcyBzdWl0ZXMgZm9yIHRoYXQgam9iIEknZCBzYXksIHdoaWNoIGlzIHBlci12SU9N
TVUuDQo+IA0KPiBMZXQncyBzZWUgaG93IGl0IGdvZXMuDQoNClRoYW5rcywgbGV0IG1lIGdldCBh
IG5ldyB2ZXJzaW9uIGJ5IGVuZC1vZiB0aGlzIHdlZWsuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg0K

