Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F53DC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C38206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C38206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRddO-00021y-SU
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jonathan.derrick@intel.com>) id 1jRdcG-0000mG-Dj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jonathan.derrick@intel.com>) id 1jRdcF-0003xr-F1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:18:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:15939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jRdcE-0003oI-Kp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:18:15 -0400
IronPort-SDR: kguTZ79BJUYgBC+dvi8yqJxGXvkBG64kPK/d9WbG6sVzrkbHw/pTSsFlSepC5GMwzA7stQQn/V
 c4tSh8yIxVlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 08:18:10 -0700
IronPort-SDR: zYEizug2f5pEgxBz0iBF5IN2GkdmOTUfaVcntlAZ2uiPCMykRTIFm63MPB9b9M9RfzEfWF0+6J
 NErz0qlayTWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; d="scan'208";a="430357474"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by orsmga005.jf.intel.com with ESMTP; 23 Apr 2020 08:18:10 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 08:18:10 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.140]) with mapi id 14.03.0439.000;
 Thu, 23 Apr 2020 08:18:10 -0700
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
To: "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 0/1] KVM support for VMD devices
Thread-Topic: [PATCH 0/1] KVM support for VMD devices
Thread-Index: AQHWGMupFPgnPdV8d0yMVvPmd3oXgKiGsTeAgACXUwA=
Date: Thu, 23 Apr 2020 15:18:10 +0000
Message-ID: <f58982d0d37f86c8cf4d8769d42bea284e0c2825.camel@intel.com>
References: <20200422171444.10992-1-jonathan.derrick@intel.com>
 <20200423061631.GA12688@infradead.org>
In-Reply-To: <20200423061631.GA12688@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.1.180]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2693A69249AB774DABEBE1A7DBFD60BC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=jonathan.derrick@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 11:18:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.126
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
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "Jakowski,
 Andrzej" <andrzej.jakowski@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDIwLTA0LTIyIGF0IDIzOjE2IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBBcHIgMjIsIDIwMjAgYXQgMDE6MTQ6NDRQTSAtMDQwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVGhlIHR3byBwYXRjaGVzIChMaW51eCAmIFFFTVUpIGFkZCBzdXBwb3J0
IGZvciBwYXNzdGhyb3VnaCBWTUQgZGV2aWNlcw0KPiA+IGluIFFFTVUvS1ZNLiBWTUQgZGV2aWNl
IDI4QzAgYWxyZWFkeSBzdXBwb3J0cyBwYXNzdGhyb3VnaCBuYXRpdmVseSBieQ0KPiA+IHByb3Zp
ZGluZyB0aGUgSG9zdCBQaHlzaWNhbCBBZGRyZXNzIGluIGEgc2hhZG93IHJlZ2lzdGVyIHRvIHRo
ZSBndWVzdA0KPiA+IGZvciBjb3JyZWN0IGJyaWRnZSBwcm9ncmFtbWluZy4NCj4gPiANCj4gPiBU
aGUgUUVNVSBwYXRjaCBlbXVsYXRlcyB0aGUgMjhDMCBtb2RlIGJ5IGNyZWF0aW5nIGEgc2hhZG93
IHJlZ2lzdGVyIGFuZA0KPiA+IGFkdmVydGlzaW5nIGl0cyBzdXBwb3J0IGJ5IHVzaW5nIFFFTVUn
cyBzdWJzeXN0ZW0gdmVuZG9yL2lkLg0KPiA+IFRoZSBMaW51eCBwYXRjaCBtYXRjaGVzIHRoZSBR
RU1VIHN1YnN5c3RlbSB2ZW5kb3IvaWQgdG8gdXNlIHRoZSBzaGFkb3cNCj4gPiByZWdpc3Rlci4N
Cj4gDQo+IFBsZWFzZSBwaWNrIGEgZGlmZmVyZW50IFBDSSBJRCBmb3IgUWVtdSB2cyByZWFsIGhh
cmR3YXJlIHNvIHRoYXQgd2UNCj4gY2FuIHByb3Blcmx5IHF1aXJrIHRoZW0gaWYgdGhleSBlbmQg
dXAgYmVoYXZpbmcgZGlmZmVyZW50bHkgZHVlIHRvDQo+IGhhcmR3YXJlIG9yIHNvZnR3YXJlIGJ1
Z3MuDQoNClN1cmUuIFdpbGwgbG9vayBpbnRvIHRoYXQuDQpUaGFua3MgQ2hyaXN0b3BoDQoNCkpv
bg0K

