Received: from eggs.gnu.org ([209.51.188.92]:57354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hCNDI-0002No-Tz
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1hCND8-0007Mk-Uj
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:45 -0400
Received: from mail-eopbgr30136.outbound.protection.outlook.com
	([40.107.3.136]:43778
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1hCND3-0006rC-8T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:39 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 5 Apr 2019 11:40:29 +0000
Message-ID: <084a53dc-642c-0219-3cc5-3cbe783db37b@virtuozzo.com>
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
	<8ef4ffa2-6c59-a6dd-e2bd-97b6fea7a5d1@virtuozzo.com>
	<7abd40bc-963b-cf61-14e8-4c4187813c5c@virtuozzo.com>
	<5c342066-30b6-e492-e23a-cb5accbfb11a@virtuozzo.com>
	<53b5c677-870e-56a0-402d-7fdc985ec3f5@virtuozzo.com>
In-Reply-To: <53b5c677-870e-56a0-402d-7fdc985ec3f5@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB8DCA3B755443499A337B08DC87BF56@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PINGl] [PATCH 0/3] migration: add sztd compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
Cc: Denis Lunev <den@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

cGluZyENCg0KT24gMjYuMDMuMjAxOSAxODo1MSwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBw
aW5nIHBpbmcgcGluZyBwaW5nIHBpbmchDQo+IA0KPiBPbiAxOC4wMy4yMDE5IDEwOjUzLCBEZW5p
cyBQbG90bmlrb3Ygd3JvdGU6DQo+PiBwaW5nIHBpbmcgcGluZyBwaW5nIQ0KPj4NCj4+IE9uIDEx
LjAzLjIwMTkgMTE6MjAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+PiBwaW5nIHBpbmcgcGlu
ZyENCj4+Pg0KPj4+IE9uIDA0LjAzLjIwMTkgMTg6MTAsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToN
Cj4+Pj4gcGluZyENCj4+Pj4NCj4+Pj4gT24gMjYuMDIuMjAxOSAxNjoxNSwgRGVuaXMgUGxvdG5p
a292IHdyb3RlOg0KPj4+Pj4genN0ZCBkYXRlIGNvbXByZXNzaW9uIGFsZ29yaXRobSBzaG93cyBi
ZXR0ZXIgcGVyZm9ybWFuY2Ugb24gZGF0YSBjb21wcmVzc2lvbi4NCj4+Pj4+IEl0IG1pZ2h0IGJl
IHVzZWZ1bCB0byBlbXBsb3kgdGhlIGFsZ29yaXRobSBpbiBWTSBtaWdyYXRpb24gdG8gcmVkdWNl
IENQVSB1c2FnZS4NCj4+Pj4+IEEgdXNlciB3aWxsIGJlIGFibGUgdG8gY2hvb3NlIGJldHdlZW4g
dGhvc2UgYWxnb3JpdGhtcywgdGhlcmVmb3IgY29tcHJlc3MtdHlwZQ0KPj4+Pj4gbWlncmF0aW9u
IHBhcmFtZXRlciBpcyBhZGRlZC4NCj4+Pj4+DQo+Pj4+PiBIZXJlIGFyZSBzb21lIHJlc3VsdHMg
b2YgcGVyZm9ybWFuY2UgY29tcGFyaXNvbiB6c3RkIHZzIGd6aXA6DQo+Pj4+Pg0KPj4+Pj4gaG9z
dDogaTctNDc5MCA4eENQVSBAIDMuNjBHSHosIDE2RyBSQU0NCj4+Pj4+IG1pZ3JhdGlvbiB0byB0
aGUgc2FtZSBob3N0DQo+Pj4+PiBWTTogMnhWQ1BVLCA4RyBSQU0gdG90YWwNCj4+Pj4+IDVHIFJB
TSB1c2VkLCBtZW1vcnkgcG9wdWxhdGVkIHdpdGggcG9zdGdyZXFzbCBkYXRhDQo+Pj4+PiBwcm9k
dWNlZCBieSBwZ2JlbmNoIHBlcmZvcm1hbmNlIGJlbmNobWFyaw0KPj4+Pj4NCj4+Pj4+DQo+Pj4+
PiBUaHJlYWRzOiAxIGNvbXByZXNzIOKAkyAxIGRlY29tcHJlc3MNCj4+Pj4+DQo+Pj4+PiB6c3Rk
IHByb3ZpZGVzIHNsaWdodGx5IGxlc3MgY29tcHJlc3Npb24gcmF0aW8gd2l0aCBhbG1vc3QgdGhl
IHNhbWUNCj4+Pj4+IENQVSB1c2FnZSBidXQgY29wZXMgd2l0aCBSQU0gIGNvbXByZXNzaW9uIHJv
Z2hseSAyIHRpbWVzIGZhc3Rlcg0KPj4+Pj4NCj4+Pj4+IGNvbXByZXNzaW9uIHR5cGUgICAgICAg
ICAgICAgIHpsaWIgICAgICAgfCAgICAgIHpzdGQNCj4+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+Pj4gY29tcHJlc3Npb24g
bGV2ZWwgICAgICAgICAgMSAgICAgICA1ICAgICB8ICAgMSAgICAgICA1DQo+Pj4+PiBjb21wcmVz
c2lvbiByYXRpbyAgICAgICAgICA2LjkyICAgIDcuMDUgIHwgICA2LjY5ICAgIDYuODkNCj4+Pj4+
IGNwdSBpZGxlLCAlICAgICAgICAgICAgICAgIDgyICAgICAgODMgICAgfCAgIDg2ICAgICAgODAN
Cj4+Pj4+IHRpbWUsIHNlYyAgICAgICAgICAgICAgICAgIDQ5ICAgICAgNzEgICAgfCAgIDI2ICAg
ICAgMzENCj4+Pj4+IHRpbWUgZGlmZiB0byB6bGliLCBzZWMgICAgICAgICAgICAgICAgICAgICAg
LTI1ICAgICAtNDENCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gVGhyZWFkczogOCBjb21wcmVzcyDigJMg
MiBkZWNvbXByZXNzDQo+Pj4+Pg0KPj4+Pj4genN0ZCBwcm92aWRlcyB0aGUgc2FtZSBtaWdyYXRp
b24gdGltZSB3aXRoIGxlc3MgY3B1IGNvbnN1bXB0aW9uDQo+Pj4+Pg0KPj4+Pj4gY29tcHJlc3Np
b24gdHlwZSAgICAgICAgIG5vbmUgIHwgICAgICAgIGd6aXAoemxpYikgICAgfCAgICAgICAgICB6
c3RkDQo+Pj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4+IGNvbXByZXNzaW9uIGxldmVs
ICAgICAgICAtICAgICB8ICAxICAgICAgNSAgICAgICA5ICAgIHwgICAxICAgICAgIDUgICAgICAg
MTUNCj4+Pj4+IGNvbXByZXNzaW9uIHJhdGlvICAgICAgICAtICAgICB8ICA2Ljk0ICAgNi45OSAg
ICA3LjE0IHwgICA2LjY0ICAgIDYuODkgICAgNi45Mw0KPj4+Pj4gdGltZSwgc2VjICAgICAgICAg
ICAgICAgIDE1NCAgIHwgIDIyICAgICAyMyAgICAgIDI3ICAgfCAgIDIzICAgICAgMjMgICAgICAy
NQ0KPj4+Pj4gY3B1IGlkbGUsICUgICAgICAgICAgICAgIDk5ICAgIHwgIDQ1ICAgICAzMCAgICAg
IDEyICAgfCAgIDcwICAgICAgNTIgICAgICAyMw0KPj4+Pj4gY3B1IGlkbGUgZGlmZiB0byB6bGli
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfCAgLTI1JSAgICAtMjIlICAgIC0xMSUN
Cj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gRGVuaXMgUGxvdG5pa292ICgzKToNCj4+Pj4+ICAgICAgICBt
aWdyYXRpb246IHJld29yayBjb21wcmVzc2lvbiBjb2RlIGZvciBhZGRpbmcgbW9yZSBkYXRhIGNv
bXByZXNzb3JzDQo+Pj4+PiAgICAgICAgaG1wOiBhZGQgY29tcHJlc3MtdHlwZSBwYXJhbWV0ZXIg
dG8gbWlncmF0aW9uIHBhcmFtZXRlcnMNCj4+Pj4+ICAgICAgICBtaWdyYXRpb246IGFkZCB6c3Rk
IGNvbXByZXNzaW9uDQo+Pj4+Pg0KPj4+Pj4gICAgICAgY29uZmlndXJlICAgICAgICAgICAgIHwg
IDI2ICsrKysNCj4+Pj4+ICAgICAgIGhtcC5jICAgICAgICAgICAgICAgICB8ICAgOCArKw0KPj4+
Pj4gICAgICAgbWlncmF0aW9uL21pZ3JhdGlvbi5jIHwgIDQ1ICsrKysrKy0NCj4+Pj4+ICAgICAg
IG1pZ3JhdGlvbi9taWdyYXRpb24uaCB8ICAgMSArDQo+Pj4+PiAgICAgICBtaWdyYXRpb24vcWVt
dS1maWxlLmMgfCAgMzkgKystLS0tDQo+Pj4+PiAgICAgICBtaWdyYXRpb24vcWVtdS1maWxlLmgg
fCAgMTggKystDQo+Pj4+PiAgICAgICBtaWdyYXRpb24vcmFtLmMgICAgICAgfCAyOTEgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+Pj4+PiAgICAgICBxYXBpL21p
Z3JhdGlvbi5qc29uICAgfCAgMjYgKysrLQ0KPj4+Pj4gICAgICAgOCBmaWxlcyBjaGFuZ2VkLCAz
NjkgaW5zZXJ0aW9ucygrKSwgODUgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pg0KPj4+DQo+Pg0K
PiANCg0KLS0gDQpCZXN0LA0KRGVuaXMNCg==
