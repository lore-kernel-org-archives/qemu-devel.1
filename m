Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F8CC31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C36C21855
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C36C21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyCUJ-0006sg-Cm
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiewen.yao@intel.com>) id 1hyCTZ-0006Bm-15
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiewen.yao@intel.com>) id 1hyCTW-0001lB-SM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:53611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiewen.yao@intel.com>)
 id 1hyCTW-0001kJ-K8
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:55:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Aug 2019 02:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; d="scan'208";a="167703949"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga007.jf.intel.com with ESMTP; 15 Aug 2019 02:55:14 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 15 Aug 2019 02:55:14 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 15 Aug 2019 02:55:14 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.62]) with mapi id 14.03.0439.000;
 Thu, 15 Aug 2019 17:55:11 +0800
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>
Thread-Topic: CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5lMVYZhTq/0GuokGqDPas2Kb6jzUA//+ZRQCAAdE5QA==
Date: Thu, 15 Aug 2019 09:55:11 +0000
Message-ID: <74D8A39837DF1E4DA445A8C0B3885C503F75E4E9@shsmsx102.ccr.corp.intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
In-Reply-To: <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGFvbG8NCkkgYW0gbm90IHN1cmUgd2hhdCBkbyB5b3UgbWVhbiAtICJZb3UgZG8gbm90IG5l
ZWQgYSByZXNldCB2ZWN0b3IgLi4uIi4NCklmIHNvLCB3aGVyZSBpcyB0aGUgZmlyc3QgaW5zdHJ1
Y3Rpb24gb2YgdGhlIG5ldyBDUFUgaW4gdGhlIHZpcnR1YWxpemF0aW9uIGVudmlyb25tZW50Pw0K
UGxlYXNlIGhlbHAgbWUgdW5kZXJzdGFuZCB0aGF0IGF0IGZpcnN0LiBUaGVuIHdlIGNhbiBjb250
aW51ZSB0aGUgZGlzY3Vzc2lvbi4NCg0KVGhhbmsgeW91DQpZYW8gSmlld2VuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBbbWFpbHRvOnBib256
aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE0LCAyMDE5IDEwOjA1
IFBNDQo+IFRvOiBZYW8sIEppZXdlbiA8amlld2VuLnlhb0BpbnRlbC5jb20+OyBMYXN6bG8gRXJz
ZWsNCj4gPGxlcnNla0ByZWRoYXQuY29tPjsgZWRrMi1kZXZlbC1ncm91cHMtaW8gPGRldmVsQGVk
azIuZ3JvdXBzLmlvPg0KPiBDYzogZWRrMi1yZmMtZ3JvdXBzLWlvIDxyZmNAZWRrMi5ncm91cHMu
aW8+OyBxZW11IGRldmVsIGxpc3QNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IElnb3IgTWFt
bWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+Ow0KPiBDaGVuLCBZaW5nd2VuIDx5aW5nd2VuLmNo
ZW5AaW50ZWwuY29tPjsgTmFrYWppbWEsIEp1bg0KPiA8anVuLm5ha2FqaW1hQGludGVsLmNvbT47
IEJvcmlzIE9zdHJvdnNreSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+Ow0KPiBKb2FvIE1h
cmNhbCBMZW1vcyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPjsgUGhpbGxpcCBH
b2VybA0KPiA8cGhpbGxpcC5nb2VybEBvcmFjbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogQ1BVIGhv
dHBsdWcgdXNpbmcgU01NIHdpdGggUUVNVStPVk1GDQo+IA0KPiBPbiAxNC8wOC8xOSAxNToyMCwg
WWFvLCBKaWV3ZW4gd3JvdGU6DQo+ID4+IC0gRG9lcyB0aGlzIHBhcnQgcmVxdWlyZSBhIG5ldyBi
cmFuY2ggc29tZXdoZXJlIGluIHRoZSBPVk1GIFNFQyBjb2RlPw0KPiA+PiAgIEhvdyBkbyB3ZSBk
ZXRlcm1pbmUgd2hldGhlciB0aGUgQ1BVIGV4ZWN1dGluZyBTRUMgaXMgQlNQIG9yDQo+ID4+ICAg
aG90LXBsdWdnZWQgQVA/DQo+ID4gW0ppZXdlbl0gSSB0aGluayB0aGlzIGlzIGJsb2NrZWQgZnJv
bSBoYXJkd2FyZSBwZXJzcGVjdGl2ZSwgc2luY2UgdGhlIGZpcnN0DQo+IGluc3RydWN0aW9uLg0K
PiA+IFRoZXJlIGFyZSBzb21lIGhhcmR3YXJlIHNwZWNpZmljIHJlZ2lzdGVycyBjYW4gYmUgdXNl
ZCB0byBkZXRlcm1pbmUgaWYgdGhlDQo+IENQVSBpcyBuZXcgYWRkZWQuDQo+ID4gSSBkb27igJl0
IHRoaW5rIHRoaXMgbXVzdCBiZSBzYW1lIGFzIHRoZSByZWFsIGhhcmR3YXJlLg0KPiA+IFlvdSBh
cmUgZnJlZSB0byBpbnZlbnQgc29tZSByZWdpc3RlcnMgaW4gZGV2aWNlIG1vZGVsIHRvIGJlIHVz
ZWQgaW4gT1ZNRg0KPiBob3QgcGx1ZyBkcml2ZXIuDQo+IA0KPiBZZXMsIHRoaXMgd291bGQgYmUg
YSBuZXcgb3BlcmF0aW9uIG1vZGUgZm9yIFFFTVUsIHRoYXQgb25seSBhcHBsaWVzIHRvDQo+IGhv
dC1wbHVnZ2VkIENQVXMuICBJbiB0aGlzIG1vZGUgdGhlIEFQIGRvZXNuJ3QgcmVwbHkgdG8gSU5J
VCBvciBTTUksIGluDQo+IGZhY3QgaXQgZG9lc24ndCByZXBseSB0byBhbnl0aGluZyBhdCBhbGwu
DQo+IA0KPiA+PiAtIEhvdyBkbyB3ZSB0ZWxsIHRoZSBob3QtcGx1Z2dlZCBBUCB3aGVyZSB0byBz
dGFydCBleGVjdXRpb24/IChJLmUuIHRoYXQNCj4gPj4gICBpdCBzaG91bGQgZXhlY3V0ZSBjb2Rl
IGF0IGEgcGFydGljdWxhciBwZmxhc2ggbG9jYXRpb24uKQ0KPiA+IFtKaWV3ZW5dIFNhbWUgcmVh
bCBtb2RlIHJlc2V0IHZlY3RvciBhdCBGRkZGOkZGRjAuDQo+IA0KPiBZb3UgZG8gbm90IG5lZWQg
YSByZXNldCB2ZWN0b3Igb3IgSU5JVC9TSVBJL1NJUEkgc2VxdWVuY2UgYXQgYWxsIGluDQo+IFFF
TVUuICBUaGUgQVAgZG9lcyBub3Qgc3RhcnQgZXhlY3V0aW9uIGF0IGFsbCB3aGVuIGl0IGlzIHVu
cGx1Z2dlZCwgc28NCj4gbm8gY2FjaGUtYXMtUkFNIGV0Yy4NCg0KPiBXZSBvbmx5IG5lZWQgdG8g
bW9kaWZ5IFFFTVUgc28gdGhhdCBob3QtcGx1Z2dlZCBBUElzIGRvIG5vdCByZXBseSB0bw0KPiBJ
TklUL1NJUEkvU01JLg0KPiANCj4gPiBJIGRvbuKAmXQgdGhpbmsgdGhlcmUgaXMgcHJvYmxlbSBm
b3IgcmVhbCBoYXJkd2FyZSwgd2hvIGFsd2F5cyBoYXMgQ0FSLg0KPiA+IENhbiBRRU1VIHByb3Zp
ZGUgc29tZSBDUFUgc3BlY2lmaWMgc3BhY2UsIHN1Y2ggYXMgTU1JTyByZWdpb24/DQo+IA0KPiBX
aHkgaXMgYSBDUFUtc3BlY2lmaWMgcmVnaW9uIG5lZWRlZCBpZiBldmVyeSBvdGhlciBwcm9jZXNz
b3IgaXMgaW4gU01NDQo+IGFuZCB0aHVzIHRydXN0ZWQuDQo+ID4+ICAgRG9lcyBDUFUgaG90cGx1
ZyBhcHBseSBvbmx5IGF0IHRoZSBzb2NrZXQgbGV2ZWw/IElmIHRoZSBDUFUgaXMNCj4gPj4gICBt
dWx0aS1jb3JlLCB3aGF0IGlzIHJlc3BvbnNpYmxlIGZvciBob3QtcGx1Z2dpbmcgYWxsIGNvcmVz
IHByZXNlbnQgaW4NCj4gPj4gICB0aGUgc29ja2V0Pw0KPiANCj4gSSBjYW4gYW5zd2VyIHRoaXM6
IHRoZSBTTU0gaGFuZGxlciB3b3VsZCBpbnRlcmFjdCB3aXRoIHRoZSBob3RwbHVnDQo+IGNvbnRy
b2xsZXIgaW4gdGhlIHNhbWUgd2F5IHRoYXQgQUNQSSBEU0RUIGRvZXMgbm9ybWFsbHkuICBUaGlz
IHN1cHBvcnRzDQo+IG11bHRpcGxlIGhvdHBsdWdzIGFscmVhZHkuDQo+IA0KPiBXcml0ZXMgdG8g
dGhlIGhvdHBsdWcgY29udHJvbGxlciBmcm9tIG91dHNpZGUgU01NIHdvdWxkIGJlIGlnbm9yZWQu
DQo+IA0KPiA+Pj4gKDAzKSBOZXcgQ1BVOiAoRmxhc2gpIHNlbmQgYm9hcmQgbWVzc2FnZSB0byB0
ZWxsIGhvc3QgQ1BVIChHUElPLT5TQ0kpDQo+ID4+PiAgICAgIC0tIEkgYW0gd2FpdGluZyBmb3Ig
aG90LWFkZCBtZXNzYWdlLg0KPiA+Pg0KPiA+PiBNYXliZSB3ZSBjYW4gc2ltcGxpZnkgdGhpcyBp
biBRRU1VIGJ5IGJyb2FkY2FzdGluZyBhbiBTTUkgdG8gZXhpc3RlbnQNCj4gPj4gcHJvY2Vzc29y
cyBpbW1lZGlhdGVseSB1cG9uIHBsdWdnaW5nIHRoZSBuZXcgQ1BVLg0KPiANCj4gVGhlIFFFTVUg
RFNEVCBjb3VsZCBiZSBtb2RpZmllZCAod2hlbiBzZWN1cmUgYm9vdCBpcyBpbiBlZmZlY3QpIHRv
IE9VVA0KPiB0byAweEIyIHdoZW4gaG90cGx1ZyBoYXBwZW5zLiAgSXQgY291bGQgd3JpdGUgYSB3
ZWxsLWtub3duIHZhbHVlIHRvDQo+IDB4QjIsIHRvIGJlIHJlYWQgYnkgYW4gU01JIGhhbmRsZXIg
aW4gZWRrMi4NCj4gDQo+IA0KPiA+Pg0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKE5PVEU6IEhvc3QgQ1BVIGNhbg0KPiBvbmx5DQo+ID4+IHNlbmQNCj4gPj4+
ICAgICAgaW5zdHJ1Y3Rpb24gaW4gU01NIG1vZGUuIC0tIFRoZSByZWdpc3RlciBpcyBTTU0gb25s
eSkNCj4gPj4NCj4gPj4gU29ycnksIEkgZG9uJ3QgZm9sbG93IC0tIHdoYXQgcmVnaXN0ZXIgYXJl
IHdlIHRhbGtpbmcgYWJvdXQgaGVyZSwgYW5kDQo+ID4+IHdoeSBpcyB0aGUgQlNQIG5lZWRlZCB0
byBzZW5kIGFueXRoaW5nIGF0IGFsbD8gV2hhdCAiaW5zdHJ1Y3Rpb24iIGRvIHlvdQ0KPiA+PiBo
YXZlIGluIG1pbmQ/DQo+ID4gW0ppZXdlbl0gVGhlIG5ldyBDUFUgZG9lcyBub3QgZW5hYmxlIFNN
SSBhdCByZXNldC4NCj4gPiBBdCBzb21lIHBvaW50IG9mIHRpbWUgbGF0ZXIsIHRoZSBDUFUgbmVl
ZCBlbmFibGUgU01JLCByaWdodD8NCj4gPiBUaGUgImluc3RydWN0aW9uIiBoZXJlIG1lYW5zLCB0
aGUgaG9zdCBDUFVzIG5lZWQgdGVsbCB0byBDUFUgdG8gZW5hYmxlDQo+IFNNSS4NCj4gDQo+IFJp
Z2h0LCB0aGlzIHdvdWxkIGJlIGEgd3JpdGUgdG8gdGhlIENQVSBob3RwbHVnIGNvbnRyb2xsZXIN
Cj4gDQo+ID4+PiAoMDQpIEhvc3QgQ1BVOiAoT1MpIGdldCBtZXNzYWdlIGZyb20gYm9hcmQgdGhh
dCBhIG5ldyBDUFUgaXMgYWRkZWQuDQo+ID4+PiAgICAgIChHUElPIC0+IFNDSSkNCj4gPj4+DQo+
ID4+PiAoMDUpIEhvc3QgQ1BVOiAoT1MpIEFsbCBDUFVzIGVudGVyIFNNTSAoU0NJLT5TV1NNSSkg
KE5PVEU6IE5ldyBDUFUNCj4gPj4+ICAgICAgd2lsbCBub3QgZW50ZXIgQ1BVIGJlY2F1c2UgU01J
IGlzIGRpc2FibGVkKQ0KPiA+Pg0KPiA+PiBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIE9TIGludm9s
dmVtZW50IGhlcmUuIEJ1dCwgYWdhaW4sIHBlcmhhcHMgUUVNVQ0KPiBjYW4NCj4gPj4gZm9yY2Ug
YWxsIGV4aXN0ZW50IENQVXMgaW50byBTTU0gaW1tZWRpYXRlbHkgdXBvbiBhZGRpbmcgdGhlIG5l
dyBDUFUuDQo+ID4gW0ppZXdlbl0gT1MgaGVyZSBtZWFucyB0aGUgSG9zdCBDUFUgcnVubmluZyBj
b2RlIGluIE9TIGVudmlyb25tZW50LCBub3QNCj4gaW4gU01NIGVudmlyb25tZW50Lg0KPiANCj4g
U2VlIGFib3ZlLg0KPiANCj4gPj4+ICgwNikgSG9zdCBDUFU6IChTTU0pIFNhdmUgMzgwMDAsIFVw
ZGF0ZSAzODAwMCAtLSBmaWxsIHNpbXBsZSBTTU0NCj4gPj4+ICAgICAgcmViYXNlIGNvZGUuDQo+
ID4+Pg0KPiA+Pj4gKDA3KSBIb3N0IENQVTogKFNNTSkgU2VuZCBtZXNzYWdlIHRvIE5ldyBDUFUg
dG8gRW5hYmxlIFNNSS4NCj4gPj4NCj4gPj4gQWhhLCBzbyB0aGlzIGlzIHRoZSBTTU0tb25seSBy
ZWdpc3RlciB5b3UgbWVudGlvbiBpbiBzdGVwICgwMykuIElzIHRoZQ0KPiA+PiByZWdpc3RlciBz
cGVjaWZpZWQgaW4gdGhlIEludGVsIFNETT8NCj4gPiBbSmlld2VuXSBSaWdodC4gVGhhdCBpcyB0
aGUgcmVnaXN0ZXIgdG8gbGV0IGhvc3QgQ1BVIHRlbGwgbmV3IENQVSB0byBlbmFibGUNCj4gU01J
Lg0KPiA+IEl0IGlzIHBsYXRmb3JtIHNwZWNpZmljIHJlZ2lzdGVyLiBOb3QgZGVmaW5lZCBpbiBT
RE0uDQo+ID4gWW91IG1heSBpbnZlbnQgb25lIGluIGRldmljZSBtb2RlbC4NCj4gDQo+IFNlZSBh
Ym92ZS4NCj4gDQo+ID4+PiAoMTApIE5ldyBDUFU6IChTTU0pIFJlc3BvbnNlIGZpcnN0IFNNSSBh
dCAzODAwMCwgYW5kIHJlYmFzZSBTTUJBU0UNCj4gdG8NCj4gPj4+ICAgICAgVFNFRy4NCj4gPj4N
Cj4gPj4gV2hhdCBjb2RlIGRvZXMgdGhlIG5ldyBDUFUgZXhlY3V0ZSBhZnRlciBpdCBjb21wbGV0
ZXMgc3RlcCAoMTApPyBEb2VzDQo+IGl0DQo+ID4+IGhhbHQ/DQo+ID4NCj4gPiBbSmlld2VuXSBU
aGUgbmV3IENQVSBleGl0cyBTTU0gYW5kIHJldHVybiB0byBvcmlnaW5hbCBwbGFjZSAtIHdoZXJl
IGl0IGlzDQo+ID4gaW50ZXJydXB0ZWQgdG8gZW50ZXIgU01NIC0gcnVubmluZyBjb2RlIG9uIHRo
ZSBmbGFzaC4NCj4gDQo+IFNvIGluIG91ciBjYXNlIHdlJ2QgbmVlZCBhbiBJTklUL1NJUEkvU0lQ
SSBzZXF1ZW5jZSBiZXR3ZWVuICgwNikgYW5kICgwNykuDQo+IA0KPiA+Pj4gKDExKSBIb3N0IENQ
VTogKFNNTSkgUmVzdG9yZSAzODAwMC4NCj4gPj4NCj4gPj4gVGhlc2Ugc3RlcHMgKGkuZS4sICgw
NikgdGhyb3VnaCAoMTEpKSBkb24ndCBhcHBlYXIgUkFTLXNwZWNpZmljLiBUaGUNCj4gPj4gb25s
eSBwbGF0Zm9ybS1zcGVjaWZpYyBmZWF0dXJlIHNlZW1zIHRvIGJlIFNNSSBtYXNraW5nIHJlZ2lz
dGVyLCB3aGljaA0KPiA+PiBjb3VsZCBiZSBleHRyYWN0ZWQgaW50byBhIG5ldyBTbW1DcHVGZWF0
dXJlc0xpYiBBUEkuDQo+ID4+DQo+ID4+IFRodXMsIHdvdWxkIHlvdSBwbGVhc2UgY29uc2lkZXIg
b3BlbiBzb3VyY2luZyBmaXJtd2FyZSBjb2RlIGZvciBzdGVwcw0KPiA+PiAoMDYpIHRocm91Z2gg
KDExKT8NCj4gPj4NCj4gPj4gQWx0ZXJuYXRpdmVseSAtLSBhbmQgaW4gcGFydGljdWxhciBiZWNh
dXNlIHRoZSBzdGFjayBmb3Igc3RlcCAoMDEpDQo+ID4+IGNvbmNlcm5zIG1lIC0tLCB3ZSBjb3Vs
ZCBhcHByb2FjaCB0aGlzIGZyb20gYSBoaWdoLWxldmVsLCBmdW5jdGlvbmFsDQo+ID4+IHBlcnNw
ZWN0aXZlLiBUaGUgc3RhdGVzIHRoYXQgcmVhbGx5IG1hdHRlciBhcmUgdGhlIHJlbG9jYXRlZCBT
TUJBU0UgZm9yDQo+ID4+IHRoZSBuZXcgQ1BVLCBhbmQgdGhlIHN0YXRlIG9mIHRoZSBmdWxsIHN5
c3RlbSwgcmlnaHQgYXQgdGhlIGVuZCBvZiBzdGVwDQo+ID4+ICgxMSkuDQo+ID4+DQo+ID4+IFdo
ZW4gdGhlIFNNTSBzZXR1cCBxdWllc2NlcyBkdXJpbmcgbm9ybWFsIGZpcm13YXJlIGJvb3QsIE9W
TUYgY291bGQNCj4gPj4gdXNlDQo+ID4+IGV4aXN0ZW50IChmaW5hbGl6ZWQpIFNNQkFTRSBpbmZv
bWF0aW9uIHRvICpwcmUtcHJvZ3JhbSogc29tZSB2aXJ0dWFsDQo+ID4+IFFFTVUgaGFyZHdhcmUs
IHdpdGggc3VjaCBzdGF0ZSB0aGF0IHdvdWxkIGJlIGV4cGVjdGVkLCBhcyAiZmluYWwiIHN0YXRl
LA0KPiA+PiBvZiBhbnkgbmV3IGhvdHBsdWdnZWQgQ1BVLiBBZnRlcndhcmRzLCBpZiAvIHdoZW4g
dGhlIGhvdHBsdWcgYWN0dWFsbHkNCj4gPj4gaGFwcGVucywgUUVNVSBjb3VsZCBibGFua2V0LWFw
cGx5IHRoaXMgc3RhdGUgdG8gdGhlIG5ldyBDUFUsIGFuZA0KPiA+PiBicm9hZGNhc3QgYSBoYXJk
d2FyZSBTTUkgdG8gYWxsIENQVXMgZXhjZXB0IHRoZSBuZXcgb25lLg0KPiANCj4gSSdkIHJhdGhl
ciBhdm9pZCB0aGlzIGFuZCBzdGF5IGFzIGNsb3NlIGFzIHBvc3NpYmxlIHRvIHJlYWwgaGFyZHdh
cmUuDQo+IA0KPiBQYW9sbw0K

