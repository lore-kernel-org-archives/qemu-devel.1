Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99878C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 22:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645F52077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 22:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645F52077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRNhc-0003Zl-FX
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 18:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jonathan.derrick@intel.com>) id 1jRNh0-000356-1N
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 18:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jonathan.derrick@intel.com>) id 1jRNgy-0003lV-TD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 18:18:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:4671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jRNgy-0003Z1-CQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 18:18:04 -0400
IronPort-SDR: Q6b2r/qH46ilDovB0wqFIyri6zBsHSe+tGfEkjHTZqqS9u42b62/hfLllTshvIi9sPYVQdZ8q+
 qOr9GYHM+lmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 15:17:58 -0700
IronPort-SDR: p1Ujg028c0lEOtoOttEuV1B4Ci6ZYBuIeJr51EE8NcHpOqSLEvo26mU61JJyGMSAfakGOKq/1R
 UiNBPa6rxSQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; d="scan'208";a="255788029"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by orsmga003.jf.intel.com with ESMTP; 22 Apr 2020 15:17:58 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Apr 2020 15:17:57 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.34]) with mapi id 14.03.0439.000;
 Wed, 22 Apr 2020 15:17:57 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH for QEMU] hw/vfio: Add VMD Passthrough Quirk
Thread-Topic: [PATCH for QEMU] hw/vfio: Add VMD Passthrough Quirk
Thread-Index: AQHWGMtyZw4X1Uq3s0+HhumXVtYMzKiGH9SAgAALrAA=
Date: Wed, 22 Apr 2020 22:17:56 +0000
Message-ID: <48e2ef3f6f843d533e4f3cdb83da9be5184768e6.camel@intel.com>
References: <158759136841.3922.4821101148440128786@39012742ff91>
In-Reply-To: <158759136841.3922.4821101148440128786@39012742ff91>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.7.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC102D38D2895946AC9731BC742461CF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=jonathan.derrick@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 18:17:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: "Jakowski, Andrzej" <andrzej.jakowski@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDE0OjM2IC0wNzAwLCBuby1yZXBseUBwYXRjaGV3Lm9yZyB3
cm90ZToNCj4gUGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjE3
MTMwNS4xMDkyMy0xLWpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tLw0KPiANCj4gDQo+IA0KPiBI
aSwNCj4gDQo+IFRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2Ug
ZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQNCj4gdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5
b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdA0K
PiBsb2NhbGx5Lg0KPiANCj4gPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQ0KPiAjIS9iaW4vYmFz
aA0KPiBleHBvcnQgQVJDSD14ODZfNjQNCj4gbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTENCj4gdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQ0KPiA9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQ0KPiANCj4gICBDQyAgICAgIHFlbXUtaW8tY21kcy5vDQo+ICAgQ0MgICAgICByZXBsaWNhdGlv
bi5vDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBody92ZmlvL3RyYWNlLmM6NToNCj4gL3RtcC9x
ZW11LXRlc3QvYnVpbGQvaHcvdmZpby90cmFjZS5oOjIzNDg6MTIwOiBlcnJvcjogZXhwZWN0ZWQg
JyknDQo+ICAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2ZmlvX3BjaV92bWRfcXVpcmtf
c2hhZG93X3JlZ3MgIiAiJXMgbWVtYmFyMV9waHlzPTB4JSJQUkl4NjQiIG1lbWJhcjJfcGh5cz0w
eCUiUFJJeDY0IiAiXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gDQoNCkl0J3MgdGhlIGV4dHJhICIgYXQgdGhl
IGVuZCwgd2hpY2ggd2lsbCBiZSBmaXhlZCBpbiB2Mg0KVGhhbmtzIGZvciB0aGUgc2FuaXR5IGNo
ZWNrDQoNCg==

