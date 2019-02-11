Received: from eggs.gnu.org ([209.51.188.92]:59987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtF9g-000280-QL
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtEuM-0006zT-8F
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:58:16 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 16:58:05 +0000
Message-ID: <1ea995a3-38d1-61b9-6868-f007172a2341@virtuozzo.com>
References: <1548244464-633186-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51o97m8ltv.fsf@maestria.local.igalia.com>
	<41e29129-196d-1b24-03ae-373b7d357725@virtuozzo.com>
	<w51sgwuv2ok.fsf@maestria.local.igalia.com>
	<6b3c82fb-b4a2-7802-1737-a34e22130114@virtuozzo.com>
	<w51mun2uxts.fsf@maestria.local.igalia.com>
In-Reply-To: <w51mun2uxts.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E332FB6894D85D4DBBC056068157DDF0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 1/1] Stream block job
 involves copy-on-read filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

MTEuMDIuMjAxOSAxODo1MiwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIE1vbiAxMSBGZWIg
MjAxOSAwMzo1MTozMyBQTSBDRVQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+Pj4+PiBJIHRoaW5rIHRoaXMgd2FzIGFscmVhZHkgZGlzY3Vzc2VkIGluIHRoZSBwcmV2aW91
cyB2ZXJzaW9uIG9mIHRoaXMNCj4+Pj4+IHBhdGNoOiBpZiB5b3UgaW5zZXJ0IGEgY29weS1vbi1y
ZWFkIGZpbHRlciBoZXJlIHRoZW4gYWxsIGd1ZXN0DQo+Pj4+PiByZWFkcyB3aWxsIGNvcHkgdGhl
IGRhdGEgZnJvbSB0aGUgYmFja2luZyBjaGFpbiwgYnV0IHlvdSBkb24ndCB3YW50DQo+Pj4+PiB0
byBjb3B5IGFueXRoaW5nIGJlbG93IHRoZSAnYmFzZScgbm9kZSwgc28gdGhlIGNvcHktb24tcmVh
ZCBmaWx0ZXINCj4+Pj4+IG5lZWRzIGEgJ2Jhc2UnIHBhcmFtZXRlci4NCj4+Pj4+DQo+Pj4+IEJl
Zm9yZSB0aGF0LCB3ZSBzdGlsbCBoYXZlIHRoZSB1bnJlc29sdmVkIGlzc3VlIHdpdGggZ2V0dGlu
ZyB0aGUNCj4+Pj4gZmlsdGVyIGFzIHRoZSAnYmFzZScgaW5wdXQgcGFyYW1ldGVyLiBUaGF0IGhh
cHBlbnMgc29tZXRpbWVzIGJlY2F1c2UNCj4+Pj4gdGhlIGJhc2UgaXMgYmVpbmcgc2VhcmNoZWQg
YnkgdGhlIGZpbGUgbmFtZSwgd2hpY2ggaXMgdGhlIHNhbWUgdG8NCj4+Pj4gdGhlIG9uZSBvZiB0
aGUgZmlsdGVyLCByYXRoZXIgdGhhbiBieSB0aGUgbm9kZSBuYW1lICghKQ0KPj4+DQo+Pj4gSSdt
IG5vdCBzdXJlIGlmIEkgdW5kZXJzdGFuZC4gYmxvY2stc3RyZWFtIGhhcyAnYmFzZScgYW5kICdi
YXNlLW5vZGUnDQo+Pj4gcGFyYW1ldGVycywgYW5kIGluIHRoZSBmaXJzdCBjYXNlIHlvdSB3b3Vs
ZCBjb252ZXJ0IHRoZSBmaWxlIG5hbWUgdG8NCj4+PiBhIG5vZGUgbmFtZS4NCj4+Pg0KPj4+IHN0
cmVhbV9zdGFydCgpIGdldHMgdGhlIEJsb2NrRHJpdmVyU3RhdGUsIG5vdCB0aGUgZmlsZSBuYW1l
LCBzbyB3aHkNCj4+PiBjYW4ndCB5b3UgZ2V0IHRoZSBub2RlIG5hbWUgZnJvbSB0aGVyZSBhbmQg
cGFzcyBpdCB0byB0aGUNCj4+PiBjb3B5LW9uLXJlYWQgZmlsdGVyPw0KPj4NCj4+IFRoZSBwcm9i
bGVtIGlzIGluIHRoZSBjb25jZXB0IG9mICJiYXNlIiBub2RlLiBUaGUgY29kZSB3cml0dGVuIGlu
DQo+PiBtYW5uZXIgdGhhdCBiYXNlIGlzIG5vdCBjaGFuZ2VkIGR1cmluZyBibG9jayBqb2IuIEhv
d2V2ZXIsIGpvYiBkb24ndA0KPj4gb3duIGJhc2UgYW5kIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0
aGF0IGl0IHdpbGwgbm90IGNoYW5nZSBkdXJpbmcgdGhlDQo+PiBqb2IuDQo+IA0KPiBCdXQgaWYg
dGhhdCdzIHRoZSBjYXNlIHRoZW4gd2UgaGF2ZSBhIHByb2JsZW0gYWxyZWFkeSwgYmVjYXVzZSAn
YmFzZScgaXMNCj4gYSBtZW1iZXIgb2YgU3RyZWFtQmxvY2tKb2IgYW5kIGlzIHVzZWQgaW4gdGhl
IGV4aXN0aW5nIHN0cmVhbV9ydW4oKQ0KPiBjb2RlLg0KDQpJIHRoaW5rIGl0IHNob3VsZCBiZSBw
b3NzaWJsZSB0byByZXByb2R1Y2UsIHVzaW5nIGJsb2NrLWNvbW1pdCAod2hpY2ggYWxyZWFkeSBo
YXMNCmZpbHRlcikgd2l0aCBibG9jay1zdHJlYW0gaW4gcGFyYWxsZWwsIHdlJ2xsIHRyeS4NCg0K
PiANCj4gU28gaWYgdGhlcmUncyBhIHdheSB0byBtYWtlICdiYXNlJyBkaXNhcHBlYXIgZHVyaW5n
IHRoZSBqb2IgKGhvdz8pIHRoZW4NCj4gd2UgY291bGQgcHJvdGVjdCBpdCB3aXRoIGJsb2NrX2pv
Yl9hZGRfYmRydigpLg0KDQpJJ20gbm90IHN1cmUgdGhpcyBpcyBjb3JyZWN0LiBXaGF0IGlzIHRo
ZSByZWFzb24gZm9yIHN0cmVhbSB0byBvd24gYmFzZT8gSXQncyBub3QNCnJlYWxseSBpbnRlcmVz
dGVkIGluIGl0Lg0KDQpBdCBsZWFzdCBpdCdsbCBicmVhayBpb3Rlc3QgdGVzdF9zdHJlYW1fcGFy
YWxsZWwgd2hpY2ggY3JlYXRlcyBwYXJhbGxlbCBzdHJlYW0gam9icywNCndoaWNoIHNoYXJlcyBi
b3JkZXItbm9kZXMgKG9uZXMgdG9wIGlzIG90aGVycyBiYXNlKS4gSG93ZXZlciB0aGlzIHNjZW5h
cmlvIGxvb2tzDQpub3QgcmVhbC1saWZlLg0KDQpTbywgaXQncyBxdWVzdGlvbmFibGUsIHNob3Vs
ZCBzdHJlYW0gYmxvY2sgYmFzZSBvciBub3QuIE5vdCBibG9ja2luZyBpcyBhbnl3YXkgbW9yZQ0K
ZmxleGlibGUsIGFuZCBteSBzdWdnZXN0aW9uIHRyaWVzIHRvIGtlZXAgYmFzZSBub3QgYmxvY2tl
ZC4NCg0KSG0sIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGNvbnRpbnVlIGRpc2N1c3Np
b24gb3ZlciB3b3JraW5nIHJlcHJvZHVjZXIsDQpJIGhvcGUgd2UnbGwgbWFrZSBpdCBzb29uLg0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
