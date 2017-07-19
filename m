Received: from eggs.gnu.org ([2001:4830:134:3::10]:32891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXker-0000NX-LJ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXkeo-0000rx-CD
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:48:37 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:57437)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXken-0000pP-Hw
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:48:34 -0400
Date: Wed, 19 Jul 2017 16:48:23 +0800 (CST)
Message-ID: <201707191648232246645@zte.com.cn>
References: 201707191247531805742@zte.com.cn,20170719081028.GA2103@work-vm
Mime-Version: 1.0
From: <wang.yi59@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_v2=5D_hmp=3A_allow_cpu_index_for?=
 =?utf-8?q?_=22info_lapic=22?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

Piogd2FuZy55aTU5QHp0ZS5jb20uY24gKHdhbmcueWk1OUB6dGUuY29tLmNuKSB3cm90ZToNCg0K
DQo+PiBIaSBFZHVhcmRvLA0KDQo+PiANCg0KPj4gVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IQ0K
DQo+PiANCg0KPj4gPk9uIE1vbiwgSnVsIDE3LCAyMDE3IGF0IDA5OjQ5OjM3UE0gLTA0MDAsIFlp
IFdhbmcgd3JvdGU6DQoNCj4+IA0KDQo+PiA+PiBBZGQgW3ZjcHVdIGluZGV4IHN1cHBvcnQgZm9y
IGhtcCBjb21tYW5kICJpbmZvIGxhcGljIiwgd2hpY2ggaXMNCg0KPj4gDQoNCj4+ID4+IHVzZWZ1
bCB3aGVuIGRlYnVnZ2luZyBpcGkgYW5kIHNvIG9uLiBDdXJyZW50IGJlaGF2aW9yIGlzIG5vdA0K
DQo+PiANCg0KPj4gPj4gY2hhbmdlZCB3aGVuIHRoZSBwYXJhbWV0ZXIgaXNuJ3Qgc3BlY2lmaWVk
Lg0KDQo+PiANCg0KPj4gPj4gDQoNCj4+IA0KDQo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBZaSBXYW5n
IDx3YW5nLnlpNTlAenRlLmNvbS5jbj4NCg0KPj4gDQoNCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFl1
biBMaXUgPGxpdS55dW5oQHp0ZS5jb20uY24+DQoNCj4+IA0KDQo+PiA+DQoNCj4+IA0KDQo+PiA+
V2UgaGF2ZSA4IG1vbml0b3IgY29tbWFuZHMgKHNlZSBiZWxvdykgdGhhdCB1c2UgdGhlIENQVSBz
ZXQgYnkNCg0KPj4gPnRoZSAiY3B1IiBjb21tYW5kIChtb25fZ2V0X2NwdSgpKSBhcyBpbnB1dC4g
IFdoeSBpcyAiaW5mbyBsYXBpYyINCg0KPj4gPnNwZWNpYWw/DQoNCj4+IA0KDQo+PiBXaGVuIHdl
IGRlYnVnZ2luZyBhIHByb2JsZW0gb2YgaXBpLCB3ZSB3YW50ZWQgdG8gdmVyaWZ5IGxhcGljIGlu
Zm8NCg0KPj4gb24gZWFjaCB2Q1BVLCBidXQgd2UgZm91bmQgdGhhdCB3ZSBjb3VsZCBvbmx5IGdl
dCB2Q1BVIDAncyBsYXBpYw0KDQo+PiB0aHJvdWdoICJpbmZvIGxhcGljIiwgc28gd2Ugc3VwcG9z
ZWQgdGhpcyBwYXRjaCBjb3VsZCBoZWxwIHRob3NlDQoNCj4+IHdobyBoYXZlIHRoZSBzYW1lIHBy
b2JsZW0gYXMgdXMuDQoNCj4NCg0KPkkgdGhpbmsgRWR1YXJkbydzIHBvaW50IGlzIHRoYXQgeW91
IGNhbiBhbHJlYWR5IGRvOg0KDQo+ICAgIGNwdSAwDQoNCj4gICAgaW5mbyBsYXBpYw0KDQo+ICAg
IGNwdSAxDQoNCj4gICAgaW5mbyBsYXBpYw0KDQpZZXMsIEkgZ2V0IGl0LCB0aGFuayB5b3UuDQoN
ClRoZSByZWFzb24gb2YgdGhlIHByb2JsZW0gd2UgbWV0IGlzIHRoYXQgd2UgdXNlICJ2aXJzaCBx
ZW11LW1vbml0b3ItY29tbWFuZCIsDQoNCnNvIHRoZSAnY3B1JyBjb21tYW5kIGRpZG4ndCB3b3Jr
Lg0KDQoNCg0KDQoNCg0KDQoNCi0tLQ0KDQpCZXN0IHdpc2hlcw0KDQpZaSBXYW5n
