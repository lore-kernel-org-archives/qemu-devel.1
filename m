Received: from eggs.gnu.org ([2001:4830:134:3::10]:47227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fLWT4-0001zs-1E
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fLWSz-0002jP-QQ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:18:26 -0400
Received: from mail-co1nam03on0070.outbound.protection.outlook.com
	([104.47.40.70]:53962
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fLWSz-0002ij-6o
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:18:21 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 23 May 2018 16:18:17 +0000
Message-ID: <DM5PR12MB24715AE7662F1F1D571832B9956B0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
	<1526949675-106737-3-git-send-email-babu.moger@amd.com>
	<CY4PR12MB181551D174221BF3CC5F209AF9940@CY4PR12MB1815.namprd12.prod.outlook.com>
	<DM5PR12MB24713F0E6095C786E0AA8ED795940@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180522140339.GC25013@localhost.localdomain>
In-Reply-To: <20180522140339.GC25013@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 2/5] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Duran, Leo" <leo.duran@amd.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVkdWFyZG8gSGFia29zdCBb
bWFpbHRvOmVoYWJrb3N0QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyMiwgMjAx
OCA5OjA0IEFNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPg0KPiBDYzog
RHVyYW4sIExlbyA8bGVvLmR1cmFuQGFtZC5jb20+OyBtc3RAcmVkaGF0LmNvbTsNCj4gbWFyY2Vs
LmFwZmVsYmF1bUBnbWFpbC5jb207IHBib256aW5pQHJlZGhhdC5jb207IHJ0aEB0d2lkZGxlLm5l
dDsNCj4gbXRvc2F0dGlAcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBrdm1Admdl
ci5rZXJuZWwub3JnOw0KPiBrYXNoQHRyaXBsZWJhY2submV0OyBnZW9mZkBob3N0Zmlzc2lvbi5j
b20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMi81XSBpMzg2OiBQb3B1bGF0ZSBBTUQgUHJv
Y2Vzc29yIENhY2hlDQo+IEluZm9ybWF0aW9uIGZvciBjcHVpZCAweDgwMDAwMDFEDQo+IA0KPiBP
biBUdWUsIE1heSAyMiwgMjAxOCBhdCAwMTozMjo1MlBNICswMDAwLCBNb2dlciwgQmFidSB3cm90
ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IER1
cmFuLCBMZW8NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDIxLCAyMDE4IDg6MzIgUE0NCj4gPiA+
IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgbXN0QHJlZGhhdC5jb207DQo+
ID4gPiBtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbTsgcGJvbnppbmlAcmVkaGF0LmNvbTsgcnRo
QHR3aWRkbGUubmV0Ow0KPiA+ID4gZWhhYmtvc3RAcmVkaGF0LmNvbTsgbXRvc2F0dGlAcmVkaGF0
LmNvbQ0KPiA+ID4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsga3ZtQHZnZXIua2VybmVsLm9y
ZzsNCj4ga2FzaEB0cmlwbGViYWNrLm5ldDsNCj4gPiA+IGdlb2ZmQGhvc3RmaXNzaW9uLmNvbQ0K
PiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MTAgMi81XSBpMzg2OiBQb3B1bGF0ZSBBTUQgUHJv
Y2Vzc29yIENhY2hlDQo+ID4gPiBJbmZvcm1hdGlvbiBmb3IgY3B1aWQgMHg4MDAwMDAxRA0KPiA+
ID4NCj4gPiA+IEJhYnUsDQo+ID4gPg0KPiA+ID4gSWYgbnVtX3NoYXJpbmdfbDNfY2FjaGUoKSB1
c2VzIE1BWF9OT0RFU19FUFlDLCB0aGVuIHRoYXQgZnVuY3Rpb24NCj4gSXTigJlzDQo+ID4gPiBF
UFlDIHNwZWNpZmljLg0KPiA+ID4NCj4gPiA+IEFuIGFsdGVybmF0aXZlIHdvdWxkIGJlIHRvIHVz
ZSBhIGRhdGEgbWVtYmVyIChlLmcuLA0KPiA+ID4gbWF4X25vZGVzX3Blcl9zb2NrZXQpKSB0aGF0
IGdldCBpbml0aWFsaXplZCAodmlhIGFub3RoZXIgaGVscGVyDQo+IGZ1bmN0aW9uKSB0bw0KPiA+
ID4gTUFYX05PREVTX0VQWUMuDQo+ID4NCj4gPiBUaGFua3MgTGVvLiAgTGV0IG1lIHNlZSBob3cg
d2UgY2FuIGhhbmRsZSB0aGlzLiBUaGlzIHJlcXVpcmVzIGNoYW5nZXMgaW4NCj4gZ2VuZXJpYw0K
PiA+IERhdGEgc3RydWN0dXJlIHdoaWNoIEkgdHJpZWQgdG8gYXZvaWQgaGVyZS4gIEkgd2lsbCB3
YWl0IGZvciBhbGwgdGhlIGNvbW1lbnRzDQo+IGZvciB3aG9sZQ0KPiA+IHNlcmllcyBiZWZvcmUg
bWFraW5nIHRoaXMgY2hhbmdlLiAgTm90ZSB0aGF0IHJpZ2h0IG5vdywgdGhpcyBmZWF0dXJlIGlz
IG9ubHkNCj4gZW5hYmxlZA0KPiA+IGZvciBFUFlDLiBZZXMuIEkga25vdyB0aGlzIGNvdWxkIHRo
aXMgaW4gZnV0dXJlLg0KPiANCj4gV2UganVzdCBuZWVkIGEgcmVhc29uYWJsZSBkZWZhdWx0LCBi
eSBub3csIGFuZCBpdCBjYW4gZXZlbiBiZSB0aGUNCj4gc2FtZSB2YWx1ZSB1c2VkIG9uIEVQWUMu
ICBUaGlzIGRlZmF1bHQganVzdCBuZWVkIHRvIGdlbmVyYXRlDQo+IHJlYXNvbmFibGUgcmVzdWx0
cyBmb3Igb3RoZXIgY2FzZXMgdGhhdCBkb24ndCBtYXRjaCByZWFsIGhhcmR3YXJlDQo+IChsaWtl
IGNvcmVzPTMyIG9yIGNvcmVzPTEyKS4NCg0KT2suIFdpbGwgY2hhbmdlIHRoZSBuYW1lIHRvIGJp
dCBnZW5lcmljIGZvciBub3cgYW5kIGtlZXAgdGhlIGRlZmF1bHRzIGFzIGluIEVQWUMuDQo+IA0K
PiAtLQ0KPiBFZHVhcmRvDQo=
