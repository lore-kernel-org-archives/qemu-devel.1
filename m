Received: from eggs.gnu.org ([2001:4830:134:3::10]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g82P2-00009m-Mr
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g82P1-0002RZ-U1
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:06:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 4 Oct 2018 12:06:18 +0000
Message-ID: <f4be9f7d-417f-58c2-a78b-3f950b17f2cd@virtuozzo.com>
References: <20181002233314.30159-1-jsnow@redhat.com>
	<79b55f31-00a9-273f-e004-6c097a2f1542@virtuozzo.com>
	<ee24dc7f-7685-aaae-3315-60d66284bb23@redhat.com>
	<a0d3a14f-610f-c326-004b-336f49c98f39@redhat.com>
	<48fef418-d99d-b4d2-d007-062f1275ad8a@redhat.com>
In-Reply-To: <48fef418-d99d-b4d2-d007-062f1275ad8a@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C12DE21C4E1A246A29BD58AB6CBE8EE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

MDMuMTAuMjAxOCAyMzowMSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMy8xOCAyOjU3IFBN
LCBKb2huIFNub3cgd3JvdGU6DQo+DQo+Pj4+IMKgwqAgwqAtIEkgYWx3YXlzIGZvcmdldCB0byB1
cGRhdGUgdGhpcyBmaWVsZC4uIFdlIGRlZmluaXRlbHkgc2hvdWxkIA0KPj4+PiBhZGQgc29tZQ0K
Pj4+PiBnZW5lcmljIGNoZWNrIG9uIGl0IHNvbWV3aGVyZSwgYXQgbGVhc3QgaW4gdGVzdHMuDQo+
Pj4NCj4+PiBNeSBzdWdnZXN0aW9uIChpbiBhbm90aGVyIHRocmVhZCkgd2FzIHRvIGVuaGFuY2UN
Cj4+PiB4LWRlYnVnLWJsb2NrLWRpcnR5LWJpdG1hcC1zaGEyNTYgdG8gaW5jbHVkZSAnY291bnQn
IGFsb25nc2lkZSB0aGUNCj4+PiBjaGVja3N1bSwgdG8gbWFrZSBpdCBlYXNpZXIgdG8gd3JpdGUg
c3VjaCB0ZXN0cy4NCj4+Pg0KPj4NCj4+IEkgc3VwcG9zZSB0aGlzIGlzIGluIHByZWZlcmVuY2Ug
dG8gcXVlcnktYmxvY2s/IEl0IHdvdWxkIG1ha2UgaXQgZWFzaWVyLg0KPg0KPiBXZWxsLCBxdWVy
eS1ibG9jayByZW1haW5zIHRoZSBjYW5vbmljYWwgd2F5IGZvciB1c2VycyB0byBhY2Nlc3MgdGhl
IA0KPiBjb3VudCwgd2hpbGUgeC1kZWJ1Zy1ibG9jay1kaXJ0eS1iaXRtYXAtc2hhMjU2IGlzIGZv
ciBkZWJ1Z2dpbmcgb25seSANCj4gKGJhc2ljYWxseSwgZm9yIG91ciB1bml0IHRlc3RzLCBhcyBu
byBvbmUgb3V0c2lkZSBvZiBxZW11IHdpbGwgZ2V0IA0KPiBtdWNoIHVzZSBvdXQgb2YgaXQpLsKg
IEJ1dCB5ZXMsIHdyaXRpbmcgYSB0ZXN0IHRoYXQgdXNlcyBiaXRtYXBzIG9uIGFuIA0KPiB1bmNv
bm5lY3RlZCBCRFMgaXMgZWFzaWVyIHRoYW4gYSB0ZXN0IHRoYXQgaGFzIHRvIHVzZSBhIG5hbWVk
IGRldmljZSwgDQo+IHNpbmNlIHF1ZXJ5LWJsb2NrIHdvbid0IGxpc3Qgbm9kZXMgdGhhdCBhcmVu
J3QgY29ubmVjdGVkIHRvIGEgbmFtZWQgDQo+IGRldmljZSwgYW5kIHJlcXVpcmVzIGEgbG90IG1v
cmUgcGFyc2luZyB0byBnZXQgYXQgdGhlIGFjdHVhbCBiaXRtYXAgDQo+IGluZm9ybWF0aW9uIGlu
IGNvbXBhcmlzb24gdG8gdGhlIGRlYnVnIGNvbW1hbmQgZGlyZWN0bHkgdGVsbGluZyB5b3UgDQo+
IGFib3V0IGEgc2luZ2xlIGJpdG1hcC4NCj4NCg0KSSB0aGluayB0aGUgYmVzdCBwbGFjZSBpcyBi
aXRtYXAgdW5pdCB0ZXN0LCB3aGljaCBpcyB0ZXN0cy90ZXN0LWJpdG1hcHMsIA0KYW5kIHdlIGRv
bid0IG5lZWQgYWRkaXRpb25hbCBhcGkNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
DQo=
