Received: from eggs.gnu.org ([2001:4830:134:3::10]:33666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1duobm-0006uJ-LA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1duobj-00036R-8W
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:40:46 -0400
Received: from us-smtp-delivery-101.mimecast.com ([63.128.21.101]:23111)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1duobi-00032D-Qk
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:40:43 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 20 Sep 2017 23:40:03 +0000
Message-ID: <8CF5786D-2429-43B1-BFBC-959519699EAD@nutanix.com>
References: <1505933586-11296-1-git-send-email-felipe@nutanix.com>
	<387632394.19220996.1505939593128.JavaMail.zimbra@redhat.com>
In-Reply-To: <387632394.19220996.1505939593128.JavaMail.zimbra@redhat.com>
Content-Language: en-US
Content-ID: <21F101F9B473EC4894BCF7A0287B75FC@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] virtio/vhost: reset dev->log after syncing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

SGV5YSwNCg0KPiBPbiAyMCBTZXAgMjAxNywgYXQgMTM6MzMsIE1hcmMtQW5kcsOpIEx1cmVhdSA8
bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IEhpDQo+IA0KPiAtLS0t
LSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tDQo+PiB2aG9zdF9sb2dfcHV0KCkgaXMgY2FsbGVkIHRv
IGRlY29taXNzaW9uIHRoZSBkaXJ0eSBsb2cgYmV0d2VlbiBxZW11IGFuZA0KPj4gYSB2aG9zdCBk
ZXZpY2Ugd2hlbiBzdG9wcGluZyB0aGUgZGV2aWNlLiBTdWNoIGEgY2FsbCBjYW4gaGFwcGVuIGZy
b20NCj4+IG1pZ3JhdGlvbl9jb21wbGV0aW9uKCkuDQo+PiANCj4+IFByZXNlbnQgY29kZSBzZXRz
IGRldi0+bG9nX3NpemUgdG8gemVybyB0b28gZWFybHkgaW4gdmhvc3RfbG9nX3B1dCgpLA0KPj4g
Y2F1c2luZyB0aGUgc3luYyBjaGVjayB0byBhbHdheXMgcmV0dXJuIGZhbHNlLiBBcyBhIGNvbnNl
cXVlbmNlLCB0aGUNCj4+IGxhc3QgcGFzcyBvbiB0aGUgZGlydHkgYml0bWFwIG5ldmVyIGhhcHBl
bnMgYXQgdGhlIGVuZCBvZiBtaWdyYXRpb24uDQo+PiANCj4+IElmIGEgdmhvc3QgZGV2aWNlIHdh
cyBidXN5ICh3cml0aW5nIHRvIGd1ZXN0IG1lbW9yeSkgdW50aWwgdGhlIGxhc3QNCj4+IG1vbWVu
dHMgYmVmb3JlIHZob3N0X3ZpcnRxdWV1ZV9zdG9wKCksIHRoaXMgZXJyb3Igd2lsbCByZXN1bHQg
aW4gZ3Vlc3QNCj4+IG1lbW9yeSBjb3JydXB0aW9uIChhdCBsZWFzdCkgZm9sbG93aW5nIG1pZ3Jh
dGlvbnMuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEZlbGlwZSBGcmFuY2lvc2kgPGZlbGlwZUBu
dXRhbml4LmNvbT4NCj4+IC0tLQ0KPj4gaHcvdmlydGlvL3Zob3N0LmMgfCAgICA1ICsrKy0tDQo+
PiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0K
Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC5jIGIvaHcvdmlydGlvL3Zob3N0LmMNCj4+
IGluZGV4IDVmZDY5ZjAuLmRkYzQyZjAgMTAwNjQ0DQo+PiAtLS0gYS9ody92aXJ0aW8vdmhvc3Qu
Yw0KPj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LmMNCj4+IEBAIC0zNzUsOCArMzc1LDYgQEAgc3Rh
dGljIHZvaWQgdmhvc3RfbG9nX3B1dChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJvb2wNCj4+IHN5
bmMpDQo+PiAgICAgaWYgKCFsb2cpIHsNCj4+ICAgICAgICAgcmV0dXJuOw0KPj4gICAgIH0NCj4+
IC0gICAgZGV2LT5sb2cgPSBOVUxMOw0KPj4gLSAgICBkZXYtPmxvZ19zaXplID0gMDsNCj4+IA0K
PiANCj4gDQo+IEdvb2QgY2F0Y2guIFRoaXMgcmVtaW5kcyBtZSBvZiBhbm90aGVyIHBhdGNoLCBi
dXQgSSBjYW4ndCBmaW5kIGl0Lg0KDQpJIGFjdHVhbGx5IHJhbiBpbnRvIHRoaXMgZXJyb3Igd2hl
biB0ZXN0aW5nIG1pZ3JhdGlvbiB3aXRoIGEgdmhvc3QtdXNlci1zY3NpIGJhY2tlZCBjb250cm9s
bGVyIGFuZCBhIHJlcXVlc3QgdGhhdCBjb21wbGV0ZXMgd2hpbGUgcXVpZXNjaW5nIG9uIGEgVlJJ
TkdfR0VUX0JBU0UuIFRvb2sgbWUgYSB3aGlsZSB0byBmaWd1cmUgb3V0IHdoeSB0aGUgYml0bWFw
IHdhc24ndCBiZWluZyBob25vdXJlZCBieSBRZW11LiA6KA0KDQo+IA0KPiBXaGF0IGlmIHdlIHJl
cGxhY2UgZGV2LT5sb2dfc2l6ZSB3aXRoIGxvZy0+c2l6ZSBiZWxvdz8gDQo+IA0KPiAoYW5kIEkg
ZG9uJ3Qgc2VlIGEgY2xlYXIgcmVhc29uIHdoeSBkZXYtPmxvZ19zaXplIHdvdWxkIGJlIGRpZmZl
cmVudCBmcm9tICJsb2cgPyBsb2ctPnNpemUgOiAwIiwgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8p
DQoNCkkgY2FuIHNlZSB0aGF0IHZob3N0X2Rldl9sb2dfcmVzaXplKCkgY2hhbmdlcyBkZXYtPmxv
Z19zaXplIHdpdGhvdXQgbmVjZXNzYXJpbHkgY2hhbmdpbmcgZGV2LT5sb2dfc2l6ZS4gSGF2aW5n
IHNhaWQgdGhhdCwgaXQgc2VlbXMgbGlrZSB0aGUgbGF0dGVyIGdldHMgY29ycmVjdGx5IHVwZGF0
ZWQgZHVyaW5nIHZob3N0X2xvZ19nZXQoKSB3aGljaCBoYXBwZW5zIG9uIHRoZSBzYW1lIGZ1bmN0
aW9uLg0KDQpJbiBhbnkgY2FzZSwgSSBmZWVsIGxpa2UgYW55IGZ1cnRoZXIgaW1wcm92ZW1lbnQg
dG8gdGhlIGZ1bmN0aW9uIHNob3VsZCBiZSBkaXNjdXNzZWQgYW5kIGRvbmUgaW4gYSBzZXBhcmF0
ZSBjb21taXQuDQoNCkNoZWVycywNCkZlbGlwZQ0KDQo+IA0KPj4gICAgIC0tbG9nLT5yZWZjbnQ7
DQo+PiAgICAgaWYgKGxvZy0+cmVmY250ID09IDApIHsNCj4+IEBAIC0zOTYsNiArMzk0LDkgQEAg
c3RhdGljIHZvaWQgdmhvc3RfbG9nX3B1dChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIGJvb2wNCj4+
IHN5bmMpDQo+PiANCj4+ICAgICAgICAgZ19mcmVlKGxvZyk7DQo+PiAgICAgfQ0KPj4gKw0KPj4g
KyAgICBkZXYtPmxvZyA9IE5VTEw7DQo+PiArICAgIGRldi0+bG9nX3NpemUgPSAwOw0KPiANCj4+
IH0NCj4+IA0KPj4gc3RhdGljIGJvb2wgdmhvc3RfZGV2X2xvZ19pc19zaGFyZWQoc3RydWN0IHZo
b3N0X2RldiAqZGV2KQ0KPj4gLS0NCj4+IDEuNy4xDQo+PiANCj4+IA0KPiANCg0K
