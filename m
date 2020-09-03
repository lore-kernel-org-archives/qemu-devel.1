Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C1CC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA012072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA012072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpSI-0002BP-Iw
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kDnLx-0007eG-Ny
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:29 -0400
Received: from [203.148.12.82] (port=43291 helo=ZXSHCAS2.zhaoxin.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kDnLt-0007qd-68
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:29 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 3 Sep 2020
 19:24:16 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 3 Sep 2020
 19:24:15 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Thu, 3 Sep 2020 19:24:15 +0800
From: FelixCui-oc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvMV0gU2tpcCBmbGF0dmlld19zaW1wbGlmeSgpIGZv?=
 =?gb2312?Q?r_specific_cpu_vendor?=
Thread-Topic: [PATCH 1/1] Skip flatview_simplify() for specific cpu vendor
Thread-Index: AQHWgdeRAj24Xg9au0WX5GoWcziw/KlWMruAgACLhxg=
Date: Thu, 3 Sep 2020 11:24:15 +0000
Message-ID: <d91ca1499e3347278f9a33a8fc314919@zhaoxin.com>
References: <20200903094935.2361-1-FelixCui-oc@zhaoxin.com>
 <20200903094935.2361-2-FelixCui-oc@zhaoxin.com>,
 <612db96b-2f7b-1f98-4da8-46bccff9adca@redhat.com>
In-Reply-To: <612db96b-2f7b-1f98-4da8-46bccff9adca@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.19]
Content-Type: multipart/alternative;
 boundary="_000_d91ca1499e3347278f9a33a8fc314919zhaoxincom_"
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 203.148.12.82 (failed)
Received-SPF: pass client-ip=203.148.12.82;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS2.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 05:49:52
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: 45
X-Spam_score: 4.5
X-Spam_bar: ++++
X-Spam_report: (4.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Sep 2020 09:34:31 -0400
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
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
 RockCui-oc <RockCui-oc@zhaoxin.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 CobeChen-oc <CobeChen-oc@zhaoxin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_d91ca1499e3347278f9a33a8fc314919zhaoxincom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

DQo+SSB0aGluayB5b3UncmUgc2VlaW5nIGlzc3VlcyB3aGVuIGEgZ3Vlc3QgYWNjZXNzZXMgYW4g
YWRqYWNlbnQgbWFwcGluZw0KPmJldHdlZW4gdGhlIGRlbGV0ZSBhbmQgYWRkIHBoYXNlcyBvZiB0
aGUgS1ZNIE1lbW9yeUxpc3RlbmVyLg0KDQo+V2UncmUgY29uc2lkZXJpbmcgZml4aW5nIHRoYXQg
aW4gdGhlIGtlcm5lbCwgYnkgYWRkaW5nIGEgbmV3IGlvY3RsIHRoYXQNCj5jaGFuZ2VzIHRoZSB3
aG9sZSBtZW1vcnkgbWFwIGluIGEgc2luZ2xlIHN0ZXAuICBJIGFtIENDaW5nIFBldGVyIFh1Lg0K
DQoNCmhpIHBhb2xvLA0KDQogICAgICAgICAgICAgIFdoYXQgeW91IHNhaWQgaXMgdmVyeSBzaW1p
bGFyIHRvIG15IGlzc3Vlcy4gTXkgcHJvYmxlbSBpcyBoYXBwZW5lZCB3aGVuIGEgRUhDSSBkZXZp
Y2UgYWNjZXNzZXMgYW4gYWRqYWNlbnQgbWFwcGluZyBiZXR3ZWVuIHRoZSBkZWxldGUgYW5kIGFk
ZCBwaGFzZXMgb2YgdGhlIFZGSU8gTWVtb3J5TGlzdGVuZXIuDQoNClZGSU8gTWVtb3J5TGlzdGVu
ZXIgIGlzIGFsc28gaW5jbHVkZWQgdW5kZXIgYWRkcmVzc19zcGFjZV9tZW1vcnkuDQoNCiAgICAg
ICAgICAgICAgRG9lcyBhZGRpbmcgYSBuZXcgaW9jdGwgYWxzbyBhcHBseSB0byBWRklPIE1lbW9y
eUxpc3RlbmVyPw0KDQoNCkJlc3QgcmVnYXJkcw0KDQpGZWxpeGN1aS1vYw0KDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IFBhb2xvIEJvbnppbmkgPHBib256aW5p
QHJlZGhhdC5jb20+DQq3osvNyrG85DogMjAyMMTqOdTCM8jVIDE4OjM3OjQ3DQrK1bz+yMs6IEZl
bGl4Q3VpLW9jOyBSaWNoYXJkIEhlbmRlcnNvbjsgRWR1YXJkbyBIYWJrb3N0DQqzrcvNOiBxZW11
LWRldmVsQG5vbmdudS5vcmc7IFJvY2tDdWktb2M7IFRvbnkgVyBXYW5nLW9jOyBDb2JlQ2hlbi1v
YzsgUGV0ZXIgWHUNCtb3zOI6IFJlOiBbUEFUQ0ggMS8xXSBTa2lwIGZsYXR2aWV3X3NpbXBsaWZ5
KCkgZm9yIHNwZWNpZmljIGNwdSB2ZW5kb3INCg0KT24gMDMvMDkvMjAgMTE6NDksIEZlbGl4Q3Vp
b2Mgd3JvdGU6DQo+IEZsYXR2aWV3X3NpbXBsaWZ5KCkgd2lsbCBtZXJnZSBtYW55IGFkZHJlc3Mg
cmFuZ2VzDQo+IGludG8gb25lIHJhbmdlLldoZW4gYSBwYXJ0IG9mIHRoZSBiaWcgcmFuZ2UgbmVl
ZHMNCj4gdG8gYmUgY2hhbmdlZCx0aGlzIHdpbGwgY2F1c2Ugc29tZSBpbm5vY2VudCBtYXBwaW5n
cw0KPiB0byBiZSB1bm1hcHBlZC5TbyB3ZSB3YW50IHRvIHNraXAgZmxhdHZpZXdfc2ltcGxpZnko
KS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRmVsaXhDdWlvYyA8RmVsaXhDdWktb2NAemhhb3hpbi5j
b20+DQoNClRoaXMgaGFzIHNldmVyYWwgaXNzdWVzLiAgSW4gbm8gcGFydGljdWxhciBvcmRlcjoN
Cg0KMSkgeW91J3JlIGFkZGluZyBob3N0X2dldF92ZW5kb3IgdG8gdGFyZ2V0L2kzODYvY3B1LmMg
c28gdGhpcyBkb2VzIG5vdA0KZXZlbiBidWlsZCBmb3IgdGhlIGRlZmF1bHQgIi4uL2NvbmZpZ3Vy
ZSAmJiBtYWtlIi4NCg0KMikgeW91J3JlIGFkZGluZyBhIGNoZWNrIGZvciB0aGUgaG9zdCwgYnV0
IHRoZSBidWcgYXBwbGllcyB0byBhbGwgaG9zdHMuDQogSWYgdGhlcmUgaXMgYSBidWcgb24geDg2
IGhhcmR3YXJlIGVtdWxhdGlvbiwgaXQgc2hvdWxkIGJlIGZpeGVkIGV2ZW4NCndoZW4gZW11bGF0
aW5nIHg4NiBmcm9tIEFSTS4NCg0KMykgeW91J3JlIG5vdCBleHBsYWluaW5nIHdoYXQgaXMgdGhl
IGJpZyByYW5nZSBhbmQgaG93IHRoZSBidWcgaXMNCm1hbmlmZXN0aW5nLg0KDQpJIHRoaW5rIHlv
dSdyZSBzZWVpbmcgaXNzdWVzIHdoZW4gYSBndWVzdCBhY2Nlc3NlcyBhbiBhZGphY2VudCBtYXBw
aW5nDQpiZXR3ZWVuIHRoZSBkZWxldGUgYW5kIGFkZCBwaGFzZXMgb2YgdGhlIEtWTSBNZW1vcnlM
aXN0ZW5lci4gIFdlJ3JlDQpjb25zaWRlcmluZyBmaXhpbmcgdGhhdCBpbiB0aGUga2VybmVsLCBi
eSBhZGRpbmcgYSBuZXcgaW9jdGwgdGhhdA0KY2hhbmdlcyB0aGUgd2hvbGUgbWVtb3J5IG1hcCBp
biBhIHNpbmdsZSBzdGVwLiAgSSBhbSBDQ2luZyBQZXRlciBYdS4NCg0KUGFvbG8NCg0KDQo+IC0t
LQ0KPiAgc29mdG1tdS9tZW1vcnkuYyAgfCAxNiArKysrKysrKysrKysrKystDQo+ICB0YXJnZXQv
aTM4Ni9jcHUuYyB8ICA4ICsrKysrKysrDQo+ICB0YXJnZXQvaTM4Ni9jcHUuaCB8ICAzICsrKw0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9zb2Z0bW11L21lbW9yeS5jIGIvc29mdG1tdS9tZW1vcnkuYw0KPiBpbmRl
eCA3MGI5MzEwNGU4Li4zNDhlOWRiNjIyIDEwMDY0NA0KPiAtLS0gYS9zb2Z0bW11L21lbW9yeS5j
DQo+ICsrKyBiL3NvZnRtbXUvbWVtb3J5LmMNCj4gQEAgLTY5OSw2ICs2OTksMTggQEAgc3RhdGlj
IE1lbW9yeVJlZ2lvbiAqbWVtb3J5X3JlZ2lvbl9nZXRfZmxhdHZpZXdfcm9vdChNZW1vcnlSZWdp
b24gKm1yKQ0KPiAgICAgIHJldHVybiBOVUxMOw0KPiAgfQ0KPg0KPiArc3RhdGljIGJvb2wgc2tp
cF9zaW1wbGlmeSh2b2lkKQ0KPiArew0KPiArICAgIGNoYXIgdmVuZG9yW0NQVUlEX1ZFTkRPUl9T
WiArIDFdID0geyAwIH07DQo+ICsgICAgaG9zdF9nZXRfdmVuZG9yKHZlbmRvcik7DQo+ICsgICAg
aWYgKCFzdHJuY21wKHZlbmRvciwgQ1BVSURfVkVORE9SX1ZJQSwgc3RybGVuKENQVUlEX1ZFTkRP
Ul9WSUEpKQ0KPiArICAgICAgICB8fCAhc3RybmNtcCh2ZW5kb3IsIENQVUlEX1ZFTkRPUl9aSEFP
WElOLA0KPiArICAgICAgICAgICAgICAgICAgICBzdHJsZW4oQ1BVSURfVkVORE9SX1pIQU9YSU4p
KSkgew0KPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gKyAgICB9DQo+ICsgICAgcmV0dXJuIGZh
bHNlOw0KPiArfQ0KPiArDQo+ICAvKiBSZW5kZXIgYSBtZW1vcnkgdG9wb2xvZ3kgaW50byBhIGxp
c3Qgb2YgZGlzam9pbnQgYWJzb2x1dGUgcmFuZ2VzLiAqLw0KPiAgc3RhdGljIEZsYXRWaWV3ICpn
ZW5lcmF0ZV9tZW1vcnlfdG9wb2xvZ3koTWVtb3J5UmVnaW9uICptcikNCj4gIHsNCj4gQEAgLTcx
Miw3ICs3MjQsOSBAQCBzdGF0aWMgRmxhdFZpZXcgKmdlbmVyYXRlX21lbW9yeV90b3BvbG9neShN
ZW1vcnlSZWdpb24gKm1yKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRycmFu
Z2VfbWFrZShpbnQxMjhfemVybygpLCBpbnQxMjhfMl82NCgpKSwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZmFsc2UsIGZhbHNlKTsNCj4gICAgICB9DQo+IC0gICAgZmxhdHZpZXdf
c2ltcGxpZnkodmlldyk7DQo+ICsgICAgaWYgKCFza2lwX3NpbXBsaWZ5KCkpIHsNCj4gKyAgICAg
ICAgZmxhdHZpZXdfc2ltcGxpZnkodmlldyk7DQo+ICsgICAgfQ0KPg0KPiAgICAgIHZpZXctPmRp
c3BhdGNoID0gYWRkcmVzc19zcGFjZV9kaXNwYXRjaF9uZXcodmlldyk7DQo+ICAgICAgZm9yIChp
ID0gMDsgaSA8IHZpZXctPm5yOyBpKyspIHsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2Nw
dS5jIGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4gaW5kZXggNDlkODk1ODUyOC4uMDg1MDhjODU4MCAx
MDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L2kzODYvY3B1
LmMNCj4gQEAgLTE2NjQsNiArMTY2NCwxNCBAQCB2b2lkIGhvc3RfY3B1aWQodWludDMyX3QgZnVu
Y3Rpb24sIHVpbnQzMl90IGNvdW50LA0KPiAgICAgICAgICAqZWR4ID0gdmVjWzNdOw0KPiAgfQ0K
Pg0KPiArdm9pZCBob3N0X2dldF92ZW5kb3IoY2hhciAqdmVuZG9yKQ0KPiArew0KPiArICAgIHVp
bnQzMl90IGVheCwgZWJ4LCBlY3gsIGVkeDsNCj4gKw0KPiArICAgIGhvc3RfY3B1aWQoMHgwLCAw
LCAmZWF4LCAmZWJ4LCAmZWN4LCAmZWR4KTsNCj4gKyAgICB4ODZfY3B1X3ZlbmRvcl93b3JkczJz
dHIodmVuZG9yLCBlYngsIGVkeCwgZWN4KTsNCj4gK30NCj4gKw0KPiAgdm9pZCBob3N0X3ZlbmRv
cl9mbXMoY2hhciAqdmVuZG9yLCBpbnQgKmZhbWlseSwgaW50ICptb2RlbCwgaW50ICpzdGVwcGlu
ZykNCj4gIHsNCj4gICAgICB1aW50MzJfdCBlYXgsIGVieCwgZWN4LCBlZHg7DQo+IGRpZmYgLS1n
aXQgYS90YXJnZXQvaTM4Ni9jcHUuaCBiL3RhcmdldC9pMzg2L2NwdS5oDQo+IGluZGV4IGQzMDk3
YmU2YTUuLjE0YzhiNGMwOWYgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5oDQo+ICsr
KyBiL3RhcmdldC9pMzg2L2NwdS5oDQo+IEBAIC04MzIsNiArODMyLDggQEAgdHlwZWRlZiB1aW50
NjRfdCBGZWF0dXJlV29yZEFycmF5W0ZFQVRVUkVfV09SRFNdOw0KPg0KPiAgI2RlZmluZSBDUFVJ
RF9WRU5ET1JfVklBICAgIkNlbnRhdXJIYXVscyINCj4NCj4gKyNkZWZpbmUgQ1BVSURfVkVORE9S
X1pIQU9YSU4gICAiICBTaGFuZ2hhaSAgIg0KPiArDQo+ICAjZGVmaW5lIENQVUlEX1ZFTkRPUl9I
WUdPTiAgICAiSHlnb25HZW51aW5lIg0KPg0KPiAgI2RlZmluZSBJU19JTlRFTF9DUFUoZW52KSAo
KGVudiktPmNwdWlkX3ZlbmRvcjEgPT0gQ1BVSURfVkVORE9SX0lOVEVMXzEgJiYgXA0KPiBAQCAt
MTkxNyw2ICsxOTE5LDcgQEAgdm9pZCBjcHVfY2xlYXJfYXBpY19mZWF0dXJlKENQVVg4NlN0YXRl
ICplbnYpOw0KPiAgdm9pZCBob3N0X2NwdWlkKHVpbnQzMl90IGZ1bmN0aW9uLCB1aW50MzJfdCBj
b3VudCwNCj4gICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZWF4LCB1aW50MzJfdCAqZWJ4LCB1
aW50MzJfdCAqZWN4LCB1aW50MzJfdCAqZWR4KTsNCj4gIHZvaWQgaG9zdF92ZW5kb3JfZm1zKGNo
YXIgKnZlbmRvciwgaW50ICpmYW1pbHksIGludCAqbW9kZWwsIGludCAqc3RlcHBpbmcpOw0KPiAr
dm9pZCBob3N0X2dldF92ZW5kb3IoY2hhciAqdmVuZG9yKTsNCj4NCj4gIC8qIGhlbHBlci5jICov
DQo+ICBib29sIHg4Nl9jcHVfdGxiX2ZpbGwoQ1BVU3RhdGUgKmNzLCB2YWRkciBhZGRyZXNzLCBp
bnQgc2l6ZSwNCj4NCg0K

--_000_d91ca1499e3347278f9a33a8fc314919zhaoxincom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><br>
</p>
<meta content=3D"text/html; charset=3DUTF-8">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; co=
lor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, =
&quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, =
&quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;">
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;I think you're =
seeing issues when a guest accesses an adjacent mapping</span><br style=3D"=
color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&quot;,&quot;Micro=
soft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=E5,sans-serif,se=
rif,EmojiFont; font-size:13.3333px">
<span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI&qu=
ot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=CC=
=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&gt;between the delete=
 and add phases of the KVM MemoryListener.&nbsp;&nbsp;</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"></p>
<div>&gt;We're&nbsp;<span style=3D"font-size: 13.3333px;">considering fixin=
g that in the kernel, by adding a new ioctl that</span></div>
<div>&gt;changes the whole memory map in a single step.&nbsp; I am CCing Pe=
ter Xu.</div>
<br>
</span>
<p></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">hi paolo,</span></p=
>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px">&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; What you said is very similar to my issues. M=
y problem is happened&nbsp;when a EHCI device accesses
 an adjacent mapping between the delete and add phases of the VFIO MemoryLi=
stener.</span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><span style=3D"colo=
r: rgb(33, 33, 33); font-family: &quot;Microsoft YaHei UI&quot;, &quot;Micr=
osoft YaHei&quot;, =CE=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-ser=
if, serif, EmojiFont; font-size: 13.3333px;">VFIO
 MemoryListener&nbsp; is also included under address_space_memory.</span></=
span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><span style=3D"colo=
r: rgb(33, 33, 33); font-family: &quot;Microsoft YaHei UI&quot;, &quot;Micr=
osoft YaHei&quot;, =CE=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-ser=
if, serif, EmojiFont; font-size: 13.3333px;">&nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Does adding a new ioctl also app=
ly to VFIO MemoryListener?</span></span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><span style=3D"colo=
r: rgb(33, 33, 33); font-family: &quot;Microsoft YaHei UI&quot;, &quot;Micr=
osoft YaHei&quot;, =CE=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-ser=
if, serif, EmojiFont; font-size: 13.3333px;"><br>
</span></span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><span style=3D"colo=
r: rgb(33, 33, 33); font-family: &quot;Microsoft YaHei UI&quot;, &quot;Micr=
osoft YaHei&quot;, =CE=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-ser=
if, serif, EmojiFont; font-size: 13.3333px;">Best
 regards</span></span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><span style=3D"colo=
r: rgb(33, 33, 33); font-family: &quot;Microsoft YaHei UI&quot;, &quot;Micr=
osoft YaHei&quot;, =CE=A2=C8=ED=D1=C5=BA=DA, SimSun, =CB=CE=CC=E5, sans-ser=
if, serif, EmojiFont; font-size: 13.3333px;">Felixcui-oc</span></span></p>
<p><span style=3D"color:rgb(33,33,33); font-family:&quot;Microsoft YaHei UI=
&quot;,&quot;Microsoft YaHei&quot;,=CE=A2=C8=ED=D1=C5=BA=DA,SimSun,=CB=CE=
=CC=E5,sans-serif,serif,EmojiFont; font-size:13.3333px"><br>
</span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>=B7=A2=BC=FE=C8=CB:</b> Paolo=
 Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2020=C4=EA9=D4=C23=C8=D5 18:37:47<br>
<b>=CA=D5=BC=FE=C8=CB:</b> FelixCui-oc; Richard Henderson; Eduardo Habkost<=
br>
<b>=B3=AD=CB=CD:</b> qemu-devel@nongnu.org; RockCui-oc; Tony W Wang-oc; Cob=
eChen-oc; Peter Xu<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH 1/1] Skip flatview_simplify() for specific =
cpu vendor</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">On 03/09/20 11:49, FelixCuioc wrote:<br>
&gt; Flatview_simplify() will merge many address ranges<br>
&gt; into one range.When a part of the big range needs<br>
&gt; to be changed,this will cause some innocent mappings<br>
&gt; to be unmapped.So we want to skip flatview_simplify().<br>
&gt; <br>
&gt; Signed-off-by: FelixCuioc &lt;FelixCui-oc@zhaoxin.com&gt;<br>
<br>
This has several issues.&nbsp; In no particular order:<br>
<br>
1) you're adding host_get_vendor to target/i386/cpu.c so this does not<br>
even build for the default &quot;../configure &amp;&amp; make&quot;.<br>
<br>
2) you're adding a check for the host, but the bug applies to all hosts.<br=
>
&nbsp;If there is a bug on x86 hardware emulation, it should be fixed even<=
br>
when emulating x86 from ARM.<br>
<br>
3) you're not explaining what is the big range and how the bug is<br>
manifesting.<br>
<br>
I think you're seeing issues when a guest accesses an adjacent mapping<br>
between the delete and add phases of the KVM MemoryListener.&nbsp; We're<br=
>
considering fixing that in the kernel, by adding a new ioctl that<br>
changes the whole memory map in a single step.&nbsp; I am CCing Peter Xu.<b=
r>
<br>
Paolo<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; softmmu/memory.c&nbsp; | 16 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp; target/i386/cpu.c |&nbsp; 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;<br>
&gt;&nbsp; target/i386/cpu.h |&nbsp; 3 &#43;&#43;&#43;<br>
&gt;&nbsp; 3 files changed, 26 insertions(&#43;), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/softmmu/memory.c b/softmmu/memory.c<br>
&gt; index 70b93104e8..348e9db622 100644<br>
&gt; --- a/softmmu/memory.c<br>
&gt; &#43;&#43;&#43; b/softmmu/memory.c<br>
&gt; @@ -699,6 &#43;699,18 @@ static MemoryRegion *memory_region_get_flatvi=
ew_root(MemoryRegion *mr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;static bool skip_simplify(void)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; char vendor[CPUID_VENDOR_SZ &#43; 1] =3D { 0 }=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; host_get_vendor(vendor);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; if (!strncmp(vendor, CPUID_VENDOR_VIA, strlen(=
CPUID_VENDOR_VIA))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || !strncmp(vendor, CP=
UID_VENDOR_ZHAOXIN,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strlen(CPUID_VENDOR_ZHAOX=
IN))) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; /* Render a memory topology into a list of disjoint absolute ran=
ges. */<br>
&gt;&nbsp; static FlatView *generate_memory_topology(MemoryRegion *mr)<br>
&gt;&nbsp; {<br>
&gt; @@ -712,7 &#43;724,9 @@ static FlatView *generate_memory_topology(Memo=
ryRegion *mr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addrrange_make(int128_zero(), int128_2_6=
4()),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp; flatview_simplify(view);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; if (!skip_simplify()) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatview_simplify(view=
);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; view-&gt;dispatch =3D address_space_disp=
atch_new(view);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; view-&gt;nr; i&#43;=
&#43;) {<br>
&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; index 49d8958528..08508c8580 100644<br>
&gt; --- a/target/i386/cpu.c<br>
&gt; &#43;&#43;&#43; b/target/i386/cpu.c<br>
&gt; @@ -1664,6 &#43;1664,14 @@ void host_cpuid(uint32_t function, uint32_t=
 count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *edx =3D vec[3];=
<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; &#43;void host_get_vendor(char *vendor)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; uint32_t eax, ebx, ecx, edx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; host_cpuid(0x0, 0, &amp;eax, &amp;ebx, &amp;ec=
x, &amp;edx);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp; x86_cpu_vendor_words2str(vendor, ebx, edx, ecx=
);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; void host_vendor_fms(char *vendor, int *family, int *model, int =
*stepping)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t eax, ebx, ecx, edx;<br>
&gt; diff --git a/target/i386/cpu.h b/target/i386/cpu.h<br>
&gt; index d3097be6a5..14c8b4c09f 100644<br>
&gt; --- a/target/i386/cpu.h<br>
&gt; &#43;&#43;&#43; b/target/i386/cpu.h<br>
&gt; @@ -832,6 &#43;832,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORD=
S];<br>
&gt;&nbsp; <br>
&gt;&nbsp; #define CPUID_VENDOR_VIA&nbsp;&nbsp; &quot;CentaurHauls&quot;<br=
>
&gt;&nbsp; <br>
&gt; &#43;#define CPUID_VENDOR_ZHAOXIN&nbsp;&nbsp; &quot;&nbsp; Shanghai&nb=
sp; &quot;<br>
&gt; &#43;<br>
&gt;&nbsp; #define CPUID_VENDOR_HYGON&nbsp;&nbsp;&nbsp; &quot;HygonGenuine&=
quot;<br>
&gt;&nbsp; <br>
&gt;&nbsp; #define IS_INTEL_CPU(env) ((env)-&gt;cpuid_vendor1 =3D=3D CPUID_=
VENDOR_INTEL_1 &amp;&amp; \<br>
&gt; @@ -1917,6 &#43;1919,7 @@ void cpu_clear_apic_feature(CPUX86State *env=
);<br>
&gt;&nbsp; void host_cpuid(uint32_t function, uint32_t count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *eax, uint32_t *ebx, uint32_t *ecx=
, uint32_t *edx);<br>
&gt;&nbsp; void host_vendor_fms(char *vendor, int *family, int *model, int =
*stepping);<br>
&gt; &#43;void host_get_vendor(char *vendor);<br>
&gt;&nbsp; <br>
&gt;&nbsp; /* helper.c */<br>
&gt;&nbsp; bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_d91ca1499e3347278f9a33a8fc314919zhaoxincom_--

