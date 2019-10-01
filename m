Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBEEC32792
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 00:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D414820815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 00:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D414820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF6Or-0006ES-Qu
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 20:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kai.huang@intel.com>) id 1iF6Nx-0005ny-JW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 20:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kai.huang@intel.com>) id 1iF6Nv-0004o0-QA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 20:51:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:5445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kai.huang@intel.com>) id 1iF6Nv-0004mX-0m
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 20:51:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Sep 2019 17:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,569,1559545200"; d="scan'208";a="215898604"
Received: from pgsmsx114.gar.corp.intel.com ([10.108.55.203])
 by fmsmga004.fm.intel.com with ESMTP; 30 Sep 2019 17:51:16 -0700
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.2]) by
 pgsmsx114.gar.corp.intel.com ([169.254.4.250]) with mapi id 14.03.0439.000;
 Tue, 1 Oct 2019 08:51:15 +0800
From: "Huang, Kai" <kai.huang@intel.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "Hu, Robert" <robert.hu@intel.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
Subject: Re: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
Thread-Topic: [RFC] cpu_map: Remove pconfig from Icelake-Server CPU model
Thread-Index: AQHVd5j2NnDCJvV270WqtqWV2Zs4SKdDwhaAgAAMqoCAAKCXgA==
Date: Tue, 1 Oct 2019 00:51:14 +0000
Message-ID: <2b8875c7eaf309b3755f6de6bafc572d6b686cdd.camel@intel.com>
References: <20190926214305.17690-1-ehabkost@redhat.com>
 <20190930102453.GO4884@orkuz.int.mamuti.net>
 <20190930141104.GA4084@habkost.net>
 <9E79D1C9A97CFD4097BCE431828FDD31173BCF76@SHSMSX104.ccr.corp.intel.com>
 <b9fbca16-9877-04b9-78fa-bf711c8f3053@redhat.com>
In-Reply-To: <b9fbca16-9877-04b9-78fa-bf711c8f3053@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.251.15.246]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8B3E164041F8F4AA34D94766C8DFBD4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>, "Kang,
 Luwei" <luwei.kang@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTA5LTMwIGF0IDE3OjE2ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAzMC8wOS8xOSAxNjozMSwgSHUsIFJvYmVydCB3cm90ZToNCj4gPiA+IFRoaXMgbWlnaHQg
YmUgYSBwcm9ibGVtIGlmIHRoZXJlIGFyZSBwbGFucyB0byBldmVudHVhbGx5IG1ha2UgS1ZNIHN1
cHBvcnQNCj4gPiA+IHBjb25maWcsIHRob3VnaC4gIFBhb2xvLCBSb2JlcnQsIGFyZSB0aGVyZSBw
bGFucyB0byBzdXBwb3J0IHBjb25maWcgaW4gS1ZNDQo+ID4gPiBpbiB0aGUNCj4gPiA+IGZ1dHVy
ZT8NCj4gPiBbUm9iZXJ0IEhvb10gDQo+ID4gVGhhbmtzIEVkdWFyZG8gZm9yIGVmZm9ydHMgaW4g
cmVzb2x2aW5nIHRoaXMgaXNzdWUsIGludHJvZHVjZWQgZnJvbSBteQ0KPiA+IEljZWxha2UgQ1BV
DQo+ID4gbW9kZWwgcGF0Y2guDQo+ID4gSSd2ZSBubyBpZGVhIGFib3V0IFBDT05GSUcncyBkZXRh
aWwgYW5kIHBsYW4uIExldCBtZSBzeW5jIHdpdGggSHVhbmcsIEthaQ0KPiA+IGFuZCBhbnN3ZXIN
Cj4gPiB5b3Ugc29vbi4NCj4gDQo+IEl0J3MgcmVhbGx5LCByZWFsbHkgdW5saWtlbHkuICBJdCdz
IHBvc3NpYmxlIHRoYXQgc29tZSBmdXR1cmUgcHJvY2Vzc29yDQo+IG92ZXJsb2FkcyBQQ09ORklH
IGluIHN1Y2ggYSB3YXkgdGhhdCBpdCB3aWxsIGJlY29tZSB2aXJ0dWFsaXphYmxlLCBidXQNCj4g
bm90IEljZUxha2UuDQoNCkkgYWdyZWUuIE5vdCBJY2VsYWtlLg0KDQpUaGFua3MsDQotS2FpDQoN
Cj4gDQo+IFdvdWxkIGl0IG1ha2Ugc2Vuc2UgZm9yIGxpYnZpcnQgdG8gdHJlYXQgYWJzZW50IENQ
VSBmbGFncyBhcyAiZGVmYXVsdA0KPiBvZmYiIGR1cmluZyBtaWdyYXRpb24sIHNvIHRoYXQgaXQg
Y2FuIGxlYXZlIG91dCB0aGUgZmxhZyBpbiB0aGUgY29tbWFuZA0KPiBsaW5lIGlmIGl0J3Mgb2Zm
PyAgSWYgaXQncyBvbiwgbGlidmlydCB3b3VsZCBwYXNzIHBjb25maWc9b24gYXMgdXN1YWwuDQo+
IFRoaXMgaXMgYSB2YXJpYW50IG9mIFsyXSwgYnV0IG1vcmUgZ2VuZXJhbGx5IGFwcGxpY2FibGU6
DQo+IA0KPiA+IFsyXSBIb3dldmVyIHN0YXJ0aW5nIGEgZG9tYWluIHdpdGggSWNlbGFrZS1TZXJ2
ZXIgc28gdGhhdCBpdCBjYW4gYmUNCj4gPiBtaWdyYXRlZCBvciBzYXZlZC9yZXN0b3JlZCBvbiBR
RU1VIGluIDMuMS4xIGFuZCA0LjAuMCB3b3VsZCBiZQ0KPiA+IGltcG9zc2libGUuIFRoaXMgY2Fu
IGJlIHNvbHZlZCBieSBhIGRpZmZlcmVudCBoYWNrLCB3aGljaCB3b3VsZCBkcm9wDQo+ID4gcGNv
bmZpZz1vZmYgZnJvbSBRRU1VIGNvbW1hbmQgbGluZS4NCj4gDQo+IFBhb2xvDQo=

