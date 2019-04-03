Received: from eggs.gnu.org ([209.51.188.92]:39697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hBbCu-0004th-Mw
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hBbCt-0003XP-SQ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 04:25:16 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 3 Apr 2019 08:25:08 +0000
Message-ID: <2dd30460-f9b5-7086-928a-aad201e0c506@virtuozzo.com>
References: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554120365-39119-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51tvfgo9wj.fsf@maestria.local.igalia.com>
In-Reply-To: <w51tvfgo9wj.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E2B131350396440BDED11B8123866C1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/stream: refactor stream_run:
 drop goto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "jsnow@redhat.com" <jsnow@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDAyLzA0LzIwMTkgMTU6NDMsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBNb24g
MDEgQXByIDIwMTkgMDI6MDY6MDQgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiBGcm9tOiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNo
aW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4gDQo+
IFlvdSBjYW4gYWxzbyBzYXkgaW4gdGhlIGxvZyBtZXNzYWdlIHRoYXQgdGhlIGdvdG8gaXMgbm90
IG5lY2Vzc2FyeSBzaW5jZQ0KPiB0aGUgY29tbW9uIGV4aXQgY29kZSB3YXMgcmVtb3ZlZCBpbiBj
b21taXQgZWIyMzY1NGRiZTQzYjU0OWVhMmE5ZWJmZjlkOGUNCj4gDQo+IFJldmlld2VkLWJ5OiBB
bGJlcnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCj4gDQo+IEJlcnRvDQo+IA0KDQpBbGJl
cnRvLA0KVGhhbmsgeW91IGZvciB0aGUgY29tbWl0IHJlZmVyZW5jZS4NCi0tIA0KV2l0aCB0aGUg
YmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==
