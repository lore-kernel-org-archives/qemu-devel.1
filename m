Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F9FC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E0F22ADB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 13:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E0F22ADB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGw6-0002Kr-Mn
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 09:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hqGvs-0001fJ-4F
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hqGvq-0003OJ-Rs
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:03:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:11643)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hqGvo-0003Na-Un
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 09:03:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Jul 2019 06:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; d="scan'208";a="189093040"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2019 06:03:43 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 24 Jul 2019 06:03:42 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.32]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.168]) with mapi id 14.03.0439.000;
 Wed, 24 Jul 2019 06:03:42 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>
Thread-Topic: [PATCH v2 0/2] pc: mmap kernel (ELF image) and initrd
Thread-Index: AQHVQV+knRdUYEW73kipO69Yq/lGUabY7R2AgADqoYCAAFtJgA==
Date: Wed, 24 Jul 2019 13:03:42 +0000
Message-ID: <e548f60000894db2404eaaa77657b1ed551a8099.camel@intel.com>
References: <20190723140445.12748-1-sgarzare@redhat.com>
 <4d2967a1637b3ab93ff79fa016fd4a42f5638204.camel@intel.com>
 <20190724073657.ldisme6i4u55axga@steredhat>
In-Reply-To: <20190724073657.ldisme6i4u55axga@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.205.60]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A3ADFE4B98DAA45BF8B2BD84905F01F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
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
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgU3RlZmFubw0KDQpPbiBXZWQsIDIwMTktMDctMjQgYXQgMDk6MzYgKzAyMDAsIFN0ZWZhbm8g
R2FyemFyZWxsYSB3cm90ZToNCj4gT24gVHVlLCBKdWwgMjMsIDIwMTkgYXQgMDU6Mzc6MThQTSAr
MDAwMCwgTW9udGVzLCBKdWxpbyB3cm90ZToNCj4gPiBTdGVmYW5vLCBCcmlsbGlhbnQgam9iIQ0K
PiA+IA0KPiA+IEkgY2FuIGNvbmZpcm0gdGhhdCB3aXRoIHRoZXNlIHBhdGNoZXMgdGhlIG1lbW9y
eSBmb290cHJpbnQgaXMNCj4gPiBzbWFsbGVyDQo+ID4gYW5kIHRoZSBib290IHRpbWUgaXMgdGhl
IHNhbWUgZm9yIGthdGENCj4gPiANCj4gPiBIZXJlIHRoZSByZXN1bHRzIHVzaW5nIGthdGEgbWV0
cmljcw0KPiA+IA0KPiA+IGh0dHBzOi8vcGFzdGVib2FyZC5jby9JcGwwNlEwLnBuZw0KPiA+IGh0
dHBzOi8vcGFzdGVib2FyZC5jby9JcGwzcDRkLnBuZw0KPiA+IA0KPiANCj4gSGkgSnVsaW8sDQo+
IHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRlc3RpbmcgOikNCj4gDQo+IFdoZW4geW91IG1lYXN1
cmUgdGhlIFBQUywgaG93IG1hbnkgUUVNVSBpbnN0YW5jZXMgZGlkIHlvdSBzdGFydD8NCj4gRGlk
IHlvdSB1c2UgYWxzbyB0aGUgaW5pdHJkPw0KDQo1MCBWTXMgd2l0aCBhIG52ZGltbS9wbWVtIGRl
dmljZSBhcyByb290ZnMsIEkgd2lsbCB0ZXN0IHlvdXIgdjMgd2l0aA0KaW5pdHJkIDopDQoNCj4g
DQo+IFRoYW5rcywNCj4gU3RlZmFubw0K

