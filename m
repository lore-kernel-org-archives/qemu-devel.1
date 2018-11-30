Received: from eggs.gnu.org ([2001:4830:134:3::10]:36101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSdlO-0005oo-8E
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSdlN-0003xI-8V
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:03:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Nov 2018 08:02:50 +0000
Message-ID: <d8cd9a19-1b4f-19d6-a83f-acd09e84b664@virtuozzo.com>
References: <20181130023232.3079982-1-eblake@redhat.com>
	<20181130023232.3079982-2-eblake@redhat.com>
In-Reply-To: <20181130023232.3079982-2-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <47B4D4925744AC4AA7A1CF20E716DA45@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd/server: Advertise all contexts in
 response to bare LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

MzAuMTEuMjAxOCA1OjMyLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBUaGUgTkJEIHNwZWMsIGFuZCBl
dmVuIG91ciBjb2RlIGNvbW1lbnQsIHNheXMgdGhhdCBpZiB0aGUgY2xpZW50DQo+IGFza3MgZm9y
IE5CRF9PUFRfTElTVF9NRVRBX0NPTlRFWFQgd2l0aCAwIHF1ZXJpZXMsIHRoZW4gd2Ugc2hvdWxk
DQo+IHJlcGx5IHdpdGggKGEgcG9zc2libHktY29tcHJlc3NlZCByZXByZXNlbnRhdGlvbiBvZikg
QUxMIGNvbnRleHRzDQo+IHRoYXQgd2UgYXJlIHdpbGxpbmcgdG8gbGV0IHRoZW0gdHJ5LiAgQnV0
IGNvbW1pdCAzZDA2OGFmZiBmb3Jnb3QNCj4gdG8gYWR2ZXJ0aXNlIHFlbXU6ZGlydHktYml0bWFw
OkZPTy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29t
Pg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIG5iZC9zZXJ2ZXIuYyB8IDEgKw0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25iZC9zZXJ2
ZXIuYyBiL25iZC9zZXJ2ZXIuYw0KPiBpbmRleCBkYzA0NTEzZGU3MC4uN2FmMGRkZmZiMjAgMTAw
NjQ0DQo+IC0tLSBhL25iZC9zZXJ2ZXIuYw0KPiArKysgYi9uYmQvc2VydmVyLmMNCj4gQEAgLTk3
OCw2ICs5NzgsNyBAQCBzdGF0aWMgaW50IG5iZF9uZWdvdGlhdGVfbWV0YV9xdWVyaWVzKE5CRENs
aWVudCAqY2xpZW50LA0KPiAgICAgICBpZiAoY2xpZW50LT5vcHQgPT0gTkJEX09QVF9MSVNUX01F
VEFfQ09OVEVYVCAmJiAhbmJfcXVlcmllcykgew0KPiAgICAgICAgICAgLyogZW5hYmxlIGFsbCBr
bm93biBjb250ZXh0cyAqLw0KPiAgICAgICAgICAgbWV0YS0+YmFzZV9hbGxvY2F0aW9uID0gdHJ1
ZTsNCj4gKyAgICAgICAgbWV0YS0+Yml0bWFwID0gISFtZXRhLT5leHAtPmV4cG9ydF9iaXRtYXA7
DQo+ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbmJfcXVlcmll
czsgKytpKSB7DQo+ICAgICAgICAgICAgICAgcmV0ID0gbmJkX25lZ290aWF0ZV9tZXRhX3F1ZXJ5
KGNsaWVudCwgbWV0YSwgZXJycCk7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==
