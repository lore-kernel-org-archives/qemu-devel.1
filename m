Received: from eggs.gnu.org ([209.51.188.92]:59633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gicQj-0002Yz-AG
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 04:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1gicHw-0003ea-LC
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 04:42:41 -0500
From: Leonid Bloch <lbloch@janustech.com>
Date: Sun, 13 Jan 2019 09:42:27 +0000
Message-ID: <5c18782a-4319-e87b-6b1f-6c808d837430@janustech.com>
References: <20190111191401.18317-1-armbru@redhat.com>
In-Reply-To: <20190111191401.18317-1-armbru@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <627AB34DBD30CA44ABB6375EA6619AE5@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/1] block: Eliminate the S_1KiB, S_2KiB,
 ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

T24gMS8xMS8xOSA5OjE0IFBNLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gQmFjayBpbiBT
ZXB0ZW1iZXIsIExlb25pZCBCbG9jayBhZGRlZCBhIHdob2xlIGJ1bmNoIG9mIG1hY3JvcyAoY29t
bWl0DQoNCiogQmxvY2guIDopDQoNCj4gNTQwYjg0OTI2MTgpIHRvIGltcHJvdmUgcmVhZGFiaWxp
dHkgb2YgcWNvdzIuaCBhIGJpdCAoY29tbWl0DQo+IGI2YTk1YzZkMTAwKS4gIEhlIGxhdGVyIHVz
ZWQgdGhlbSB0byBmaXggdGhlICJ2ZGkiIGRyaXZlcidzIHBhcmFtZXRlcg0KPiBjbHVzdGVyX3Np
emUncyBkZWZhdWx0IHZhbHVlIChjb21taXQgM2RkNWI4ZjQ3MTgpLiAgSGUgaGFzIG5vdw0KPiBw
cm9wb3NlZCBhIGZ1cnRoZXIgcGF0Y2hbMV0gdG8gYXV0by1nZW5lcmF0ZSB0aGVzZSBtYWNyb3Mu
ICBUaGF0IHBhdGNoDQo+IGZlZWxzIG92ZXJlbmdpbmVlcmVkIHRvIG1lLg0KPiANCj4gT24gY2xv
c2VyIGV4YW1pbmF0aW9uLCBJIGZvdW5kIEkgZGlzbGlrZSB0aGUgbWFjcm9zIGJlZm9yZSBoaXMg
bmV3DQo+IHBhdGNoLiAgU28gZGlkIEVyaWMgQmxha2UuDQo+IA0KPiBUaGUgbWFjcm9zIGV4aXN0
IGJlY2F1c2UgdGhlIGNvbW1vbiBLaUIsIE1pQiwgLi4uIG1hY3JvcyBhcmVuJ3QgdXNhYmxlDQo+
IHdoZW4geW91IG5lZWQgYSBsaXRlcmFsIHJhdGhlciB0aGFuIGEgY29uc3RhbnQgZXhwcmVzc2lv
bi4NCj4gc3RyaW5naWZ5KCkgZG9lcywgYW5kIHdlIHVzZSBpdCB0byBkZWZpbmUgdGhlIFFlbXVP
cHRzIGRlZmF1bHQgdmFsdWUuDQo+IA0KPiBFcmljIHByb3Bvc2VkIHRvIGltcHJvdmUgUWVtdU9w
dHMgdG8gYWNjZXB0IGludGVnZXIgZGVmYXVsdCB2YWx1ZXMsDQo+IHRvb1syXS4gIEJlZm9yZSBJ
IHJldmlldyB0aGF0IHBhdGNoIHNlcmllcywgSSB3YW50IHRvIGVzdGFibGlzaCBhDQo+ICJzdHVw
aWRlc3Qgc29sdXRpb24gdGhhdCBjYW4gcG9zc2libHkgd29yayIgYmFzZWxpbmUuICBBbmQgdGhh
dCdzIHdoYXQNCj4gdGhpcyBwYXRjaCBpcy4NCj4gDQo+IFsxXSBbUEFUQ0ggdjIgMC8xXSBpbmNs
dWRlOiBBdXRvLWdlbmVyYXRlIHRoZSBzaXplcyBsb29rdXAgdGFibGUNCj4gTWVzc2FnZS1JRDog
PDIwMTkwMTAzMjEzMzIwLjI2NTMtMS1sYmxvY2hAamFudXN0ZWNoLmNvbT4NCj4gDQo+IFsyXSBb
UEFUQ0ggdjMgMC82XSBpbmNsdWRlOiBBdXRvLWdlbmVyYXRlIHRoZSBzaXplcyBsb29rdXAgdGFi
bGUNCj4gTWVzc2FnZS1JZDogPDIwMTkwMTEwMTkxOTAxLjUwODItMS1lYmxha2VAcmVkaGF0LmNv
bT4NCj4gDQo+IE1hcmt1cyBBcm1icnVzdGVyICgxKToNCj4gICAgYmxvY2s6IEVsaW1pbmF0ZSB0
aGUgU18xS2lCLCBTXzJLaUIsIC4uLiBtYWNyb3MNCj4gDQo+ICAgYmxvY2svcWNvdzIuaCAgICAg
ICAgfCAxMCArKystLS0NCj4gICBibG9jay92ZGkuYyAgICAgICAgICB8ICAzICstDQo+ICAgaW5j
bHVkZS9xZW11L3VuaXRzLmggfCA3MyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3OSBkZWxl
dGlvbnMoLSkNCj4gDQo=
