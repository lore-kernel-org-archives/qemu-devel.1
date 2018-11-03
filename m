Received: from eggs.gnu.org ([2001:4830:134:3::10]:47178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gIjp0-0005bh-P1
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 20:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gIjox-00083Q-GV
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 20:29:50 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Sat, 3 Nov 2018 00:29:33 +0000
Message-ID: <66efaf0d-1e29-4583-f6d4-674d12a978a7@janustech.com>
References: <20181102085800.21860-1-philmd@redhat.com>
	<20181102110734.GE7521@dhcp-200-186.str.redhat.com>
	<6d96d96b-21f7-d5fc-9313-8ede0f6a745c@redhat.com>
	<20181102141030.GH7521@dhcp-200-186.str.redhat.com>
	<0b2d802d-4b58-30de-44a8-9f04dc968b1b@redhat.com>
	<20181102152800.GI7521@dhcp-200-186.str.redhat.com>
In-Reply-To: <20181102152800.GI7521@dhcp-200-186.str.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA0F9BF52B80634D8541ECFE709919B2@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qemu/units: Move out QCow2 specific
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

SGksDQoNCk9uIDExLzIvMTggNToyOCBQTSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDIuMTEu
MjAxOCB1bSAxNTo1MiBoYXQgRXJpYyBCbGFrZSBnZXNjaHJpZWJlbjoNCj4+IE9uIDExLzIvMTgg
OToxMCBBTSwgS2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAwMi4xMS4yMDE4IHVtIDEzOjM3IGhh
dCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSBnZXNjaHJpZWJlbjoNCj4+Pj4gSGkgS2V2aW4sDQo+
Pj4+DQo+Pj4+IE9uIDIvMTEvMTggMTI6MDcsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+PiBBbSAw
Mi4xMS4yMDE4IHVtIDA5OjU4IGhhdCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSBnZXNjaHJpZWJl
bjoNCj4+Pj4+PiBUaGlzIGRlZmluaXRpb25zIGFyZSBRQ293MiBzcGVjaWZpYywgdGhlcmUgaXMg
bm8gbmVlZCB0byBleHBvc2UgdGhlbQ0KPj4+Pj4+IGluIHRoZSBnbG9iYWwgbmFtZXNwYWNlLg0K
DQpUaGVzZSBhcmUgbm90IFFDT1cyIHNwZWNpZmljLiBJIHdyb3RlIHRoZXNlIGZvciBjb252ZW5p
ZW5jZSBpbiBRQ09XMiwgDQpidXQgdGhlcmUgYXJlIG1hbnkgb3RoZXIgcGxhY2VzIHdoZXJlIHRo
ZXNlIGNhbiBiZSB1c2VkIChtYW55IA0KcHJlLWRlZmluZWQgc2l6ZXMgYXJlIHBvd2VycyBvZiB0
d28pLCBhbmQgdGhlcmUgYXJlIGZldyBwbGFjZXMgd2hlcmUgDQp0aGV5IG11c3QgcmVwbGFjZSB0
aGUgY3VycmVudCBub3RhdGlvbiwgbGlrZSBpbiBibG9jay92ZGkuYyB3aXRoIA0KREVGQVVMVF9D
TFVTVEVSX1NJWkUgKHVubGVzcyBhbiBleHBsaWNpdCB2YWx1ZSBpbiBieXRlcyB3aWxsIGJlIGRl
ZmluZWQgDQppbnN0ZWFkKS4NCg0KPj4NCj4+IEFncmVlZC4gSSBkaWRuJ3Qgd2FudCBpdCBpbiB0
aGUgZmlyc3QgcGxhY2UsIGFyZ3VpbmcgdGhhdCBpZiB3ZSB3YW50DQo+PiBzdHJpbmdpZmljYXRp
b24gb2YgZGVmYXVsdHMsIGl0IHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGEgcnVudGltZSBmdW5j
dGlvbg0KPj4gZG8gdGhhdCwgcmF0aGVyIHRoYW4gYWRkaW5nIGEgc2V0IG9mIG5lYXItZHVwbGlj
YXRlIG1hY3JvIG5hbWVzLg0KDQpBIHJ1bnRpbWUgZnVuY3Rpb24gd2lsbCBub3QgaGVscCBoZXJl
LCBhcyB0aGVzZSBhcmUgdXNlZCBpbiBjb21waWxlIA0KdGltZS4gVGhlc2UgcmVzdWx0IGluIHN0
cmluZ3MgdGhhdCBhcmUgYWN0dWFsbHkgY29tcGlsZWQgaW50byB0aGUgYmluYXJpZXMuDQoNCj4+
Pg0KPj4+IFRoZW4gdGhlcmUgaXMgVkRJIHdoaWNoIHVzZXMgKDEgKiBNaUIpLCBidXQgdGhhdCBp
cyBjb21waWxlZCBvdXQgYW5kIGlmDQo+Pj4geW91IGVuYWJsZSBpdCwgaXQgYnJlYWtzLiBTbyBp
dCBuZWVkcyB0aGUgc2FtZSBmaXguDQoNClllYWgsIEkgbmVlZCB0byBmaXggdGhhdCBhcyBwcm9t
aXNlZC4gV2lsbCBkbyBzaG9ydGx5LiA6KQ0KDQpMZW9uaWQuDQo=
