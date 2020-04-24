Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B68C2BA19
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 01:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B3720715
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 01:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B3720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRn8J-0000nl-Ox
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 21:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRn7R-0000Bb-Uv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 21:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRn7O-000438-3Q
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 21:27:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:52634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRn7K-0003TC-PH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 21:26:59 -0400
IronPort-SDR: V+Rem/O4LtZnWKdvNqO0XQHklGSZGr8VqlLb1R7Q6WylqC20BS++nARuydA5O276+nc82DoeRq
 iCZwGv1J1q9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 18:26:52 -0700
IronPort-SDR: SRrcFVOItw1CVkRs1yFZjO7vHqwD9SDJuDxy0JdTMIt+RK86TWCOGCd1CNfqI7ai8j3XvtQUbB
 vjYHlbjdRiTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; d="scan'208";a="259645296"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga006.jf.intel.com with ESMTP; 23 Apr 2020 18:26:52 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 18:26:39 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 24 Apr 2020 09:26:37 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 24 Apr 2020 09:26:37 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Topic: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Index: AQHWD7P+xm/8Bq9SCE2KY4WVvkZ5vqiCyuwQgAMpKICAAIZ5EP//fRGAgACHWeA=
Date: Fri, 24 Apr 2020 01:26:37 +0000
Message-ID: <01035db9c1ac437585c5a9f3c5ecd895@intel.com>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <716ca2bcd9e64c37a79509c468e18485@intel.com>
 <18466058-4184-2c6e-d740-2a1479395506@redhat.com>
 <310162af410e43ea9e0d0a22012e1929@intel.com>
 <d5e9799e-49bc-82ee-4159-4a5602db015e@redhat.com>
In-Reply-To: <d5e9799e-49bc-82ee-4159-4a5602db015e@redhat.com>
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
Received-SPF: pass client-ip=192.55.52.93; envelope-from=chen.zhang@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 21:26:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDU6MDcg
UE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IHFlbXUtZGV2IDxx
ZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPg0KPiBDYzogWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdt
YWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIG5ldC9jb2xvLWNvbXBhcmUuYzog
RXhwb3NlICJtYXhfcXVldWVfc2l6ZSIgdG8NCj4gdXNlcnMgYW5kIGNsZWFuIHVwDQo+IA0KPiAN
Cj4gT24gMjAyMC80LzIzIOS4i+WNiDQ6NTksIFpoYW5nLCBDaGVuIHdyb3RlOg0KPiA+DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyMywgMjAyMCA0OjU0
IFBNDQo+ID4+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBxZW11LWRl
diA8cWVtdS0NCj4gPj4gZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4gQ2M6IFpoYW5nIENoZW4gPHpo
YW5nY2tpZEBnbWFpbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBuZXQvY29s
by1jb21wYXJlLmM6IEV4cG9zZSAibWF4X3F1ZXVlX3NpemUiDQo+ID4+IHRvIHVzZXJzIGFuZCBj
bGVhbiB1cA0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyMDIwLzQvMjMg5LiL5Y2IMzozMSwgWmhhbmcs
IENoZW4gd3JvdGU6DQo+ID4+PiBIaSBKYXNvbiwNCj4gPj4+DQo+ID4+PiBQbGVhc2UgcmV2aWV3
IHRoaXMgc2VyaWVzIHdoZW4geW91IGZyZWUuDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzDQo+ID4+PiBa
aGFuZyBDaGVuDQo+ID4+Pg0KPiA+PiBTdXJlLg0KPiA+Pg0KPiA+PiBJIHdvbmRlciBtYXliZSBp
dCdzIGJldHRlciBlLmcgeW91IGNhbiByZXZpZXcgYW5kIGNvbGxlY3QgdGhlIHBhdGNoZXMNCj4g
Pj4gdGhhdCBsb29rcyBnb29kIGFuZCBzZW5kIHRoZW0gdG8gbWUgcGVyaW9kaWNhbGx5Pw0KPiA+
IE9LLCBJIHdpbGwgcXVldWUgQ09MTyByZWxhdGVkIHBhdGNoIGFzIG9uZSBzZXJpZXMgdG8geW91
Lg0KPiA+IERvIEkgbmVlZCBzZW5kIGEgcHVsbCByZXF1ZXN0PyBvciBqdXN0IGEgYmlnIHBhdGNo
IHNldD8NCj4gDQo+IA0KPiBJIHByZWZlciBiaWcgcGF0Y2ggc2V0Lg0KDQpPSywgSSBnb3QgaXQu
DQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+IA0KPiA+DQo+ID4g
VGhhbmtzDQo+ID4gWmhhbmcgQ2hlbg0KPiA+DQo+ID4+IFRoYW5rcw0KDQo=

