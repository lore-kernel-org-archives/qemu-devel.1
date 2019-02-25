Received: from eggs.gnu.org ([209.51.188.92]:51344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyEyf-0001Um-Ux
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyEyf-0002iG-4z
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:03:21 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 12:03:12 +0000
Message-ID: <ef3c7636-f920-7945-c8f8-0489580786ab@virtuozzo.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-8-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-8-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2B4F88CB40F974B8756332B3D753737@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 07/10] block/dirty-bitmaps: unify
 qmp_locked and user_locked calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

MjMuMDIuMjAxOSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoZXNlIG1lYW4gdGhlIHNhbWUg
dGhpbmcgbm93LiBVbmlmeSB0aGVtIGFuZCByZW5hbWUgdGhlIG1lcmdlZCBjYWxsDQo+IGJkcnZf
ZGlydHlfYml0bWFwX2J1c3kgdG8gaW5kaWNhdGUgc2VtYW50aWNhbGx5IHdoYXQgd2UgYXJlIGRl
c2NyaWJpbmcsDQo+IGFzIHdlbGwgYXMgaGVscCBkaXNhbWJpZ3VhdGUgZnJvbSB0aGUgdmFyaW91
cyBfbG9ja2VkIGFuZCBfdW5sb2NrZWQNCj4gdmVyc2lvbnMgb2YgYml0bWFwIGhlbHBlcnMgdGhh
dCByZWZlciB0byBtdXRleCBsb2Nrcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8
anNub3dAcmVkaGF0LmNvbT4NCg0KSG1tLCBhbmQgaGVyZSwgeW91IGRpcmVjdGx5IGZpeGVkIHdo
YXQgSSd2ZSBub3RpY2VkLCBzbyBteSByLWIsDQpvZiBjb3Vyc2UsIHN0aWxsIGFwcGxpZXMuDQoN
CkhhLCBidXQgSSBub3RpY2VkIGZ1bm55IHRoaW5nOg0KDQo+IC0tLQ0KPiAgIGJsb2NrL2RpcnR5
LWJpdG1hcC5jICAgICAgICAgICB8IDQwICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gICBibG9ja2Rldi5jICAgICAgICAgICAgICAgICAgICAgfCAxOCArKysrKysrLS0tLS0t
LS0NCj4gICBpbmNsdWRlL2Jsb2NrL2RpcnR5LWJpdG1hcC5oICAgfCAgNSArKy0tLQ0KPiAgIG1p
Z3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYyB8ICA2ICsrLS0tDQo+ICAgbmJkL3NlcnZlci5j
ICAgICAgICAgICAgICAgICAgIHwgIDYgKystLS0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDM0IGlu
c2VydGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Rp
cnR5LWJpdG1hcC5jIGIvYmxvY2svZGlydHktYml0bWFwLmMNCj4gaW5kZXggZDkyYTI2OTc1My4u
YjM2MjdiMGQ4YyAxMDA2NDQNCj4gLS0tIGEvYmxvY2svZGlydHktYml0bWFwLmMNCj4gKysrIGIv
YmxvY2svZGlydHktYml0bWFwLmMNCg0KWy4uXQ0KDQo+IEBAIC0yNjUsOSArMjU5LDkgQEAgaW50
IGJkcnZfZGlydHlfYml0bWFwX2NyZWF0ZV9zdWNjZXNzb3IoQmxvY2tEcml2ZXJTdGF0ZSAqYnMs
DQo+ICAgICAgIGNoaWxkLT5kaXNhYmxlZCA9IGJpdG1hcC0+ZGlzYWJsZWQ7DQo+ICAgICAgIGJp
dG1hcC0+ZGlzYWJsZWQgPSB0cnVlOw0KPiAgIA0KPiAtICAgIC8qIEluc3RhbGwgdGhlIHN1Y2Nl
c3NvciBhbmQgbG9jayB0aGUgcGFyZW50ICovDQo+ICsgICAgLyogSW5zdGFsbCB0aGUgc3VjY2Vz
c29yIGFuZCBtYXJrIHRoZSBwYXJlbnQgYXMgYnVzeSAqLw0KDQpJIGFza2VkIHlvdSB0byBmaXgg
Y29tbWVudCBmb3IgYmRydl9kaXJ0eV9iaXRtYXBfY3JlYXRlX3N1Y2Nlc3NvcigpLCBidXQgSSBk
aWRuJ3QNCm5vdGljZWQgdGhpcyBvbmUsIEkgbWVhbnQgdGhlIGNvbW1lbnQgdG8gdGhlIHdob2xl
IGZ1bmN0aW9uLCBwbGFjZWQgYWJvdmUgaXQsIHdoaWNoDQpub3cgaGF2ZQ0KICAiUmVxdWlyZXMg
dGhhdCB0aGUgYml0bWFwIGlzIG5vdCB1c2VyX2xvY2tlZCBhbmQgaGFzIG5vIHN1Y2Nlc3Nvci4i
DQoNClNvLCBpdCBzaG91bGQgYmUgdXBkYXRlZCB0b28uDQoNCmFuZCB3aXRoIGl0Og0KUmV2aWV3
ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCg0KPiAgICAgICBiaXRtYXAtPnN1Y2Nlc3NvciA9IGNoaWxkOw0KPiAtICAgIGJpdG1h
cC0+cW1wX2xvY2tlZCA9IHRydWU7DQo+ICsgICAgYml0bWFwLT5idXN5ID0gdHJ1ZTsNCj4gICAg
ICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K
