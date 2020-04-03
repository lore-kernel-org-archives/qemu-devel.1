Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912F2C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622EA2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622EA2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNC8-0004rD-HM
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNBT-0004Ov-89
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNBR-0004iC-8Q
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:20:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:40211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jKNBR-0004OS-0j
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:20:33 -0400
IronPort-SDR: ncnmN8L6Sq2uUPRWnwQWX89MmodqwY6bKEK9Jc3Y9KCCyMJQK72zDZztD0obBB4aSbJ3NLwzoH
 oL4fEK9Wt9xQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 07:20:24 -0700
IronPort-SDR: 2rpQ7rIuR4YUY0xutP8EPYCYieB6vL0BcBNl35QFYD1nMs86yI801vsSY3VF1kc6yr5wB5UD2u
 Xfc9cs/52umA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; d="scan'208";a="250182018"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga003.jf.intel.com with ESMTP; 03 Apr 2020 07:20:23 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 07:20:22 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 07:20:22 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.7]) with mapi id 14.03.0439.000;
 Fri, 3 Apr 2020 22:20:19 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Thread-Topic: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Thread-Index: AQHWBkpi4SFlYLfwBEaCXIDf+JnUMqhk//QAgABXcoCAAiHikA==
Date: Fri, 3 Apr 2020 14:20:18 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A220CF8@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <984e6f47-2717-44fb-7ff2-95ca61d1858f@redhat.com>
 <20200402134601.GJ7174@xz-x1>
In-Reply-To: <20200402134601.GJ7174@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.93
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBB
cHJpbCAyLCAyMDIwIDk6NDYgUE0NCj4gVG86IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDAvMjJdIGludGVsX2lvbW11OiBleHBvc2Ug
U2hhcmVkIFZpcnR1YWwgQWRkcmVzc2luZyB0bw0KPiBWTXMNCj4gDQo+IE9uIFRodSwgQXByIDAy
LCAyMDIwIGF0IDA0OjMzOjAyUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+ID4gPiBUaGUg
Y29tcGxldGUgUUVNVSBzZXQgY2FuIGJlIGZvdW5kIGluIGJlbG93IGxpbms6DQo+ID4gPiBodHRw
czovL2dpdGh1Yi5jb20vbHV4aXMxOTk5L3FlbXUuZ2l0OiBzdmFfdnRkX3YxMF92Mg0KPiA+DQo+
ID4NCj4gPiBIaSBZaToNCj4gPg0KPiA+IEkgY291bGQgbm90IGZpbmQgdGhlIGJyYW5jaCB0aGVy
ZS4NCj4gDQo+IEphc29uLA0KPiANCj4gSGUgdHlwZWQgd3JvbmcuLi4gSXQncyBhY3R1YWxseSAo
SSBmb3VuZCBpdCBteXNlbGYpOg0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29tL2x1eGlzMTk5OS9x
ZW11L3RyZWUvc3ZhX3Z0ZF92MTBfcWVtdV92Mg0KdGhhbmtzLCByZWFsbHkgYSBzaWxseSB0eXBl
IG1pc3Rha2UuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==

