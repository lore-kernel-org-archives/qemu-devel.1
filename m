Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55307C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 01:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252D0207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 01:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252D0207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je7Im-0006uy-B6
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 21:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1je7Hy-0006Mj-AN
 for qemu-devel@nongnu.org; Wed, 27 May 2020 21:24:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:20041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1je7Hw-0005Gn-Ma
 for qemu-devel@nongnu.org; Wed, 27 May 2020 21:24:53 -0400
IronPort-SDR: Oj1P7CWIUWVI1CtO0khxAuEL5mf3tnIdclemmWsDgFTBPf6arvFiOROQBIABF6OxtjWgNbtK5k
 ZdGlo5Ti+8oQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 18:24:43 -0700
IronPort-SDR: tTeWw6R2y17R8amsEG/iaQL5LI6A/pp0k+zZ7QG3R5FPUr2ja1mwlIXSwRUc6Gd+xMHGawgzHb
 /5puKgVQUwQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="414422873"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga004.jf.intel.com with ESMTP; 27 May 2020 18:24:43 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.75]) with mapi id 14.03.0439.000;
 Wed, 27 May 2020 18:24:43 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "imammedo@redhat.com" <imammedo@redhat.com>
Subject: Re: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
Thread-Topic: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
Thread-Index: AQHWHPxgprv/zXvgEUuLq6cJexZCW6izQRuAgAoXyoA=
Date: Thu, 28 May 2020 01:24:42 +0000
Message-ID: <b91f0709d2a425e39d8ecaff5824c022dc893ee6.camel@intel.com>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
 <20200428012810.10877-3-vishal.l.verma@intel.com>
 <20200521171657.778f20a4@redhat.com>
In-Reply-To: <20200521171657.778f20a4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1DD8EBAA74F924D8D1D96877276CBF1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=vishal.l.verma@intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 21:24:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDIwLTA1LTIxIGF0IDE3OjE2ICswMjAwLCBJZ29yIE1hbW1lZG92IHdyb3RlOg0K
DQpIaSBJZ29yLCBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClsuLl0NCj4gPiAgDQo+ID4gQEAg
LTI0MjksNiArMjQzMCwyNSBAQCBidWlsZF9zcmF0KEdBcnJheSAqdGFibGVfZGF0YSwgQklPU0xp
bmtlciAqbGlua2VyLCBNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE1FTV9BRkZJTklUWV9FTkFCTEVEKTsNCj4gPiAgICAgICAgICB9DQo+
ID4gICAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKG1hY2hpbmUtPm52ZGltbXNfc3RhdGUtPmlz
X2VuYWJsZWQpIHsNCj4gPiArICAgICAgICBHU0xpc3QgKmRldmljZV9saXN0ID0gbnZkaW1tX2dl
dF9kZXZpY2VfbGlzdCgpOw0KPiA+ICsNCj4gPiArICAgICAgICBmb3IgKDsgZGV2aWNlX2xpc3Q7
IGRldmljZV9saXN0ID0gZGV2aWNlX2xpc3QtPm5leHQpIHsNCj4gPiArICAgICAgICAgICAgRGV2
aWNlU3RhdGUgKmRldiA9IGRldmljZV9saXN0LT5kYXRhOw0KPiA+ICsgICAgICAgICAgICBpbnQg
bm9kZSA9IG9iamVjdF9wcm9wZXJ0eV9nZXRfaW50KE9CSkVDVChkZXYpLCBQQ19ESU1NX05PREVf
UFJPUCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBOVUxMKTsNCj4gPiArICAgICAgICAgICAgdWludDY0X3QgYWRkciA9IG9iamVjdF9wcm9wZXJ0
eV9nZXRfdWludChPQkpFQ1QoZGV2KSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBQQ19ESU1NX0FERFJfUFJPUCwgTlVMTCk7DQo+ID4g
KyAgICAgICAgICAgIHVpbnQ2NF90IHNpemUgPSBvYmplY3RfcHJvcGVydHlfZ2V0X3VpbnQoT0JK
RUNUKGRldiksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgUENfRElNTV9TSVpFX1BST1AsIE5VTEwpOw0KPiA+ICsNCj4gc3VnZ2VzdCB0
byB1c2UgZXJyb3JfYWJvcnQgaW4gZ2V0dGVycw0KDQpZZXAsIGZpeGVkIGluIHYyLg0KDQo+IA0K
PiA+ICsgICAgICAgICAgICBudW1hbWVtID0gYWNwaV9kYXRhX3B1c2godGFibGVfZGF0YSwgc2l6
ZW9mICpudW1hbWVtKTsNCj4gPiArICAgICAgICAgICAgYnVpbGRfc3JhdF9tZW1vcnkobnVtYW1l
bSwgYWRkciwgc2l6ZSwgbm9kZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
TUVNX0FGRklOSVRZX0VOQUJMRUQgfCBNRU1fQUZGSU5JVFlfTk9OX1ZPTEFUSUxFKTsNCj4gPiAr
ICAgICAgICB9DQo+IHdobyBpcyBpbiBjaGFyZ2Ugb2YgZnJlZWluZyBkZXZpY2VfbGlzdCA/DQoN
ClRoYW5rcywgYWxzbyBmaXhlZCBpbiB2Mi4NCg0KPiANCj4gPiArICAgIH0NCj4gDQo+IFRoZXJl
IGlzIEFSTSB2ZXJzaW9uIG9mIGJ1aWxkX3NyYXQoKSwNCj4gSSBzdWdnZXN0IHRvIHB1dCB0aGlz
IE5WRElNTSBzcGVjaWZpYyBwYXJ0IGluIGhlbHBlciBmdW5jdGlvbiB3aXRoaW4gaHcvYWNwaS9u
dmRpbW0uYw0KPiBhbmQgdXNlIGl0IGZyb20gYm90aCBidWlsZF9zcmF0KCkgZnVuY3Rpb25zLg0K
DQpTcGxpdHRpbmcgdGhlIHdvcmsgb3V0IGludG8gYSBoZWxwZXIgZnVuY3Rpb24gaW4gbnZkaW1t
LmMgZG9lcyBtYWtlDQpzZW5zZSwgYW5kIEkndmUgZG9uZSB0aGF0LiBIb3dldmVyLCBsb29raW5n
IGF0IHRoZSBhcm0gdmVyc2lvbiBvZg0KYnVpbGRfc3JhdCBhbmQgZ2VuZXJhbGx5IGluIHZpcnQt
YWNwaS1idWlsZC5jLCBJIGRvbid0IHNlZSBhbnkgTlZESU1NDQpzdXBwb3J0LCBzbyB1bmxlc3Mg
SSdtIG1pc3Rha2VuLCBpdCB3b3VsZG4ndCBtYWtlIHNlbnNlIHRvIGFjdHVhbGx5IGNhbGwNCnRo
aXMgZnJvbSB0aGUgYXJtIHZlcnNpb24gb2YgYnVpbGRfc3JhdC4NCg0KSSdsbCBzZW5kIGEgdjIg
d2l0aCB0aGUgYWJvdmUgZml4ZXMuDQoNCj4gDQo+ID4gKw0KPiA+ICAgICAgc2xvdHMgPSAodGFi
bGVfZGF0YS0+bGVuIC0gbnVtYV9zdGFydCkgLyBzaXplb2YgKm51bWFtZW07DQo+ID4gICAgICBm
b3IgKDsgc2xvdHMgPCBwY21zLT5udW1hX25vZGVzICsgMjsgc2xvdHMrKykgew0KPiA+ICAgICAg
ICAgIG51bWFtZW0gPSBhY3BpX2RhdGFfcHVzaCh0YWJsZV9kYXRhLCBzaXplb2YgKm51bWFtZW0p
Ow0K

