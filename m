Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC55CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819A9206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819A9206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCg3L-0003G5-OG
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jCg2k-0002rY-5Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jCg2i-0006LI-6A
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:51:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:56059)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jCg2h-00069z-UV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:51:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 01:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; d="scan'208";a="416234220"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 13 Mar 2020 01:51:38 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 01:51:24 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Mar 2020 16:51:21 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 13 Mar 2020 16:51:21 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Laurent Vivier <laurent@vivier.eu>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH] configure: Fix configure error.
Thread-Topic: [PATCH] configure: Fix configure error.
Thread-Index: AQHV+QWoCV1IbU1BsEWn7GP9oLZwEKhFp6aAgACPL3A=
Date: Fri, 13 Mar 2020 08:51:21 +0000
Message-ID: <3fdff67c4e4047859c0e8aa183bd53d9@intel.com>
References: <20200313065525.31722-1-chen.zhang@intel.com>
 <e240baab-18b8-94b9-7ed5-e7ec9daed489@vivier.eu>
In-Reply-To: <e240baab-18b8-94b9-7ed5-e7ec9daed489@vivier.eu>
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
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBWaXZpZXIg
PGxhdXJlbnRAdml2aWVyLmV1Pg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDEzLCAyMDIwIDQ6MTgg
UE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IHFlbXUtZGV2IDxx
ZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPg0KPiBDYzogWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdt
YWlsLmNvbT47IERyIC4gRGF2aWQgQWxhbiBHaWxiZXJ0DQo+IDxkZ2lsYmVydEByZWRoYXQuY29t
PjsgSnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gY29uZmlndXJlOiBGaXggY29uZmlndXJlIGVycm9yLg0KPiANCj4gTGUgMTMvMDMvMjAy
MCDDoCAwNzo1NSwgWmhhbmcgQ2hlbiBhIMOpY3JpdMKgOg0KPiA+IEZyb206IFpoYW5nIENoZW4g
PGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gV2hlbiBydW4gdGhlIC4vY29uZmlndXJl
IHdpbGwgYWx3YXlzIGdldCB0aGlzIGVycm9yOg0KPiA+IFVua25vd24gb3B0aW9uIC0tZXhpc3QN
Cj4gPg0KPiA+IEl0IGNhdXNlZCBieSB0aGlzIHBhdGNoOg0KPiA+IGNvbW1pdCAzYTY3ODQ4MTM0
ZDBjMDdkYTQ5MDMzZjllZDA4YmYwZGRlZWMwYzZkDQo+ID4gQXV0aG9yOiBKdWFuIFF1aW50ZWxh
IDxxdWludGVsYUByZWRoYXQuY29tPg0KPiA+IERhdGU6ICAgVHVlIERlYyAxNyAyMToxNToyNCAy
MDE5ICswMTAwDQo+ID4NCj4gPiAgICAgY29uZmlndXJlOiBFbmFibGUgdGVzdCBhbmQgbGlicyBm
b3IgenN0ZA0KPiA+DQo+ID4gICAgIEFkZCBpdCB0byBzZXZlcmFsIGJ1aWxkIHN5c3RlbXMgdG8g
bWFrZSB0ZXN0aW5nIGdvb2QuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBDaGVuIDxj
aGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgY29uZmlndXJlIHwgMiArLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9jb25maWd1cmUNCj4gPiBpbmRleCAzYzc0NzAwOTZm
Li4zMDU1OTFmN2UwIDEwMDc1NQ0KPiA+IC0tLSBhL2NvbmZpZ3VyZQ0KPiA+ICsrKyBiL2NvbmZp
Z3VyZQ0KPiA+IEBAIC0yNDc1LDcgKzI0NzUsNyBAQCBmaQ0KPiA+ICAjIHpzdGQgY2hlY2sNCj4g
Pg0KPiA+ICBpZiB0ZXN0ICIkenN0ZCIgIT0gIm5vIiA7IHRoZW4NCj4gPiAtICAgIGlmICRwa2df
Y29uZmlnIC0tZXhpc3QgbGlienN0ZCA7IHRoZW4NCj4gPiArICAgIGlmICRwa2dfY29uZmlnIC0t
ZXhpc3RzIGxpYnpzdGQgOyB0aGVuDQo+ID4gICAgICAgICAgenN0ZF9jZmxhZ3M9IiQoJHBrZ19j
b25maWcgLS1jZmxhZ3MgbGlienN0ZCkiDQo+ID4gICAgICAgICAgenN0ZF9saWJzPSIkKCRwa2df
Y29uZmlnIC0tbGlicyBsaWJ6c3RkKSINCj4gPiAgICAgICAgICBMSUJTPSIkenN0ZF9saWJzICRM
SUJTIg0KPiA+DQo+IA0KPiBKdWFuIGFscmVhZHkgc2VudCBhIHBhdGNoIHRvIGZpeCB0aGF0Og0K
PiANCj4gW1BBVENIIHYyXSBjb25maWd1cmU6IEltcHJvdmUgenN0ZCB0ZXN0DQo+IGh0dHBzOi8v
cGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMDExMTQzMS4xNzMxNTEtMS0NCj4gcXVpbnRlbGFAcmVk
aGF0LmNvbS8NCg0KT0ssIExvb2tzIGhhdmVuJ3QgbWVyZ2VkIHRvIHVwc3RyZWFtLg0KDQpUaGFu
a3MNClpoYW5nIENoZW4NCg0KPiANCj4gVGhhbmtzLA0KPiBMYXVyZW50DQo=

