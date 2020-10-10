Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7AFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6F3223BD
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 16:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6F3223BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRHeV-0004vk-Qu
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 12:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kRHdd-0004UV-Qi; Sat, 10 Oct 2020 12:22:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:64260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kRHdb-0005Zm-8t; Sat, 10 Oct 2020 12:22:29 -0400
IronPort-SDR: y60BstR+gyVhrVACtB6QzsWKOT9Yw9bNaV9aAmwEbFCtUhlEDD57TdJlrDHC2aXQmnGm14lfYT
 8FhE7iUmy2Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9770"; a="250286057"
X-IronPort-AV: E=Sophos;i="5.77,359,1596524400"; d="scan'208";a="250286057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2020 09:22:21 -0700
IronPort-SDR: PogaIxRRd1ze8U2UPT3Li/AgkLUQTnoxLaOcuDsdJqYUMO2viw3NCijno82VOrR7LLsFcl1AYQ
 uGvX/OYnqNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,359,1596524400"; d="scan'208";a="520122762"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2020 09:22:21 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 10 Oct 2020 09:22:20 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 11 Oct 2020 00:22:18 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Sun, 11 Oct 2020 00:22:18 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Pan Nengyuan <pannengyuan@huawei.com>, Li Qiang <liq3ea@gmail.com>
Subject: RE: [PATCH] net/filter-rewriter: destroy g_hash_table in
 colo_rewriter_cleanup
Thread-Topic: [PATCH] net/filter-rewriter: destroy g_hash_table in
 colo_rewriter_cleanup
Thread-Index: AQHWgoxAN7Z5W4Oo6kad3S1TmqXujalYsCSAgDesHgCAAOC18A==
Date: Sat, 10 Oct 2020 16:22:18 +0000
Message-ID: <b2e6f80cf0f04b39a7ebeb96a572fe7c@intel.com>
References: <20200904134908.1396-1-pannengyuan@huawei.com>
 <CAKXe6SJL8Y2frr1-d06=Ovoo=45+kJSGM2vhDGFeJf4YuUfN4A@mail.gmail.com>
 <e327c596-08bf-655b-5b2b-aaeb4fcbdb2e@huawei.com>
In-Reply-To: <e327c596-08bf-655b-5b2b-aaeb4fcbdb2e@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 12:22:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Qemu Developers <qemu-devel@nongnu.org>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBhbHJlYWR5IHF1ZXVlZCB0aGlzIHBhdGNoIHRvIENPTE8gcHJveHkgdHJlZSwgdGhlbiBJIHdp
bGwgc2VuZCBhIHNlcmllcyB0byBKYXNvbi4NCg0KVGhhbmtzDQpDaGVuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFuIE5lbmd5dWFuIDxwYW5uZW5neXVhbkBodWF3
ZWkuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxMCwgMjAyMCA2OjU1IFBNDQo+IFRv
OiBMaSBRaWFuZyA8bGlxM2VhQGdtYWlsLmNvbT4NCj4gQ2M6IFFlbXUgRGV2ZWxvcGVycyA8cWVt
dS1kZXZlbEBub25nbnUub3JnPjsgWmhhbmcsIENoZW4NCj4gPGNoZW4uemhhbmdAaW50ZWwuY29t
PjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47DQo+IHpoYW5naGFpbGlhbmcgPHpo
YW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IENoZW4gUXVuDQo+IDxrdWhuLmNoZW5xdW5A
aHVhd2VpLmNvbT47IHFlbXUtdHJpdmlhbEBub25nbnUub3JnOyBMYXVyZW50IFZpdmllcg0KPiA8
bGF1cmVudEB2aXZpZXIuZXU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldC9maWx0ZXItcmV3
cml0ZXI6IGRlc3Ryb3kgZ19oYXNoX3RhYmxlIGluDQo+IGNvbG9fcmV3cml0ZXJfY2xlYW51cA0K
PiANCj4gcGluZyENCj4gDQo+IE1heWJlIG1pc3NlZCB0byBxdWV1ZT8NCj4gDQo+IE9uIDIwMjAv
OS81IDg6NDQsIExpIFFpYW5nIHdyb3RlOg0KPiA+IFBhbiBOZW5neXVhbiA8cGFubmVuZ3l1YW5A
aHVhd2VpLmNvbT4g5LqOMjAyMOW5tDnmnIg05pel5ZGo5LqUIOS4iw0KPiDljYgzOjIz5YaZ6YGT
77yaDQo+ID4+DQo+ID4+IHMtPmNvbm5lY3Rpb25fdHJhY2tfdGFibGUgZm9yZ290IHRvIGRlc3Ry
b3kgaW4gY29sb19yZXdyaXRlcl9jbGVhbnVwLiBGaXgNCj4gaXQuDQo+ID4+DQo+ID4+IFJlcG9y
dGVkLWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogUGFuIE5lbmd5dWFuIDxwYW5uZW5neXVhbkBodWF3ZWkuY29tPg0KPiA+DQo+ID4g
UmV2aWV3ZWQtYnk6IExpIFFpYW5nIDxsaXEzZWFAZ21haWwuY29tPg0KPiA+DQo+ID4+IC0tLQ0K
PiA+PiAgbmV0L2ZpbHRlci1yZXdyaXRlci5jIHwgMiArKw0KPiA+PiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvbmV0L2ZpbHRlci1yZXdy
aXRlci5jIGIvbmV0L2ZpbHRlci1yZXdyaXRlci5jIGluZGV4DQo+ID4+IDFhYWFkMTAxYjYuLjlm
ZjM2NmQ0NGYgMTAwNjQ0DQo+ID4+IC0tLSBhL25ldC9maWx0ZXItcmV3cml0ZXIuYw0KPiA+PiAr
KysgYi9uZXQvZmlsdGVyLXJld3JpdGVyLmMNCj4gPj4gQEAgLTM3Niw2ICszNzYsOCBAQCBzdGF0
aWMgdm9pZCBjb2xvX3Jld3JpdGVyX2NsZWFudXAoTmV0RmlsdGVyU3RhdGUNCj4gKm5mKQ0KPiA+
PiAgICAgICAgICBmaWx0ZXJfcmV3cml0ZXJfZmx1c2gobmYpOw0KPiA+PiAgICAgICAgICBnX2Zy
ZWUocy0+aW5jb21pbmdfcXVldWUpOw0KPiA+PiAgICAgIH0NCj4gPj4gKw0KPiA+PiArICAgIGdf
aGFzaF90YWJsZV9kZXN0cm95KHMtPmNvbm5lY3Rpb25fdHJhY2tfdGFibGUpOw0KPiA+PiAgfQ0K
PiA+Pg0KPiA+PiAgc3RhdGljIHZvaWQgY29sb19yZXdyaXRlcl9zZXR1cChOZXRGaWx0ZXJTdGF0
ZSAqbmYsIEVycm9yICoqZXJycCkNCj4gPj4gLS0NCj4gPj4gMi4xOC4yDQo+ID4+DQo+ID4+DQo=

