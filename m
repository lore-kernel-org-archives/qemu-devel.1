Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E924C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 01:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5537C20716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 01:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5537C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnY3C-00022t-KX
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 21:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnY2W-0001dx-Gq
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 21:47:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:24465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnY2T-0006cq-Oi
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 21:47:56 -0400
IronPort-SDR: cVvRvFk/zVXf1DMQ2H35wG50DrIRtYVkVK1eSJqa36y9Wu9thmNVpGHBHE34kiTREBB6UQ1Ptg
 1ZY8tuEjw5xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="209120422"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="209120422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 18:47:47 -0700
IronPort-SDR: 6j5K3SbSe8RGcVuxtcmHV4DHvxYXss909a8bzyj/c2Nj1b/XtYoRnyGh1zCdbJZp+7VBKqM1p1
 nd18fpdkdh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="353654945"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga001.jf.intel.com with ESMTP; 22 Jun 2020 18:47:46 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jun 2020 18:47:45 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 23 Jun 2020 09:47:43 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 23 Jun 2020 09:47:43 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Topic: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Index: AQHWD7P+xm/8Bq9SCE2KY4WVvkZ5vqiHGCMAgFkFkQCABcLnsA==
Date: Tue, 23 Jun 2020 01:47:43 +0000
Message-ID: <5660d3b43c8d4fb4ab0a42e0bf67eaa4@intel.com>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <c8ce4348-d81c-1d10-ff82-74be39a03b5a@redhat.com>
 <20200619194611.057b48ed@luklap>
In-Reply-To: <20200619194611.057b48ed@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=chen.zhang@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 21:47:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgU3RyYXViIDxs
dWthc3N0cmF1YjJAd2ViLmRlPg0KPiBTZW50OiBTYXR1cmRheSwgSnVuZSAyMCwgMjAyMCAxOjQ3
IEFNDQo+IFRvOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBDYzogWmhhbmcs
IENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgcWVtdS1kZXYgPHFlbXUtDQo+IGRldmVsQG5v
bmdudS5vcmc+OyBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDAvMl0gbmV0L2NvbG8tY29tcGFyZS5jOiBFeHBvc2UgIm1heF9xdWV1ZV9zaXpl
IiB0bw0KPiB1c2VycyBhbmQgY2xlYW4gdXANCj4gDQo+IE9uIEZyaSwgMjQgQXByIDIwMjAgMTA6
MTk6NDggKzA4MDANCj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
IA0KPiA+IE9uIDIwMjAvNC8xMSDkuIrljYgxMTozOCwgWmhhbmcgQ2hlbiB3cm90ZToNCj4gPiA+
IEZyb206IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+IFRo
aXMgc2VyaWVzIG1ha2UgYSB3YXkgdG8gY29uZmlnIENPTE8gIm1heF9xdWV1ZV9zaXplIiBwYXJh
bWV0ZXJzDQo+ID4gPiBhY2NvcmRpbmcgdG8gdXNlcidzIHNjZW5hcmlvcyBhbmQgZW52aXJvbm1l
bnRzIGFuZCBkbyBzb21lIGNsZWFuIHVwIGZvcg0KPiBkZXNjcmlwdGlvbnMuDQo+ID4gPg0KPiA+
ID4gWmhhbmcgQ2hlbiAoMik6DQo+ID4gPiAgICBuZXQvY29sby1jb21wYXJlLmM6IEV4cG9zZSBj
b21wYXJlICJtYXhfcXVldWVfc2l6ZSIgdG8gdXNlcnMNCj4gPiA+ICAgIHFlbXUtb3B0aW9ucy5o
eDogQ2xlYW4gdXAgYW5kIGZpeCB0eXBvIGZvciBjb2xvLWNvbXBhcmUNCj4gPiA+DQo+ID4gPiAg
IG5ldC9jb2xvLWNvbXBhcmUuYyB8IDQzDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0NCj4gPiA+ICAgcWVtdS1vcHRpb25zLmh4ICAgIHwgMzMgKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5z
ZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPg0KPiA+IFF1ZXVlZCBmb3IgNS4x
Lg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4NCj4gPg0KPiANCj4gSGksDQo+IEl0IGxvb2tzIGxpa2Ug
dGhpcyBoYXNuJ3QgYmVlbiBtZXJnZWQuDQoNClRoYW5rcyBMdWthcy4NCkhpIEphc29uLCBJIGhh
dmUgZG91YmxlIGNoZWNrZWQgb24gdXBzdHJlYW0sIGxvb2tzIG1pc3NlZCB0aGlzIHNlcmllcy4N
Cg0KVGhhbmtzDQpaaGFuZyBDaGVuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEx1a2FzIFN0cmF1Yg0K

