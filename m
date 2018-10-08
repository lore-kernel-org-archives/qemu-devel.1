Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1g9W5T-0000xo-Pu
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1g9Vsb-0005pb-MQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:47:31 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 8 Oct 2018 13:47:13 +0000
Message-ID: <76c2bb8e-c19c-9557-8067-b718c2d88d37@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1534844779-118784-8-git-send-email-anton.nefedov@virtuozzo.com>
	<20181004155200.GJ6009@localhost.localdomain>
In-Reply-To: <20181004155200.GJ6009@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CB039A7084B7B4AAEEF265CD5746EDE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 7/8] file-posix: account discard
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

DQoNCk9uIDQvMTAvMjAxOCA2OjUyIFBNLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiBBbSAyMS4wOC4y
MDE4IHVtIDExOjQ2IGhhdCBBbnRvbiBOZWZlZG92IGdlc2NocmllYmVuOg0KPj4gVGhpcyB3aWxs
IGhlbHAgdG8gaWRlbnRpZnkgaG93IG1hbnkgb2YgdGhlIHVzZXItaXNzdWVkIGRpc2NhcmQgb3Bl
cmF0aW9ucw0KPj4gKGFjY291bnRlZCBvbiBhIGRldmljZSBsZXZlbCkgaGF2ZSBhY3R1YWxseSBz
dWNlZWRlZCBkb3duIG9uIHRoZSBob3N0IGZpbGUNCj4+IChldmVuIHRob3VnaCB0aGUgbnVtYmVy
cyB3aWxsIG5vdCBiZSBleGFjdGx5IHRoZSBzYW1lIGlmIG5vbi1yYXcgZm9ybWF0DQo+PiBkcml2
ZXIgaXMgdXNlZCAoZS5nLiBxY293MiBzZW5kaW5nIG1ldGFkYXRhIGRpc2NhcmRzKSkuDQo+Pg0K
Pj4gTm90ZSB0aGF0IHRoZXNlIG51bWJlcnMgd2lsbCBub3QgaW5jbHVkZSBkaXNjYXJkcyB0cmln
Z2VyZWQgYnkNCj4+IHdyaXRlLXplcm9lcyArIE1BWV9VTk1BUCBjYWxscy4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+DQo+
IA0KPiBXaHkgbm90IGltcGxlbWVudCBhY2NvdW50aW5nIGF0IHRoZSBCRFMgbGV2ZWwgZm9yIGFs
bCBkcml2ZXJzPyBUaGVuIHdlDQo+IGNhbiBhbHNvIHJldXNlIHRoZSBleGlzdGluZyBCbG9ja1N0
YXRzIGZpZWxkcyBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nDQo+IHRoZW0gaW50byBkcml2ZXItc3Bl
Y2lmaWMgbmV3IG9uZXMuDQo+IA0KPiBLZXZpbg0KPiANCg0KSSBqdXN0IHdvbmRlciBob3cgdXNl
ZnVsIGlzIHRoYXQ/DQpEaXNjYXJkcyBhcmUgaW50ZXJlc3RpbmcgdG8gc2VlIG9uIHRoZSBCRFMg
bGV2ZWwgYXMgdGhleSBhcmUgb3B0aW9uYWwuDQpNYXliZSBvbmUgY2FuIGJlIGN1cmlvdXMgaG93
IG11Y2ggZGF0YSBpcyBiZWluZyByZWFkIGZyb20gYmFja2luZw0KaW1hZ2VzLiBBbnl0aGluZyBl
bHNlPw0KDQpJdCBmZWVscyBsaWtlIEJEUyBsZXZlbCBpcyBjb21wbGV4IGVub3VnaCBhcyBpdCBp
cy4NCkFjY291bnRpbmcgbWVhbnMgd2Ugc2hvdWxkIGtlZXAgdGhhdCBpbiBtaW5kIGluIGFsbCB0
aGUgZXJyb3IgcGF0aHMsDQp3aXRoIGEgcmlzayB0byBub3QgYWNjb3VudCBvciB0byBhY2NvdW50
IHR3aWNlIChldmVuIG1vcmUgY29tcGxpY2F0ZWQNCndpdGggYm91bmNlIGJ1ZmZlciBmYWxsYmFj
ayBwYXRocykuDQoNCldlIGNvdWxkIHByb2JhYmx5IGNob29zZSBzb21lIGFuY2hvciBwb2ludCB0
byBiaW5kIHRvLCBsaWtlDQoNCiAgIC0gYWNjb3VudCBhdCB0aGUgdmVyeSBib3R0b20gb25seSwg
aS5lLiByaWdodCBhZnRlciBkcnYtPmJkcnZfeCgpDQogICAgICAgKC0pIG1pc3NpbmcgdGhlIGNh
c2VzIHdoZXJlIGVhcmxpZXIgc2FuaXR5IGNoZWNrcyBmaXJlZA0KICAgICAgICgtKSBlYXN5IHRv
IGRvdWJsZS1hY2NvdW50IGZhbGxiYWNrIHNjZW5hcmlvcw0KDQogICAtIGFjY291bnQgYXQgdHJh
Y2tlZF9yZXF1ZXN0X2JlZ2luL2VuZA0KICAgICAgICgtKSBtaXNzaW5nIHRoZSBjYXNlcyB3aGVy
ZSBlYXJsaWVyIHNhbml0eSBjaGVja3MgZmlyZWQNCiAgICAgICAoLSkgYWNjb3VudGluZyBibGsg
bGF5ZXIgcmVxdWVzdHMsIGFuZCBub3QgdGhlIG9uZXMgYWN0dWFsbHkNCiAgICAgICAgICAgcGFz
c2VkIHRvIHRoZSBkcml2ZXIgKHdoaWNoIGNhbiBiZSBzbWFsbGVyIGluIHNpemUgZHVlIHRvDQog
ICAgICAgICAgIEJsb2NrTGltaXRzIC0gYW5kIGNhbiBmYWlsIHBhcnRpYWxseSBpbiBkaXNjYXJk
IGNhc2UpDQoNCk1heWJlIGFub3RoZXIgb3B0aW9uIHdvdWxkIGJlIHRvIGtlZXAgQmxvY2tTdGF0
cyBvbiBCRFMgYnV0IHN0aWxsIGxldA0KdGhlIGRyaXZlcnMgdXBkYXRlIHRoZW0/DQoNCi9BbnRv
bg0K
