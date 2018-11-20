Received: from eggs.gnu.org ([2001:4830:134:3::10]:36031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephend@silicom-usa.com>) id 1gP8eh-0007Mj-Ur
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:13:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephend@silicom-usa.com>) id 1gP8ed-0006Ra-KI
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:13:39 -0500
Received: from mail-eopbgr70135.outbound.protection.outlook.com
	([40.107.7.135]:56479
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stephend@silicom-usa.com>)
	id 1gP8ed-0006I5-5c
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:13:35 -0500
From: Steve Douthit <stephend@silicom-usa.com>
Date: Tue, 20 Nov 2018 16:13:28 +0000
Message-ID: <03cf3bbc-d557-1c12-dd2b-6acf7934db3c@silicom-usa.com>
References: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
	<20181119084855.uyira2lpu73mu2fo@sirius.home.kraxel.org>
	<CAGxU2F4O4aKzrJky7EFeWaHFuBKPwi_Z-j7G7m+ENRojVG_5vA@mail.gmail.com>
	<20181119130713.GB6443@stefanha-x1.localdomain>
	<20181119141543.o6xl4vfptajuksi3@sirius.home.kraxel.org>
	<CAGxU2F4kUD85FMVEAcOpWUAGF98G2KR9O8EVAkzBDmA+DkS2KA@mail.gmail.com>
	<20181120155500.GA29471@morn.lan>
In-Reply-To: <20181120155500.GA29471@morn.lan>
Reply-To: Steve Douthit <stephend@silicom-usa.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E58C11DC7F7A744C826CDB205FC52D07@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [SeaBIOS]  SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>, Rob Bradford <robert.bradford@intel.com>, "seabios@seabios.org" <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

T24gMTEvMjAvMTggMTA6NTUgQU0sIEtldmluIE8nQ29ubm9yIHdyb3RlOg0KPiBPbiBNb24sIE5v
diAxOSwgMjAxOCBhdCAwNzozODozOVBNICswMTAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
DQo+PiBqdXN0IGFuIHVwZGF0ZSwgSSBlbmFibGVkIHRoZSBkZWJ1ZyBwcmludHMgYW5kIEkgc2F3
IHR3byB0aW1lb3V0cyBmaXJlZA0KPj4gd2l0aCBhIGxvdA0KPj4gb2YgdGltZSBsb3N0ICh+Nzgw
bXMgYmV0d2VlbiAiaW5pdCB0aW1lciIgYW5kICJTY2FuIGZvciBWR0EgLi4uIiksDQo+PiBwdXR0
aW5nIG90aGVyIHByaW50cyBJIGRpc2NvdmVyZWQgdGhhdCBhIGxvdCBvZiB0aW1lIGlzIHNwZW50
IGluIHRoZQ0KPj4gdHBtX3NldHVwKCksDQo+PiBkdXJpbmcgdGhlIHByb2JlIG9mIHRoZSAyIFRQ
TSBkZXZpY2VzOg0KPj4NCj4+IDAwLjU0ODg2OSBpbml0IHRpbWVyDQo+PiAwMC41NDk2NzcgLi9z
cmMvcG9zdC5jOjE1NyBwbGF0Zm9ybV9oYXJkd2FyZV9zZXR1cA0KPj4gMDAuNTUwMTgyIC4vc3Jj
L2h3L3RwbV9kcml2ZXJzLmM6NTc5IHRwbWh3X3Byb2JlDQo+PiAwMS4zMDA4MzMgV0FSTklORyAt
IFRpbWVvdXQgYXQgd2FpdF9yZWc4OjgxIQ0KPj4gMDEuMzAxMzg4IC4vc3JjL2h3L3RwbV9kcml2
ZXJzLmM6NTc5IHRwbWh3X3Byb2JlDQo+PiAwMS4zMzE4NDMgV0FSTklORyAtIFRpbWVvdXQgYXQg
d2FpdF9yZWc4OjgxIQ0KPj4gMDEuMzMyMzE2IC4vc3JjL3Bvc3QuYzoxNjAgcGxhdGZvcm1faGFy
ZHdhcmVfc2V0dXANCj4+IDAxLjMzMzM1OCBTY2FuIGZvciBWR0Egb3B0aW9uIHJvbQ0KPiANCj4g
RllJLCB0aGlzIHdhcyByYWlzZWQgYSBmZXcgbW9udGhzIGFnbyAtIHNlZToNCj4gDQo+IGh0dHBz
Oi8vbWFpbC5jb3JlYm9vdC5vcmcvcGlwZXJtYWlsL3NlYWJpb3MvMjAxOC1NYXJjaC8wMTIxODYu
aHRtbA0KPiANCj4gSUlSQywgaXQgc2hvdWxkIGJlIHBvc3NpYmxlIHRvIHZlcmlmeSB0aGUgVFBN
IGRldmljZSBpcyBwcmVzZW50IGJlZm9yZQ0KPiB0cnlpbmcgdG8gd2FpdCBmb3IgaXQuDQoNCldl
IGNvdWxkIHNraXAgcHJvYmluZyBlbnRpcmVseSBpZiB0aGVyZSdzIG5vIFRDUEEgb3IgVFBNMiBB
Q1BJIHRhYmxlcy4NClRoZXJlJ2QgbmVlZCB0byBiZSBzb21lIG9wdGlvbiB0byBmb3JjZSBwcm9i
aW5nIGluIHRoZSBjYXNlIG9mDQptaXNzaW5nL2Jyb2tlbiBBQ1BJIGNvbmZpZ3VyYXRpb25zLg0K
DQo+IC1LZXZpbg0KPiANCg0K
