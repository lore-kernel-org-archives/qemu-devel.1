Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2F3C352A3
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 06:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040A42082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 06:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040A42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2quM-0004VD-5N
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 01:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j2qtX-00043L-VW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 01:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j2qtV-00083x-L7
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 01:25:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:19199)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j2qtV-0007rU-DF
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 01:25:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 22:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,443,1574150400"; d="scan'208";a="435017982"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2020 22:25:29 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 22:25:28 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.98]) with mapi id 14.03.0439.000;
 Sat, 15 Feb 2020 14:25:26 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Topic: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Thread-Index: AQHV1p1ISlCEZJtKwkqCei/mecuDIagDpFsAgADzWWCAES39gIABZmlAgAKR7QCAAiP4wA==
Date: Sat, 15 Feb 2020 06:25:25 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1BE6EB@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-4-git-send-email-yi.l.liu@intel.com>
 <20200131040644.GG15210@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A199306@SHSMSX104.ccr.corp.intel.com>
 <20200211165843.GG984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA4D8@SHSMSX104.ccr.corp.intel.com>
 <20200214053620.GR124369@umbus.fritz.box>
In-Reply-To: <20200214053620.GR124369@umbus.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGZlYjkwM2ItM2JmNS00YTYzLTg1NWMtZGJjOWE2MmE3NjdmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibnowamcraDFiRmFXemluMEczZ2RxaHNVWGJxOFZoSEFubG91NGx1d3JKQkRUSHh0Q0s4dWE3cmJHVFNIUFJKQiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBEYXZpZCBHaWJzb24gPCBkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUgPg0KPiBT
ZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE0LCAyMDIwIDE6MzYgUE0NCj4gVG86IExpdSwgWWkgTCA8
eWkubC5saXVAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MyAwMy8yNV0gaHcvaW9t
bXU6IGludHJvZHVjZSBJT01NVUNvbnRleHQNCj4gDQo+IE9uIFdlZCwgRmViIDEyLCAyMDIwIGF0
IDA3OjE1OjEzQU0gKzAwMDAsIExpdSwgWWkgTCB3cm90ZToNCj4gPiBIaSBQZXRlciwNCj4gPg0K
PiA+ID4gRnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogV2Vk
bmVzZGF5LCBGZWJydWFyeSAxMiwgMjAyMCAxMjo1OSBBTQ0KPiA+ID4gVG86IExpdSwgWWkgTCA8
eWkubC5saXVAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgdjMgMDMvMjVdIGh3
L2lvbW11OiBpbnRyb2R1Y2UgSU9NTVVDb250ZXh0DQo+ID4gPg0KPiA+ID4gT24gRnJpLCBKYW4g
MzEsIDIwMjAgYXQgMTE6NDI6MTNBTSArMDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+ID4gPiA+
IEknbSBub3QgdmVyeSBjbGVhciBvbiB0aGUgcmVsYXRpb25zaGlwIGJldHdlbiBhbiBJT01NVUNv
bnRleHQgYW5kIGENCj4gPiA+ID4gPiBEdWFsU3RhZ2VJT01NVU9iamVjdC4gIENhbiB0aGVyZSBi
ZSBtYW55IElPTU1VQ29udGV4dHMgdG8gYQ0KPiA+ID4gPiA+IER1YWxTdGFnZUlPTU1VT0JqZWN0
PyAgVGhlIG90aGVyIHdheSBhcm91bmQ/ICBPciBpcyBpdCBqdXN0DQo+ID4gPiA+ID4gemVyby1v
ci1vbmUgRHVhbFN0YWdlSU9NTVVPYmplY3RzIHRvIGFuIElPTU1VQ29udGV4dD8NCj4gPiA+ID4N
Cj4gPiA+ID4gSXQgaXMgcG9zc2libGUuIEFzIHRoZSBiZWxvdyBwYXRjaCBzaG93cywgRHVhbFN0
YWdlSU9NTVVPYmplY3QgaXMgcGVyIHZmaW8NCj4gPiA+ID4gY29udGFpbmVyLiBJT01NVUNvbnRl
eHQgY2FuIGJlIGVpdGhlciBwZXItZGV2aWNlIG9yIHNoYXJlZCBhY3Jvc3MgZGV2aWNlcywNCj4g
PiA+ID4gaXQgZGVwZW5kcyBvbiB2ZW5kb3Igc3BlY2lmaWMgdklPTU1VIGVtdWxhdG9ycy4NCj4g
PiA+DQo+ID4gPiBJcyB0aGVyZSBhbiBleGFtcGxlIHdoZW4gYW4gSU9NTVVDb250ZXh0IGNhbiBi
ZSBub3QgcGVyLWRldmljZT8NCj4gPg0KPiA+IE5vLCBJIGRvbuKAmXQgaGF2ZSBzdWNoIGV4YW1w
bGUgc28gZmFyLiBCdXQgYXMgSU9NTVVDb250ZXh0IGlzIGdvdCBmcm9tDQo+ID4gcGNpX2Rldmlj
ZV9pb21tdV9jb250ZXh0KCksICBpbiBjb25jZXB0IGl0IHBvc3NpYmxlIHRvIGJlIG5vdCBwZXIt
ZGV2aWNlLg0KPiA+IEl0IGlzIGtpbmQgb2YgbGVhdmUgdG8gdklPTU1VIHRvIGRlY2lkZSBpZiBk
aWZmZXJlbnQgZGV2aWNlcyBjb3VsZCBzaGFyZSBhDQo+ID4gc2luZ2xlIElPTU1VQ29udGV4dC4N
Cj4gDQo+IE9uIHRoZSAicHNlcmllcyIgbWFjaGluZSB0aGUgdklPTU1VIG9ubHkgaGFzIG9uZSBz
ZXQgb2YgdHJhbnNsYXRpb25zDQo+IGZvciBhIHdob2xlIHZpcnR1YWwgUENJIEhvc3QgQnJpZGdl
ICh2UEhCKS4gIFNvIGlmIHlvdSBhdHRhY2ggbXVsdGlwbGUNCj4gZGV2aWNlcyB0byBhIHNpbmds
ZSB2UEhCLCBJIGJlbGlldmUgeW91J2QgZ2V0IG11bHRpcGxlIGRldmljZXMgaW4gYW4NCj4gSU9N
TVVDb250ZXh0LiAgV2VsbC4uIGlmIHdlIGRpZCB0aGUgUEFTSUQgc3R1ZmYsIHdoaWNoIHdlIGRv
bid0IGF0IHRoZQ0KPiBtb21lbnQuDQo+IA0KPiBOb3RlIHRoYXQgb24gcHNlcmllcyBvbiB0aGUg
b3RoZXIgaGFuZCBpdCdzIHJvdXRpbmUgdG8gY3JlYXRlIG11bHRpcGxlDQo+IHZQSEJzLCByYXRo
ZXIgdGhhbiBtdWx0aXBsZSBQQ0kgcm9vdHMgYmVpbmcgYW4gb2RkaXR5IGFzIGl0IGlzIG9uIHg4
Ni4NCg0KVGhhbmtzIGZvciB0aGUgZXhhbXBsZSwgRGF2aWQuIDotKSBCVFcuIEknbGwgZHJvcCBJ
T01NVUNvbnRleHQgaW4gbmV4dCB2ZXJzaW9uDQphcyB0aGUgZW1haWwgYmVsb3cgbWVudGlvbmVk
LiAgUGxlYXNlIGZlZWwgZnJlZSBsZXQgbWUga25vdyB5b3VyIG9waW5pb24uDQoNCmh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIwLTAyL21zZzAyODc0Lmh0
bWwNCg0KUmVnYXJkcywNCllpIExpdQ0K

