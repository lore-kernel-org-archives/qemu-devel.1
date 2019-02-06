Received: from eggs.gnu.org ([209.51.188.92]:44614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grHLb-0003C1-6y
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grHFL-0000X1-Jf
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:03:50 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Feb 2019 07:03:24 +0000
Message-ID: <b5745dca-3edc-b908-ef6d-6e3e3761043d@virtuozzo.com>
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549397675-189741-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ce1a623e-8844-72d5-e4a7-ca8cb9354c86@redhat.com>
In-Reply-To: <ce1a623e-8844-72d5-e4a7-ca8cb9354c86@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <299FBCB8845FC44CB87A78F0CDA4D442@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 2/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDUuMDIuMjAxOSAyMzozMywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMi81LzE5IDI6MTQgUE0s
IEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gSW4gdGhlICdGb3JtYXQgc3BlY2lmaWMgaW5m
b3JtYXRpb24nIHNlY3Rpb24gb2YgdGhlICdxZW11LWltZyBpbmZvJw0KPj4gY29tbWFuZCBvdXRw
dXQsIHRoZSBzdXBwbGVtZW50YWwgaW5mb3JtYXRpb24gYWJvdXQgZXhpc3RpbmcgUUNPVzINCj4+
IGJpdG1hcHMgd2lsbCBiZSBzaG93biwgc3VjaCBhcyBhIGJpdG1hcCBuYW1lLCBmbGFncyBhbmQg
Z3JhbnVsYXJpdHk6DQo+Pg0KPiANCj4+ICsjIw0KPj4gKyMgQFFjb3cyQml0bWFwSW5mbzoNCj4+
ICsjDQo+PiArIyBRY293MiBiaXRtYXAgaW5mb3JtYXRpb24uDQo+PiArIw0KPj4gKyMgQG5hbWU6
IHRoZSBuYW1lIG9mIHRoZSBiaXRtYXANCj4+ICsjDQo+PiArIyBAZ3JhbnVsYXJpdHk6IGdyYW51
bGFyaXR5IG9mIHRoZSBiaXRtYXAgaW4gYnl0ZXMNCj4+ICsjDQo+PiArIyBAZmxhZ3M6IGZsYWdz
IG9mIHRoZSBiaXRtYXANCj4+ICsjDQo+PiArIyBTaW5jZTogNC4wDQo+IA0KPiBZb3UgZ290IHJp
ZCBvZiB0aGUgZG9jcyBmb3IgdW5rbm93bi1mbGFncywNCj4gDQo+PiArIyMNCj4+ICt7ICdzdHJ1
Y3QnOiAnUWNvdzJCaXRtYXBJbmZvJywNCj4+ICsgICdkYXRhJzogeyduYW1lJzogJ3N0cicsICdn
cmFudWxhcml0eSc6ICd1aW50MzInLA0KPj4gKyAgICAgICAgICAgJ2ZsYWdzJzogWydRY293MkJp
dG1hcEluZm9GbGFncyddLA0KPj4gKyAgICAgICAgICAgJyp1bmtub3duLWZsYWdzJzogJ3VpbnQz
MicgfSB9DQo+IA0KPiBidXQgZm9yZ290IHRvIGFjdHVhbGx5IGdldCByaWQgb2YgdGhlIGZpZWxk
LiBUaGF0J3MgYSBwcmV0dHkgc2ltcGxlDQo+IGNsZWFudXAsIHdoaWNoIEkgZG9uJ3QgbWluZCBt
YWtpbmcgaWYgdGhpcyBzZXJpZXMgaXMgb3RoZXJ3aXNlIHJlYWR5IHRvIGdvLg0KPiANCj4gUmV2
aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPiANCg0KYW5kIHdpdGgg
dGhhdCBmaXhlZCwgaXQncyBPSyBmb3IgbWUgdG9vOg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
