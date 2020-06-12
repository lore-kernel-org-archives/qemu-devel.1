Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF55CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B50F220835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50F220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlbd-0006y9-0I
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jjlL0-00010q-QT
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 11:11:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:18225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jjlKx-0005m0-RL
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 11:11:22 -0400
IronPort-SDR: CjqK5J6nVJ7GpFBFOpCx+SRGjzFsXQutMvh19FijATNdkERHzKq5hHPkBhPOD2GHFtVcEnKm0W
 oct6La2W/YYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 08:11:16 -0700
IronPort-SDR: gWYtmwS4CqAZdgOvyx7dX8ZDmyOqJ8Y4Fncp77qtakbVb+6bOLwLOrg3dsdSHXoyVoGIl5GBnZ
 RVwuMDRwmTLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; d="scan'208";a="271925759"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2020 08:11:16 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.250]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.62]) with mapi id 14.03.0439.000;
 Fri, 12 Jun 2020 08:11:16 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Topic: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Index: AQHWNJ6/KA9BUx6s/UuCJV3Lsz6Rn6i/VTmAgABYZACAAAgMAIAUwX2AgAEXAYCAABUAgA==
Date: Fri, 12 Jun 2020 15:11:15 +0000
Message-ID: <8466e3ff386547a3bbaf578c3099dd12d545a7f8.camel@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-3-jonathan.derrick@intel.com>
 <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
 <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
 <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
 <f1d36b8fc4ab7aacf6efca19303b04a5b4f8189c.camel@intel.com>
 <20200612135443.GA25653@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200612135443.GA25653@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.209.129.249]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2235C0C9FC0184E9366125CF83DC4A3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=jonathan.derrick@intel.com; helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 11:11:17
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

T24gRnJpLCAyMDIwLTA2LTEyIGF0IDE0OjU0ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMTEsIDIwMjAgYXQgMDk6MTY6NDhQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+ID4gPiBIaSBKb24sDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gaXQgbG9va3MgbGlrZSBJIGNhbiB0YWtlIHRoaXMgcGF0Y2ggZm9y
IHY1Ljggd2hlcmVhcyBwYXRjaCAyIGRlcGVuZHMNCj4gPiA+ID4gPiBvbiB0aGUgUUVNVSBjaGFu
Z2VzIGFjY2VwdGFuY2UgYW5kIHNob3VsZCBwcm9iYWJseSB3YWl0Lg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIGFzYXAgYW5kIEkgd2lsbCB0
cnkgdG8gYXQgbGVhc3QNCj4gPiA+ID4gPiBzcXVlZXplIHRoaXMgcGF0Y2ggaW4uDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gTG9yZW56bw0KPiA+ID4gPiANCj4gPiA+ID4gSGkgTG9yZW56bywNCj4g
PiA+ID4gDQo+ID4gPiA+IFRoaXMgaXMgZmluZS4gUGxlYXNlIHRha2UgUGF0Y2ggMS4NCj4gPiA+
ID4gUGF0Y2ggMiBpcyBoYXJtbGVzcyB3aXRob3V0IHRoZSBRRU1VIGNoYW5nZXMsIGJ1dCBtYXkg
YWx3YXlzIG5lZWQgYQ0KPiA+ID4gPiBkaWZmZXJlbnQgYXBwcm9hY2guDQo+ID4gPiANCj4gPiA+
IFB1bGxlZCBwYXRjaCAxIGludG8gcGNpL3ZtZCwgdGhhbmtzLg0KPiA+ID4gDQo+ID4gPiBMb3Jl
bnpvDQo+ID4gDQo+ID4gSGkgTG9yZW56bywNCj4gPiANCj4gPiBBbGV4IGhhcyBwci1lZCB0aGUg
UUVNVSBwYXRjaCBbMV0NCj4gPiBJcyBpdCB0b28gbGF0ZSB0byBwdWxsIHBhdGNoIDIvMiBmb3Ig
djUuOD8NCj4gDQo+IEkgdGhpbmsgaXQgaXMgLSBJIGRvbid0IGtub3cgaWYgQmpvcm4gcGxhbm5l
ZCBhIHNlY29uZCBQUiBmb3IgdGhpcw0KPiBtZXJnZSB3aW5kb3csIGlmIG5vdCBpdCBpcyB2NS45
IG1hdGVyaWFsIEkgYW0gYWZyYWlkLg0KPiANCj4gVGhhbmtzLA0KPiBMb3JlbnpvDQo+IA0KPiA+
IFsxXSANCj4gPiBodHRwczovL2dpdGh1Yi5jb20vYXdpbGxpYW0vcWVtdS12ZmlvL3JlbGVhc2Vz
L3RhZy92ZmlvLXVwZGF0ZS0yMDIwMDYxMS4wDQoNCk5vIHByb2JsZW0NCkpvbg0K

