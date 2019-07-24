Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6490C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A778A21911
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A778A21911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKF3-0004yB-T9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 12:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37230)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hqKEu-0004Zo-26
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hqKEp-0004ez-AC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:35:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:17739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hqKEm-00047w-99
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:35:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 09:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; d="scan'208";a="169974079"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2019 09:35:23 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.32]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.17]) with mapi id 14.03.0439.000;
 Wed, 24 Jul 2019 09:35:23 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v4 0/3] pc: mmap kernel (ELF image) and initrd
Thread-Index: AQHVQix43hB3UdS20kqxBqvkK73rbKbabIsA
Date: Wed, 24 Jul 2019 16:35:23 +0000
Message-ID: <0d7d1ba8b4da6021c7e05ce736f38df1d012e9c6.camel@intel.com>
References: <20190724143105.307042-1-sgarzare@redhat.com>
In-Reply-To: <20190724143105.307042-1-sgarzare@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.25.192]
Content-Type: text/plain; charset="utf-8"
Content-ID: <93F9E0FEC0358644B30B98A41DCAE01F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH v4 0/3] pc: mmap kernel (ELF image) and
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

SGkgU3RlZmFubw0KDQpIZXJlIHRoZSByZXN1bHRzDQoNCmh0dHBzOi8vcGFzdGVib2FyZC5jby9J
cHUzRE80LnBuZw0KaHR0cHM6Ly9wYXN0ZWJvYXJkLmNvL0lwdTNMNjkucG5nDQoNCmJvb3QgdGlt
ZSB3aXRoIGluaXRyZCBpcyBhIGxpdHRsZSBiaXQgYmV0dGVyDQoNClRoYW5rcw0KDQotDQpKdWxp
bw0KDQoNCk9uIFdlZCwgMjAxOS0wNy0yNCBhdCAxNjozMSArMDIwMCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOg0KPiBJbiBvcmRlciB0byByZWR1Y2UgdGhlIG1lbW9yeSBmb290cHJpbnQgd2hl
biBQVkgga2VybmVsIGFuZCBpbml0cmQNCj4gYXJlIHVzZWQsIHdlIG1hcCB0aGVtIGludG8gbWVt
b3J5IGluc3RlYWQgb2YgcmVhZGluZyB0aGVtLg0KPiBJbiB0aGlzIHdheSB3ZSBjYW4gc2hhcmUg
dGhlbSBiZXR3ZWVuIG11bHRpcGxlIGluc3RhbmNlcyBvZiBRRU1VLg0KPiANCj4gdjQ6DQo+ICAg
LSBQYXRjaCAxOiBmaXggdGhlIHJvbV9hZGRfZWxmX3Byb2dyYW0oKSBjb21tZW50IFtQYW9sb10N
Cj4gICAtIFBhdGNoIDI6DQo+ICAgICB+IGZpeCB0aGUgbWlzc2luZyBvZiBnX21hcHBlZF9maWxl
X3VucmVmKCkgaW4gdGhlIHN1Y2Nlc3MgY2FzZQ0KPiBbUGFvbG9dDQo+ICAgICB+IGZpeCB0aGUg
cm9tX2FkZF9lbGZfcHJvZ3JhbSgpIGNvbW1lbnQgW1Bhb2xvXQ0KPiANCj4gdjM6IA0KPiBodHRw
czovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA3MjQxMTI1MzEuMjMyMjYwLTEtc2dhcnphcmVAcmVk
aGF0LmNvbS8NCj4gdjI6IA0KPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA3MjMxNDA0
NDUuMTI3NDgtMS1zZ2FyemFyZUByZWRoYXQuY29tLw0KPiANCj4gVGhlc2UgYXJlIHRoZSByZXN1
bHRzIHVzaW5nIGEgUFZIIGtlcm5lbCBhbmQgaW5pdHJkIChjcGlvKToNCj4gLSBtZW1vcnkgZm9v
dHByaW50ICh1c2luZyBzbWVtKSBbTUJdDQo+ICAgICAgICAgUUVNVSAgICAgICAgICAgICAgYmVm
b3JlICAgICAgICAgICAgICAgICAgIG5vdw0KPiAgICAgIyBpbnN0YW5jZXMgICAgICAgIFVTUyAg
ICAgIFBTUyAgICAgICAgICAgIFVTUyAgICAgIFBTUw0KPiAgICAgICAgICAxICAgICAgICAgICAx
MDIuME0gICAxMDUuOE0gICAgICAgICAxMDIuM00gICAxMDYuMk0NCj4gICAgICAgICAgMiAgICAg
ICAgICAgIDk0LjZNICAgMTAxLjJNICAgICAgICAgIDcyLjNNICAgIDkwLjFNDQo+ICAgICAgICAg
IDQgICAgICAgICAgICA5NC4xTSAgICA5OC4wTSAgICAgICAgICA3Mi4wTSAgICA4MS41TQ0KPiAg
ICAgICAgICA4ICAgICAgICAgICAgOTQuME0gICAgOTYuMk0gICAgICAgICAgNzEuOE0gICAgNzYu
OU0NCj4gICAgICAgICAxNiAgICAgICAgICAgIDkzLjlNICAgIDk1LjFNICAgICAgICAgIDcxLjZN
ICAgIDc0LjNNDQo+IA0KPiAgICAgSW5pdHJkIHNpemU6IDMuME0NCj4gICAgIEtlcm5lbA0KPiAg
ICAgICAgIGltYWdlIHNpemU6IDI4TQ0KPiAgICAgICAgIHNlY3Rpb25zIHNpemUgW3NpemUgLUEg
LWQgdm1saW51eF06ICAxOC45TQ0KPiANCj4gLSBib290IHRpbWUgW21zXQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJlZm9yZSAgICAgICAgICAgICAgICAgICBub3cNCj4gIHFlbXVfaW5p
dF9lbmQ6ICAgICAgICAgICA2My44NSAgICAgICAgICAgICAgICAgICA1NS45MQ0KPiAgbGludXhf
c3RhcnRfa2VybmVsOiAgICAgIDgyLjExICgrMTguMjYpICAgICAgICAgIDc0LjUxICgrMTguNjAp
DQo+ICBsaW51eF9zdGFydF91c2VyOiAgICAgICAxNjkuOTQgKCs4Ny44MykgICAgICAgICAxNTku
MDYgKCs4NC41NikNCj4gDQo+IFFFTVUgY29tbWFuZCB1c2VkOg0KPiAuL3FlbXUtc3lzdGVtLXg4
Nl82NCAtYmlvcyAvcGF0aC90by9zZWFiaW9zL291dC9iaW9zLmJpbiAtbm8taHBldCBcDQo+ICAg
ICAtbWFjaGluZQ0KPiBxMzUsYWNjZWw9a3ZtLGtlcm5lbF9pcnFjaGlwLG52ZGltbSxzYXRhPW9m
ZixzbWJ1cz1vZmYsdm1wb3J0PW9mZiBcDQo+ICAgICAtY3B1IGhvc3QgLW0gMUcgLXNtcCAxIC12
Z2Egbm9uZSAtZGlzcGxheSBub25lIC1uby11c2VyLWNvbmZpZw0KPiAtbm9kZWZhdWx0cyBcDQo+
ICAgICAta2VybmVsIC9wYXRoL3RvL3ZtbGludXggLWluaXRyZCAvcGF0aC90by9yb290ZnMuY3Bp
byBcDQo+ICAgICAtYXBwZW5kICdyb290PS9kZXYvbWVtMCBybyBjb25zb2xlPWh2YzAgcGNpPWxh
c3RidXM9MCBub3NtYXAnDQo+IA0KPiBTdGVmYW5vIEdhcnphcmVsbGEgKDMpOg0KPiAgIGxvYWRl
cjogSGFuZGxlIG1lbW9yeS1tYXBwZWQgRUxGcw0KPiAgIGVsZi1vcHMuaDogTWFwIGludG8gbWVt
b3J5IHRoZSBFTEYgdG8gbG9hZA0KPiAgIGh3L2kzODYvcGM6IE1hcCBpbnRvIG1lbW9yeSB0aGUg
aW5pdHJkDQo+IA0KPiAgaHcvY29yZS9sb2FkZXIuYyAgICAgfCAzOCArKysrKysrKysrKysrKysr
KysrLS0tLS0NCj4gIGh3L2kzODYvcGMuYyAgICAgICAgIHwgMTcgKysrKysrKystLS0NCj4gIGlu
Y2x1ZGUvaHcvZWxmX29wcy5oIHwgNzEgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLQ0KPiAtLS0tDQo+ICBpbmNsdWRlL2h3L2kzODYvcGMuaCB8ICAxICsNCj4gIGluY2x1
ZGUvaHcvbG9hZGVyLmggIHwgIDUgKystLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRp
b25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4gDQo=

