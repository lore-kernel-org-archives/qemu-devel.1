Received: from eggs.gnu.org ([209.51.188.92]:52536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gwjK3-00011a-5m
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gwjK1-0005C8-HJ
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:03:11 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 21 Feb 2019 08:02:53 +0000
Message-ID: <a714b5b5-7f76-f5da-501f-7912a14e6e0f@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
	<f557be19-e398-7f5d-2851-67928f33584f@virtuozzo.com>
In-Reply-To: <f557be19-e398-7f5d-2851-67928f33584f@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1232EF7454379449859B556951D3A098@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 0/9] discard blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

T24gMTQvMS8yMDE5IDQ6MTYgUE0sIEFudG9uIE5lZmVkb3Ygd3JvdGU6DQo+IE9uIDMwLzExLzIw
MTggNTo0NyBQTSwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4+IHFtcCBxdWVyeS1ibG9ja3N0YXRz
IHByb3ZpZGVzIHN0YXRzIGluZm8gZm9yIHdyaXRlL3JlYWQvZmx1c2ggb3BzLg0KPj4NCj4+IFBh
dGNoZXMgMS03IGltcGxlbWVudCB0aGUgc2ltaWxhciBmb3IgZGlzY2FyZCAodW5tYXApIGNvbW1h
bmQgZm9yIHNjc2kNCj4+IGFuZCBpZGUgZGlza3MuDQo+PiBEaXNjYXJkIHN0YXQgInVubWFwX29w
cyAvIHVubWFwX2J5dGVzIiBpcyBzdXBwb3NlZCB0byBhY2NvdW50IHRoZSBvcHMgDQo+PiB0aGF0
DQo+PiBoYXZlIGNvbXBsZXRlZCB3aXRob3V0IGFuIGVycm9yLg0KPj4NCj4+IEhvd2V2ZXIsIGRp
c2NhcmQgb3BlcmF0aW9uIGlzIGFkdmlzb3J5LiBTcGVjaWZpY2FsbHksDQo+PiDCoCAtIGNvbW1v
biBibG9jayBsYXllciBpZ25vcmVzIEVOT1RTVVAgZXJyb3IgY29kZS4NCj4+IMKgwqDCoCBUaGF0
IG1pZ2h0IGJlIHJldHVybmVkIGlmIHRoZSBibG9jayBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCBk
aXNjYXJkLA0KPj4gwqDCoMKgIG9yIGRpc2NhcmQgaGFzIGJlZW4gY29uZmlndXJlZCB0byBiZSBp
Z25vcmVkLg0KPj4gwqAgLSBmb3JtYXQgZHJpdmVycyBzdWNoIGFzIHFjb3cyIG1heSBpZ25vcmUg
ZGlzY2FyZCBpZiB0aGV5IHdlcmUgDQo+PiBjb25maWd1cmVkDQo+PiDCoMKgwqAgdG8gaWdub3Jl
IHRoYXQsIG9yIGlmIHRoZSBjb3JyZXNwb25kaW5nIGFyZWEgaXMgYWxyZWFkeSBtYXJrZWQgdW51
c2VkDQo+PiDCoMKgwqAgKHVuYWxsb2NhdGVkIC8gemVybyBjbHVzdGVycykuDQo+Pg0KPj4gQW5k
IHdoYXQgaXMgYWN0dWFsbHkgdXNlZnVsIGlzIHRoZSBudW1iZXIgb2YgYnl0ZXMgYWN0dWFsbHkg
ZGlzY2FyZGVkDQo+PiBkb3duIG9uIHRoZSBob3N0IGZpbGVzeXN0ZW0uDQo+PiBUbyBhY2hpZXZl
IHRoYXQsIGRyaXZlci1zcGVjaWZpYyBzdGF0aXN0aWNzIGhhcyBiZWVuIGFkZGVkIHRvIGJsb2Nr
c3RhdHMNCj4+IChwYXRjaCA5KS4NCj4+IFdpdGggcGF0Y2ggOCwgZmlsZS1wb3NpeCBkcml2ZXIg
YWNjb3VudHMgZGlzY2FyZCBvcGVyYXRpb25zIG9uIGl0cyANCj4+IGxldmVsIHRvby4NCj4+DQo+
IA0KPiBwaW5nDQoNCnBpbmcNCg==
