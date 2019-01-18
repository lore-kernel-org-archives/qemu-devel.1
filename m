Received: from eggs.gnu.org ([209.51.188.92]:48779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkSwK-000271-LJ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkSwH-0001ly-Ag
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:08:00 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 18 Jan 2019 12:07:43 +0000
Message-ID: <857845c9-325e-a525-c9e3-a39c33571bc0@virtuozzo.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-18-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-18-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D610F51C6F114245A566337D00CFC622@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 17/21] nbd/client: Add
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MTcuMDEuMjAxOSAyMjozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gV2Ugd2FudCB0byBiZSBhYmxl
IHRvIGRldGVjdCB3aGV0aGVyIGEgZ2l2ZW4gcWVtdSBOQkQgc2VydmVyIGlzDQo+IGV4cG9zaW5n
IHRoZSByaWdodCBleHBvcnQocykgYW5kIGRpcnR5IGJpdG1hcHMsIGF0IGxlYXN0IGZvcg0KPiBy
ZWdyZXNzaW9uIHRlc3RpbmcuICBXZSBjb3VsZCB1c2UgJ25iZC1jbGllbnQgLWwnIGZyb20gdGhl
IHVwc3RyZWFtDQo+IE5CRCBwcm9qZWN0IHRvIGxpc3QgZXhwb3J0cywgYnV0IGl0J3MgYW5ub3lp
bmcgdG8gcmVseSBvbg0KPiBvdXQtb2YtdHJlZSBiaW5hcmllczsgZnVydGhlcm1vcmUsIG5iZC1j
bGllbnQgZG9lc24ndCBuZWNlc3NhcmlseQ0KPiBrbm93IGFib3V0IGFsbCBvZiB0aGUgcWVtdSBO
QkQgZXh0ZW5zaW9ucy4gIFRodXMsIHdlIHBsYW4gb24gYWRkaW5nDQo+IGEgbmV3IG1vZGUgdG8g
cWVtdS1uYmQgdGhhdCBtZXJlbHkgc25pZmZzIGFsbCBwb3NzaWJsZSBpbmZvcm1hdGlvbg0KPiBm
cm9tIHRoZSBzZXJ2ZXIgZHVyaW5nIGhhbmRzaGFrZSBwaGFzZSwgdGhlbiBkaXNjb25uZWN0cyBh
bmQgZHVtcHMNCj4gdGhlIGluZm9ybWF0aW9uLg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBs
b3ctbGV2ZWwgY2xpZW50IGNvZGUgZm9yIGdyYWJiaW5nIHRoZSBsaXN0DQo+IG9mIGV4cG9ydHMu
ICBJdCBiZW5lZml0cyBmcm9tIHRoZSByZWNlbnQgcmVmYWN0b3JpbmcgcGF0Y2hlcywgaW4NCj4g
b3JkZXIgdG8gc2hhcmUgYXMgbXVjaCBjb2RlIGFzIHBvc3NpYmxlIHdoZW4gaXQgY29tZXMgdG8g
ZG9pbmcNCj4gdmFsaWRhdGlvbiBvZiBzZXJ2ZXIgcmVwbGllcy4gIFRoZSByZXN1bHRpbmcgaW5m
b3JtYXRpb24gaXMgc3RvcmVkDQo+IGluIGFuIGFycmF5IG9mIE5CREV4cG9ydEluZm8gd2hpY2gg
aGFzIGJlZW4gZXhwYW5kZWQgdG8gYW55DQo+IGRlc2NyaXB0aW9uIHN0cmluZywgYWxvbmcgd2l0
aCBhIGNvbnZlbmllbmNlIGZ1bmN0aW9uIGZvciBmcmVlaW5nDQo+IHRoZSBsaXN0Lg0KPiANCj4g
Tm90ZTogYSBtYWxpY2lvdXMgc2VydmVyIGNvdWxkIGV4aGF1c3QgbWVtb3J5IG9mIGEgY2xpZW50
IGJ5IGZlZWRpbmcNCj4gYW4gdW5lbmRpbmcgbG9vcCBvZiBleHBvcnRzOyBwZXJoYXBzIHdlIHNo
b3VsZCBwbGFjZSBhIGxpbWl0IG9uIGhvdw0KPiBtYW55IHdlIGFyZSB3aWxsaW5nIHRvIHJlY2Vp
dmUuIEJ1dCBub3RlIHRoYXQgYSBzZXJ2ZXIgY291bGQNCj4gcmVhc29uYWJseSBiZSBzZXJ2aW5n
IGFuIGV4cG9ydCBmb3IgZXZlcnkgZmlsZSBpbiBhIGxhcmdlIGRpcmVjdG9yeSwNCj4gd2hlcmUg
YW4gYXJiaXRyYXJ5IGxpbWl0IGluIHRoZSBjbGllbnQgbWVhbnMgd2UgY2FuJ3QgbGlzdCBhbnl0
aGluZw0KPiBmcm9tIHN1Y2ggYSBzZXJ2ZXI7IHRoZSBzYW1lIGhhcHBlbnMgaWYgd2UganVzdCBy
dW4gdW50aWwgdGhlIGNsaWVudA0KPiBmYWlscyB0byBtYWxsb2MoKSBhbmQgdGh1cyBkaWVzIGJ5
IGFuIGFib3J0KCksIHdoZXJlIHRoZSBsaW1pdCBpcw0KPiBubyBsb25nZXIgYXJiaXRyYXJ5IGJ1
dCBkZXRlcm1pbmVkIGJ5IGF2YWlsYWJsZSBtZW1vcnkuICBTaW5jZSB0aGUNCj4gY2xpZW50IGlz
IGFscmVhZHkgcGxhbm5pbmcgb24gYmVpbmcgc2hvcnQtbGl2ZWQsIGl0J3MgaGFyZCB0byBjYWxs
DQo+IHRoaXMgYSBkZW5pYWwgb2Ygc2VydmljZSBhdHRhY2sgdGhhdCB3b3VsZCBzdGFydmUgb2Zm
IG90aGVyIHVzZXMsDQo+IHNvIGl0IGRvZXMgbm90IGFwcGVhciB0byBiZSBhIHNlY3VyaXR5IGlz
c3VlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZTxlYmxha2VAcmVkaGF0LmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgVy5NLiBKb25lczxyam9uZXNAcmVkaGF0LmNvbT4NCg0K
UmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
