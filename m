Received: from eggs.gnu.org ([2001:4830:134:3::10]:36099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <james.r.harris@intel.com>) id 1dTAp3-00086z-M9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <james.r.harris@intel.com>) id 1dTAp0-0004Nc-Jn
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:44:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <james.r.harris@intel.com>)
	id 1dTAp0-0004Mt-B3
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:44:10 -0400
From: "Harris, James R" <james.r.harris@intel.com>
Date: Thu, 6 Jul 2017 17:44:07 +0000
Message-ID: <C687878C-6918-475C-95C0-AA2ACAD65EF1@intel.com>
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
	<20170302214746.GA4711@redhat.com>
	<9950C259-FD65-4286-84D0-89FA00420E86@nutanix.com>
	<20170706164014-mutt-send-email-mst@kernel.org>
	<757B1E6A-A74C-47E2-A239-893F40922DD2@intel.com>
	<30b1f1cb-f959-7711-96c2-5d5c138135e1@redhat.com>
	<7813DE88-EB6D-4330-AC69-27E7051C4000@intel.com>
	<67124212.47615869.1499361095640.JavaMail.zimbra@redhat.com>
In-Reply-To: <67124212.47615869.1499361095640.JavaMail.zimbra@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCD6D1D8CE2E334084294062FB798505@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/4] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Felipe
	Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

DQo+IE9uIEp1bCA2LCAyMDE3LCBhdCAxMDoxMSBBTSwgTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJj
YW5kcmUubHVyZWF1QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gSGkNCj4gDQo+IC0tLS0tIE9y
aWdpbmFsIE1lc3NhZ2UgLS0tLS0NCj4+IA0KPj4+IE9uIEp1bCA2LCAyMDE3LCBhdCA5OjU2IEFN
LCBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+PiAN
Cj4+PiANCj4+PiBPbiAwNi8wNy8yMDE3IDE4OjU0LCBIYXJyaXMsIEphbWVzIFIgd3JvdGU6DQo+
Pj4+IEhpIE1pY2hhZWwsDQo+Pj4+IA0KPj4+PiBZZXMgLSB3ZSAoU1BESyB0ZWFtIGF0IEludGVs
KSBoYXZlIHRoaXMgb24gb3VyIFRPRE8gbGlzdCwgaW4gYWRkaXRpb24NCj4+Pj4gdG8gYSBwb2xs
ZWQgbW9kZSB2aXJ0aW8tc2NzaSBkcml2ZXIgKGFraW4gdG8gdGhlIERQREsgdmlydGlvLW5ldCBk
cml2ZXINCj4+Pj4gdGhhdA0KPj4+PiBjYW4gYmUgdXNlZCBpbiB0aGUgZ3Vlc3QpLg0KPj4+IA0K
Pj4+IENhbiB5b3UgYWxzbyBsb29rIGF0IHZpcnRpby1ibGsgcG9sbC1tb2RlIGRyaXZlcnMgYW5k
IHZob3N0LXVzZXItYmxrDQo+Pj4gKHZob3N0LXVzZXItYmxrIHdvdWxkIGJlIHJlYWxseSBlYXN5
IHRvIHdyaXRlLCB0aGUgc2FtcGxlIHNlcnZlciBiZWluZw0KPj4+IG11Y2ggbW9yZSB3b3JrIHRo
YW4gdGhlIFFFTVUgY29kZSk/DQo+Pj4gDQo+Pj4gUGFvbG8NCj4+IA0KPj4gSGkgUGFvbG8sDQo+
PiANCj4+IHZob3N0LXVzZXItYmxrOg0KPj4gDQo+PiBXZSBoYXZlIGFuIGluaXRpYWwgaW1wbGVt
ZW50YXRpb24gaW4gb3VyIFNQREsgUUVNVSByZXBvLiAgQ2hhbmdwZW5nIExpdQ0KPj4gKGFkZGVk
KQ0KPj4gd2lsbCBiZSBzZW5kaW5nIHRoaXMgdG8gdGhlIFFFTVUgbWFpbGluZyBsaXN0IHNob3J0
bHkuICBJZiB5b3UgYXJlIGludGVyZXN0ZWQNCj4+IGluIHZpZXdpbmcgaXQNCj4+IGJlZm9yZSBp
dCBoaXRzIHRoZSBtYWlsaW5nIGxpc3QsIHlvdSBjYW4gdGFrZSBhIGxvb2sgYXQgdGhlIHBhdGNo
IGhlcmU6DQo+PiANCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9zcGRrL3FlbXUvY29tbWl0L2RiMmZj
YjBmNTAwMmMzZDE5NWU3NTZlYWIwN2JkOTc2Y2NmNmU3YzgNCj4gDQo+IEdyZWF0ISBJIGFsc28g
anVzdCBzdGFydGVkIGxvb2tpbmcgaW50byB0aGlzLCBJJ2xsIHRha2UgYSBsb29rIGF0IHlvdXIg
aW1wbGVtZW50YXRpb24uIERvIHlvdSBhbHNvIGhhdmUgYSAic2VydmVyIi9zbGF2ZSBzaWRlLCBv
ciBwbGFuIHRvIHNoYXJlIG9uZT8NCg0KV2Ugd2lsbCBhZGQgYSBzYW1wbGUgc2VydmVyIHRoYXQg
Y2FuIGJlIHVwc3RyZWFtZWQgaW50byBRRU1VLCBhbmQgd2lsbCBhbHNvIHByb3ZpZGUgYSBtb3Jl
ZnVsbHktZnVuY3Rpb25hbCB2aG9zdC11c2VyLWJsaw0KdGFyZ2V0IHdpdGggU1BESy4NCg0KQSBs
b3Qgb2YgdGhlIFNQREsgdmhvc3QtdXNlci1ibGsgd29yayBoYXMgYmVlbiBwdXNoZWQgb3V0IHRv
IG91ciBtYXN0ZXIgYnJhbmNoIGFscmVhZHksIGJ1dCB0aGVyZeKAmXMgc3RpbGwgc29tZSBXSVAu
DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9zcGRrL3NwZGsvdHJlZS9tYXN0ZXIvbGliL3Zob3N0DQoN
Ci1KaW0NCg0K
