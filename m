Received: from eggs.gnu.org ([209.51.188.92]:36574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpa1K-0005n8-34
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpa1I-00012k-RH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:42:18 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 1 Feb 2019 14:42:10 +0000
Message-ID: <a0fe9357-7128-21cb-f5b5-ef766baaccbd@virtuozzo.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1548942405-760115-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A5822BD3D03384AA5AF423F42515EA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 1/3] bdrv_query_image_info Error
 parameter added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, "Daniel P. Berrange" <berrange@redhat.com>

MzEuMDEuMjAxOSAxNjo0NiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEluZm9ybSBhIHVz
ZXIgaW4gY2FzZSBxY293Ml9nZXRfc3BlY2lmaWNfaW5mbyBmYWlscyB0byBvYnRhaW4NCj4gUUNP
VzIgaW1hZ2Ugc3BlY2lmaWMgaW5mb3JtYXRpb24uIFRoaXMgcGF0Y2ggaXMgcHJlbGltaW5hcnkg
dG8NCj4gdGhlIHByaW50IG9mIGJpdG1hcCBpbmZvcm1hdGlvbiBpbiB0aGUgJ3FlbXUtaW1nIGlu
Zm8nIG91dHB1dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRy
ZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8
ZWJsYWtlQHJlZGhhdC5jb20+DQo+IC0tLQ0KDQoNClsuLi5dDQoNCj4gLS0tIGEvYmxvY2svY3J5
cHRvLmMNCj4gKysrIGIvYmxvY2svY3J5cHRvLmMNCj4gQEAgLTU5NCwxMyArNTk0LDEzIEBAIHN0
YXRpYyBpbnQgYmxvY2tfY3J5cHRvX2dldF9pbmZvX2x1a3MoQmxvY2tEcml2ZXJTdGF0ZSAqYnMs
DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBJbWFnZUluZm9TcGVjaWZpYyAqDQo+IC1ibG9ja19j
cnlwdG9fZ2V0X3NwZWNpZmljX2luZm9fbHVrcyhCbG9ja0RyaXZlclN0YXRlICpicykNCj4gK2Js
b2NrX2NyeXB0b19nZXRfc3BlY2lmaWNfaW5mb19sdWtzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBF
cnJvciAqKmVycnApDQo+ICAgew0KPiAgICAgICBCbG9ja0NyeXB0byAqY3J5cHRvID0gYnMtPm9w
YXF1ZTsNCj4gICAgICAgSW1hZ2VJbmZvU3BlY2lmaWMgKnNwZWNfaW5mbzsNCj4gICAgICAgUUNy
eXB0b0Jsb2NrSW5mbyAqaW5mbzsNCj4gICANCj4gLSAgICBpbmZvID0gcWNyeXB0b19ibG9ja19n
ZXRfaW5mbyhjcnlwdG8tPmJsb2NrLCBOVUxMKTsNCj4gKyAgICBpbmZvID0gcWNyeXB0b19ibG9j
a19nZXRfaW5mbyhjcnlwdG8tPmJsb2NrLCBlcnJwKTsNCj4gICAgICAgaWYgKCFpbmZvKSB7DQo+
ICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gICAgICAgfQ0KDQptb3JlIGNvbnRleHQ6DQoNCiAg
ICAgICBpZiAoaW5mby0+Zm9ybWF0ICE9IFFfQ1JZUFRPX0JMT0NLX0ZPUk1BVF9MVUtTKSB7DQog
ICAgICAgICAgIHFhcGlfZnJlZV9RQ3J5cHRvQmxvY2tJbmZvKGluZm8pOw0KICAgICAgICAgICBy
ZXR1cm4gTlVMTDsNCiAgICAgICB9DQoNCmZvciBhIGZhc3QgbG9vaywgSSB0aGluayBpdCBzaG91
bGQgYmUgYXNzZXJ0aW9uLCBub3QgaWYsIERhbmllbCwgYW0gSSByaWdodD8NCkFsc28sIEkgdGhp
bmsgd2UgZG9uJ3QgaGF2ZSBibG9jay9jcnlwdG8uYyBpbiBDcnlwdG9ncmFwaHkgc2VjdGlvbiBv
ZiBNQUlOVEFJTkVSUw0KYnkgbWlzdGFrZSwgc28geW91IHdlcmUgbm90IENDJ2VkLg0KDQoNCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL3FhcGkuYyBiL2Jsb2NrL3FhcGkuYw0KPiBpbmRleCBjNjZmOTQ5
Li5mNTNmMTAwIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9xYXBpLmMNCj4gKysrIGIvYmxvY2svcWFw
aS5jDQo+IEBAIC0yODIsNyArMjgyLDEyIEBAIHZvaWQgYmRydl9xdWVyeV9pbWFnZV9pbmZvKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgaW5mby0+ZGlydHlfZmxhZyA9IGJkaS5p
c19kaXJ0eTsNCj4gICAgICAgICAgIGluZm8tPmhhc19kaXJ0eV9mbGFnID0gdHJ1ZTsNCj4gICAg
ICAgfQ0KPiAtICAgIGluZm8tPmZvcm1hdF9zcGVjaWZpYyAgICAgPSBiZHJ2X2dldF9zcGVjaWZp
Y19pbmZvKGJzKTsNCj4gKyAgICBpbmZvLT5mb3JtYXRfc3BlY2lmaWMgICAgID0gYmRydl9nZXRf
c3BlY2lmaWNfaW5mbyhicywgJmVycik7DQoNCndoaWxlIGJlaW5nIGhlcmUsIGxldCdzIGRyb3Ag
dGhlc2UgZXh0cmEgd2hpdGVzcGFjZXMNCg0KPiArICAgIGlmIChlcnIpIHsNCj4gKyAgICAgICAg
ZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQo+ICsgICAgICAgIHFhcGlfZnJlZV9JbWFnZUlu
Zm8oaW5mbyk7DQo+ICsgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgIH0NCj4gICAgICAgaW5mby0+
aGFzX2Zvcm1hdF9zcGVjaWZpYyA9IGluZm8tPmZvcm1hdF9zcGVjaWZpYyAhPSBOVUxMOw0KPiAg
IA0KPiAgICAgICBiYWNraW5nX2ZpbGVuYW1lID0gYnMtPmJhY2tpbmdfZmlsZTsNCg0KDQpTbywg
SSdtIHVuc3VyZSBhYm91dCBjcnlwdG8sIGJ1dCBpdCdzIHNhZmUgdG8ga2VlcCBpdCBhcyBpcywg
c28gZm9yIHRoaXMgcGF0Y2g6DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K
