Received: from eggs.gnu.org ([2001:4830:134:3::10]:56082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjUwT-000493-Sh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjUwS-0004r9-Qc
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:55:05 -0500
Received: from mail-cys01nam02on0129.outbound.protection.outlook.com
	([104.47.37.129]:7583
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1cjUwS-0004pu-BA
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:55:04 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 2 Mar 2017 17:21:46 +0000
Message-ID: <3FB730F1-6067-4FD4-8D3F-19C648472B1B@nutanix.com>
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
	<148847375468.285.999031041241417996@0e2666bad730>
	<F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
	<20170302171721.GG11445@redhat.com>
In-Reply-To: <20170302171721.GG11445@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <229B284037C7274CA95CEBFDBCA84346@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "famz@redhat.com" <famz@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

DQo+IE9uIDIgTWFyIDIwMTcsIGF0IDE3OjE3LCBEYW5pZWwgUC4gQmVycmFuZ2UgPGJlcnJhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXIgMDIsIDIwMTcgYXQgMDU6MDE6
MDZQTSArMDAwMCwgRmVsaXBlIEZyYW5jaW9zaSB3cm90ZToNCj4+IEhpIEVyaWMsDQo+PiANCj4+
IFBpbmcgb24gdGhpcz8NCj4+IGh0dHA6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9x
ZW11LWRldmVsLzIwMTYtMTAvbXNnMDYxNjkuaHRtbA0KPiANCj4gW3NuaXBdDQo+IA0KPj4gICAg
ICBDQyAgICAgIGNvbnRyaWIvaXZzaG1lbS1jbGllbnQvbWFpbi5vDQo+PiAgICAvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtbmF4dXlfa3Uvc3JjL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2
aG9zdC11c2VyLmM6IEluIGZ1bmN0aW9uIOKAmHZ1X3Bhbmlj4oCZOg0KPj4gICAgL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLW5heHV5X2t1L3NyYy9jb250cmliL2xpYnZob3N0LXVzZXIvbGli
dmhvc3QtdXNlci5jOjg0OjU6IGVycm9yOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2Yg4oCYdmFz
cHJpbnRm4oCZLCBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3YXJuX3VudXNlZF9yZXN1bHQgWy1X
ZXJyb3I9dW51c2VkLXJlc3VsdF0NCj4+ICAgICAgICAgKHZvaWQpdmFzcHJpbnRmKCZidWYsIG1z
ZywgYXApOw0KPj4gICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4+ICAg
IGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+IA0KPiBZb3UgY2Fu
IHNpZGUtc3RlcCB0aGUgaXNzdWUgZW50aXJlbHkgYnkgc2ltcGx5IG5vdCB1c2luZyB0aGUgdmFz
cHJpbnRmDQo+IGZ1bmN0aW9uLiBJbnN0ZWFkIGRvICAgJ2J1ZiA9IGdfc3RyZHVwX3ZwcmludGYo
bXNnLCBhcCk7JyAtIGdsaWIgZG9lcw0KPiBhYm9ydC1vbi1vb20sIHNvIHRoZXJlJ3Mgbm8gZXJy
b3Igc2NlbmFyaW8geW91IG5lZWQgdG8gaGFuZGxlLg0KDQpUaGFua3MgZm9yIHRoZSBwb2ludGVy
LiBUaGF0IGNvZGUgaXMgaW4gbGlidmhvc3QtdXNlciBhbHJlYWR5LiBJIGNhbiBzZW5kIGEgc2Vw
YXJhdGUgcGF0Y2ggdG8gZml4IHRoYXQgaWYgeW91IHByZWZlci4NCkp1c3QgdGhpbmsgdGhhdCBm
b3IgdGhpcyBraW5kIG9mIHVzYWdlIGEgc2ltcGxlIGlnbm9yZV92YWx1ZSh2YXNwcmludGYoLi4u
KSkgaXMgc3VmZmljaWVudDsgdGhhdCBjYWxsIGlzIGluIGEgcGFuaWMgcGF0aCBhbHJlYWR5Lg0K
DQpUaGVyZSB3ZXJlIG90aGVyIGNhc2VzIHdoZXJlIGlnbm9yaW5nIHRoZSByZXR1cm4gdmFsdWUg
c2VlbWVkIGxpa2UgdGhlIHByZWZlcnJlZCB0aGluZyB0byBkby4NCg0KRmVsaXBlDQoNCj4gDQo+
IFJlZ2FyZHMsDQo+IERhbmllbA0KPiAtLSANCj4gfDogaHR0cDovL2JlcnJhbmdlLmNvbSAgICAg
IC1vLSAgICBodHRwOi8vd3d3LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5nZS8gOnwNCj4gfDog
aHR0cDovL2xpYnZpcnQub3JnICAgICAgICAgICAgICAtby0gICAgICAgICAgICAgaHR0cDovL3Zp
cnQtbWFuYWdlci5vcmcgOnwNCj4gfDogaHR0cDovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAgICAt
by0gICAgaHR0cDovL3NlYXJjaC5jcGFuLm9yZy9+ZGFuYmVyci8gOnwNCg0K
