Received: from eggs.gnu.org ([209.51.188.92]:48792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gw2fi-00012c-2X
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gw2fh-0004nC-As
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:30:42 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 19 Feb 2019 10:30:23 +0000
Message-ID: <bb07067b-561d-7836-fc5d-a8bf687bb2d2@virtuozzo.com>
References: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9466E0BA9A18746939C627F0D2E5489@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] iotests: handle TypeError for Python3 in
 test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MTguMDIuMjAxOSAyMjo1OSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRvIHdyaXRlIG9u
ZSBieXRlIHRvIGRpc2ssIFB5dGhvbjIgbWF5IHVzZSAnY2hyJyB0eXBlLg0KPiBJbiBQeXRob24z
LCBjb252ZXJzaW9uIHRvICdieXRlJyB0eXBlIGlzIHJlcXVpcmVkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+
DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQoNCkZvcmdldCB0byBzYXkgdG8gQW5kcmV5IHRoYXQgd2Ugc2hvdWxk
IGFkZA0KDQpSZXBvcnRlZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCg0KPiAt
LS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjQyIHwgOSArKysrKysrLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDIgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjQyDQo+IGlu
ZGV4IDE2YzY1ZWQuLjZiMWY3YjggMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8y
NDINCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Mg0KPiBAQCAtNjUsOSArNjUsMTQgQEAg
ZGVmIHRvZ2dsZV9mbGFnKG9mZnNldCk6DQo+ICAgICAgIHdpdGggb3BlbihkaXNrLCAicitiIikg
YXMgZjoNCj4gICAgICAgICAgIGYuc2VlayhvZmZzZXQsIDApDQo+ICAgICAgICAgICBjID0gZi5y
ZWFkKDEpDQo+IC0gICAgICAgIHRvZ2dsZWQgPSBjaHIob3JkKGMpIF4gYml0bWFwX2ZsYWdfdW5r
bm93bikNCj4gKyAgICAgICAgdG9nZ2xlZCA9IG9yZChjKSBeIGJpdG1hcF9mbGFnX3Vua25vd24N
Cj4gICAgICAgICAgIGYuc2VlaygtMSwgMSkNCj4gLSAgICAgICAgZi53cml0ZSh0b2dnbGVkKQ0K
PiArICAgICAgICB0cnk6DQo+ICsgICAgICAgICAgICAjIHB5dGhvbjINCj4gKyAgICAgICAgICAg
IGYud3JpdGUoY2hyKHRvZ2dsZWQpKQ0KPiArICAgICAgICBleGNlcHQgVHlwZUVycm9yOg0KPiAr
ICAgICAgICAgICAgIyBweXRob24zDQo+ICsgICAgICAgICAgICBmLndyaXRlKGJ5dGVzKFt0b2dn
bGVkXSkpDQo+ICAgDQo+ICAgDQo+ICAgcWVtdV9pbWdfY3JlYXRlKCctZicsIGlvdGVzdHMuaW1n
Zm10LCBkaXNrLCAnMU0nKQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
