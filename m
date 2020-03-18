Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558E2C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6DF20674
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6DF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jESi6-00052r-D7
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 03:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jESgz-0004Gj-98
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jESgx-0001ca-FR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:00:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:20823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jESgx-0001NQ-6N
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:00:39 -0400
IronPort-SDR: oV/Zhv4nPDV9jYwHkhUnqWeHJBhbUXWFyjjpyrBaitRwT00cNyJN/a4rYTRtmVnbSUCV/N6vXo
 GaHVjjwicMPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 00:00:35 -0700
IronPort-SDR: JUb2E0jeKVQG/LfUsvrX/Fh19kQFEcMdj1seJYj9WbZofBCJBolRdMsswB3uWB8kD034VIhg7D
 NZYsr1hTcAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; d="scan'208";a="238520067"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga008.jf.intel.com with ESMTP; 18 Mar 2020 00:00:35 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 00:00:34 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Mar 2020 15:00:32 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 18 Mar 2020 15:00:32 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/2] net/colo-compare.c: Expose more COLO internal
Thread-Topic: [PATCH 0/2] net/colo-compare.c: Expose more COLO internal
Thread-Index: AQHV6o0xaOdrdOl2ek2ZIaAYq4O+2qg4ID0ggBR1HRCAAK6mAIAAzJqQ
Date: Wed, 18 Mar 2020 07:00:32 +0000
Message-ID: <c3bd15a84ae44a479b6a9d179740546c@intel.com>
References: <20200223205805.26412-1-chen.zhang@intel.com>
 <16d27cc5e749412ebfff71cdb0de1e34@intel.com>
 <151064153931455a89ed47c03bbb54a9@intel.com>
 <6f05b6a2-cd63-e0a0-f24e-f99a2f1a9f02@redhat.com>
In-Reply-To: <6f05b6a2-cd63-e0a0-f24e-f99a2f1a9f02@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.24
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
Cc: Daniel Cho <danielcho@qnap.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxOCwgMjAyMCAxMDo0
OCBBTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgcWVtdS1kZXYg
PHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBEYW5pZWwgQ2hvIDxkYW5pZWxjaG9A
cW5hcC5jb20+OyBEciAuIERhdmlkIEFsYW4gR2lsYmVydA0KPiA8ZGdpbGJlcnRAcmVkaGF0LmNv
bT47IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMC8yXSBuZXQvY29sby1jb21wYXJlLmM6IEV4cG9zZSBtb3JlIENPTE8gaW50ZXJuYWwNCj4g
DQo+IA0KPiBPbiAyMDIwLzMvMTcg5LiL5Y2INDoyNSwgWmhhbmcsIENoZW4gd3JvdGU6DQo+ID4g
SGkgSmFzb24sDQo+ID4NCj4gPiBObyBuZXdzIGZvciBhIHdoaWxlLg0KPiA+IFBsZWFzZSByZXZp
ZXcgdGhpcyBzZXJpZXMgd2hlbiB5b3UgaGF2ZSB0aW1lLg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4g
WmhhbmcgQ2hlbg0KPiANCj4gDQo+IFNvcnJ5IGZvciB0aGUgZGVsYXkuDQo+IA0KPiBQYXRjaCBs
b29rcyBnb29kIHRvIG1lLg0KPiANCj4gQnV0IGl0IGNhbiBub3QgYmUgYXBwbGllZCBjbGVhbmx5
IG9uIG1hc3Rlci4NCj4gDQo+IFBsZWFzZSByZWJhc2UgYW5kIHNlbmQgVjIgKGJ0dywgSSBub3Rp
Y2Ugc29tZSB0eXBvcyBpbiB0aGUgY29tbWl0IGxvZywNCj4gcGxlYXNlIHRyeSB0byBmaXggdGhl
bSBhcyB3ZWxsKS4NCg0KU3VyZS4NCg0KVGhhbmtzDQpaaGFuZyBDaGVuDQoNCj4gDQo+IFRoYW5r
cw0KDQo=

