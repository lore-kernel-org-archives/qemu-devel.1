Received: from eggs.gnu.org ([2001:4830:134:3::10]:33859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1ett0P-0005fx-8r
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1ett0L-0006C4-9b
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:42:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:8583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1ett0K-0006Bf-W5
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:42:33 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Thu, 8 Mar 2018 10:42:27 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439B8A9CB@SHSMSX104.ccr.corp.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-12-git-send-email-yi.l.liu@linux.intel.com>
	<a899b75f-5a0b-2a0f-f995-5a3c21eeab8c@redhat.com>
	<20180305091119.GH2482@sky-dev>
	<afb9cbb9-3b05-7677-5707-6deb540daf26@redhat.com>
In-Reply-To: <afb9cbb9-3b05-7677-5707-6deb540daf26@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 11/12] intel_iommu: add framework for
 PASID AddressSpace management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "Tian, Kevin" <kevin.tian@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>

PiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gU2Vu
dDogVHVlc2RheSwgTWFyY2ggNiwgMjAxOCA2OjI3IFBNDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1k
ZXZlbF0gW1BBVENIIHYzIDExLzEyXSBpbnRlbF9pb21tdTogYWRkIGZyYW1ld29yayBmb3IgUEFT
SUQNCj4gQWRkcmVzc1NwYWNlIG1hbmFnZW1lbnQNCj4gDQo+IE9uIDA1LzAzLzIwMTggMTA6MTEs
IExpdSwgWWkgTCB3cm90ZToNCj4gPj4gRG8geW91IHJlYWxseSBuZWVkIFZURERldmljZU5vZGU/
ICBJIHRoaW5rIGNhbiB5b3Ugc2ltcGx5IHB1dCB0aGUNCj4gPj4gUUxJU1RfRU5UUlkgaW4gVlRE
QWRkcmVzc1NwYWNlIChuYW1lZCBlLmcuIG5leHRfYnlfcGFzaWQpLCBzaW5jZQ0KPiA+PiBWVERB
ZGRyZXNzU3BhY2UgYWxyZWFkeSBpbmNsdWRlcyBhIChidXMsIGRldmZuKS4NCj4gPiBFeGlzdGlu
ZyBWVERBZGRyZXNzU3BhY2UgaXMgYWN0YXVsbHkgcGVyLWRldmljZS4gV2hpbGUgZm9yIFBBU0lE
DQo+ID4gdGFnZ2VkIGFkZHJlc3Mgc3BhY2UsIGl0IGlzIHBvc3NpYmxlIHRvIGhhdmUgbXVsdGlw
bGUgZGV2aWNlcyB0aWVkIHRvDQo+ID4gYSBzaW5nbGUgUEFTSUQgdGFnZ2VkIGFkZHJlc3Mgc3Bh
Y2UuDQo+IA0KPiBZZXMsIHRoYXQncyB0aGUgcHVycG9zZSBvZiBWVERQQVNJREFkZHJlc3NTcGFj
ZS4NCj4gDQo+ID4gUmV1c2UgVlREQWRkcmVzc1NwYWNlIGNvdWxkIGJlIGEgY2hvaWNlIHNpbmNl
IGl0IGlzIGEgcGVyLWRldmljZQ0KPiA+IHN0cnVjdHVyZSwgYnV0IGl0IG1heSBiZSBtaXNzbGVh
ZGluZyBzaW5jZSB0aGVyZSBpcyBvdGhlciBmaWxlZHMgaW4NCj4gPiBWVERBZGRyZXNzU3BhY2Uu
IFRoaXMgaXMgd2h5IEkgcHJvcG9zZWQgdG8gaGF2ZSBWVEREZXZpY2VOb2RlLg0KPiANCj4gSSB0
aGluayBpdCdzIG9rYXkgdG8gcHV0IGFsbCBwZXItZGV2aWNlIHNldHVwIGluIFZUREFkZHJlc3NT
cGFjZS4gIExhdGVyIGlmIGl0IG1ha2VzDQo+IHNlbnNlIFZUREFkZHJlc3NTcGFjZSBjb3VsZCBi
ZWNvbWUgYSB1bmlvbiwgYWNjb3JkaW5nIHRvIHdoZXRoZXIgdGhlIElPTU1VIGlzDQo+IGNvbmZp
Z3VyZWQgZm9yIFBBU0lEIG9yIHJlcXVlc3RlciBJRCBvcGVyYXRpb24sIGFuZCBjb3VsZCBiZSBy
ZW5hbWVkIHRvDQo+IFZURERldmljZUluZm8uICBCdXQgZm9yIG5vdyBpdCdzIG5vdCBuZWVkZWQu
DQoNCkFncmVlZC4gTGV0IG1lIGFwcGx5IHRoZSBpZGVhIGluIG5leHQgdmVyc2lvbi4NCg0KVGhh
bmtzLA0KWWkgTGl1DQo=
