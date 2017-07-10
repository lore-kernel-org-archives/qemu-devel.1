Received: from eggs.gnu.org ([2001:4830:134:3::10]:45894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUO4D-000177-T6
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 22:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUO4A-0005dm-ON
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 22:04:53 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:36314 helo=zte.com.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUO4A-0005cX-5v
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 22:04:50 -0400
Date: Mon, 10 Jul 2017 10:04:39 +0800 (CST)
Message-ID: <201707101004393739204@zte.com.cn>
Mime-Version: 1.0
From: <jiang.biao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=5D_tcg/mips=3A_Bugfix_for_crash_?=
 =?utf-8?q?when_runningprogram_with_qemu-i386=2E?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: qemu-devel@nongnu.org, james.hogan@imgtec.com, zhong.weidong@zte.com.cn, wang.liang82@zte.com.cn, shi.zhongbing@zte.com.cn, jinguojie@loongson.cn, jiang.yong5@zte.com.cn

Pj4gICAgICAgaWYgKFRDR19UQVJHRVRfUkVHX0JJVFMgPiBUQVJHRVRfTE9OR19CSVRTKSB7DQoN
Cg0KDQo+PiAgICAgICAgICAgdGNnX291dF9leHQzMnUocywgYmFzZSwgYWRkcl9yZWdsKQ0KPj4g
LSAgICAgICAgYWRkcl9yZWdsID0gYmFzZQ0KPj4gKyAgICAgICAgdGNnX291dF9tb3YocywgVENH
X1RZUEVfUFRSLCBhZGRyX3JlZ2wsIGJhc2UpDQo+PiAgICAgICB9DQo+PiAgICAgICBpZiAoZ3Vl
c3RfYmFzZSA9PSAwICYmIGRhdGFfcmVnbCAhPSBhZGRyX3JlZ2wpIHsNCj4+ICAgICAgICAgICBi
YXNlID0gYWRkcl9yZWdsDQo+IA0KPiBUaGlzIGlzIHdyb25nLCBiZWNhdXNlIHlvdSdyZSBub3Qg
YWxsb3dlZCB0byBtb2RpZnkgdGhlIGlucHV0IG9wZXJhbmRzLg0KPiANCj4gVHJ5IHRoaXMsIGp1
c3QgYSBmZXcgbGluZXMgbG93ZXIgaW4gdGhlIGZ1bmN0aW9uOg0KDQo+IC0gICAgICAgIHRjZ19v
dXRfbW92aShzLCBUQ0dfVFlQRV9QVFIsIGJhc2UsIGd1ZXN0X2Jhc2UpDQo+IC0gICAgICAgIHRj
Z19vdXRfb3BjX3JlZyhzLCBBTElBU19QQURELCBiYXNlLCBiYXNlLCBhZGRyX3JlZ2wpDQo+ICsg
ICAgICAgIHRjZ19vdXRfbW92aShzLCBUQ0dfVFlQRV9QVFIsIFRDR19UTVAwLCBndWVzdF9iYXNl
KQ0KPiArICAgICAgICB0Y2dfb3V0X29wY19yZWcocywgQUxJQVNfUEFERCwgYmFzZSwgVENHX1RN
UDAsIGFkZHJfcmVnbCkNCj4NCg0KR290IGl0LCBidXQgdGhlIHJlYWwgcHJvYmxlbSBpcyBmb3Ig
YWRkcl9yZWdsIGluc3RlYWQgb2YgZ3Vlc3RfYmFzZS4NCg0KDQpVc2luZyB5b3VyIGNvZGUgZm9y
IHJlZmVyZW5jZSwgSSdsbCB1c2UgVENHX1RNUDAgZm9yIGFkZHJfcmVnbCBpbnN0ZWFkIA0KDQoN
Cm9mIG1vZGlmeWluZyBpdCwgYW5kIHRoZW4gc2VuZCBwYXRjaCBvZiBuZXcgdmVyc2lvbiBsYXRl
ci4NCg0KDQoNCg0KDQo+DQoNCg0KPiBhbmQgeW91J2xsIG5lZWQgdGhlIHNhbWUgY2hhbmdlIHdp
dGhpbiB0Y2dfb3V0X3FlbXVfc3QuDQpJJ2xsIHdyaXRlIGEgdGVzdCBkZW1vIHRvIHByb2R1Y2Ug
Y3Jhc2ggaW4gdGNnX291dF9xZW11X3N0IGZsb3csIGFuZCBzZW5kDQoNCmFub3RoZXIgcGF0Y2gg
Zm9yIHRoYXQuDQoNCg0KDQoNCg0KPiBCZXR0ZXIgd291bGQgYmUgdG8gcmVzZXJ2ZSBhIHJlZ2lz
dGVyIGZvciB0aGUgZ3Vlc3RfYmFzZSwgbGlrZSB3ZSBkbyBmb3IgcHBjLiANCj4gU2VlIGFsbCBv
ZiB0aGUgdXNlcyBvZiBUQ0dfR1VFU1RfQkFTRV9SRUcgaW4gdGNnL3BwYy90Y2ctdGFyZ2V0Lmlu
Yy5jLg0KSXQgdXNlcyBiYXNlKFRDR19SRUdfQTApIGZvciB0ZW1wZXJhcnkgdXNlIGZvciBndWVz
dF9iYXNlIGluIHRoaXMgY2FzZS4NCg0KDQoNCg0KVGhhbmtzIGEgbG90Lg==
