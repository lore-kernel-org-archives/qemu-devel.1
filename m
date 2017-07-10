Received: from eggs.gnu.org ([2001:4830:134:3::10]:51291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUS8u-0000iQ-JY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUS8p-0006yZ-MS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:26:00 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:35112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dUS8o-0006sz-QO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:25:55 -0400
Date: Mon, 10 Jul 2017 14:25:35 +0800 (CST)
Message-ID: <201707101425356378007@zte.com.cn>
References: 201707101115005493498@zte.com.cn,
	f0290c7b-ff80-6e4d-1ff4-4cd1121aadef@twiddle.net
Mime-Version: 1.0
From: <jiang.biao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=5D_tcg/mips=3A_Bugfix_for_crashw?=
 =?utf-8?q?henrunningprogram_with_qemu-i386=2E?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: james.hogan@imgtec.com, zhong.weidong@zte.com.cn, wang.liang82@zte.com.cn, qemu-devel@nongnu.org, shi.zhongbing@zte.com.cn, jinguojie@loongson.cn, jiang.yong5@zte.com.cn

PiA+IHRoaXMgc2VjdGlvbiBvZiBjb2RlIGlzIHRvIGV4dGVuZCB0aGUgYWRkcl9yZWdsIHRvIDY0
Yml0LCBhbmQgdXNlICpiYXNlKiBhcyB0ZW1wDQoNCg0KDQoNCg0KPiA+IGludGVybWVkaWEuIFRo
ZSByZWFsIGludGVudGlvbiBjb3VsZCBiZSB0byBleHRlbmQgYWRkcl9yZWdsIGludG8gYmFzZSwg
YW5kIHRoZW4NCj4gPiBtb3ZlIGJhc2UgYmFjayB0byBhZGRyX3JlZ2wgZm9yIGxhdGVyIHVzZSwg
YnV0IGl0IHdyb25nbHkgYXNzaWduaW5nICBiYXNlIHRvDQo+ID4gYWRkcl9yZWdsIGRpcmVjdGx5
LCB3aGljaCB3aWxsIGNhdXNlIGNyYXNoIGZvciBldmVyeSB1c2Ugb2YgdGNnX291dF9xZW11X3N0
Lg0KPiANCj4gVGhlIGludGVudCBpcyB0byB6ZXJvLWV4dGVuZCBhZGRyX3JlZ2wgaW50byBhIHRl
bXBvcmFyeSBiYXNlID0gQTAsIGFuZCBhdCB0aGlzIA0KPiBwb2ludCBpcyBrbm93biB0byBiZSB1
bnVzZWQuICBBZnRlcndhcmQsIHdoZW5ldmVyIHdlIHRhbGsgYWJvdXQgdGhlIGxvdyBwYXJ0IG9m
IA0KPiB0aGUgYWRkcmVzcywgd2Ugd2FudCB0byB1c2UgdGhlIHRlbXBvcmFyeSBhbmQgbm90IHRo
ZSBvcmlnaW5hbCBpbnB1dC4NCj4gDQo+IEZvciBleGFtcGxlLCBpZiBhZGRyX3JlZ2wgPSBTMCwg
YW5kIGd1ZXN0X2Jhc2UgPSBTMSwgdGhlbiB3ZSB3YW50DQo+IA0KPiAgICAgZGV4dCAgICBhMCwg
czAsIDMxLCAwDQo+ICAgIGRhZGQgICAgYTAsIHMxLCBhMA0KPiANCj4gaW5zdGVhZCBvZg0KPiAN
Cj4gICAgIGRleHQgICAgYTAsIHMwLCAzMSwgMA0KPiAgICAgbW92ICAgIHMwLCBhMA0KPiAgICAg
ZGFkZCAgICBhMCwgczEsIHMwDQpHb3Qgd2hhdCB5b3UgbWVhbiBmaW5hbGx5IDotKSwgaXQgaXMg
YmV0dGVyIGluZGVlZC4gDQoNCg0KSSdsbCBzZW5kIGEgbmV3IHZlcnNpb24gcGF0Y2ggZm9yIHRo
YXQsIGFuZCBzZW5kIGFub3RoZXIgcGF0Y2ggdHJ5aW5nIA0KDQoNCnRvIG9wdGltaXplIHRoZSB1
c2Ugb2YgcmVnaXN0ZXIgYnkgZ3Vlc3RfYmFzZSAu
