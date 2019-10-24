Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB074CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8B02075C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8B02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTkH-0005yR-LL
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iNTTp-0007M4-Qv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iNTTm-0003KD-F6
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:08:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:4040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iNTTm-0003G1-6v
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:08:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 20:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,223,1569308400"; d="scan'208";a="223411769"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 23 Oct 2019 20:07:58 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 20:07:58 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 20:07:57 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX152.ccr.corp.intel.com ([10.239.6.52]) with mapi id 14.03.0439.000;
 Thu, 24 Oct 2019 11:07:56 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
Thread-Topic: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
Thread-Index: AQHVhBTjxTqcvh6BcUahjVnjYn1+nKdnlByAgACGwZD//4PCAIABhPHA
Date: Thu, 24 Oct 2019 03:07:55 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78062C4C7E@shsmsx102.ccr.corp.intel.com>
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <20191016112209.9024-2-chen.zhang@intel.com>
 <e294876e-d26b-b401-78ab-487e1b44685f@redhat.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78062C3894@shsmsx102.ccr.corp.intel.com>
 <bea650cd-b790-ba3c-3872-3b1af5682318@redhat.com>
In-Reply-To: <bea650cd-b790-ba3c-3872-3b1af5682318@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTA3ZGVhZDMtMTgyZS00OTMyLThkNzgtOThjNTk3NjI0MDliIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia1dLeXAyS3VRenNVRkFvT0RkQ1wvZzNjdTZmMWhkdU9kYm5ob3l2aHFDcFVlV2RaZ2JaQ1VEd0VuYzlSNUZrRWIifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIz
LCAyMDE5IDc6MzkgUE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47
IEphc29uIFdhbmcNCj4gPGphc293YW5nQHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPjsgcWVtdS0NCj4gZGV2IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+
IENjOiBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JG
QyBQQVRDSCAxLzRdIG5ldC9hd2QuYzogSW50cm9kdWNlIEFkdmFuY2VkIFdhdGNoIERvZw0KPiBt
b2R1bGUgZnJhbWV3b3JrDQo+IA0KPiBPbiAxMC8yMy8xOSAxOjA5IFBNLCBaaGFuZywgQ2hlbiB3
cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogUGhpbGlw
cGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNk
YXksIE9jdG9iZXIgMjMsIDIwMTkgNzowMSBQTQ0KPiA+PiBUbzogWmhhbmcsIENoZW4gPGNoZW4u
emhhbmdAaW50ZWwuY29tPjsgSmFzb24gV2FuZw0KPiA+PiA8amFzb3dhbmdAcmVkaGF0LmNvbT47
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBxZW11LQ0KPiBkZXYNCj4gPj4g
PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4gQ2M6IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBn
bWFpbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDEvNF0gbmV0L2F3ZC5jOiBJ
bnRyb2R1Y2UgQWR2YW5jZWQgV2F0Y2ggRG9nDQo+ID4+IG1vZHVsZSBmcmFtZXdvcmsNCj4gPj4N
Cj4gPj4gSGkgQ2hlbiwNCj4gPj4NCj4gPj4gT24gMTAvMTYvMTkgMToyMiBQTSwgWmhhbmcgQ2hl
biB3cm90ZToNCj4gPj4+IEZyb206IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0K
PiA+Pj4NCj4gPj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlIGEgbmV3IG1vZHVsZSBuYW1lZCBBZHZh
bmNlZCBXYXRjaCBEb2csIGFuZA0KPiA+Pj4gZGVmaW5lZCB0aGUgaW5wdXQgYW5kIG91dHB1dCBw
YXJhbWV0ZXIuIEFXRCB1c2Ugc3RhbmRhcmQgY2hhcmRldiBhcw0KPiA+Pj4gdGhlIHdheSBvZiBj
b21tdW5pY2F0aW9uZyB3aXRoIHRoZSBvdXRzaWRlIHdvcmxkLg0KPiA+Pj4gRGVtbyBjb21tYW5k
Og0KPiA+Pj4gLW9iamVjdA0KPiA+Pj4gYWR2YW5jZWQtDQo+ID4+IHdhdGNoZG9nLGlkPWhlYXJ0
MSxzZXJ2ZXI9b24sYXdkX25vZGU9aDEsbm90aWZpY2F0aW9uX25vZGU9aGUNCj4gPj4+IGFydGJl
YXQwLG9wdF9zY3JpcHQ9b3B0X3NjcmlwdF9wYXRoLGlvdGhyZWFkPWlvdGhyZWFkMSxwdWxzZV9p
bnRlcnZhDQo+ID4+PiBsPQ0KPiA+Pj4gMTAwMCx0aW1lb3V0PTUwMDANCj4gPj4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPj4+IC0t
LQ0KPiA+Pj4gICAgbmV0L01ha2VmaWxlLm9ianMgfCAgIDEgKw0KPiA+Pj4gICAgbmV0L2F3ZC5j
ICAgICAgICAgfCAyNjENCj4gPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+Pj4gICAgcWVtdS1vcHRpb25zLmh4ICAgfCAgIDYgKysNCj4gPj4+ICAg
IDMgZmlsZXMgY2hhbmdlZCwgMjY4IGluc2VydGlvbnMoKykNCj4gPj4+ICAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBuZXQvYXdkLmMNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvbmV0L01ha2VmaWxl
Lm9ianMgYi9uZXQvTWFrZWZpbGUub2JqcyBpbmRleA0KPiA+Pj4gYzVkMDc2ZDE5Yy4uMTM5YjEz
OTRlOSAxMDA2NDQNCj4gPj4+IC0tLSBhL25ldC9NYWtlZmlsZS5vYmpzDQo+ID4+PiArKysgYi9u
ZXQvTWFrZWZpbGUub2Jqcw0KPiA+Pj4gQEAgLTE5LDYgKzE5LDcgQEAgY29tbW9uLW9iai15ICs9
IGNvbG8tY29tcGFyZS5vDQo+ID4+PiAgICBjb21tb24tb2JqLXkgKz0gY29sby5vDQo+ID4+PiAg
ICBjb21tb24tb2JqLXkgKz0gZmlsdGVyLXJld3JpdGVyLm8NCj4gPj4+ICAgIGNvbW1vbi1vYmot
eSArPSBmaWx0ZXItcmVwbGF5Lm8NCj4gPj4+ICtjb21tb24tb2JqLXkgKz0gYXdkLm8NCj4gPj4g
Q2FuIHlvdSBhZGQgYSBuZXQvS2NvbmZpZyBmaWxlIGludHJvZHVjaW5nIHRoZSBBRFZBTkNFRF9X
QVRDSERPRw0KPiA+PiBzZWxlY3Rvcj8NCj4gPj4NCj4gPj4gY29uZmlnIENPTE9fQURWQU5DRURf
V0FUQ0hET0cNCj4gPj4gICAgICAgYm9vbA0KPiA+PiAgICAgICBkZWZhdWx0IG4NCj4gPj4NCj4g
Pj4gVGhlbiB1c2UgaGVyZToNCj4gPj4NCj4gPj4gICAgICAgY29tbW9uLW9iai0kKENPTE9fQURW
QU5DRURfV0FUQ0hET0cpICs9IGF3ZC5vDQo+ID4+DQo+ID4NCj4gPiBTdXJlLCBidXQgQVdEIGlz
IGEgdW5pdmVyc2FsIG1vZHVsZSwgIENPTE8gaXMganVzdCB0aGUgZmlyc3QgdXNlci4NCj4gPiBN
YXliZSB1c2UgImNvbmZpZyBBRFZBTkNFRF9XQVRDSERPRyIgaXMgYmV0dGVyLg0KPiANCj4gT2gg
SSBzZWUsIGJldHRlciB0aGVuLg0KPiANCj4gVGhlbiB3ZSBtaWdodCBhZGQgKGxhdGVyKQ0KPiAN
Cj4gICAgY29uZmlnIENPTE8NCj4gICAgICAgIC4uLg0KPiAgICAgICAgc2VsZWN0IEFEVkFOQ0VE
X1dBVENIRE9HDQo+IA0KDQpJIG5vdGljZWQgdGhhdCB3ZSBoYXZlbid0IHRoZSAibmV0L2tjb25m
aWciIGZpbGUsIHRoZSBBV0QgaXNuJ3QgYSBIVyBpbiB0aGUgaHcvbmV0Lg0KRG8geW91IG1lYW5z
IHdlIGNhbiBhZGQgdGhlIHNlbGVjdG9yIGluICJjb25maWd1cmF0aW9uIiBmaWxlPw0KV2UgY2Fu
IGFkZCBzb21lIHJlbGF0ZWQgY29uZmlndXJhdGlvbiBjb21tYW5kIGxpa2UgIi0tZW5hYmxlLWFk
dmFuY2VkLXdhdGNoZG9nIiBhbmQgZGVmYXVsdCBpcyAibm8iLg0KDQpUaGFua3MNClpoYW5nIENo
ZW4NCg0KPiBUaGFua3MhDQo+IA0KPiBQaGlsLg0KPiANCj4gPj4+ICAgIHRhcC1vYmotJChDT05G
SUdfTElOVVgpID0gdGFwLWxpbnV4Lm8NCj4gPj4+ICAgIHRhcC1vYmotJChDT05GSUdfQlNEKSA9
IHRhcC1ic2Qubw0KPiA+PiBbLi4uXQ0K

