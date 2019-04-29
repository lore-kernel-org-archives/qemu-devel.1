Received: from eggs.gnu.org ([209.51.188.92]:38924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKyH9-0005wH-JG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKyFG-00069Q-3G
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:50:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Apr 2019 04:49:56 +0000
Message-ID: <2e608d6a-8dce-aee8-15e4-a9830a2afd6b@virtuozzo.com>
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
	<20190415144948.78568-6-vsementsov@virtuozzo.com>
	<4f5ed0c3-83d0-bcbe-5866-e0aab67f188f@redhat.com>
In-Reply-To: <4f5ed0c3-83d0-bcbe-5866-e0aab67f188f@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <12A8C8B25D813F4D8A98F0648E02E6F6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 5/5] block/backup: refactor: split out
 backup_calculate_cluster_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjYuMDQuMjAxOSAyMTozMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNS4wNC4xOSAxNjo0OSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNwbGl0IG91dCBjbHVzdGVy
X3NpemUgY2FsY3VsYXRpb24uIE1vdmUgY29weS1iaXRtYXAgY3JlYXRpb24gYWJvdmUNCj4+IGJs
b2NrLWpvYiBjcmVhdGlvbiwgYXMgd2UgYXJlIGdvaW5nIHRvIHNoYXJlIGl0IHdpdGggdXBjb21p
bmcNCj4+IGJhY2t1cC10b3AgZmlsdGVyLCB3aGljaCBhbHNvIHNob3VsZCBiZSBjcmVhdGVkIGJl
Zm9yZSBhY3R1YWwgYmxvY2sgam9iDQo+PiBjcmVhdGlvbi4NCj4+DQo+PiBBbHNvLCB3aGlsZSBi
ZWluZyBoZXJlLCBkcm9wIHVubmVjZXNzYXJ5ICJnb3RvIGVycm9yIiBmcm9tDQo+PiBiZHJ2X2dl
dGxlbmd0aCBlcnJvciBwYXRoLg0KPiANCj4gSXQgaXNu4oCZdCB1bm5lY2Vzc2FyeSwgdGhvdWdo
LiAgQmVmb3JlIHRoaXMsIHdlIGludm9rZQ0KPiBiZHJ2X2RpcnR5X2JpdG1hcF9jcmVhdGVfc3Vj
Y2Vzc29yKCksIHNvIHRoZSBlcnJvciBwYXRoIGhhcyB0byBjbGVhbg0KPiB0aGF0IHVwIHdpdGgg
YmRydl9yZWNsYWltX2RpcnR5X2JpdG1hcCgpLg0KPiANCj4gTWF4DQo+IA0KDQpPb3BzLCB3aWxs
IHJlc2VuZC4gSSB3YXMgbG9va2luZyBhdCBwcmV2aW91cyBwbGFpbiAicmV0dXJuIE5VTEwiLCBi
dXQgbWlzc2VkDQp0aGF0IGluICJpZiIgYnJhbmNoIHdlIGRvIHRoaW5nIHRvIGJlIHJvbGxlZC1i
YWNrIG9uIGZhaWwuDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3IQ0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=
