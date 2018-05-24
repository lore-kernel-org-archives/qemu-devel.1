Received: from eggs.gnu.org ([2001:4830:134:3::10]:56487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fLsed-00040Q-9C
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fLsea-0003TN-5U
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:59:51 -0400
Received: from mail-by2nam03on0053.outbound.protection.outlook.com
	([104.47.42.53]:21568
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fLseZ-0003Sp-RE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:59:48 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Thu, 24 May 2018 15:59:44 +0000
Message-ID: <DM5PR12MB247109D7898F9D444FE8987B956A0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
	<4e7811da-f900-bbf4-ea88-cf8983a6675f@tripleback.net>
In-Reply-To: <4e7811da-f900-bbf4-ea88-cf8983a6675f@tripleback.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 0/5] i386: Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kash Pande <kash@tripleback.net>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "geoff@hostfission.com" <geoff@hostfission.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEthc2ggUGFuZGUgW21haWx0
bzprYXNoQHRyaXBsZWJhY2submV0XQ0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDI0LCAyMDE4IDEw
OjUxIEFNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgbXN0QHJlZGhh
dC5jb207DQo+IG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tOyBwYm9uemluaUByZWRoYXQuY29t
OyBydGhAdHdpZGRsZS5uZXQ7DQo+IGVoYWJrb3N0QHJlZGhhdC5jb207IG10b3NhdHRpQHJlZGhh
dC5jb20NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsga3ZtQHZnZXIua2VybmVsLm9yZzsg
Z2VvZmZAaG9zdGZpc3Npb24uY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDAvNV0gaTM4
NjogRW5hYmxlIFRPUE9FWFQgdG8gc3VwcG9ydA0KPiBoeXBlcnRocmVhZGluZyBvbiBBTUQgQ1BV
DQo+IA0KPiBUZXN0ZWQtYnk6IEthc2ggUGFuZGUgPGthc2hAdHJpcGxlYmFjay5uZXQ+DQoNClRo
YW5rcw0KDQo+IA0KPiANCj4gSG9wZWZ1bGx5IHdlIGNhbiBnZXQgdGhpcyBtZXJnZWQgYmVjYXVz
ZSBpdCdzIHRha2VuIGEgcmlkaWN1bG91c2x5IGxvbmcNCj4gdGltZSB3aXRoIG1hbnkgYmFjay1h
bmQtZm9ydGhzIGZvciBzbWFsbCBpc3N1ZXMgdGhhdCBjb3VsZCBoYXZlIGJlZW4gcHV0DQo+IG9m
ZiB0aWwgbGF0ZXIuDQoNCldlIGFyZSBhbG1vc3QgdGhlcmUuICBUaGFua3MgZm9yIHlvdXIgcGF0
aWVuY2UuICk6DQoNCj4gDQo+IEthc2gNCj4gDQo+IE9uIDIwMTgtMDUtMjQgMTE6NDMgQU0sIEJh
YnUgTW9nZXIgd3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgZW5hYmxlcyB0aGUgVE9QT0VYVCBmZWF0
dXJlIGZvciBBTUQgQ1BVcy4gVGhpcyBpcyByZXF1aXJlZCB0bw0KPiA+IHN1cHBvcnQgaHlwZXJ0
aHJlYWRpbmcgb24ga3ZtIGd1ZXN0cy4NCj4gPg0KPiA+IFRoaXMgYWRkcmVzc2VzIHRoZSBpc3N1
ZXMgcmVwb3J0ZWQgaW4gdGhlc2UgYnVnczoNCj4gPiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5j
b20vc2hvd19idWcuY2dpP2lkPTE0ODEyNTMNCj4gPiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5l
dC9xZW11LytidWcvMTcwMzUwNg0KPiA+DQo+ID4gdjExOg0KPiA+ICBQYXRjaGVzIGFyZSBiYXNl
ZCBvZmYgb2YgRWR1YXJkbydzIGdpdDovL2dpdGh1Yi5jb20vZWhhYmtvc3QvcWVtdS5naXQNCj4g
eDg2LW5leHQuDQo+ID4gIFN1bW1hcnkgb2YgY2hhbmdlcy4NCj4gPiAgMS5BZGRlZCBtb3JlIGNv
bW1lbnRzIGV4cGxhaW5pbmcgZGlmZmVyZW50IGNvbnN0YW50cyBhbmQgdmFyaWFibGVzLg0KPiA+
ICAyLlJlbW92ZWQgTlVNX1NIQVJJTkdfQ0FDSEUgbWFjcm8gYW5kIG1hZGUgdGhlIGNvZGUgc2lt
cGxlci4NCj4gPiAgMy5DaGFuZ2VkIHRoZSBmdW5jdGlvbiBuYW1lIG51bV9zaGFyaW5nX2wzX2Nh
Y2hlIHRvDQo+IGNvcmVzX2luX2NvcmVfY29tcGxleC4NCj4gPiAgICBUaGlzIGZ1bmN0aW9uIGlz
IGFjdHVhbGx5IGZpbmRpbmcgdGhlIG51bWJlciBvZiBjb3JlcyBpbiBhIGNvcmUgY29tcGxleC4N
Cj4gPiAgICBQdXJwb3NlIGhlcmUgaXMgdG8gcmUtdXNlIHRoZSBjb2RlIGluIGNvdXBsZSBtb3Jl
IHBsYWNlcy4NCj4gPiAgNC5BZGRlZCBuZXcgZnVuY3Rpb24gbm9kZXNfaW5fc29ja2V0IHRvIGZp
bmQgbnVtYmVyIG9mIG5vZGVzIGluIHRoZQ0KPiBjb25maWcuDQo+ID4gICAgUHVycG9zZSBoZXJl
IGlzIHRvIHJlLXVzZSB0aGUgY29kZS4NCj4gPiAgNS5Vc2VkIERJVl9ST1VORF9VUCB3aGVyZXZl
ciBhcHBsaWNhYmxlLg0KPiA+ICA2LlJlbmFtZWQgZmV3IGNvbnN0YW50cyBhbmQgZnVuY3Rpb25z
IHRvIGdlbmVyaWMgbmFtZXMuDQo+ID4gIDcuRmV3IG1vcmUgdGV4dCBjb3JyZWN0aW9ucy4NCj4g
Pg0KPiANCg0K
