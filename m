Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD94C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E3220720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E3220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUaS-0001jR-1D
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jjUZS-0000rF-8F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 17:17:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:30352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jjUZO-0004S4-UL
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 17:17:09 -0400
IronPort-SDR: sarjtd3cr70wHHCpiUI+qZKT3Rn6ZjQQsfpP/c72jW4Wl7x9V8ZYbhrwaqtVRSYVKPYdyMvu5k
 cEGhPSD9qpmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 14:16:50 -0700
IronPort-SDR: u+tXLqzRyd+zHsf/JJDI9ZiTv3gWJtMM94LaYd+rYqmUS7aSwvkPbOLyf5qfKTne2GAdAn7qNH
 owA/ehE0GJWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; d="scan'208";a="473962908"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2020 14:16:50 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 14:16:49 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.250]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.61]) with mapi id 14.03.0439.000;
 Thu, 11 Jun 2020 14:16:49 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Topic: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Index: AQHWNJ6/KA9BUx6s/UuCJV3Lsz6Rn6i/VTmAgABYZACAAAgMAIAUwX2A
Date: Thu, 11 Jun 2020 21:16:48 +0000
Message-ID: <f1d36b8fc4ab7aacf6efca19303b04a5b4f8189c.camel@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-3-jonathan.derrick@intel.com>
 <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
 <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
 <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.23.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66D5545A7F2B504AB19EF890BBF933F1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=jonathan.derrick@intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 17:16:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "hch@lst.de" <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDE3OjE4ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gRnJpLCBNYXkgMjksIDIwMjAgYXQgMDM6NTM6MzdQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIwLTA1LTI5IGF0IDExOjMzICswMTAwLCBM
b3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTWF5IDI3LCAyMDIwIGF0IDEx
OjAyOjM5UE0gLTA0MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+ID4gPiBWZXJzaW9ucyBvZiBW
TUQgd2l0aCB0aGUgSG9zdCBQaHlzaWNhbCBBZGRyZXNzIHNoYWRvdyByZWdpc3RlciB1c2UgdGhp
cw0KPiA+ID4gPiByZWdpc3RlciB0byBjYWxjdWxhdGUgdGhlIGJ1cyBhZGRyZXNzIG9mZnNldCBu
ZWVkZWQgdG8gZG8gZ3Vlc3QNCj4gPiA+ID4gcGFzc3Rocm91Z2ggb2YgdGhlIGRvbWFpbi4gVGhp
cyByZWdpc3RlciBzaGFkb3dzIHRoZSBIb3N0IFBoeXNpY2FsDQo+ID4gPiA+IEFkZHJlc3MgcmVn
aXN0ZXJzIGluY2x1ZGluZyB0aGUgcmVzb3VyY2UgdHlwZSBiaXRzLiBBZnRlciBjYWxjdWxhdGlu
Zw0KPiA+ID4gPiB0aGUgb2Zmc2V0LCB0aGUgZXh0cmEgcmVzb3VyY2UgdHlwZSBiaXRzIGxlYWQg
dG8gdGhlIFZNRCByZXNvdXJjZXMgYmVpbmcNCj4gPiA+ID4gb3Zlci1wcm92aXNpb25lZCBhdCB0
aGUgZnJvbnQgYW5kIHVuZGVyLXByb3Zpc2lvbmVkIGF0IHRoZSBiYWNrLg0KPiA+ID4gPiANCj4g
PiA+ID4gRXhhbXBsZToNCj4gPiA+ID4gcGNpIDEwMDAwOjgwOjAyLjA6IHJlZyAweDEwOiBbbWVt
IDB4ZjgwMWZmZmMtMHhmODAzZmZmYiA2NGJpdF0NCj4gPiA+ID4gDQo+ID4gPiA+IEV4cGVjdGVk
Og0KPiA+ID4gPiBwY2kgMTAwMDA6ODA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhmODAyMDAwMC0w
eGY4MDNmZmZmIDY0Yml0XQ0KPiA+ID4gPiANCj4gPiA+ID4gSWYgb3RoZXIgZGV2aWNlcyBhcmUg
bWFwcGVkIGluIHRoZSBvdmVyLXByb3Zpc2lvbmVkIGZyb250LCBpdCBjb3VsZCBsZWFkDQo+ID4g
PiA+IHRvIHJlc291cmNlIGNvbmZsaWN0IGlzc3VlcyB3aXRoIFZNRCBvciB0aG9zZSBkZXZpY2Vz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IGExYTMwMTcwMTM4YzkgKCJQQ0k6IHZtZDogRml4
IHNoYWRvdyBvZmZzZXRzIHRvIHJlZmxlY3Qgc3BlYyBjaGFuZ2VzIikNCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCA2ICsrKystLQ0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiA+IA0KPiA+ID4gSGkgSm9uLA0KPiA+ID4gDQo+ID4gPiBpdCBsb29rcyBsaWtlIEkgY2Fu
IHRha2UgdGhpcyBwYXRjaCBmb3IgdjUuOCB3aGVyZWFzIHBhdGNoIDIgZGVwZW5kcw0KPiA+ID4g
b24gdGhlIFFFTVUgY2hhbmdlcyBhY2NlcHRhbmNlIGFuZCBzaG91bGQgcHJvYmFibHkgd2FpdC4N
Cj4gPiA+IA0KPiA+ID4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMgYXNhcCBhbmQg
SSB3aWxsIHRyeSB0byBhdCBsZWFzdA0KPiA+ID4gc3F1ZWV6ZSB0aGlzIHBhdGNoIGluLg0KPiA+
ID4gDQo+ID4gPiBMb3JlbnpvDQo+ID4gDQo+ID4gSGkgTG9yZW56bywNCj4gPiANCj4gPiBUaGlz
IGlzIGZpbmUuIFBsZWFzZSB0YWtlIFBhdGNoIDEuDQo+ID4gUGF0Y2ggMiBpcyBoYXJtbGVzcyB3
aXRob3V0IHRoZSBRRU1VIGNoYW5nZXMsIGJ1dCBtYXkgYWx3YXlzIG5lZWQgYQ0KPiA+IGRpZmZl
cmVudCBhcHByb2FjaC4NCj4gDQo+IFB1bGxlZCBwYXRjaCAxIGludG8gcGNpL3ZtZCwgdGhhbmtz
Lg0KPiANCj4gTG9yZW56bw0KDQpIaSBMb3JlbnpvLA0KDQpBbGV4IGhhcyBwci1lZCB0aGUgUUVN
VSBwYXRjaCBbMV0NCklzIGl0IHRvbyBsYXRlIHRvIHB1bGwgcGF0Y2ggMi8yIGZvciB2NS44Pw0K
DQpbMV0gDQpodHRwczovL2dpdGh1Yi5jb20vYXdpbGxpYW0vcWVtdS12ZmlvL3JlbGVhc2VzL3Rh
Zy92ZmlvLXVwZGF0ZS0yMDIwMDYxMS4wDQo=

