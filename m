Received: from eggs.gnu.org ([209.51.188.92]:48806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCQrj-00060w-6v
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hCQrf-0003sr-MU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:34:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 5 Apr 2019 15:34:32 +0000
Message-ID: <57ff4a6d-36ed-3126-6de0-aa708828693d@virtuozzo.com>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-4-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-4-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2205CE0757DA54681CCE2D0A93617C3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/7] nbd/server: Don't fail NBD_OPT_INFO
 for byte-aligned sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MDMuMDQuMjAxOSA2OjA1LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBJbiBjb21taXQgMGMxZDUwYmQs
IEkgYWRkZWQgYSBjb3VwbGUgb2YgVE9ETyBjb21tZW50cyBhYm91dCB3aGV0aGVyIHdlDQo+IGNv
bnN1bHQgYmwucmVxdWVzdF9hbGlnbm1lbnQgd2hlbiByZXNwb25kaW5nIHRvIE5CRF9PUFRfSU5G
Ty4gQXQgdGhlDQo+IHRpbWUsIHFlbXUgYXMgc2VydmVyIHdhcyBoYXJkLWNvZGluZyBhbiBhZHZl
cnRpc2VkIGFsaWdubWVudCBvZiA1MTIgdG8NCj4gY2xpZW50cyB0aGF0IHByb21pc2VkIHRvIG9i
ZXkgY29uc3RyYWludHMsIGFuZCB0aGVyZSB3YXMgbm8gZnVuY3Rpb24NCj4gZm9yIGdldHRpbmcg
YXQgYSBkZXZpY2UncyBwcmVmZXJyZWQgYWxpZ25tZW50LiBCdXQgaW4gaGluZHNpZ2h0LA0KPiBh
ZHZlcnRpc2luZyA1MTIgd2hlbiB0aGUgYmxvY2sgZGV2aWNlIHByZWZlcnMgMSBjYXVzZWQgb3Ro
ZXINCj4gY29tcGxpYW5jZSBwcm9ibGVtcywgYW5kIGNvbW1pdCBiMDI0NWQ2NCBjaGFuZ2VkIG9u
ZSBvZiB0aGUgdHdvIFRPRE8NCj4gY29tbWVudHMgdG8gYWR2ZXJ0aXNlIGEgbW9yZSBhY2N1cmF0
ZSBhbGlnbm1lbnQuIFRpbWUgdG8gZml4IHRoZSBvdGhlcg0KPiBUT0RPLiAgRG9lc24ndCByZWFs
bHkgaW1wYWN0IHFlbXUgYXMgY2xpZW50IChvdXIgbm9ybWFsIGNsaWVudCBkb2Vzbid0DQo+IHVz
ZSBOQkRfT1BUX0lORk8sIGFuZCBxZW11LW5iZCAtLWxpc3QgcHJvbWlzZXMgdG8gb2JleSBibG9j
ayBzaXplcyksDQo+IGJ1dCBpdCBtaWdodCBwcm92ZSB1c2VmdWwgdG8gb3RoZXIgY2xpZW50cy4N
Cj4gDQo+IEZpeGVzOiBiMDI0NWQ2NA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxh
a2VAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==
