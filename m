Received: from eggs.gnu.org ([2001:4830:134:3::10]:60101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1eEtdF-0001h9-Nj
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1eEtdA-0000Q6-3d
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:05:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:14196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1eEtd9-0000Gq-PA
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:05:12 -0500
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Wed, 15 Nov 2017 09:05:03 +0000
Message-ID: <1510736731.4383.4.camel@intel.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKE1-ApZ9MF2njB-0yiaszqJFZPVTfGQHg0YYgsuhwhnw@mail.gmail.com>
	<d670c086-f0f8-8906-795e-80345ec8475a@linux.vnet.ibm.com>
	<CAJ+F1C+4Ab_+DpUNbEf+kZPZ=T26tA0tNxQD4JWpc1+mmiKK-A@mail.gmail.com>
In-Reply-To: <CAJ+F1C+4Ab_+DpUNbEf+kZPZ=T26tA0tNxQD4JWpc1+mmiKK-A@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4AD911A31C8B34D962A6590E41488D3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 1/3] tpm_emulator: Add a
 caching layer for the TPM Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

T24gV2VkLCAyMDE3LTExLTE1IGF0IDA0OjQ3ICswMTAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3Jv
dGU6DQo+IEhpDQo+IA0KPiBPbiBXZWQsIE5vdiAxNSwgMjAxNyBhdCAyOjE2IEFNLCBTdGVmYW4g
QmVyZ2VyDQo+IDxzdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4g
T24gMTEvMTQvMjAxNyAwNjo0MCBQTSwgTWFyYy1BbmRyw6kgTHVyZWF1IHdyb3RlOg0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+IEhpDQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgTm92IDE0LCAyMDE3IGF0
IDEwOjUyIFBNLCBTdGVmYW4gQmVyZ2VyDQo+ID4gPiA8c3RlZmFuYkBsaW51eC52bmV0LmlibS5j
b20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBhIGNhY2hpbmcgbGF5
ZXIgZm9yIHRoZSBUUE0gZXN0YWJsaXNoZWQgZmxhZyBzbyB0aGF0IHdlDQo+ID4gPiA+IGRvbid0
DQo+ID4gPiA+IG5lZWQgdG8gZ28gdG8gdGhlIGVtdWxhdG9yIGV2ZXJ5IHRpbWUgdGhlIGZsYWcg
aXMgcmVhZCBieQ0KPiA+ID4gPiBhY2Nlc3NpbmcNCj4gPiA+ID4gdGhlIFJFR19BQ0NFU1MgcmVn
aXN0ZXIuDQo+ID4gPiBXaGF0J3MgdGhlIGltcGFjdD8gSXNuJ3QgdGhpcyBqdXN0IGEgInNtYWxs
IiBvcHRpbWl6YXRpb24/IElvdHcsDQo+ID4gPiB3aHkNCj4gPiA+IGlzIHRoaXMgZm9yLTIuMTE/
DQo+ID4gDQo+ID4gVGhlIFRJUyBoYXMgYSByZWdpc3RlciB0aGF0IGNvbnRhaW5zIHRoaXMgZmxh
ZyBhbmQgdGhhdCdzIGJlaW5nDQo+ID4gcG9sbGVkIHF1aXRlDQo+ID4gZnJlcXVlbnRseS4gU28g
aXQgZ2VuZXJhdGVzIGEgbG90IG9mIHRyYWZmaWMgdG8gdGhlIGVtdWxhdG9yLiBUaGlzDQo+ID4g
Y2FjaGluZw0KPiA+IGxheWVyIGdldHMgcmlkIG9mIG1vc3Qgb2YgdGhlIHRyYWZmaWMuDQo+IEkg
ZGlkbid0IG5vdGljZSBhbnkgcHJvYmxlbSB3aGVuIGRvaW5nIG15IHRlc3RzLCBJIGd1ZXNzIEFt
YXJuYXRoDQo+IG5pZXRoZXIuIHBlcmhhcHMgaXQncyBiZXN0IHRvIGRlbGF5IGZvciBhZnRlciAy
LjExLg0KDQpZZXMsIEkgY291bGQgc2VlIHRoZXJlIGlzIGxpdHRsZSBmcmVxdWVudCgyMSBjYWxs
cyB0byBiYWNrZW5kKSB0byBnZXQNCmVzdGFibGlzaCBmbGFnLCBhbmQgdGhpcyBwYXRjaCB3aWxs
IGhlbHAgdG8gYXZvaWQgdGhlbS4gQnV0IGkgc3RpbGwNCmFncmVlIHdpdGggTWFyYyBhbmQgdGFn
IHRoaXMgYXMgInNtYWxsIiBvcHRpbWl6YXRpb24uDQoNCi0gQW1hcm5hdGgNCg==
