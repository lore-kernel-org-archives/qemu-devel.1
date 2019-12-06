Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D047BC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A44A324659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44A324659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGn6-0001qk-KI
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1idFTU-00025m-6t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1idFTS-00012V-E2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:24:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:5610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1idFTS-0000qL-02
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:24:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Dec 2019 07:24:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,285,1571727600"; d="scan'208";a="209465510"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2019 07:24:48 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Dec 2019 07:24:48 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Dec 2019 07:24:47 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.90]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.19]) with mapi id 14.03.0439.000;
 Fri, 6 Dec 2019 23:24:46 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: about QEMU release schedule
Thread-Topic: about QEMU release schedule
Thread-Index: AdWr6SNBeGNJvd/QTLOJrz2+yP08bP//3sOAgADhi+U=
Date: Fri, 6 Dec 2019 15:24:46 +0000
Message-ID: <12B7DFF3-8414-4C26-97BD-DDF772D7433A@intel.com>
References: <A2975661238FB949B60364EF0F2C25743A12875B@SHSMSX104.ccr.corp.intel.com>,
 <CAFEAcA_A814+1_vvD+QO=cDeiWEXdUJyZgjuBeU2RTXaHYCh+A@mail.gmail.com>
In-Reply-To: <CAFEAcA_A814+1_vvD+QO=cDeiWEXdUJyZgjuBeU2RTXaHYCh+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+PiBPbiBEZWMgNiwgMjAxOSwgYXQgMTc6NTcsIFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZz4gd3JvdGU6DQo+PiANCj4+IO+7v09uIEZyaSwgNiBEZWMgMjAxOSBhdCAw
NDowMCwgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+IHdyb3RlOg0KPj4gSGkgUGV0ZXIs
DQo+PiBJ4oCZbSB3b25kZXJpbmcgd2hhdOKAmXMgdGhlIHJ1bGUgb2YgUUVNVSB2ZXJzaW9uIG5h
bWluZyBhbmQgcmVsZWFzZS4NCj4+IEkgbm90aWNlZCB0aGVyZSBpcyBhIHYzLjEuMS4xIHJlbGVh
c2VkIGFmdGVyIHY0LjEuMCB3YXMgcmVsZWFzZWQuDQo+IA0KPiBBbnkgcmVhc29uIGZvciBub3Qg
anVzdCBhc2tpbmcgdGhpcyBvbiB0aGUgcHVibGljIGxpc3RzPw0KDQpObywgSSBzaG91bGQgaGF2
ZSBjY2VkIG1haWxpbmcgbGlzdCwgdGh1cyBvdGhlciBwZW9wbGUgd291bGQgbGVhcm4gaXQgYXMg
d2VsbC4gDQoNCj4+IEFsc28sIEnigJlkIGxpa2UgdG8gcXVlcnkgdGhlIHJlbGVhc2UgcGxhbiBp
biAyMDIwLiBXaGF0IHZlcnNpb24gd291bGQgaXQNCj4+IGJlIGluIDIwMjAtSnVseT8NCj4gDQo+
IEZvciBtYW55IHllYXJzIHdlJ3ZlIGRvbmUgbWFqb3IgcmVsZWFzZXMgdGhyZWUgdGltZXMNCj4g
YSB5ZWFyLCBpbiBBcHJpbCwgQXVndXN0IGFuZCBEZWNlbWJlciAocm91Z2hseSkuDQo+IFN0YXJ0
aW5nIGZyb20gNC4wLCB3ZSBzd2l0Y2hlZCB0byBhIG5hbWluZyBjb252ZW50aW9uIHdoZXJlDQo+
IHRoZSBtYWpvciBudW1iZXIganVzdCBpbmNyZW1lbnRzIG9uY2UgYSB5ZWFyLiBTbyAyMDE5J3MN
Cj4gcmVsZWFzZXMgYXJlIDQuMCwgNC4xIGFuZCA0LjI7IDIwMjAncyB3aWxsIGJlIDUuMCwgNS4x
DQo+IGFuZCA1LjIsIGFuZCBzbyBvbi4NCj4gDQo+IEZ1cnRoZXIgcmVsZWFzZXMgb24gc3RhYmxl
IGJyYW5jaGVzIChlZyA0LjAuMSwgZXRjKSBhcmUNCj4gbm90IGhhbmRsZWQgYnkgbWUgLS0gdGhl
eSdyZSBkb25lIGJ5IE1pa2UgUm90aC4gSSBkb24ndA0KPiBrbm93IHdoYXQgdGhlIHVzdWFsIHBh
dHRlcm4gaXMgZm9yIHRob3NlIG9yIGhvdyBtYW55DQo+IGJyYW5jaGVzIGJhY2sgd2UgZG8gdXBk
YXRlcyBmb3IuDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHNoYXJpbmcuIA0KDQpSZWdhcmRzLA0K
WWkgTGl1

