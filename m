Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D96C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E592072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E592072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jehLY-0000LW-DG
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jehKS-00068h-NB
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:53:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:44249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jehKQ-0004PH-QV
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:53:52 -0400
IronPort-SDR: YQQKLKOO9HAw3IgHkg7Gnz5Bpyq8cHYmtDNwHhISkaubmpciIWkYYteJ3afNp04f2HCs4TxJ5O
 JLmPC7sR+CAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 08:53:38 -0700
IronPort-SDR: 2LJzmXHoxG3l3dt/Xjw9fYZRV1akjKmqCZ5JCidjlXjHVzdL9loI3YC2zgbv+/d7I40+b7pgbl
 cAe4oqT7s6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; d="scan'208";a="303162420"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by orsmga008.jf.intel.com with ESMTP; 29 May 2020 08:53:38 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 08:53:38 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.250]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.126]) with mapi id 14.03.0439.000;
 Fri, 29 May 2020 08:53:38 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Topic: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Index: AQHWNJ6/KA9BUx6s/UuCJV3Lsz6Rn6i/VTmAgABYZAA=
Date: Fri, 29 May 2020 15:53:37 +0000
Message-ID: <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-3-jonathan.derrick@intel.com>
 <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.4.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9320F8450203F74885A01C2338E0390F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=jonathan.derrick@intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 11:53:39
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDExOjMzICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMTE6MDI6MzlQTSAtMDQwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVmVyc2lvbnMgb2YgVk1EIHdpdGggdGhlIEhvc3QgUGh5c2ljYWwgQWRk
cmVzcyBzaGFkb3cgcmVnaXN0ZXIgdXNlIHRoaXMNCj4gPiByZWdpc3RlciB0byBjYWxjdWxhdGUg
dGhlIGJ1cyBhZGRyZXNzIG9mZnNldCBuZWVkZWQgdG8gZG8gZ3Vlc3QNCj4gPiBwYXNzdGhyb3Vn
aCBvZiB0aGUgZG9tYWluLiBUaGlzIHJlZ2lzdGVyIHNoYWRvd3MgdGhlIEhvc3QgUGh5c2ljYWwN
Cj4gPiBBZGRyZXNzIHJlZ2lzdGVycyBpbmNsdWRpbmcgdGhlIHJlc291cmNlIHR5cGUgYml0cy4g
QWZ0ZXIgY2FsY3VsYXRpbmcNCj4gPiB0aGUgb2Zmc2V0LCB0aGUgZXh0cmEgcmVzb3VyY2UgdHlw
ZSBiaXRzIGxlYWQgdG8gdGhlIFZNRCByZXNvdXJjZXMgYmVpbmcNCj4gPiBvdmVyLXByb3Zpc2lv
bmVkIGF0IHRoZSBmcm9udCBhbmQgdW5kZXItcHJvdmlzaW9uZWQgYXQgdGhlIGJhY2suDQo+ID4g
DQo+ID4gRXhhbXBsZToNCj4gPiBwY2kgMTAwMDA6ODA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhm
ODAxZmZmYy0weGY4MDNmZmZiIDY0Yml0XQ0KPiA+IA0KPiA+IEV4cGVjdGVkOg0KPiA+IHBjaSAx
MDAwMDo4MDowMi4wOiByZWcgMHgxMDogW21lbSAweGY4MDIwMDAwLTB4ZjgwM2ZmZmYgNjRiaXRd
DQo+ID4gDQo+ID4gSWYgb3RoZXIgZGV2aWNlcyBhcmUgbWFwcGVkIGluIHRoZSBvdmVyLXByb3Zp
c2lvbmVkIGZyb250LCBpdCBjb3VsZCBsZWFkDQo+ID4gdG8gcmVzb3VyY2UgY29uZmxpY3QgaXNz
dWVzIHdpdGggVk1EIG9yIHRob3NlIGRldmljZXMuDQo+ID4gDQo+ID4gRml4ZXM6IGExYTMwMTcw
MTM4YzkgKCJQQ0k6IHZtZDogRml4IHNoYWRvdyBvZmZzZXRzIHRvIHJlZmxlY3Qgc3BlYyBjaGFu
Z2VzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0Bp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCA2
ICsrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gSGkgSm9uLA0KPiANCj4gaXQgbG9va3MgbGlrZSBJIGNhbiB0YWtlIHRoaXMg
cGF0Y2ggZm9yIHY1Ljggd2hlcmVhcyBwYXRjaCAyIGRlcGVuZHMNCj4gb24gdGhlIFFFTVUgY2hh
bmdlcyBhY2NlcHRhbmNlIGFuZCBzaG91bGQgcHJvYmFibHkgd2FpdC4NCj4gDQo+IFBsZWFzZSBs
ZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIGFzYXAgYW5kIEkgd2lsbCB0cnkgdG8gYXQgbGVhc3QN
Cj4gc3F1ZWV6ZSB0aGlzIHBhdGNoIGluLg0KPiANCj4gTG9yZW56bw0KDQpIaSBMb3JlbnpvLA0K
DQpUaGlzIGlzIGZpbmUuIFBsZWFzZSB0YWtlIFBhdGNoIDEuDQpQYXRjaCAyIGlzIGhhcm1sZXNz
IHdpdGhvdXQgdGhlIFFFTVUgY2hhbmdlcywgYnV0IG1heSBhbHdheXMgbmVlZCBhDQpkaWZmZXJl
bnQgYXBwcm9hY2guDQoNCkJlc3QsDQpqb24NCg0KDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0K
PiA+IGluZGV4IGRhYzkxZDYuLmUzODZkNGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci92bWQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMN
Cj4gPiBAQCAtNDQ1LDkgKzQ0NSwxMSBAQCBzdGF0aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0
cnVjdCB2bWRfZGV2ICp2bWQsIHVuc2lnbmVkIGxvbmcgZmVhdHVyZXMpDQo+ID4gIAkJCWlmICgh
bWVtYmFyMikNCj4gPiAgCQkJCXJldHVybiAtRU5PTUVNOw0KPiA+ICAJCQlvZmZzZXRbMF0gPSB2
bWQtPmRldi0+cmVzb3VyY2VbVk1EX01FTUJBUjFdLnN0YXJ0IC0NCj4gPiAtCQkJCQlyZWFkcSht
ZW1iYXIyICsgTUIyX1NIQURPV19PRkZTRVQpOw0KPiA+ICsJCQkJCShyZWFkcShtZW1iYXIyICsg
TUIyX1NIQURPV19PRkZTRVQpICYNCj4gPiArCQkJCQkgUENJX0JBU0VfQUREUkVTU19NRU1fTUFT
Syk7DQo+ID4gIAkJCW9mZnNldFsxXSA9IHZtZC0+ZGV2LT5yZXNvdXJjZVtWTURfTUVNQkFSMl0u
c3RhcnQgLQ0KPiA+IC0JCQkJCXJlYWRxKG1lbWJhcjIgKyBNQjJfU0hBRE9XX09GRlNFVCArIDgp
Ow0KPiA+ICsJCQkJCShyZWFkcShtZW1iYXIyICsgTUIyX1NIQURPV19PRkZTRVQgKyA4KSAmDQo+
ID4gKwkJCQkJIFBDSV9CQVNFX0FERFJFU1NfTUVNX01BU0spOw0KPiA+ICAJCQlwY2lfaW91bm1h
cCh2bWQtPmRldiwgbWVtYmFyMik7DQo+ID4gIAkJfQ0KPiA+ICAJfQ0KPiA+IC0tIA0KPiA+IDEu
OC4zLjENCj4gPiANCg==

