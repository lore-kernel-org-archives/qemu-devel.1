Received: from eggs.gnu.org ([2001:4830:134:3::10]:53846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=357003226=Paul.Durrant@citrix.com>)
	id 1dUXXK-00084a-8V
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=357003226=Paul.Durrant@citrix.com>)
	id 1dUXXH-0000bp-47
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:11:34 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 10 Jul 2017 12:11:27 +0000
Message-ID: <e531a9398dfe453097999300e41db31f@AMSPEX02CL01.citrite.net>
References: <20170621125249.8805-1-paul.durrant@citrix.com>
	<20170621125249.8805-4-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1706221410580.12819@sstabellini-ThinkPad-X260>
	<3b55bff7d41d4b37b52a8ec96d88677a@AMSPEX02CL01.citrite.net>
	<alpine.DEB.2.10.1707071452400.2919@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1707071452400.2919@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen-disk: use an IOThread per
 instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin
	Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "afaerber@suse.de" <afaerber@suse.de>, "armbru@redhat.com" <armbru@redhat.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KW3NuaXBdDQo+ID4gPiA+ICsgICAgb2JqZWN0
X3VucGFyZW50KE9CSkVDVChibGtkZXYtPmlvdGhyZWFkKSk7DQo+ID4gPg0KPiA+ID4gU2hvdWxk
bid0IHRoaXMgYmUgb2JqZWN0X3VucmVmPw0KPiA+ID4NCj4gPg0KPiA+IEkgZG9uJ3QgdGhpbmsg
c28uIEkgdGhpbmsgdGhpcyBpcyByZXF1aXJlZCB0byB1bmRvIHdoYXQgd2FzIGRvbmUgYnkgY2Fs
bGluZw0KPiBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKCkgb24gdGhlIHJvb3Qgb2JqZWN0Lg0K
PiANCj4gUmlnaHQsIHNvIGlmIG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQgaXMgbm90IGFjdHVh
bGx5IHJlcXVpcmVkLCB0aGVuDQo+IHlvdSBtaWdodCBiZSBhYmxlIHRvIHR1cm4gb2JqZWN0X3Vu
cGFyZW50IGludG8gb2JqZWN0X3VucmVmLg0KPiANCj4gVW5mb3J0dW5hdGVseSBJIGRvbid0IGtu
b3cgZW5vdWdoIGFib3V0IFFPTSB0byBiZSBhYmxlIHRvIHRlbGwgd2hpY2ggaXMNCj4gdGhlIHJp
Z2h0IHdheSBvZiBkb2luZyB0aGluZ3MsIGJ1dCBsb29raW5nIGF0DQo+IGh3L2Jsb2NrL2RhdGFw
bGFuZS92aXJ0aW8tYmxrLmMsIGl0IHdvdWxkIHNlZW0gdGhhdCBvbmx5IG9iamVjdF9yZWYgYW5k
DQo+IG9iamVjdF91bnJlZiBhcmUgcmVxdWlyZWQ/DQo+IA0KDQpJIGd1ZXNzIEkgY2FuIGdpdmUg
aXQgYSB0cnkuIEkgd2FzIHdvcmtpbmcgb24gdGhlIGFzc3VtcHRpb24gdGhhdCBhbGwgb2JqZWN0
cyB3ZXJlIHJlcXVpcmVkIHRvIGhhdmUgYSBwYXJlbnQsIGJ1dCBtYXliZSB0aGF0J3Mgbm90IHRy
dWUuIENhbiBzb21lb25lIG1vcmUgZmFtaWxpYXIgd2l0aCBRT00gY29tbWVudD8NCg0KQ2hlZXJz
LA0KDQogIFBhdWwNCg0KPiANCj4gPiBMb29raW5nIGF0IG90aGVyIGNvZGUgc3VjaCBhcyBvYmpl
Y3RfbmV3X3dpdGhfcHJvcHYoKSBpdCBsb29rcyBsaWtlIHRoZQ0KPiByaWdodCB0aGluZyB0byBk
byBpcyB0byBjYWxsIG9iamVjdF91bnJlZigpIGFmdGVyIGNhbGxpbmcNCj4gb2JqZWN0X3Byb3Bl
cnR5X2FkZF9jaGlsZCgpIHRvIGRyb3AgdGhlIGltcGxpY2l0IHJlZiB0YWtlbiBieSBvYmplY3Rf
bmV3KCkNCj4gc28gSSdkIG5lZWQgdG8gYWRkIHRoZSBjYWxsIGluIGJsa19hbGxvYygpLg0K
