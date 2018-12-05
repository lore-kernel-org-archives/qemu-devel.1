Received: from eggs.gnu.org ([2001:4830:134:3::10]:57771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUWX4-0003Z5-Pn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUWX3-0006o8-Qw
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:44:02 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 5 Dec 2018 12:43:52 +0000
Message-ID: <02630e63-672a-43f3-5074-fc1691933d56@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-2-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181203101429.88735-2-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9D5521E3D5DF44A8FA2B7B790634D09@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

Q291bGQgeW91IHBsZWFzZSB3cml0ZSwgd2hhdCBpcyB0aGUgYmVoYXZpb3IgY2hhbmdlIGFuZCB3
aHkgaGVyZT8NCg0KSXMgaXQgYSBidWcsIHRoYXQgRlVBIHdhcyBub3QgaW5oZXJpdGVkIGJlZm9y
ZT8NCg0KMDMuMTIuMjAxOCAxMzoxNCwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gU2lnbmVkLW9m
Zi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29tPg0KPiAtLS0N
Cj4gICBibG9jay9taXJyb3IuYyB8IDggKysrKysrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL21p
cnJvci5jIGIvYmxvY2svbWlycm9yLmMNCj4gaW5kZXggNTZkOWVmNzQ3NC4uNTY5MDhjOWIxOSAx
MDA2NDQNCj4gLS0tIGEvYmxvY2svbWlycm9yLmMNCj4gKysrIGIvYmxvY2svbWlycm9yLmMNCj4g
QEAgLTE1MjgsOCArMTUyOCwxMiBAQCBzdGF0aWMgdm9pZCBtaXJyb3Jfc3RhcnRfam9iKGNvbnN0
IGNoYXIgKmpvYl9pZCwgQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICBtaXJyb3Jf
dG9wX2JzLT5pbXBsaWNpdCA9IHRydWU7DQo+ICAgICAgIH0NCj4gICAgICAgbWlycm9yX3RvcF9i
cy0+dG90YWxfc2VjdG9ycyA9IGJzLT50b3RhbF9zZWN0b3JzOw0KPiAtICAgIG1pcnJvcl90b3Bf
YnMtPnN1cHBvcnRlZF93cml0ZV9mbGFncyA9IEJEUlZfUkVRX1dSSVRFX1VOQ0hBTkdFRDsNCj4g
LSAgICBtaXJyb3JfdG9wX2JzLT5zdXBwb3J0ZWRfemVyb19mbGFncyA9IEJEUlZfUkVRX1dSSVRF
X1VOQ0hBTkdFRDsNCj4gKyAgICBtaXJyb3JfdG9wX2JzLT5zdXBwb3J0ZWRfd3JpdGVfZmxhZ3Mg
PSBCRFJWX1JFUV9XUklURV9VTkNIQU5HRUQgfA0KPiArICAgICAgICAoQkRSVl9SRVFfRlVBICYg
YnMtPnN1cHBvcnRlZF93cml0ZV9mbGFncyk7DQo+ICsgICAgbWlycm9yX3RvcF9icy0+c3VwcG9y
dGVkX3plcm9fZmxhZ3MgPSBCRFJWX1JFUV9XUklURV9VTkNIQU5HRUQgfA0KPiArICAgICAgICAo
KEJEUlZfUkVRX0ZVQSB8IEJEUlZfUkVRX01BWV9VTk1BUCkNCj4gKyAgICAgICAgICYgYnMtPnN1
cHBvcnRlZF96ZXJvX2ZsYWdzKTsNCj4gKw0KPiAgICAgICBic19vcGFxdWUgPSBnX25ldzAoTWly
cm9yQkRTT3BhcXVlLCAxKTsNCj4gICAgICAgbWlycm9yX3RvcF9icy0+b3BhcXVlID0gYnNfb3Bh
cXVlOw0KPiAgICAgICBiZHJ2X3NldF9haW9fY29udGV4dChtaXJyb3JfdG9wX2JzLCBiZHJ2X2dl
dF9haW9fY29udGV4dChicykpOw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=
