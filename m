Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F09CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254B52084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254B52084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNF1r-00076T-NW
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iNEW5-0007ca-CY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iNEW0-00059O-NN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:09:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:22916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iNEVz-00052m-Su
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:09:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 04:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; d="scan'208";a="188218613"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga007.jf.intel.com with ESMTP; 23 Oct 2019 04:09:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 04:09:07 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 04:09:07 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Oct 2019 04:09:06 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.166]) with mapi id 14.03.0439.000;
 Wed, 23 Oct 2019 19:09:05 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
Thread-Topic: [RFC PATCH 1/4] net/awd.c: Introduce Advanced Watch Dog module
 framework
Thread-Index: AQHVhBTjxTqcvh6BcUahjVnjYn1+nKdnlByAgACGwZA=
Date: Wed, 23 Oct 2019 11:09:05 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78062C3894@shsmsx102.ccr.corp.intel.com>
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <20191016112209.9024-2-chen.zhang@intel.com>
 <e294876e-d26b-b401-78ab-487e1b44685f@redhat.com>
In-Reply-To: <e294876e-d26b-b401-78ab-487e1b44685f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmM4ZTI3MTktMzUxYS00OWFkLWIwZmUtNjY5YTVjNTA4ZTViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQUVUbzV1clFpclpSOVBCT3l0WjFzVUF1VTI2VUt0K2xiTW00QnJaYXh6U3cwRU9RSW52WStRYmVpYUd0NTF2OCJ9
x-originating-ip: [10.239.127.40]
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIz
LCAyMDE5IDc6MDEgUE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47
IEphc29uIFdhbmcNCj4gPGphc293YW5nQHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPjsgcWVtdS0NCj4gZGV2IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+
IENjOiBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JG
QyBQQVRDSCAxLzRdIG5ldC9hd2QuYzogSW50cm9kdWNlIEFkdmFuY2VkIFdhdGNoIERvZw0KPiBt
b2R1bGUgZnJhbWV3b3JrDQo+IA0KPiBIaSBDaGVuLA0KPiANCj4gT24gMTAvMTYvMTkgMToyMiBQ
TSwgWmhhbmcgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGlu
dGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlIGEgbmV3IG1vZHVsZSBuYW1l
ZCBBZHZhbmNlZCBXYXRjaCBEb2csIGFuZA0KPiA+IGRlZmluZWQgdGhlIGlucHV0IGFuZCBvdXRw
dXQgcGFyYW1ldGVyLiBBV0QgdXNlIHN0YW5kYXJkIGNoYXJkZXYgYXMNCj4gPiB0aGUgd2F5IG9m
IGNvbW11bmljYXRpb25nIHdpdGggdGhlIG91dHNpZGUgd29ybGQuDQo+ID4gRGVtbyBjb21tYW5k
Og0KPiA+IC1vYmplY3QNCj4gPiBhZHZhbmNlZC0NCj4gd2F0Y2hkb2csaWQ9aGVhcnQxLHNlcnZl
cj1vbixhd2Rfbm9kZT1oMSxub3RpZmljYXRpb25fbm9kZT1oZQ0KPiA+IGFydGJlYXQwLG9wdF9z
Y3JpcHQ9b3B0X3NjcmlwdF9wYXRoLGlvdGhyZWFkPWlvdGhyZWFkMSxwdWxzZV9pbnRlcnZhbD0N
Cj4gPiAxMDAwLHRpbWVvdXQ9NTAwMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hl
biA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBuZXQvTWFrZWZpbGUub2Jq
cyB8ICAgMSArDQo+ID4gICBuZXQvYXdkLmMgICAgICAgICB8IDI2MQ0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBxZW11LW9wdGlvbnMuaHgg
ICB8ICAgNiArKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyNjggaW5zZXJ0aW9ucygrKQ0KPiA+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IG5ldC9hd2QuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL25l
dC9NYWtlZmlsZS5vYmpzIGIvbmV0L01ha2VmaWxlLm9ianMgaW5kZXgNCj4gPiBjNWQwNzZkMTlj
Li4xMzliMTM5NGU5IDEwMDY0NA0KPiA+IC0tLSBhL25ldC9NYWtlZmlsZS5vYmpzDQo+ID4gKysr
IGIvbmV0L01ha2VmaWxlLm9ianMNCj4gPiBAQCAtMTksNiArMTksNyBAQCBjb21tb24tb2JqLXkg
Kz0gY29sby1jb21wYXJlLm8NCj4gPiAgIGNvbW1vbi1vYmoteSArPSBjb2xvLm8NCj4gPiAgIGNv
bW1vbi1vYmoteSArPSBmaWx0ZXItcmV3cml0ZXIubw0KPiA+ICAgY29tbW9uLW9iai15ICs9IGZp
bHRlci1yZXBsYXkubw0KPiA+ICtjb21tb24tb2JqLXkgKz0gYXdkLm8NCj4gQ2FuIHlvdSBhZGQg
YSBuZXQvS2NvbmZpZyBmaWxlIGludHJvZHVjaW5nIHRoZSBBRFZBTkNFRF9XQVRDSERPRw0KPiBz
ZWxlY3Rvcj8NCj4gDQo+IGNvbmZpZyBDT0xPX0FEVkFOQ0VEX1dBVENIRE9HDQo+ICAgICAgYm9v
bA0KPiAgICAgIGRlZmF1bHQgbg0KPiANCj4gVGhlbiB1c2UgaGVyZToNCj4gDQo+ICAgICAgY29t
bW9uLW9iai0kKENPTE9fQURWQU5DRURfV0FUQ0hET0cpICs9IGF3ZC5vDQo+IA0KDQpTdXJlLCBi
dXQgQVdEIGlzIGEgdW5pdmVyc2FsIG1vZHVsZSwgIENPTE8gaXMganVzdCB0aGUgZmlyc3QgdXNl
ci4NCk1heWJlIHVzZSAiY29uZmlnIEFEVkFOQ0VEX1dBVENIRE9HIiBpcyBiZXR0ZXIuDQoNClRo
YW5rcw0KWmhhbmcgQ2hlbg0KDQo+IFRoYW5rcywNCj4gDQo+IFBoaWwuDQo+IA0KPiA+DQo+ID4g
ICB0YXAtb2JqLSQoQ09ORklHX0xJTlVYKSA9IHRhcC1saW51eC5vDQo+ID4gICB0YXAtb2JqLSQo
Q09ORklHX0JTRCkgPSB0YXAtYnNkLm8NCj4gWy4uLl0NCg==

