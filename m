Received: from eggs.gnu.org ([209.51.188.92]:39764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmfih-0002a1-CO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmfie-0004hb-IW
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:11:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 14:10:54 +0000
Message-ID: <3f61e7b5-7226-dc48-900d-e00768b6951a@virtuozzo.com>
References: <20190124122525.145968-1-vsementsov@virtuozzo.com>
	<20190124122525.145968-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190124122525.145968-3-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <974DDAA9F55B4049A38B196E3B029B31@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] iotest: fix 169: do not run qmp_cont
 in RUN_STATE_FINISH_MIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "lcapitulino@redhat.com" <lcapitulino@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>

MjQuMDEuMjAxOSAxNToyNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
cW1wX2NvbnQgZmFpbHMgaWYgdm0gaW4gUlVOX1NUQVRFX0ZJTklTSF9NSUdSQVRFLCBzbyBsZXQn
cyB3YWl0IGZvcg0KPiBmaW5hbCBSVU5fU1RBVEVfUE9TVE1JR1JBVEUuIEFsc28sIHdoaWxlIGJl
aW5nIGhlcmUsIGNoZWNrIHFtcF9jb250DQo+IHJlc3VsdC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBN
YXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAg
IHRlc3RzL3FlbXUtaW90ZXN0cy8xNjkgfCA3ICsrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMv
cWVtdS1pb3Rlc3RzLzE2OSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNjkNCj4gaW5kZXggNTI3YWVi
ZDBjYi4uN2UwNmNjMTE0NSAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzE2OQ0K
PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTY5DQo+IEBAIC0xMDIsMTIgKzEwMiwxNyBAQCBj
bGFzcyBUZXN0RGlydHlCaXRtYXBNaWdyYXRpb24oaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+ICAg
ICAgICAgICAgICAgZXZlbnQgPSBzZWxmLnZtX2EuZXZlbnRfd2FpdCgnTUlHUkFUSU9OJykNCj4g
ICAgICAgICAgICAgICBpZiBldmVudFsnZGF0YSddWydzdGF0dXMnXSA9PSAnY29tcGxldGVkJzoN
Cj4gICAgICAgICAgICAgICAgICAgYnJlYWsNCj4gKyAgICAgICAgd2hpbGUgVHJ1ZToNCj4gKyAg
ICAgICAgICAgIHJlc3VsdCA9IHNlbGYudm1fYS5xbXAoJ3F1ZXJ5LXN0YXR1cycpDQo+ICsgICAg
ICAgICAgICBpZiAocmVzdWx0WydyZXR1cm4nXVsnc3RhdHVzJ10gPT0gJ3Bvc3RtaWdyYXRlJyk6
DQo+ICsgICAgICAgICAgICAgICAgYnJlYWsNCg0KcG9zc2libHksIG5vdCBiYWQgdG8gYWRkDQoN
CisgICAgICAgICAgICAgIHRpbWUuc2xlZXAoMC4xKQ0KDQpvciAwLjUsIG9yIHNvbWV0aGluZy4g
KE5vdGUsIHRoYXQgdGltZSBtb2R1bGUgaXMgYWxyZWFkeSBpbXBvcnRlZCB0byB0aGUgdGVzdCkN
Cg0KPiAgIA0KPiAgICAgICAgICAgIyB0ZXN0IHRoYXQgYml0bWFwIGlzIHN0aWxsIGhlcmUNCj4g
ICAgICAgICAgIHJlbW92ZWQgPSAobm90IG1pZ3JhdGVfYml0bWFwcykgYW5kIHBlcnNpc3RlbnQN
Cj4gICAgICAgICAgIHNlbGYuY2hlY2tfYml0bWFwKHNlbGYudm1fYSwgRmFsc2UgaWYgcmVtb3Zl
ZCBlbHNlIHNoYTI1NikNCj4gICANCj4gLSAgICAgICAgc2VsZi52bV9hLnFtcCgnY29udCcpDQo+
ICsgICAgICAgIHJlc3VsdCA9IHNlbGYudm1fYS5xbXAoJ2NvbnQnKQ0KPiArICAgICAgICBzZWxm
LmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICAgDQo+ICAgICAgICAgICAjIHRl
c3QgdGhhdCBiaXRtYXAgaXMgc3RpbGwgaGVyZSBhZnRlciBpbnZhbGlkYXRpb24NCj4gICAgICAg
ICAgIHNlbGYuY2hlY2tfYml0bWFwKHNlbGYudm1fYSwgc2hhMjU2KQ0KPiANCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
