Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D776C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E5A2190F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E5A2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyjP-0003p3-Bv
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54643)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hpyjE-0003PC-FP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hpyjD-00082A-AJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:37:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:49133)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hpyjC-0007ud-Sm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:37:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jul 2019 10:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; d="scan'208";a="368952638"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2019 10:37:20 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jul 2019 10:37:19 -0700
Received: from fmsmsx104.amr.corp.intel.com ([169.254.3.206]) by
 fmsmsx115.amr.corp.intel.com ([169.254.4.134]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 10:37:19 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 0/2] pc: mmap kernel (ELF image) and initrd
Thread-Index: AQHVQV+knRdUYEW73kipO69Yq/lGUabY7R2A
Date: Tue, 23 Jul 2019 17:37:18 +0000
Message-ID: <4d2967a1637b3ab93ff79fa016fd4a42f5638204.camel@intel.com>
References: <20190723140445.12748-1-sgarzare@redhat.com>
In-Reply-To: <20190723140445.12748-1-sgarzare@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.156.125]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2906C5AB0AA35A4E8C4FFFAF92D05B5D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH v2 0/2] pc: mmap kernel (ELF image) and
 initrd
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "slp@redhat.com" <slp@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U3RlZmFubywgQnJpbGxpYW50IGpvYiENCg0KSSBjYW4gY29uZmlybSB0aGF0IHdpdGggdGhlc2Ug
cGF0Y2hlcyB0aGUgbWVtb3J5IGZvb3RwcmludCBpcyBzbWFsbGVyDQphbmQgdGhlIGJvb3QgdGlt
ZSBpcyB0aGUgc2FtZSBmb3Iga2F0YQ0KDQpIZXJlIHRoZSByZXN1bHRzIHVzaW5nIGthdGEgbWV0
cmljcw0KDQpodHRwczovL3Bhc3RlYm9hcmQuY28vSXBsMDZRMC5wbmcNCmh0dHBzOi8vcGFzdGVi
b2FyZC5jby9JcGwzcDRkLnBuZw0KDQpUaGFua3MNCg0KLQ0KSnVsaW8NCg0KDQpPbiBUdWUsIDIw
MTktMDctMjMgYXQgMTY6MDQgKzAyMDAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4gSW4g
b3JkZXIgdG8gcmVkdWNlIHRoZSBtZW1vcnkgZm9vdHByaW50IHdoZW4gUFZIIGtlcm5lbCBhbmQg
aW5pdHJkDQo+IGFyZSB1c2VkLCB3ZSBtYXAgdGhlbSBpbnRvIG1lbW9yeSBpbnN0ZWFkIG9mIHJl
YWRpbmcgdGhlbS4NCj4gSW4gdGhpcyB3YXkgd2UgY2FuIHNoYXJlIHRoZW0gYmV0d2VlbiBtdWx0
aXBsZSBpbnN0YW5jZXMgb2YgUUVNVS4NCj4gDQo+IHYyOg0KPiAtIFBhdGNoIDE6IHVzZWQgZ19t
YXBwZWRfZmlsZV9uZXdfZnJvbV9mZCgpIHdpdGggJ3dyaXRlYmxlJyBzZXQgdG8NCj4gJ3RydWUn
LA0KPiAgICAgICAgICAgIHNpbmNlIHdlIGNhbiBtb2RpZnkgdGhlIG1hcHBlZCBidWZmZXIuIFtQ
YW9sbywgUGV0ZXJdDQo+IA0KPiBUaGVzZSBhcmUgdGhlIHJlc3VsdHMgdXNpbmcgYSBQVkgga2Vy
bmVsIGFuZCBpbml0cmQgKGNwaW8pOg0KPiAtIG1lbW9yeSBmb290cHJpbnQgKHVzaW5nIHNtZW0p
IFtNQl0NCj4gICAgICAgICBRRU1VICAgICAgICAgICAgICBiZWZvcmUgICAgICAgICAgICAgICAg
ICAgbm93DQo+ICAgICAjIGluc3RhbmNlcyAgICAgICAgVVNTICAgICAgUFNTICAgICAgICAgICAg
VVNTICAgICAgUFNTDQo+ICAgICAgICAgIDEgICAgICAgICAgIDEwMi4wTSAgIDEwNS44TSAgICAg
ICAgIDEwMi4zTSAgIDEwNi4yTQ0KPiAgICAgICAgICAyICAgICAgICAgICAgOTQuNk0gICAxMDEu
Mk0gICAgICAgICAgNzIuM00gICAgOTAuMU0NCj4gICAgICAgICAgNCAgICAgICAgICAgIDk0LjFN
ICAgIDk4LjBNICAgICAgICAgIDcyLjBNICAgIDgxLjVNDQo+ICAgICAgICAgIDggICAgICAgICAg
ICA5NC4wTSAgICA5Ni4yTSAgICAgICAgICA3MS44TSAgICA3Ni45TQ0KPiAgICAgICAgIDE2ICAg
ICAgICAgICAgOTMuOU0gICAgOTUuMU0gICAgICAgICAgNzEuNk0gICAgNzQuM00NCj4gDQo+ICAg
ICBJbml0cmQgc2l6ZTogMy4wTQ0KPiAgICAgS2VybmVsDQo+ICAgICAgICAgaW1hZ2Ugc2l6ZTog
MjhNDQo+ICAgICAgICAgc2VjdGlvbnMgc2l6ZSBbc2l6ZSAtQSAtZCB2bWxpbnV4XTogIDE4LjlN
DQo+IA0KPiAtIGJvb3QgdGltZSBbbXNdDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgYmVm
b3JlICAgICAgICAgICAgICAgICAgIG5vdw0KPiAgcWVtdV9pbml0X2VuZDogICAgICAgICAgIDYz
Ljg1ICAgICAgICAgICAgICAgICAgIDU1LjkxDQo+ICBsaW51eF9zdGFydF9rZXJuZWw6ICAgICAg
ODIuMTEgKCsxOC4yNikgICAgICAgICAgNzQuNTEgKCsxOC42MCkNCj4gIGxpbnV4X3N0YXJ0X3Vz
ZXI6ICAgICAgIDE2OS45NCAoKzg3LjgzKSAgICAgICAgIDE1OS4wNiAoKzg0LjU2KQ0KPiANCj4g
UUVNVSBjb21tYW5kIHVzZWQ6DQo+IC4vcWVtdS1zeXN0ZW0teDg2XzY0IC1iaW9zIC9wYXRoL3Rv
L3NlYWJpb3Mvb3V0L2Jpb3MuYmluIC1uby1ocGV0IFwNCj4gICAgIC1tYWNoaW5lDQo+IHEzNSxh
Y2NlbD1rdm0sa2VybmVsX2lycWNoaXAsbnZkaW1tLHNhdGE9b2ZmLHNtYnVzPW9mZix2bXBvcnQ9
b2ZmIFwNCj4gICAgIC1jcHUgaG9zdCAtbSAxRyAtc21wIDEgLXZnYSBub25lIC1kaXNwbGF5IG5v
bmUgLW5vLXVzZXItY29uZmlnDQo+IC1ub2RlZmF1bHRzIFwNCj4gICAgIC1rZXJuZWwgL3BhdGgv
dG8vdm1saW51eCAtaW5pdHJkIC9wYXRoL3RvL3Jvb3Rmcy5jcGlvIFwNCj4gICAgIC1hcHBlbmQg
J3Jvb3Q9L2Rldi9tZW0wIHJvIGNvbnNvbGU9aHZjMCBwY2k9bGFzdGJ1cz0wIG5vc21hcCcNCj4g
DQo+IFN0ZWZhbm8gR2FyemFyZWxsYSAoMik6DQo+ICAgZWxmLW9wcy5oOiBNYXAgaW50byBtZW1v
cnkgdGhlIEVMRiB0byBsb2FkDQo+ICAgaHcvaTM4Ni9wYzogTWFwIGludG8gbWVtb3J5IHRoZSBp
bml0cmQNCj4gDQo+ICBody9pMzg2L3BjLmMgICAgICAgICB8IDE1ICsrKysrKysrLS0tDQo+ICBp
bmNsdWRlL2h3L2VsZl9vcHMuaCB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0NCj4gLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAz
MyBkZWxldGlvbnMoLSkNCj4gDQo=

