Received: from eggs.gnu.org ([209.51.188.92]:56064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmK7w-0007XU-G6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmK7o-0006sV-Ng
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:07:35 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 23 Jan 2019 15:07:16 +0000
Message-ID: <63fcc13e-6fce-126b-1a6d-3ad1ed7d9976@virtuozzo.com>
References: <154825524292.21.4589691216699401444@ebba9967afc0>
In-Reply-To: <154825524292.21.4589691216699401444@ebba9967afc0>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D950B4257928EB46AB667D76714DD7C4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 0/9] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjMuMDEuMjAxOSAxNzo1NCwgbm8tcmVwbHlAcGF0Y2hldy5vcmcgd3JvdGU6DQo+IFBhdGNoZXcg
VVJMOiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTAxMDgxNzA2NTUuMjk3NjYtMS12c2Vt
ZW50c292QHZpcnR1b3p6by5jb20vDQo+IA0KPiANCj4gDQo+IEhpLA0KPiANCj4gVGhpcyBzZXJp
ZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZA0KPiB0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBo
YXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0DQo+IGxv
Y2FsbHkuDQo+IA0KPiA9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09DQo+ICMhL2Jpbi9iYXNoDQo+
IHRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0DQo+ID09
PSBURVNUIFNDUklQVCBFTkQgPT09DQo+IA0KPiAgICBDQyAgICAgIHFhcGkvcWFwaS1jb21tYW5k
cy1jcnlwdG8ubw0KPiAgICBDQyAgICAgIHFhcGkvcWFwaS1jb21tYW5kcy1pbnRyb3NwZWN0Lm8N
Cj4gL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6IEluIGZ1bmN0aW9uICdmaW5k
X3ZkaV9uYW1lJzoNCj4gL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6MTIzOTo1
OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCAyNTYgZXF1YWxzIGRlc3RpbmF0aW9u
IHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0NCj4gICAgICAgc3RybmNweShidWYg
KyBTRF9NQVhfVkRJX0xFTiwgdGFnLCBTRF9NQVhfVkRJX1RBR19MRU4pOw0KPiAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCg0KdW5yZWxhdGVkIHRvIG15
IHNlcmllcy4NCg0KPiANCj4gDQo+IFRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQNCj4gaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTAxMDgxNzA2NTUuMjk3NjYtMS12c2VtZW50c292QHZp
cnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuDQo+
IC0tLQ0KPiBFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8v
cGF0Y2hldy5vcmcvXS4NCj4gUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
