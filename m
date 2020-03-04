Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006C5214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006C5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9P42-0006Kc-4V
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1j9P3N-0005sU-4S
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1j9P3L-0004TZ-Ho
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:06:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:29964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1j9P3L-0004FW-8E
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:06:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 00:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; d="scan'208";a="229241479"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 04 Mar 2020 00:06:46 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 4 Mar 2020 00:06:46 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Mar 2020 16:06:44 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 4 Mar 2020 16:06:44 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>
Subject: RE: [PATCH V4 0/5] Introduce Advanced Watch Dog module
Thread-Topic: [PATCH V4 0/5] Introduce Advanced Watch Dog module
Thread-Index: AQHVtNkQRvIivFPjlkOOUrHE3VnstKfevUyAgBKjcBCAASn2AIAjdzswgACuZwCADSPFAIAUuFaA
Date: Wed, 4 Mar 2020 08:06:44 +0000
Message-ID: <679426098de74479a19c2287c68785c4@intel.com>
References: <20191217124554.30818-1-chen.zhang@intel.com>
 <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
 <0502a0db0a17484c9220b3a63c40b397@intel.com>
 <08a1a225-52c1-4e6c-85f7-fcf6612b5383@redhat.com>
 <3049425105b94f6cb9cd846c84c95a84@intel.com>
 <783bac16-0e4d-f027-3e4a-b6fff500c244@redhat.com>
 <c6564993-ec06-7fe1-137d-956f3d554e74@intel.com>
In-Reply-To: <c6564993-ec06-7fe1-137d-956f3d554e74@intel.com>
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAwLzVdIEludHJvZHVjZSBBZHZhbmNlZCBXYXRj
aCBEb2cgbW9kdWxlDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IE9uIDIwMjAvMS8xOSDkuIvljYg1OjEw
LCBaaGFuZywgQ2hlbiB3cm90ZToNCj4gPj4+PiBIaX4NCj4gPj4+Pg0KPiA+Pj4+IEFueW9uZSBo
YXZlIGNvbW1lbnRzIGFib3V0IHRoaXMgbW9kdWxlPw0KPiA+Pj4gSGkgQ2hlbjoNCj4gPj4+DQo+
ID4+PiBJIHdpbGwgdGFrZSBhIGxvb2sgYXQgdGhpcyBzZXJpZXMuDQo+ID4+IFNvcnJ5IGZvciBz
bG93IHJlcGx5IGR1ZSB0byBDTlkgYW5kIGV4dGVuZCBsZWF2ZS4NCj4gPj4gT0ssIHdhaXRpbmcg
eW91ciBjb21tZW50c34gVGhhbmtzfg0KPiA+Pg0KPiA+Pj4gVHdvIGdlbmVyYWwgcXVlc3Rpb25z
Og0KPiA+Pj4NCj4gPj4+IC0gaWYgaXQgY2FuIGRldGVjdCBtb3JlIHRoYW4gbmV0d29yayBzdGFs
bCwgaXQgc2hvdWxkIG5vdCBiZWxvbmcgdG8NCj4gPj4+IC9uZXQNCj4gPj4gVGhpcyBtb2R1bGUg
dXNlIG5ldHdvcmsgY29ubmVjdGlvbiBzdGF0dXMgdG8gZGV0ZWN0IGFsbCB0aGUgaXNzdWUoSG9z
dCB0bw0KPiBHdWVzdC9Ib3N0IHRvIEhvc3QvSG9zdCB0byBBZG1pbi4uLikuDQo+ID4+IFRoZSB0
YXJnZXQgaXMgbW9yZSB0aGFuIG5ldHdvcmsgYnV0IGFsbCB1c2UgbmV0d29yayB3YXkuIFNvIGl0
IGlzIGxvb2tzIGENCj4gdHJpY2t5IHByb2JsZW0uDQo+ID4NCj4gPiBPay4NCj4gPg0KPiA+DQo+
ID4+PiAtIG5lZWQgdG8gY29udmluY2UgbGlidmlydCBndXlzIGZvciB0aGlzIHByb3Bvc2FsLCBz
aW5jZSB1c3VhbGx5DQo+ID4+PiBpdCdzIHRoZSBkdXR5IG9mIHVwcGVyIGxheWVyIGluc3RlYWQg
b2YgcWVtdSBpdHNlbGYNCj4gPj4+DQo+ID4+IFllcywgSXQgbG9va3MgYSB1cHBlciBsYXllciBy
ZXNwb25zaWJpbGl0eSwgYnV0IEluIHRoZSBjb3ZlciBsYXR0ZXIgSSBoYXZlDQo+IGV4cGxhaW5l
ZCB0aGUgcmVhc29uIHdoeSB3ZSBuZWVkIHRoaXMgaW4gUWVtdS4NCj4gPj4gICAgdHJ5IHRvIG1h
a2UgdGhpcyBtb2R1bGUgYXMgc2ltcGxlIGFzIHBvc3NpYmxlLiBUaGlzIG1vZHVsZSBnaXZlIHVw
cGVyDQo+IGxheWVyIHNvZnR3YXJlIGEgbmV3IHdheSB0byBjb25uZWN0L21vbml0b3JpbmcgUWVt
dS4NCj4gPj4gQW5kIGR1ZSB0byBhbGwgdGhlIENPTE8gY29kZSBpbXBsZW1lbnQgaW4gUWVtdSBz
aWRlLCBNYW55IGN1c3RvbWVyDQo+ID4+IHdhbnQgdG8gdXNlIHRoaXMgRlQgc29sdXRpb24gd2l0
aG91dCBvdGhlciBkZXBlbmRlbmNpZXMsIGl0IGlzIHZlcnkgZWFzeSB0bw0KPiBpbnRlZ3JhdGVk
IHRvIHJlYWwgcHJvZHVjdC4NCj4gPj4NCj4gPj4gVGhhbmtzDQo+ID4+IFpoYW5nIENoZW4NCj4g
Pg0KPiA+IEkgd291bGQgbGlrZSB0byBoZWFyIGZyb20gbGlidmlydCBhYm91dCBzdWNoIGRlc2ln
bi4NCj4gDQo+IA0KPiBIaSBKYXNvbiwNCj4gDQo+IE9LLiBJIGFkZCB0aGUgbGlidmlydCBtYWls
aW5nIGxpc3QgaW4gdGhpcyB0aHJlYWQuDQo+IA0KPiBUaGUgZnVsbCBtYWlsIGRpc2N1c3Npb24g
YW5kIHBhdGNoZXM6DQo+IA0KPiBodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1s
L3FlbXUtZGV2ZWwvMjAyMC0wMi9tc2cwMjYxMS5odG1sDQo+IA0KPiANCj4gQnkgdGhlIHdheSwg
SSBub3RpY2VkIEVyaWMgaXMgbGlidmlydCBtYWludGlhbmVyLg0KPiANCj4gSGkgRXJpYyBhbmQg
UGFvbG8sIENhbiB5b3UgZ2l2ZSBzb21lIGNvbW1lbnRzIGFib3V0IHRoaXMgc2VyaWVzPw0KPiAN
Cj4gDQoNCk5vIG5ld3MgZm9yIGEgd2hpbGUuLi4NCldlIGFscmVhZHkgaGF2ZSBzb21lIHVzZXJz
KENsb3VkIFNlcnZpY2UgUHJvdmlkZXIpIHRyeSB0byB1c2UgaXMgbW9kdWxlIGluIHRoZWlyIHBy
b2R1Y3QuDQpCdXQgdGhleSBhbHNvIG5lZWQgdG8gZm9sbG93IHRoZSBRZW11IHVwc3RyZWFtIGNv
ZGUuDQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQoNCj4gVGhhbmtzDQo+IA0KPiBaaGFuZyBDaGVu
DQo+IA0KPiANCj4gPg0KPiA+IFRoYW5rcw0KPiA+DQoNCg==

