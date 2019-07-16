Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9982EC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7472173E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7472173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnV8E-0006hT-GV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hnV84-0006Iu-KL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hnV83-0000Nk-OZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:36:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:61516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hnV83-0000HX-5p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:36:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jul 2019 14:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; d="scan'208";a="178683084"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga002.jf.intel.com with ESMTP; 16 Jul 2019 14:36:46 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jul 2019 14:36:45 -0700
Received: from fmsmsx104.amr.corp.intel.com ([169.254.3.188]) by
 fmsmsx163.amr.corp.intel.com ([169.254.6.210]) with mapi id 14.03.0439.000;
 Tue, 16 Jul 2019 14:36:45 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Thread-Topic: [PATCH] kconfig: do not select VMMOUSE
Thread-Index: AQHVPBte+njUTQRgrkCcefAk02mtzabOOkCA
Date: Tue, 16 Jul 2019 21:36:45 +0000
Message-ID: <586bd5b8b4ed639669e21ae687f360ad015d220a.camel@intel.com>
References: <20190716211343.10792-1-pbonzini@redhat.com>
In-Reply-To: <20190716211343.10792-1-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.218.162.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0CC58F256ADDF43B0B8AC8D2E86359A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH] kconfig: do not select VMMOUSE
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
Cc: "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIFBhb2xvDQoNCk9uIFR1ZSwgMjAxOS0wNy0xNiBhdCAyMzoxMyArMDIwMCwgUGFvbG8g
Qm9uemluaSB3cm90ZToNCj4gSnVzdCBtYWtlIGl0IGEgZGVmYXVsdCBkZXZpY2UsIHNvIHRoYXQg
aXQgaXMgYXV0b21hdGljYWxseSByZW1vdmVkIGlmDQo+IFZNUE9SVA0KPiBpcyBub3QgaW5jbHVk
ZWQgaW4gdGhlIGJpbmFyeSAoYXMgaXMgdGhlIGNhc2Ugd2l0aCAtLXdpdGgtZGVmYXVsdC0NCj4g
ZGV2aWNlcykuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L2kzODYvS2NvbmZpZyB8IDMgKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9LY29uZmlnIGIvaHcvaTM4Ni9LY29uZmlnDQo+IGluZGV4IGI5Yzk2YWMzNjEu
LjgzYTVkOWM3YzQgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvS2NvbmZpZw0KPiArKysgYi9ody9p
Mzg2L0tjb25maWcNCj4gQEAgLTU5LDcgKzU5LDYgQEAgY29uZmlnIEk0NDBGWA0KPiAgICAgIHNl
bGVjdCBJREVfUElJWA0KPiAgICAgIHNlbGVjdCBESU1NDQo+ICAgICAgc2VsZWN0IFNNQklPUw0K
PiAtICAgIHNlbGVjdCBWTU1PVVNFDQo+ICAgICAgc2VsZWN0IEZXX0NGR19ETUENCj4gIA0KPiAg
Y29uZmlnIElTQVBDDQo+IEBAIC04NSw3ICs4NCw2IEBAIGNvbmZpZyBRMzUNCj4gICAgICBzZWxl
Y3QgQUhDSV9JQ0g5DQo+ICAgICAgc2VsZWN0IERJTU0NCj4gICAgICBzZWxlY3QgU01CSU9TDQo+
IC0gICAgc2VsZWN0IFZNTU9VU0UNCj4gICAgICBzZWxlY3QgRldfQ0ZHX0RNQQ0KPiAgDQo+ICBj
b25maWcgVlREDQo+IEBAIC05OSw0ICs5Nyw1IEBAIGNvbmZpZyBWTVBPUlQNCj4gIA0KPiAgY29u
ZmlnIFZNTU9VU0UNCj4gICAgICBib29sDQo+ICsgICAgZGVmYXVsdCB5DQo+ICAgICAgZGVwZW5k
cyBvbiBWTVBPUlQNCg0KUmV2aWV3ZWQtYnk6IEp1bGlvIE1vbnRlcyA8anVsaW8ubW9udGVzQGlu
dGVsLmNvbT4NClRlc3RlZC1ieTogSnVsaW8NCk1vbnRlcyA8anVsaW8ubW9udGVzQGludGVsLmNv
bT4NCg==

