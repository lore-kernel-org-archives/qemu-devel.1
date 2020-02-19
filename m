Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268FCC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DBB21D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DBB21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PGz-0000QA-5E
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j4PGC-0007y4-8d
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jianjay.zhou@huawei.com>) id 1j4PG9-00009G-Hp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:19:27 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2067 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
 id 1j4PG9-0008T0-7Z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:19:25 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 07EE585EAA1D8F302C6B;
 Wed, 19 Feb 2020 21:19:14 +0800 (CST)
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.16]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0439.000;
 Wed, 19 Feb 2020 21:19:08 +0800
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: RFC: Split EPT huge pages in advance of dirty logging
Thread-Topic: RFC: Split EPT huge pages in advance of dirty logging
Thread-Index: AdXmU97BvyK5YKoyS5++my9GnvXVk///1+yA//428yA=
Date: Wed, 19 Feb 2020 13:19:08 +0000
Message-ID: <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
In-Reply-To: <20200218174311.GE1408806@xz-x1>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.228.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
Cc: "Liujinsong \(Paul\)" <liu.jinsong@huawei.com>,
 "linfeng \(M\)" <linfeng23@huawei.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
WHUgW21haWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFy
eSAxOSwgMjAyMCAxOjQzIEFNDQo+IFRvOiBaaG91amlhbiAoamF5KSA8amlhbmpheS56aG91QGh1
YXdlaS5jb20+DQo+IENjOiBrdm1Admdlci5rZXJuZWwub3JnOyBxZW11LWRldmVsQG5vbmdudS5v
cmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGRnaWxiZXJ0QHJlZGhhdC5jb207IHF1aW50ZWxh
QHJlZGhhdC5jb207IExpdWppbnNvbmcgKFBhdWwpDQo+IDxsaXUuamluc29uZ0BodWF3ZWkuY29t
PjsgbGluZmVuZyAoTSkgPGxpbmZlbmcyM0BodWF3ZWkuY29tPjsgd2FuZ3hpbiAoVSkNCj4gPHdh
bmd4aW54aW4ud2FuZ0BodWF3ZWkuY29tPjsgSHVhbmd3ZWlkb25nIChDKQ0KPiA8d2VpZG9uZy5o
dWFuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogUkZDOiBTcGxpdCBFUFQgaHVnZSBwYWdl
cyBpbiBhZHZhbmNlIG9mIGRpcnR5IGxvZ2dpbmcNCj4gDQo+IE9uIFR1ZSwgRmViIDE4LCAyMDIw
IGF0IDAxOjEzOjQ3UE0gKzAwMDAsIFpob3VqaWFuIChqYXkpIHdyb3RlOg0KPiA+IEhpIGFsbCwN
Cj4gPg0KPiA+IFdlIGZvdW5kIHRoYXQgdGhlIGd1ZXN0IHdpbGwgYmUgc29mdC1sb2NrdXAgb2Nj
YXNpb25hbGx5IHdoZW4gbGl2ZQ0KPiA+IG1pZ3JhdGluZyBhIDYwIHZDUFUsIDUxMkdpQiBodWdl
IHBhZ2UgYW5kIG1lbW9yeSBzZW5zaXRpdmUgVk0uIFRoZQ0KPiA+IHJlYXNvbiBpcyBjbGVhciwg
YWxtb3N0IGFsbCBvZiB0aGUgdkNQVXMgYXJlIHdhaXRpbmcgZm9yIHRoZSBLVk0gTU1VDQo+ID4g
c3Bpbi1sb2NrIHRvIGNyZWF0ZSA0SyBTUFRFcyB3aGVuIHRoZSBodWdlIHBhZ2VzIGFyZSB3cml0
ZSBwcm90ZWN0ZWQuIFRoaXMNCj4gcGhlbm9tZW5vbiBpcyBhbHNvIGRlc2NyaWJlZCBpbiB0aGlz
IHBhdGNoIHNldDoNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMTYz
NDU5Lw0KPiA+IHdoaWNoIGFpbXMgdG8gaGFuZGxlIHBhZ2UgZmF1bHRzIGluIHBhcmFsbGVsIG1v
cmUgZWZmaWNpZW50bHkuDQo+ID4NCj4gPiBPdXIgaWRlYSBpcyB0byB1c2UgdGhlIG1pZ3JhdGlv
biB0aHJlYWQgdG8gdG91Y2ggYWxsIG9mIHRoZSBndWVzdA0KPiA+IG1lbW9yeSBpbiB0aGUgZ3Jh
bnVsYXJpdHkgb2YgNEsgYmVmb3JlIGVuYWJsaW5nIGRpcnR5IGxvZ2dpbmcuIFRvIGJlDQo+ID4g
bW9yZSBzcGVjaWZpYywgd2Ugc3BsaXQgYWxsIHRoZSBQRFBFX0xFVkVMIFNQVEVzIGludG8gRElS
RUNUT1JZX0xFVkVMDQo+ID4gU1BURXMgYXMgdGhlIGZpcnN0IHN0ZXAsIGFuZCB0aGVuIHNwbGl0
IGFsbCB0aGUgRElSRUNUT1JZX0xFVkVMIFNQVEVzIGludG8NCj4gUEFHRV9UQUJMRV9MRVZFTCBT
UFRFcyBhcyB0aGUgZm9sbG93aW5nIHN0ZXAuDQo+IA0KPiBJSVVDLCBRRU1VIHdpbGwgcHJlZmVy
IHRvIHVzZSBodWdlIHBhZ2VzIGZvciBhbGwgdGhlIGFub255bW91cyByYW1ibG9ja3MNCj4gKHBs
ZWFzZSByZWZlciB0byByYW1fYmxvY2tfYWRkKToNCj4gDQo+ICAgICAgICAgcWVtdV9tYWR2aXNl
KG5ld19ibG9jay0+aG9zdCwgbmV3X2Jsb2NrLT5tYXhfbGVuZ3RoLA0KPiBRRU1VX01BRFZfSFVH
RVBBR0UpOw0KDQpZZXMsIHlvdSdyZSByaWdodA0KDQo+IA0KPiBBbm90aGVyIGFsdGVybmF0aXZl
IEkgY2FuIHRoaW5rIG9mIGlzIHRvIGFkZCBhbiBleHRyYSBwYXJhbWV0ZXIgdG8gUUVNVSB0bw0K
PiBleHBsaWNpdGx5IGRpc2FibGUgaHVnZSBwYWdlcyAoc28gdGhhdCBjYW4gZXZlbiBiZSBNQURW
X05PSFVHRVBBR0UNCj4gaW5zdGVhZCBvZiBNQURWX0hVR0VQQUdFKS4gIEhvd2V2ZXIgdGhhdCBz
aG91bGQgYWxzbyBkcmFnIGRvd24gdGhlDQo+IHBlcmZvcm1hbmNlIGZvciB0aGUgd2hvbGUgbGlm
ZWN5Y2xlIG9mIHRoZSBWTS4gIA0KDQpGcm9tIHRoZSBwZXJmb3JtYW5jZSBwb2ludCBvZiB2aWV3
LCBpdCBpcyBiZXR0ZXIgdG8ga2VlcCB0aGUgaHVnZSBwYWdlcw0Kd2hlbiB0aGUgVk0gaXMgbm90
IGluIHRoZSBsaXZlIG1pZ3JhdGlvbiBzdGF0ZS4NCg0KPiBBIDNyZCBvcHRpb24gaXMgdG8gbWFr
ZSBhIFFNUA0KPiBjb21tYW5kIHRvIGR5bmFtaWNhbGx5IHR1cm4gaHVnZSBwYWdlcyBvbi9vZmYg
Zm9yIHJhbWJsb2NrcyBnbG9iYWxseS4NCg0KV2UncmUgc2VhcmNoaW5nIGEgZHluYW1pYyBtZXRo
b2QgdG9vLg0KV2UgcGxhbiB0byBhZGQgdHdvIG5ldyBmbGFncyBmb3IgZWFjaCBtZW1vcnkgc2xv
dCwgc2F5DQpLVk1fTUVNX0ZPUkNFX1BUX0RJUkVDVE9SWV9QQUdFUyBhbmQNCktWTV9NRU1fRk9S
Q0VfUFRfUEFHRV9UQUJMRV9QQUdFUy4gVGhlc2UgZmxhZ3MgY2FuIGJlIHNldA0KdGhyb3VnaCBL
Vk1fU0VUX1VTRVJfTUVNT1JZX1JFR0lPTiBpb2N0bC4NCg0KVGhlIG1hcHBpbmdfbGV2ZWwgd2hp
Y2ggaXMgY2FsbGVkIGJ5IHRkcF9wYWdlX2ZhdWx0IGluIHRoZSBrZXJuZWwgc2lkZQ0Kd2lsbCBy
ZXR1cm4gUFRfRElSRUNUT1JZX0xFVkVMIGlmIHRoZQ0KS1ZNX01FTV9GT1JDRV9QVF9ESVJFQ1RP
UllfUEFHRVMgZmxhZyBvZiB0aGUgbWVtb3J5IHNsb3QgaXMNCnNldCwgYW5kIHJldHVybiBQVF9Q
QUdFX1RBQkxFX0xFVkVMIGlmIHRoZQ0KS1ZNX01FTV9GT1JDRV9QVF9QQUdFX1RBQkxFX1BBR0VT
IGZsYWcgaXMgc2V0Lg0KIA0KVGhlIGtleSBzdGVwcyB0byBzcGxpdCB0aGUgaHVnZSBwYWdlcyBp
biBhZHZhbmNlIG9mIGVuYWJsaW5nIGRpcnR5IGxvZyBpcw0KYXMgZm9sbG93czoNCjEuIFRoZSBt
aWdyYXRpb24gdGhyZWFkIGluIHVzZXIgc3BhY2UgdXNlcw0KS1ZNX1NFVF9VU0VSX01FTU9SWV9S
RUdJT04gaW9jdGwgdG8gc2V0IHRoZQ0KS1ZNX01FTV9GT1JDRV9QVF9ESVJFQ1RPUllfUEFHRVMg
ZmxhZyBmb3IgZWFjaCBtZW1vcnkgc2xvdC4NCjIuIFRoZSBtaWdyYXRpb24gdGhyZWFkIGNvbnRp
bnVlcyB0byB1c2UgdGhlIEtWTV9TUExJVF9IVUdFX1BBR0VTDQppb2N0bCAod2hpY2ggaXMgbmV3
bHkgYWRkZWQpIHRvIGRvIHRoZSBzcGxpdHRpbmcgb2YgbGFyZ2UgcGFnZXMgaW4gdGhlDQprZXJu
ZWwgc2lkZS4NCjMuIEEgbmV3IHZDUFUgaXMgY3JlYXRlZCB0ZW1wb3JhbGx5KGRvIHNvbWUgaW5p
dGlhbGl6YXRpb24gYnV0IHdpbGwgbm90DQpydW4pIHRvIGhlbHAgdG8gZG8gdGhlIHdvcmssIGku
ZS4gYXMgdGhlIHBhcmFtZXRlciBvZiB0aGUgdGRwX3BhZ2VfZmF1bHQuDQo0LiBDb2xsZWN0IHRo
ZSBHUEEgcmFuZ2VzIG9mIGFsbCB0aGUgbWVtb3J5IHNsb3RzIHdpdGggdGhlDQpLVk1fTUVNX0ZP
UkNFX1BUX0RJUkVDVE9SWV9QQUdFUyBmbGFnIHNldC4NCjUuIFNwbGl0IHRoZSAxRyBodWdlIHBh
Z2VzKGNvbGxlY3RlZCBpbiBzdGVwIDQpIGludG8gMk0gYnkgY2FsbGluZw0KdGRwX3BhZ2VfZmF1
bHQsIHNpbmNlIHRoZSBtYXBwaW5nX2xldmVsIHdpbGwgcmV0dXJuDQpQVF9ESVJFQ1RPUllfTEVW
RUwuIEhlcmUgaXMgdGhlIG1haW4gZGlmZmVyZW5jZSBmcm9tIHRoZSB1c3VhbA0KcGF0aCB3aGlj
aCBpcyBjYXVzZWQgYnkgdGhlIEd1ZXN0IHNpZGUoRVBUIHZpb2xhdGlvbi9taXNjb25maWcgZXRj
KSwNCndlIGNhbGwgaXQgZGlyZWN0bHkgaW4gdGhlIGh5cGVydmlzb3Igc2lkZS4NCjYuIERvIHNv
bWUgY2xlYW51cHMsIGkuZS4gZnJlZSB0aGUgdkNQVSByZWxhdGVkIHJlc291cmNlcw0KNy4gVGhl
IEtWTV9TUExJVF9IVUdFX1BBR0VTIGlvY3RsIHJldHVybmVkIHRvIHRoZSB1c2VyIHNwYWNlIHNp
ZGUuDQo4LiBVc2luZyBLVk1fTUVNX0ZPUkNFX1BUX1BBR0VfVEFCTEVfUEFHRVMgaW5zdHJlYWQg
b2YNCktWTV9NRU1fRk9SQ0VfUFRfRElSRUNUT1JZX1BBR0VTIHRvIHJlcGVhdCBzdGVwIDEgfiBz
dGVwIDcsDQppbiBzdGVwIDUgdGhlIDJNIGh1Z2UgcGFnZXMgd2lsbCBiZSBzcGxpdHRlZCBpbnRv
IDRLIHBhZ2VzLg0KOS4gQ2xlYXIgdGhlIEtWTV9NRU1fRk9SQ0VfUFRfRElSRUNUT1JZX1BBR0VT
IGFuZA0KS1ZNX01FTV9GT1JDRV9QVF9QQUdFX1RBQkxFX1BBR0VTIGZsYWdzIGZvciBlYWNoIG1l
bW9yeSBzbG90Lg0KMTAuIFRoZW4gdGhlIG1pZ3JhdGlvbiB0aHJlYWQgY2FsbHMgdGhlIGxvZ19z
dGFydCBpb2N0bCB0byBlbmFibGUgdGhlIGRpcnR5DQpsb2dnaW5nLCBhbmQgdGhlIHJlbWFpbmlu
ZyB0aGluZyBpcyB0aGUgc2FtZS4NCg0KV2hhdCdzIHlvdXIgdGFrZSBvbiB0aGlzLCB0aGFua3Mu
DQoNClJlZ2FyZHMsDQpKYXkgWmhvdQ0KDQo+IEhhdmVuJ3QgdGhvdWdodCBkZWVwIGludG8gYW55
IG9mIHRoZW0sIGJ1dCBzZWVtcyBkb2FibGUuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAtLQ0KPiBQ
ZXRlciBYdQ0KDQo=

