Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B17C2D0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0C620673
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0C620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZwO-0006X7-0o
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jYZuk-00054n-G2
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:46:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:64743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jYZuh-0004rm-C5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:46:01 -0400
IronPort-SDR: uzPprFaGGQ75Qt3Q3BQLDiQ/NZdhvm0ibYZQM7tazwEVhDILb0aYH2INYXHkUauf4XirmPgs6n
 YtruIB5VNanQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2020 11:45:45 -0700
IronPort-SDR: ksG1gJ0z6tpJtGerIbgBRCkpP+pfNoC9F45m8ZuM458RUi4JeIJCwrACfX6mfEybFIkMekQi3r
 Jgr84vun0IRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,384,1583222400"; d="scan'208";a="280234506"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga002.jf.intel.com with ESMTP; 12 May 2020 11:45:45 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 12 May 2020 11:45:45 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.217]) with mapi id 14.03.0439.000;
 Tue, 12 May 2020 11:45:45 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/3] account for NVDIMM nodes during SRAT generation
Thread-Topic: [PATCH 0/3] account for NVDIMM nodes during SRAT generation
Thread-Index: AQHWHPxhIv/dZlNKYkaQJpWbPC6PXailVhWA
Date: Tue, 12 May 2020 18:45:44 +0000
Message-ID: <4f0a068c6a3d388d4ee358d9d50d550eb95d8bf4.camel@intel.com>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
In-Reply-To: <20200428012810.10877-1-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <437EF0930C27384AA7A3154F2C8AD937@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=vishal.l.verma@intel.com; helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 14:45:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "Liu, Jingqi" <jingqi.liu@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "Williams, 
 Dan J" <dan.j.williams@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDIwLTA0LTI3IGF0IDE5OjI4IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IE9uIHRoZSBjb21tYW5kIGxpbmUsIG9uZSBjYW4gc3BlY2lmeSBhIE5VTUEgbm9kZSBmb3IgTlZE
SU1NIGRldmljZXMuIElmDQo+IHdlIHNldCB1cCB0aGUgdG9wb2xvZ3kgdG8gZ2l2ZSBOVkRJTU1z
IHRoZWlyIG93biBub2RlcywgaS5lLiBub3QNCj4gY29udGFpbmluZyBhbnkgQ1BVcyBvciByZWd1
bGFyIG1lbW9yeSwgcWVtdSBkb2Vzbid0IHBvcHVsYXRlIFNSQVQgbWVtb3J5DQo+IGFmZmluaXR5
IHN0cnVjdHVyZXMgZm9yIHRoZXNlIG5vZGVzLiBIb3dldmVyIHRoZSBORklUIGRvZXMgcmVmZXJl
bmNlDQo+IHRob3NlIHByb3hpbWl0eSBkb21haW5zLg0KPiANCj4gQXMgYSByZXN1bHQsIExpbnV4
LCB3aGlsZSBwYXJzaW5nIHRoZSBTUkFULCBmYWlscyB0byBpbml0aWFsaXplIG5vZGUNCj4gcmVs
YXRlZCBzdHJ1Y3R1cmVzIGZvciB0aGVzZSBub2RlcywgYW5kIHRoZXkgbmV2ZXIgZW5kIHVwIGlu
IHRoZQ0KPiBub2Rlc19wb3NzaWJsZSBtYXAuIFdoZW4gdGhlc2UgYXJlIG9ubGluZWQgYXQgYSBs
YXRlciBwb2ludCAodmlhDQo+IGhvdHBsdWcpLCB0aGlzIGNhdXNlcyBwcm9ibGVtcy4NCj4gDQo+
IEkndmUgZm9sbG93ZWQgdGhlIGluc3RydWN0aW9ucyBpbiBiaW9zLXRhYmxlcy10ZXN0LmMgdG8g
dXBkYXRlIHRoZQ0KPiBleHBlY3RlZCBTUkFUIGJpbmFyeSwgYW5kIHRoZSB0ZXN0cyAobWFrZSBj
aGVjaykgcGFzcy4gUGF0Y2hlcyAxIGFuZCAzDQo+IGFyZSB0aGUgcmVsZXZhbnQgb25lcyBmb3Ig
dGhlIGJpbmFyeSB1cGRhdGUuDQo+IA0KPiBQYXRjaCAyIGlzIHRoZSBtYWluIHBhdGNoIHdoaWNo
IGNoYW5nZXMgU1JBVCBnZW5lcmF0aW9uLg0KPiANCj4gVmlzaGFsIFZlcm1hICgzKToNCj4gICBk
aWZmcy1hbGxvd2VkOiBhZGQgdGhlIFNSQVQgQU1MIHRvIGRpZmZzLWFsbG93ZWQNCj4gICBody9h
Y3BpLWJ1aWxkOiBhY2NvdW50IGZvciBOVkRJTU0gbnVtYSBub2RlcyBpbiBTUkFUDQo+ICAgdGVz
dHMvYWNwaTogdXBkYXRlIGV4cGVjdGVkIFNSQVQgZmlsZXMNCj4gDQo+ICBody9pMzg2L2FjcGkt
YnVpbGQuYyAgICAgICAgICAgICB8ICAyMCArKysrKysrKysrKysrKysrKysrKw0KPiAgdGVzdHMv
ZGF0YS9hY3BpL3BjL1NSQVQuZGltbXB4bSAgfCBCaW4gMzkyIC0+IDM5MiBieXRlcw0KPiAgdGVz
dHMvZGF0YS9hY3BpL3EzNS9TUkFULmRpbW1weG0gfCBCaW4gMzkyIC0+IDM5MiBieXRlcw0KPiAg
MyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KSGkgQWxsIC0gSnVzdCBwaW5n
aW5nIHRoaXMgcGF0Y2hzZXQgYWdhaW4uIEkgbmVnbGVjdGVkIHRvIENDIG1haW50YWluZXJzDQpp
biB0aGUgb3JpZ2luYWwgcG9zdGluZywgZG9pbmcgc28gbm93LiBUaGUgZnVsbCBzZXJpZXMgY2Fu
IGJlIHNlZW4gaGVyZToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIw
MDQyODAxMjgxMC4xMDg3Ny0xLXZpc2hhbC5sLnZlcm1hQGludGVsLmNvbS8NCg0KSWYgSSBzaG91
bGQgcmVzZW5kIHRoZSBwYXRjaGVzLCBwbGVhc2UgbGV0IG1lIGtub3cgYW5kIEknbGwgYmUgaGFw
cHkgdG8NCmRvIHNvLg0K

