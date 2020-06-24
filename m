Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1E0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F90620CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F90620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnvs9-0000VG-8L
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 23:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnvrP-0008Ef-Hx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:14:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:26997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jnvrM-0003EY-FL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:14:03 -0400
IronPort-SDR: O6I4KSuxUVwTEtddYK5odXF0II89TL2RsXLMn9UFJfkB9LSSNL2l+HJmNdqbOugB3IVYfTHXnv
 /EBUsNfvBZYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124567737"
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="124567737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 20:13:54 -0700
IronPort-SDR: D11Ep5ymVPAHU/ciH22Xur6MBsb/KFL/h17GxEErYDCsPIURCILMrNAORxWDewu1F3xj/6TZ0P
 8/fgpUu82ZCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,273,1589266800"; d="scan'208";a="452484586"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 20:13:54 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 23 Jun 2020 20:13:54 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 24 Jun 2020 11:13:51 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 24 Jun 2020 11:13:51 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Topic: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Index: AQHWD7P+xm/8Bq9SCE2KY4WVvkZ5vqiHGCMAgFkFkQCABcLnsP//vzCAgAHrdpA=
Date: Wed, 24 Jun 2020 03:13:51 +0000
Message-ID: <ad352186b43349f08b93ffa8ffbff525@intel.com>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <c8ce4348-d81c-1d10-ff82-74be39a03b5a@redhat.com>
 <20200619194611.057b48ed@luklap> <5660d3b43c8d4fb4ab0a42e0bf67eaa4@intel.com>
 <cb77d0c2-f3ee-2ba9-e495-3fc325eb122c@redhat.com>
In-Reply-To: <cb77d0c2-f3ee-2ba9-e495-3fc325eb122c@redhat.com>
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
Received-SPF: pass client-ip=192.55.52.151; envelope-from=chen.zhang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 23:13:55
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAyMywgMjAyMCAxOjU0IFBN
DQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMdWthcyBTdHJhdWIN
Cj4gPGx1a2Fzc3RyYXViMkB3ZWIuZGU+DQo+IENjOiBxZW11LWRldiA8cWVtdS1kZXZlbEBub25n
bnUub3JnPjsgWmhhbmcgQ2hlbg0KPiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAwLzJdIG5ldC9jb2xvLWNvbXBhcmUuYzogRXhwb3NlICJtYXhfcXVldWVfc2l6
ZSIgdG8NCj4gdXNlcnMgYW5kIGNsZWFuIHVwDQo+IA0KPiANCj4gT24gMjAyMC82LzIzIOS4iuWN
iDk6NDcsIFpoYW5nLCBDaGVuIHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEx1a2FzIFN0cmF1YiA8bHVrYXNzdHJhdWIyQHdlYi5kZT4NCj4g
Pj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjAsIDIwMjAgMTo0NyBBTQ0KPiA+PiBUbzogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gPj4gQ2M6IFpoYW5nLCBDaGVuIDxjaGVuLnpo
YW5nQGludGVsLmNvbT47IHFlbXUtZGV2IDxxZW11LQ0KPiA+PiBkZXZlbEBub25nbnUub3JnPjsg
WmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCAwLzJdIG5ldC9jb2xvLWNvbXBhcmUuYzogRXhwb3NlICJtYXhfcXVldWVfc2l6ZSINCj4gPj4g
dG8gdXNlcnMgYW5kIGNsZWFuIHVwDQo+ID4+DQo+ID4+IE9uIEZyaSwgMjQgQXByIDIwMjAgMTA6
MTk6NDggKzA4MDANCj4gPj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6
DQo+ID4+DQo+ID4+PiBPbiAyMDIwLzQvMTEg5LiK5Y2IMTE6MzgsIFpoYW5nIENoZW4gd3JvdGU6
DQo+ID4+Pj4gRnJvbTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+ID4+Pj4N
Cj4gPj4+PiBUaGlzIHNlcmllcyBtYWtlIGEgd2F5IHRvIGNvbmZpZyBDT0xPICJtYXhfcXVldWVf
c2l6ZSIgcGFyYW1ldGVycw0KPiA+Pj4+IGFjY29yZGluZyB0byB1c2VyJ3Mgc2NlbmFyaW9zIGFu
ZCBlbnZpcm9ubWVudHMgYW5kIGRvIHNvbWUgY2xlYW4gdXANCj4gPj4+PiBmb3INCj4gPj4gZGVz
Y3JpcHRpb25zLg0KPiA+Pj4+IFpoYW5nIENoZW4gKDIpOg0KPiA+Pj4+ICAgICBuZXQvY29sby1j
b21wYXJlLmM6IEV4cG9zZSBjb21wYXJlICJtYXhfcXVldWVfc2l6ZSIgdG8gdXNlcnMNCj4gPj4+
PiAgICAgcWVtdS1vcHRpb25zLmh4OiBDbGVhbiB1cCBhbmQgZml4IHR5cG8gZm9yIGNvbG8tY29t
cGFyZQ0KPiA+Pj4+DQo+ID4+Pj4gICAgbmV0L2NvbG8tY29tcGFyZS5jIHwgNDMNCj4gPj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+Pj4+ICAgIHFlbXUt
b3B0aW9ucy5oeCAgICB8IDMzICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0p
DQo+ID4+Pg0KPiA+Pj4gUXVldWVkIGZvciA1LjEuDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzDQo+ID4+
Pg0KPiA+Pj4NCj4gPj4gSGksDQo+ID4+IEl0IGxvb2tzIGxpa2UgdGhpcyBoYXNuJ3QgYmVlbiBt
ZXJnZWQuDQo+ID4gVGhhbmtzIEx1a2FzLg0KPiA+IEhpIEphc29uLCBJIGhhdmUgZG91YmxlIGNo
ZWNrZWQgb24gdXBzdHJlYW0sIGxvb2tzIG1pc3NlZCB0aGlzIHNlcmllcy4NCj4gPg0KPiA+IFRo
YW5rcw0KPiA+IFpoYW5nIENoZW4NCj4gDQo+IA0KPiBSaWdodCwgYnV0IHVuZm9ydHVuYXRlbHkg
aXQgY2FuJ3QgYmUgYXBwbGllZCBjbGVhbmx5IG9uIG1hc3Rlci4NCj4gDQo+IFBsZWFzZSBzZW5k
IGEgbmV3IHZlcnNpb24uDQo+IA0KPiBTb3JyeS4NCg0KSXQncyBPSywgSSBoYXZlIHNlbmQgVjIg
dmVyc2lvbiBvZiB0aGlzIHNlcmllcywgcGxlYXNlIG1lcmdlIGl0Lg0KDQpUaGFua3MNClpoYW5n
IENoZW4NCg0KPiANCj4gVGhhbmtzDQo+IA0KPiANCj4gPg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBM
dWthcyBTdHJhdWINCg0K

