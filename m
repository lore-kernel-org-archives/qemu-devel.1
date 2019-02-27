Received: from eggs.gnu.org ([209.51.188.92]:44252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1gyz8e-0006Oj-Gm
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1gyz8d-0007tc-8I
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:20:44 -0500
From: Denis Lunev <den@virtuozzo.com>
Date: Wed, 27 Feb 2019 13:16:11 +0000
Message-ID: <7414a532-3005-5cfe-6f29-77cf95eeb4d2@virtuozzo.com>
References: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
	<efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
In-Reply-To: <efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5917E8A90EBC6468ABEDB8C2D26AE7A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Discard old bitmap directories in QCOW2
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>

T24gMi8yNy8xOSA0OjAwIFBNLCBNYXggUmVpdHogd3JvdGU6DQo+IE9uIDE4LjAyLjE5IDE2OjM2
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMTIuMDIuMjAxOSAxNToz
NSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4gQ2xlYW4gUUNPVzIgaW1hZ2UgZnJvbSBi
aXRtYXAgb2Jzb2xldGUgZGlyZWN0b3J5IHdoZW4gYSBuZXcgb25lDQo+Pj4gaXMgYWxsb2NhdGVk
IGFuZCBzdG9yZWQuIEl0IHNsb3dzIGRvd24gdGhlIGltYWdlIGdyb3d0aCBhIGxpdHRsZSBiaXQu
DQo+Pj4gVGhlIGZsYWcgUUNPVzJfRElTQ0FSRF9BTFdBWVMgYWxsb3dzIGEgY2FsbCB0byByYXdf
Y29fcGRpc2NhcmQoKQ0KPj4+IHRoYXQgZG9lcyB0aGUgYWN0dWFsIGNsZWFuaW5nIG9mIHRoZSBp
bWFnZSBvbiBkaXNrLg0KPj4+IFdpdGggdGhlIGZsYWcgUUNPVzJfRElTQ0FSRF9PVEhFUiwgYSBy
ZWZlcmVuY2UgY291bnQgb2YgdGhlIGNsdXN0ZXINCj4+PiBpcyB1cGRhdGVkIG9ubHkuDQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hA
dmlydHVvenpvLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pg0KPj4gc2lkZSBxdWVzdGlvbjogc2hv
dWxkIG5vdCB3ZSBjaGFuZ2UgZGlzY2FyZF9wYXNzdGhyb3VnaFtRQ09XMl9ESVNDQVJEX09USEVS
XSB0bw0KPj4gdHJ1ZSBvciBhdCBsZWFzdCBmbGFncyZCRFJWX09fVU5NQVAgYnkgZGVmYXVsdD8g
V2hhdCBpcyB0aGUgcmVhc29uIG9mIG5vdCBkaXNjYXJkaW5nDQo+PiB0aGluZ3MgaW4gcWNvdzIt
Y2x1c3Rlcj8NCj4gQXMgZmFyIGFzIEkgcmVtZW1iZXIgdGhlIHJlYXNvbiBpcyB0aGF0IHdoZW5l
dmVyIHlvdSBjbGVhbiB1cCBzb21ldGhpbmcNCj4gaXRzIGNsdXN0ZXIgaXMgcHJvYmFibHkgZ29p
bmcgdG8gYmUgcmV1c2VkIHJhdGhlciBzb29uLiAgU28gY2xlYW5pbmcgdXANCj4gdGFrZXMgbG9u
Z2VyLCByZXBvcHVsYXRpbmcgdGhhdCBjbHVzdGVyIHRha2VzIGxvbmdlciwgYW5kIHlvdSBzYXZl
IG9ubHkNCj4gcmF0aGVyIGxpdHRsZSBzcGFjZS4NCj4NCj4gVGhpcyBpcyBhbHNvIHdoeSBJIGRv
bid0IGtub3cgd2hldGhlciB0aGlzIHBhdGNoIG1ha2VzIG11Y2ggc2Vuc2UuDQo+DQo+IE1heA0K
Pg0KVGhpcyBkZXBhbmRzIHVwb24gdGhlIGFtb3VudCBvZiBhY3R1YWxseSBmcmVlIGNsdXN0ZXJz
IGluIHRoZSBpbWFnZS4NCklmIHRoZXJlIGEgbG90IG9mIHRoZW0gYXQgdGhlIG1vbWVudCwgdGhp
cyBvbmUgY291bGQgYmUgcmVmaWxsZWQNCmFueSB0aW1lIGxhdGVyIG9uLg0KDQpEZW4NCg==
