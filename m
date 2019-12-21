Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680FDC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 02:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FA0206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 02:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FA0206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiUDR-00026y-9S
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 21:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wang.yongD@h3c.com>) id 1iiUCZ-0001iQ-5c
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 21:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wang.yongD@h3c.com>) id 1iiUCX-0007xh-KQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 21:09:06 -0500
Received: from smtp.h3c.com ([60.191.123.56]:13270 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wang.yongD@h3c.com>) id 1iiUCW-00072K-SI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 21:09:05 -0500
Received: from DAG2EX09-IDC.srv.huawei-3com.com ([10.8.0.72])
 by h3cspam01-ex.h3c.com with ESMTPS id xBL27IXT031638
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 21 Dec 2019 10:07:18 +0800 (GMT-8)
 (envelope-from wang.yongD@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX09-IDC.srv.huawei-3com.com (10.8.0.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 21 Dec 2019 10:07:19 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Sat, 21 Dec 2019 10:07:19 +0800
From: Wangyong <wang.yongD@h3c.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: RE: issue about virtio-blk queue size
Thread-Topic: issue about virtio-blk queue size
Thread-Index: AdWkwymM2x+KvjIaQMm6NC0SqitPwwE4PnOAAFjHq6AC9D/wgAAya+Dw
Date: Sat, 21 Dec 2019 02:07:19 +0000
Message-ID: <1ab2f9ecb3c04728aeffaa1e6d8beb0f@h3c.com>
References: <8920655f41aa4d1bbd5b7590ac0d1bef@h3c.com>
 <20191203143731.GD230219@stefanha-x1.localdomain>
 <18dcb1c11c1d481eadf491f9074f6306@h3c.com>
 <20191220095321.GB1635864@stefanha-x1.localdomain>
In-Reply-To: <20191220095321.GB1635864@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.162]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com xBL27IXT031638
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.56
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "hch@lst.de" <hch@lst.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBTdGVmYW4gSGFqbm9jemkgW21haWx0bzpzdGVmYW5oYUBnbWFpbC5jb21dDQo+IFNl
bnQ6IEZyaWRheSwgRGVjZW1iZXIgMjAsIDIwMTkgNTo1MyBQTQ0KPiBUbzogd2FuZ3lvbmcgKENs
b3VkKSA8d2FuZy55b25nREBoM2MuY29tPg0KPiBDYzogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPjsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gbWFyay5rYW5kYUBvcmFjbGUu
Y29tOyBoY2hAbHN0LmRlOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IGlz
c3VlIGFib3V0IHZpcnRpby1ibGsgcXVldWUgc2l6ZQ0KPg0KPiBPbiBUaHUsIERlYyAwNSwgMjAx
OSBhdCAwMTozMDowOUFNICswMDAwLCBXYW5neW9uZyB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBU
aHUsIE5vdiAyOCwgMjAxOSBhdCAwODo0NDo0M0FNICswMDAwLCBXYW5neW9uZyB3cm90ZToNCj4g
PiA+ID4gSGkgYWxsLA0KPiA+ID4NCj4gPiA+IFRoaXMgbG9va3MgaW50ZXJlc3RpbmcsIHBsZWFz
ZSBjb250aW51ZSB0aGlzIGRpc2N1c3Npb24gb24gdGhlIFFFTVUNCj4gPiA+IG1haWxpbmcgbGlz
dCA8cWVtdS1kZXZlbEBub25nbnUub3JnPiBzbyB0aGF0IG90aGVycyBjYW4gcGFydGljaXBhdGUu
DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIG1ha2VzIHZpcnRpb19ibGsgcXVl
dWUgc2l6ZSBjb25maWd1cmFibGUNCj4gPiA+ID4NCj4gPiA+ID4gY29tbWl0IDYwNDBhZWRkZGI1
ZjQ3NGE5YzIzMDRiNmE0MzJhNjUyZDgyYjNkM2MNCj4gPiA+ID4gQXV0aG9yOiBNYXJrIEthbmRh
IDxtYXJrLmthbmRhQG9yYWNsZS5jb20+DQo+ID4gPiA+IERhdGU6ICAgTW9uIERlYyAxMSAwOTox
NjoyNCAyMDE3IC0wNjAwDQo+ID4gPiA+DQo+ID4gPiA+ICAgICB2aXJ0aW8tYmxrOiBtYWtlIHF1
ZXVlIHNpemUgY29uZmlndXJhYmxlDQo+ID4gPiA+DQo+ID4gPiA+IEJ1dCB3aGVuIHdlIHNldCB0
aGUgcXVldWUgc2l6ZSB0byBtb3JlIHRoYW4gMTI4LCBpdCB3aWxsIG5vdCB0YWtlIGVmZmVjdC4N
Cj4gPiA+ID4NCj4gPiA+ID4gVGhhdCdzIGJlY2F1c2UgbGludXggYWlvJ3MgbWF4aW11bSBvdXRz
dGFuZGluZyByZXF1ZXN0cyBhdCBhIHRpbWUNCj4gPiA+ID4gaXMgYWx3YXlzIGxlc3MgdGhhbiBv
ciBlcXVhbCB0byAxMjgNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGZvbGxvd2luZyBjb2RlIGxpbWl0
cyB0aGUgb3V0c3RhbmRpbmcgcmVxdWVzdHMgYXQgYSB0aW1lOg0KPiA+ID4gPg0KPiA+ID4gPiAj
ZGVmaW5lIE1BWF9FVkVOVFMgMTI4DQo+ID4gPiA+DQo+ID4gPiA+IGxhaW9fZG9fc3VibWl0KCkN
Cj4gPiA+ID4gew0KPiA+ID4gPg0KPiA+ID4gPiAgICAgaWYgKCFzLT5pb19xLmJsb2NrZWQgJiYN
Cj4gPiA+ID4gICAgICAgICAoIXMtPmlvX3EucGx1Z2dlZCB8fA0KPiA+ID4gPiAgICAgICAgICBz
LT5pb19xLmluX2ZsaWdodCArIHMtPmlvX3EuaW5fcXVldWUgPj0gTUFYX0VWRU5UUykpIHsNCj4g
PiA+ID4gICAgICAgICBpb3Ffc3VibWl0KHMpOw0KPiA+ID4gPiAgICAgfQ0KPiA+ID4gPiB9DQo+
ID4gPiA+DQo+ID4gPiA+IFNob3VsZCB3ZSBtYWtlIHRoZSB2YWx1ZSBvZiBNQVhfRVZFTlRTIGNv
bmZpZ3VyYWJsZSA/DQo+ID4gPg0KPiA+ID4gSW5jcmVhc2luZyBNQVhfRVZFTlRTIHRvIGEgbGFy
Z2VyIGhhcmRjb2RlZCB2YWx1ZSBzZWVtcyByZWFzb25hYmxlDQo+ID4gPiBhcyBhIHNob3J0dGVy
bSBmaXguICBQbGVhc2UgZmlyc3QgY2hlY2sgaG93IC9wcm9jL3N5cy9mcy9haW8tbWF4LW5yDQo+
ID4gPiBhbmQNCj4gPiA+IGlvX3NldHVwKDIpIGhhbmRsZSB0aGlzIHJlc291cmNlIGxpbWl0LiAg
VGhlIHBhdGNoIG11c3Qgbm90IGJyZWFrDQo+ID4gPiBleGlzdGluZyBzeXN0ZW1zIHdoZXJlIDEy
OCB3b3JrcyB0b2RheS4NCj4gPiBbcm9vdEBub2RlMiB+XSMgY2F0IC9ldGMvY2VudG9zLXJlbGVh
c2UgQ2VudE9TIExpbnV4IHJlbGVhc2UgNy41LjE4MDQNCj4gPiAoQ29yZSkNCj4gPg0KPiA+IFty
b290QG5vZGUyIH5dIyBjYXQgL3Byb2Mvc3lzL2ZzL2Fpby1tYXgtbnINCj4gPiA0Mjk0OTY3Mjk2
DQo+ID4NCj4gPiA+ID4gTUFYX0VWRU5UUyBzaG91bGQgaGF2ZSB0aGUgc2FtZSB2YWx1ZSBhcyBx
dWV1ZSBzaXplID8NCj4gPiA+DQo+ID4gPiBNdWx0aXBsZSB2aXJ0aW8tYmxrIGRldmljZXMgY2Fu
IHNoYXJlIGEgc2luZ2xlIEFpb0NvbnRleHQsDQo+ID4gSXMgbXVsdGlwbGUgdmlydGlvLWJsayBj
b25maWd1cmVkIHdpdGggb25lIElPVGhyZWFkPw0KPiA+IE11bHRpcGxlIHZpcnRpby1ibGsgcGVy
Zm9ybWFuY2Ugd2lsbCBiZSB3b3JzZS4NCj4NCj4gWWVzLiAgQnkgZGVmYXVsdCBJT1RocmVhZHMg
YXJlIG5vdCB1c2VkIGFuZCBhbGwgdmlydGlvLWJsayBkZXZpY2VzIHNoYXJlIHRoZQ0KPiBtYWlu
IGxvb3AncyBBaW9Db250ZXh0Lg0KPg0KPiBXaGVuIElPVGhyZWFkcyBhcmUgY29uZmlndXJlZCBp
dCdzIHVwIHRvIHRoZSB1c2VyIGhvdyB0byBhc3NpZ24gZGV2aWNlcyB0bw0KPiBJT1RocmVhZHMu
ICBBc3NpZ25pbmcgbXVsdGlwbGUgZGV2aWNlcyB0byBvbmUgSU9UaHJlYWQgaXMgcmVhbGlzdGlj
IGJlY2F1c2UNCj4gaXQncyBjb21tb24gdG8gY3JlYXRlIG9ubHkgbnVtX3ZjcHVzIElPVGhyZWFk
cy4NCj4NCj4gQSBnb29kIHN0YXJ0aW5nIHBvaW50IHdvdWxkIGJlIGEgcGF0Y2ggdGhhdCByYWlz
ZXMgdGhlIGxpbWl0IHRvIGEgaGlnaGVyDQo+IGhhcmRjb2RlZCBudW1iZXIuICBUaGVuIHlvdSBj
YW4gaW52ZXN0aWdhdGUgaG93IHRvIHNpemUgdGhlIEFpb0NvbnRleHQNCj4gYXBwcm9wcmlhdGVs
eSAobWF5YmUgZHluYW1pY2FsbHk/KSBmb3IgYSBmdWxsIGZpeC4NCj4NCk9rYXkuICBSYWlzaW5n
IE1BWF9FVkVOVCB0byAxMDI0IG1heSBiZSBtb3JlIGFwcHJvcHJpYXRlPyBJZiBwb3NzaWJsZSBJ
IGNhbiB0cnkgdG8gbWFrZSBhIHBhdGNoLg0KDQo+IFN0ZWZhbg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0K5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5paw5Y2O5LiJ6ZuG5Zui55qE5L+d5a+G5L+h
5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye6DQrnmoTkuKrkurrm
iJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjl
jIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIENCuaI
luaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmC
ruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZ
pOacrA0K6YKu5Lu277yBDQpUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4g
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTmV3IEgzQywgd2hpY2ggaXMNCmludGVuZGVk
IG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFi
b3ZlLiBBbnkgdXNlIG9mIHRoZQ0KaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkg
d2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbA0KZGlz
Y2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVy
IHRoYW4gdGhlIGludGVuZGVkDQpyZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJl
Y2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlcg0KYnkg
cGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCENCg==

