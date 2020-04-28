Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6A2C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF3D206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF3D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSpy-0006r9-Cd
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTSkG-0000ng-5w
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTSh7-0003GW-4P
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:06:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:50074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jTSh5-00039U-Ul
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:02:48 -0400
IronPort-SDR: zwkNwWpFLrvtjGu3TgbRCdZRlNf7chbY5EnnVDXP2iNoFGMNLKOXZL18R0clHqQroF+6OMj4Ds
 ubOLV1QhoBBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 09:02:44 -0700
IronPort-SDR: /eZuulpYd3j+4daqGFUMK4nitTM663T7mjHb2eIjO+NXfES7dcoZxiUf5v1GYBQsTM4K+v2L5R
 lUCkJLpGVjhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; d="scan'208";a="367538602"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2020 09:02:41 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Apr 2020 09:02:40 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.248]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.25]) with mapi id 14.03.0439.000;
 Tue, 28 Apr 2020 09:02:40 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/3] account for NVDIMM nodes during SRAT generation
Thread-Topic: [PATCH 0/3] account for NVDIMM nodes during SRAT generation
Thread-Index: AQHWHPxhIv/dZlNKYkaQJpWbPC6PXaiOSSIAgADfH4A=
Date: Tue, 28 Apr 2020 16:02:40 +0000
Message-ID: <abf42131fec08836004e4b3642d36cc0ce9abca4.camel@intel.com>
References: <158804184249.15667.634657454454879088@39012742ff91>
In-Reply-To: <158804184249.15667.634657454454879088@39012742ff91>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D9FAC84B4F3C24AB20FCF3E707DD793@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=vishal.l.verma@intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 12:02:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDIwLTA0LTI3IGF0IDE5OjQ0IC0wNzAwLCBuby1yZXBseUBwYXRjaGV3Lm9yZyB3
cm90ZToNCj4gUGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODAx
MjgxMC4xMDg3Ny0xLXZpc2hhbC5sLnZlcm1hQGludGVsLmNvbS8NClsuLl0NCj4gDQo+ID09PSBP
VVRQVVQgQkVHSU4gPT09DQo+IDEvMyBDaGVja2luZyBjb21taXQgMDhiN2VlNWU3ZGRmIChkaWZm
cy1hbGxvd2VkOiBhZGQgdGhlIFNSQVQgQU1MIHRvDQo+IGRpZmZzLWFsbG93ZWQpDQo+IDIvMyBD
aGVja2luZyBjb21taXQgZGNjOTZlYjk3ZDQ2IChody9hY3BpLWJ1aWxkOiBhY2NvdW50IGZvciBO
VkRJTU0NCj4gbnVtYSBub2RlcyBpbiBTUkFUKQ0KPiBFUlJPUjogRG8gbm90IGFkZCBleHBlY3Rl
ZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cNCj4gaW5zdHJ1Y3Rpb25zIGluIHRl
c3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0ZXN0cy9xdGVzdC9iaW9zLQ0KPiB0
YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBhbmQgaHcvaTM4Ni9hY3BpLWJ1aWxkLmMgZm91bmQN
Cj4gDQo+IEVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0aGVyIHdpdGggdGVz
dHMsIGZvbGxvdw0KPiBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVz
dC5jOiBib3RoIHRlc3RzL3F0ZXN0L2Jpb3MtDQo+IHRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5o
IGFuZCBody9pMzg2L2FjcGktYnVpbGQuYyBmb3VuZA0KDQpJJ20gbm90IHN1cmUgSSBmb2xsb3cg
dGhlc2UgZXJyb3JzIC0gSSB0aGluayBJIGZvbGxvd2VkIHRoZSBpbnN0cnVjdGlvbnMNCmluIGJp
b3MtdGFibGVzLXRlc3QuYyBleGFjdGx5Li4gRGlkIEkgbWlzcyBzb21ldGhpbmc/DQoNCj4gDQo+
IHRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMzIgbGluZXMgY2hlY2tlZA0KPiANCj4gUGF0
Y2ggMi8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMNCj4gYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlDQo+IENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuDQo+IA0KPiAzLzMgQ2hlY2tp
bmcgY29tbWl0IDM0YzU5ZDNhMDIzMiAodGVzdHMvYWNwaTogdXBkYXRlIGV4cGVjdGVkIFNSQVQN
Cj4gZmlsZXMpDQo+IEVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0aGVyIHdp
dGggdGVzdHMsIGZvbGxvdw0KPiBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10YWJs
ZXMtdGVzdC5jOiBib3RoDQo+IHRlc3RzL2RhdGEvYWNwaS9wYy9TUkFULmRpbW1weG0gYW5kIGh3
L2kzODYvYWNwaS1idWlsZC5jIGZvdW5kDQo+IA0KPiBFUlJPUjogRG8gbm90IGFkZCBleHBlY3Rl
ZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cNCj4gaW5zdHJ1Y3Rpb25zIGluIHRl
c3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aA0KPiB0ZXN0cy9kYXRhL2FjcGkvcTM1
L1NSQVQuZGltbXB4bSBhbmQgaHcvaTM4Ni9hY3BpLWJ1aWxkLmMgZm91bmQNCj4gDQo+IEVSUk9S
OiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0aGVyIHdpdGggdGVzdHMsIGZvbGxvdw0K
PiBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOiBib3RoIHRl
c3RzL3F0ZXN0L2Jpb3MtDQo+IHRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oIGFuZCBody9pMzg2
L2FjcGktYnVpbGQuYyBmb3VuZA0KPiANCj4gRVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQgZmls
ZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93DQo+IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9x
dGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVzdHMvcXRlc3QvYmlvcy0NCj4gdGFibGVz
LXRlc3QtYWxsb3dlZC1kaWZmLmggYW5kIGh3L2kzODYvYWNwaS1idWlsZC5jIGZvdW5kDQo+IA0K
PiB0b3RhbDogNCBlcnJvcnMsIDAgd2FybmluZ3MsIDEgbGluZXMgY2hlY2tlZA0KPiANCj4gUGF0
Y2ggMy8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMNCj4gYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlDQo+IENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuDQo+IA0KPiA9PT0gT1VUUFVU
IEVORCA9PT0NCj4gDQo+IFRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxDQo+IA0KPiAN
Cj4gVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdA0KPiBodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDQyODAxMjgxMC4xMDg3Ny0xLXZpc2hhbC5sLnZlcm1hQGludGVsLmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4NCj4gLS0tDQo+IEVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4NCj4gUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20NCg==

