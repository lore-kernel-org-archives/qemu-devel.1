Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE0DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9A020748
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 06:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9A020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJAnZ-0008RR-AP
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 02:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jJAmo-0007ev-6P
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jJAmm-0007Om-Cs
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:54:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:45080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jJAmm-0007My-54
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 02:54:08 -0400
IronPort-SDR: 1CRqxEIM7ouCzGf2kVs9YFptgulFpY/yq7p/yWVh1Ug9QZpXfkiuvxU5aOc9rQ44en26whIuq6
 LhA+lRDbXyKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 23:54:04 -0700
IronPort-SDR: b7WrdR08ZGzVnCvuPjL0BaWtlr5tgwUP4QlO2znxESDjJ5OVemfWoLu9XIbBUDbJ9QjRT7NBSZ
 MDxEwAzL4+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; d="scan'208";a="248958536"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga003.jf.intel.com with ESMTP; 30 Mar 2020 23:54:03 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 23:54:03 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Mar 2020 23:54:02 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Mar 2020 23:54:02 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.146]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 14:53:59 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Auger Eric <eric.auger@redhat.com>
Subject: RE: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Thread-Topic: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Thread-Index: AQHWBkpi4SFlYLfwBEaCXIDf+JnUMqhga2yAgABF7QCAAY8pcA==
Date: Tue, 31 Mar 2020 06:53:58 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21A72A@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <e709e36f-dc50-2e70-3a1e-62f08533e454@redhat.com>
 <20200330144640.GC522868@xz-x1>
In-Reply-To: <20200330144640.GC522868@xz-x1>
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
X-Received-From: 192.55.52.115
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
 "mst@redhat.com" <mst@redhat.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgTWFyY2ggMzAsIDIwMjAgMTA6NDcgUE0NCj4gVG86IEF1Z2VyIEVyaWMgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMC8yMl0gaW50ZWxf
aW9tbXU6IGV4cG9zZSBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nIHRvDQo+IFZNcw0KPiANCj4g
T24gTW9uLCBNYXIgMzAsIDIwMjAgYXQgMTI6MzY6MjNQTSArMDIwMCwgQXVnZXIgRXJpYyB3cm90
ZToNCj4gPiBJIHRoaW5rIGluIGdlbmVyYWwsIGFzIGxvbmcgYXMgdGhlIGtlcm5lbCBkZXBlbmRl
bmNpZXMgYXJlIG5vdA0KPiA+IHJlc29sdmVkLCB0aGUgUUVNVSBzZXJpZXMgaXMgc3VwcG9zZWQg
dG8gc3RheSBpbiBSRkMgc3RhdGUuDQo+IA0KPiBZZWFoIEkgYWdyZWUuIEkgdGhpbmsgdGhlIHN1
YmplY3QgaXMgbm90IGV4dHJlbWVseSBpbXBvcnRhbnQsIGJ1dCB3ZSBkZWZpbml0ZWx5IHNob3Vs
ZA0KPiB3YWl0IGZvciB0aGUga2VybmVsIHBhcnQgdG8gYmUgcmVhZHkgYmVmb3JlIG1lcmdpbmcg
dGhlIHNlcmllcy4NCj4gDQo+IFNpZGUgbm90ZTogSSBvZmZlcmVkIHF1aXRlIGEgZmV3IHItYnMg
Zm9yIHRoZSBzZXJpZXMgKGFuZCBJIHN0aWxsIHBsYW4gdG8gbW92ZSBvbg0KPiByZWFkaW5nIGl0
IHRoaXMgd2VlayBzaW5jZSB0aGVyZSdzIGEgbmV3IHZlcnNpb24sIGFuZCB0cnkgdG8gb2ZmZXIg
bW9yZSByLWJzIHdoZW4gSQ0KPiBzdGlsbCBoYXZlIHNvbWUgY29udGV4dCBpbiBteSBicmFpbi1j
YWNoZSksIGhvd2V2ZXIgdGhleSdyZSBtb3N0bHkgb25seSBmb3IgbXlzZWxmDQo+IHRvIGF2b2lk
IHJlLXJlYWRpbmcgdGhlIHdob2xlIHNlcmllcyBhZ2FpbiBpbiB0aGUgZnV0dXJlIGVzcGVjaWFs
bHkgYmVjYXVzZSBpdCdzDQo+IGh1Z2UuLi4gOikNCg0KQWdyZWVkLiBJJ2xsIHJlbmFtZSB0aGUg
bmV4dCB2ZXJzaW9uIGFzIFJGQ3Y2IHRoZW4uIEJUVy4gYWx0aG91Z2ggdGhlcmUNCmlzIGRlcGVu
ZGVuY3kgb24ga2VybmVsIHNpZGUsIGJ1dCBJIHRoaW5rIHdlJ2QgZ2V0IGFncmVlbWVudCBvbiB0
aGUNCmludGVyYWN0aW9uIG1lY2hhbmlzbSBiZXR3ZWVuIHZmaW8gYW5kIHZJT01NVSB3aXRoaW4g
UUVNVS4gQWxzbywgZm9yIHRoZQ0KVlQtZCBzcGVjaWZpYyBjaGFuZ2VzIChlLmcuIHRoZSBwYXNp
ZCBjYWNoZSBpbnZhbGlkYXRpb24gcGF0Y2hlcyBhbmQgdGhlDQpwYXNpZC1iYXNlZC1pb3RsYiBp
bnZhbGlkYXRpb25zKSwgd2UgY2FuIGFjdHVhbGx5IGdldCB0aGVtIHJlYWR5IGFzIHRoZXkNCmhh
dmUgbm8gZGVwZW5kZW5jeSBvbiBrZXJuZWwgc2lkZSBjaGFuZ2UuIFBsZWFzZSBoZWxwLiA6LSkN
Cg0KUmVnYXJkcywNCllpIExpdQ0K

