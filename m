Received: from eggs.gnu.org ([2001:4830:134:3::10]:48049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dXVDP-0000xG-Op
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dXVDM-0005JS-JE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:19:15 -0400
Received: from mail-sn1nam01on0112.outbound.protection.outlook.com
	([104.47.32.112]:59110
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1dXVDM-0005Hs-1E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:19:12 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 18 Jul 2017 16:19:08 +0000
Message-ID: <DM2PR21MB0060A68EDF44A9FC4B018C909EA10@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
	<1263c0a6-263f-0b3b-c84a-f882df33856b@redhat.com>
	<edae6aa7-34ef-a3a8-94e0-175f05728345@redhat.com>
In-Reply-To: <edae6aa7-34ef-a3a8-94e0-175f05728345@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Disable image locking for snapshot drive?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>

PiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1
ZXNkYXksIDE4IEp1bHkgMjAxNyA4OjA3DQo+IE9uIDA3LzE3LzIwMTcgMDc6MzMgUE0sIEpvaG4g
U25vdyB3cm90ZToNCj4gPiBPbiAwNy8xNy8yMDE3IDA3OjMwIFBNLCBBbmRyZXcgQmF1bWFubiB2
aWEgUWVtdS1kZXZlbCB3cm90ZToNCj4gPj4gSSdtIHJ1bm5pbmcgYSByZWNlbnQgTGludXggYnVp
bGQgb2YgcWVtdSBvbiBXaW5kb3dzIFN1YnN5c3RlbSBmb3IgTGludXgNCj4gKFdTTCkgd2hpY2gg
ZG9lc24ndCBhcHBlYXIgdG8gaW1wbGVtZW50IGZpbGUgbG9ja2luZzoNCj4gPj4NCj4gPj4gJCBx
ZW11LXN5c3RlbS1hYXJjaDY0IC4uLiAtZHJpdmUgZmlsZT10ZXN0LnZoZHgsaWY9bm9uZSxpZD1o
ZDAgLWRldmljZQ0KPiB2aXJ0aW8tYmxrLXBjaSxkcml2ZT1oZDANCj4gPj4gcWVtdS1zeXN0ZW0t
YWFyY2g2NDogLWRyaXZlIGZpbGU9dGVzdC52aGR4LGlmPW5vbmUsaWQ9aGQwOiBGYWlsZWQgdG8N
Cj4gdW5sb2NrIGJ5dGUgMTAwDQo+IA0KPiBEb2VzIFdTTCBpbXBsZW1lbnQgZmNudGwoRl9TRVRM
SykgYnV0IG5vdCBmY250bChGX09GRF9TRVRMSyk/DQoNClllcywgdGhpcyBhcHBlYXJzIHRvIGJl
IHRoZSBjYXNlICh0aGVyZSdzIGFsc28gb25lIHJlcG9ydCB0aGF0IGl0J3MgYnJva2VuKToNCmh0
dHBzOi8vZ2l0aHViLmNvbS9NaWNyb3NvZnQvQmFzaE9uV2luZG93cy9pc3N1ZXMvMTkyNw0KDQo+
IFdlDQo+IGFscmVhZHkgaGF2ZSBjb2RlIGluIHBsYWNlIGZvciBjb21waWxpbmcgd2hlbiBGX09G
RF9TRVRMSyBpcyBub3QNCj4gc3VwcG9ydGVkICh3aGljaCBtYWtlcyBsb2NrPWF1dG8gZG8gbm90
aGluZywgYW5kIGlzc3VlcyBhIHdhcm5pbmcgdGhhdA0KPiBGX1NFVExLIGxvY2tzIG1heSBiZSBp
bmVmZmVjdGl2ZSB3aGVuIGxvY2tzIGFyZSBleHBsaWNpdGx5IHJlcXVlc3RlZCksDQo+IGRvIHdl
IG5lZWQgdG8ganVzdCBleHBhbmQgdGhhdCBjb2RlIGludG8gYSBydW50aW1lIHRlc3Qgb2Ygd2hl
dGhlcg0KPiBGX09GRF9TRVRMSyBhcHBlYXJzIHRvIGJlIHVuc3VwcG9ydGVkPw0KDQpUaGF0IHdv
dWxkIGJlIGEgbmljZSBmaXgsIGFuZCBpdCB3b3VsZCBhdm9pZCB0aGUgbmVlZCBmb3IgeWV0IGFu
b3RoZXIgZmxhZy4gT24gdGhlIG90aGVyIGhhbmQsIFdTTCBpcyBhaW1pbmcgZm9yIEFCSSBjb21w
YXRpYmlsaXR5LCBzbyB0aGV5IHNob3VsZCBnZXQgYXJvdW5kIHRvIGltcGxlbWVudGluZyBGX09G
RF9TRVRMSyBldCBhbCBldmVudHVhbGx5Lg0KDQpFdmVuIGlmIHRoaXMgd2VyZSBmaXhlZCBpbiBR
RU1VIG9yIGltcGxlbWVudGVkIGluIFdTTCwgc2hvdWxkbid0IHRoZXJlIHRvIGJlIGEgd2F5IHRv
IHR1cm4gc25hcHNob3QgZmlsZSBsb2NraW5nIG9mZiBvbiBhIHBlci1kcml2ZSBiYXNpcz8NCg0K
QW5kcmV3IA0K
