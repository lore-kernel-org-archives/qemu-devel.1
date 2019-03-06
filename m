Received: from eggs.gnu.org ([209.51.188.92]:32977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1YiO-0002z3-77
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1YiN-0001mI-FY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:44:16 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Mar 2019 15:44:09 +0000
Message-ID: <da99f9c1-d651-4100-1755-d8e8423c469d@virtuozzo.com>
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-5-jsnow@redhat.com>
	<6c9c5b9b-8093-e993-1027-db692d20e2e1@virtuozzo.com>
	<c86079d4-08f4-afe6-7a8c-63b01868192c@redhat.com>
In-Reply-To: <c86079d4-08f4-afe6-7a8c-63b01868192c@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5B308B29405174E88DEECC4B9D1F126@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/5] block/qcow2-bitmap: Allow resizes with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

MDYuMDMuMjAxOSAxODozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMy82LzE5IDk6MzMgQU0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+IA0KPj4+ICsgICAgLyogRmx1
c2ggYml0bWFwcyAqLw0KPj4+ICsgICAgaWYgKHMtPm5iX2JpdG1hcHMpIHsNCj4+PiArICAgICAg
ICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+PiArDQo+Pj4gKyAgICAgICAgLyogVXN1YWxs
eSwgYml0bWFwcyBnZXQgcmVzaXplZCBhZnRlciB0aGlzIGNhbGwuDQo+Pj4gKyAgICAgICAgICog
Rm9yY2UgaXQgZWFybGllciBzbyB3ZSBjYW4gbWFrZSB0aGUgbWV0YWRhdGEgY29uc2lzdGVudC4g
Ki8NCj4+PiArICAgICAgICBiZHJ2X2RpcnR5X2JpdG1hcF90cnVuY2F0ZShicywgb2Zmc2V0KTsN
Cj4+PiArICAgICAgICBxY293Ml9mbHVzaF9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoYnMsICZs
b2NhbF9lcnIpOw0KPj4+ICsgICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4+PiArICAgICAgICAg
ICAgcmV0ID0gLUVJTlZBTDsNCj4+PiArICAgICAgICAgICAgZ290byBmYWlsOw0KPj4+ICsgICAg
ICAgIH0NCj4+PiArICAgIH0NCj4+DQo+PiBXaHkgdG8gZmx1c2ggYWZ0ZXIgcmVzaXplPyBCaXRt
YXBzIHdpbGwgYmUgSU5fVVNFIGluIHRoZSBpbWFnZSBhbnl3YXkuLi4NCj4+DQo+PiBDb3VsZCB3
ZSBpbXBsZW1lbnQgcmVzaXplIHdpdGhvdXQgZmx1c2ggZmlyc3QsICBpdCB3b3VsZCBiZSBvbmUg
cGF0Y2ggKyB0ZXN0PyBBbmQgdGhlbiBjb25zaWRlcg0KPj4gZmx1c2hpbmcgaW4gc2VwYXJhdGU/
DQo+IA0KPiBXaGF0IGhhcHBlbnMgd2l0aCBtaWdyYXRpb24gaWYgd2UgZG9uJ3QgZmx1c2ggdGhl
IG5ldyBzaXplIHRvIGRpc2ssIHNvDQo+IHRoZSBvbi1kaXNrIGZvcm1hdCBoYXMgYSBkaWZmZXJl
bnQgc2l6ZSB0aGFuIHRoZSBpbi1tZW1vcnkgdmVyc2lvbj8NCj4gDQoNCm1pZ3JhdGlvbiB3b3Jr
cyBmaW5lLCBhcyB3ZSBzdG9yZSBiaXRtYXAgbm90IG9uIGNsb3NlIGJ1dCBvbiBpbmFjdGl2YXRl
Lg0KDQpCaXRtYXBzIG1heSBiZSBtaWdyYXRlZCBpbiB0d28gd2F5czoNCg0KMS4gZGlydHktYml0
bWFwcyBtaWdyYXRpb24gY2FwYWJpbGl0eSBlbmFibGVkOiB0aGV5IG1pZ3JhdGUgdGhyb3VnaCBt
aWdyYXRpb24gY2hhbm5lbCwgUkFNIHRvIFJBTSwNCiAgICBCZHJ2RGlydHlCaXRtYXAgdG8gQmRy
dkRpcnR5Qml0bWFwLCBzdG9yZWQgYml0bWFwcyBhcmUgdW5yZWxhdGVkIGFuZCB0aGV5IGFyZSBt
YXJrZWQgSU5fVVNFIGFueXdheQ0KDQoyLiBkaXJ0eS1iaXRtYXBzIG1pZ3JhdGlvbiBjYXBhYmls
aXR5IGRpc2FibGVkOiB0aGV5IG1pZ3JhdGUgdGhyb3VnaCBzdG9yYWdlLCBzbyB0aGV5IGFyZSBz
dG9yZWQgaW4NCiAgICBpbmFjdGl2YXRpb24gb24gc291cmNlIGFuZCB0aGVuIGxvYWRlZCBpbiBp
bnZhbGlkYXRpb24gb24gdGFyZ2V0Lg0KDQpBIGdvb2QgY2h1bmsgb2YgaW5mb3JtYXRpb24gaXMg
YWxzbyBpbiBhIGh1Z2UgY29tbWVudCBpbnNpZGUgcWNvdzJfZG9fb3BlbigpIGZ1bmN0aW9uLg0K
DQoNCk5vdGU6IHdlIHVzZSB0aGUgZm9sbG93aW5nIGhhY2sgZm9yIHJlc2l6ZSwgSSBuZXZlciB0
cmllZCB0byBzZW5kIGl0IHRvIHRoZSBsaXN0Og0KDQppbiBxY293Ml9jb190cnVuY2F0ZWQsIGlu
c3RlYWQgb2YgIkNhbid0IHJlc2l6ZSBhbiBpbWFnZSB3aGljaCBoYXMgYml0bWFwcyI6DQoNCiAg
ICAgaWYgKHMtPm5iX2JpdG1hcHMpIHsNCiAgICAgICAgIC8qIEZJWE1FOiBub3QgbG9hZGVkIGJp
dG1hcHMgd2lsbCBiZSBsb3N0ICovDQogICAgICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsN
CiAgICAgICAgIHFjb3cyX3JlbW92ZV9hbGxfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXBzKGJzLCAm
bG9jYWxfZXJyKTsNCiAgICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCiAgICAgICAgICAgICBlcnJv
cl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJyKTsNCiAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCiAgICAgICAgIH0NCiAgICAgfQ0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
