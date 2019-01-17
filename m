Received: from eggs.gnu.org ([209.51.188.92]:36596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=91354dfb7=Paul.Durrant@citrix.com>)
	id 1gk3aU-00034S-4Z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=91354dfb7=Paul.Durrant@citrix.com>)
	id 1gk3aQ-00048t-6R
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:45 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 17 Jan 2019 09:02:26 +0000
Message-ID: <7ca53707d96344d885bb91701b84b547@AMSPEX02CL03.citrite.net>
References: <20190116121350.23863-1-alex.bennee@linaro.org>
	<c8f655ea-3c3b-290e-1bc2-8f7bb755f4af@citrix.com>
	<874la7zocp.fsf@linaro.org>
In-Reply-To: <874la7zocp.fsf@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] hw/block/xen: use proper
 format string for printing sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?J0FsZXggQmVubsOpZSc=?= <alex.bennee@linaro.org>, Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open
	list:Block layer core" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IEJlbm7DqWUgW21haWx0
bzphbGV4LmJlbm5lZUBsaW5hcm8ub3JnXQ0KPiBTZW50OiAxNyBKYW51YXJ5IDIwMTkgMDg6MjEN
Cj4gVG86IEFuZHJldyBDb29wZXIgPEFuZHJldy5Db29wZXIzQGNpdHJpeC5jb20+DQo+IENjOiBw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+OyBT
dGVmYW5vDQo+IFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6
QmxvY2sgbGF5ZXIgY29yZSA8cWVtdS0NCj4gYmxvY2tAbm9uZ251Lm9yZz47IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT47DQo+IFBhdWwgRHVycmFu
dCA8UGF1bC5EdXJyYW50QGNpdHJpeC5jb20+OyBBbnRob255IFBlcmFyZA0KPiA8YW50aG9ueS5w
ZXJhcmRAY2l0cml4LmNvbT47IG9wZW4gbGlzdDpYODYgPHhlbi0NCj4gZGV2ZWxAbGlzdHMueGVu
cHJvamVjdC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbWGVuLWRldmVsXSBbUEFUQ0hdIGh3L2Jsb2Nr
L3hlbjogdXNlIHByb3BlciBmb3JtYXQgc3RyaW5nDQo+IGZvciBwcmludGluZyBzZWN0b3JzDQo+
IA0KPiANCj4gQW5kcmV3IENvb3BlciA8YW5kcmV3LmNvb3BlcjNAY2l0cml4LmNvbT4gd3JpdGVz
Og0KPiANCj4gPiBPbiAxNi8wMS8yMDE5IDEyOjEzLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+ID4+
IFRoZSAlbHUgZm9ybWF0IHN0cmluZyBpcyBkaWZmZXJlbnQgZGVwZW5kaW5nIG9uIHRoZSBob3N0
IGFyY2hpdGVjdHVyZQ0KPiA+PiB3aGljaCBjYXVzZXMgYnVpbGRzIGxpa2UgdGhlIGRlYmlhbi1h
cm1oZi1jcm9zcyBidWlsZCB0byBmYWlsLiBVc2UgdGhlDQo+ID4+IGNvcnJlY3QgUFJpNjQgZm9y
bWF0IHN0cmluZy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4
LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiA+PiAtLS0NCj4gPj4gIGh3L2Jsb2NrL3hlbi1ibG9jay5j
IHwgMiArLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9ody9ibG9jay94ZW4tYmxvY2suYyBiL2h3L2Js
b2NrL3hlbi1ibG9jay5jDQo+ID4+IGluZGV4IGJlMjhiNjM0NDIuLmE2MzY0ODdiM2UgMTAwNjQ0
DQo+ID4+IC0tLSBhL2h3L2Jsb2NrL3hlbi1ibG9jay5jDQo+ID4+ICsrKyBiL2h3L2Jsb2NrL3hl
bi1ibG9jay5jDQo+ID4+IEBAIC0yMTUsNyArMjE1LDcgQEAgc3RhdGljIHZvaWQgeGVuX2Jsb2Nr
X3JlYWxpemUoWGVuRGV2aWNlICp4ZW5kZXYsDQo+IEVycm9yICoqZXJycCkNCj4gPj4NCj4gPj4g
ICAgICB4ZW5fZGV2aWNlX2JhY2tlbmRfcHJpbnRmKHhlbmRldiwgInNlY3Rvci1zaXplIiwgIiV1
IiwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmYtPmxvZ2ljYWxfYmxv
Y2tfc2l6ZSk7DQo+ID4+IC0gICAgeGVuX2RldmljZV9iYWNrZW5kX3ByaW50Zih4ZW5kZXYsICJz
ZWN0b3JzIiwgIiVsdSIsDQo+ID4+ICsgICAgeGVuX2RldmljZV9iYWNrZW5kX3ByaW50Zih4ZW5k
ZXYsICJzZWN0b3JzIiwgIiUiUFJJaTY0LA0KPiA+DQo+ID4gUFJJdTY0Lg0KPiA+DQo+ID4gWW91
J3ZlIGNoYW5nZWQgdGhlIHNpZ25lZC1uZXNzIG9mIHdoYXQgZ2V0cyBwcmludGVkLg0KPiANCj4g
SSB3YXMgZGVsaWJlcmF0ZSBhczoNCj4gICBpbnQ2NF90IGJsa19nZXRsZW5ndGgoQmxvY2tCYWNr
ZW5kICpibGspOw0KPiANCj4gYWx0aG91Z2ggSSBoYXZlIHRvIGFkbWl0IGEgc2lnbmVkIGJsb2Nr
IGxlbmd0aCBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZQ0KPiB0byBtZS4gQXQgbGVhc3QgaXQgaXNu
J3QgZ29pbmcgdG8gb3ZlcmZsb3cgYW5kIHdpbGwgc2hvdy11cCBpZiB0aGUgYmxvY2sNCj4gbGVu
Z3RoIGlzIGV2ZXIgbmVnYXRpdmUuDQoNClllcywgdGhhdCdzIGEgbXVjaCBiZXR0ZXIgZmFpbHVy
ZSBtb2RlIHRoYW4gc29tZSB3ZWlyZCBodWdlIG51bWJlciBvZiBzZWN0b3JzLg0KDQogIFBhdWwN
Cg0KPiANCj4gPg0KPiA+IH5BbmRyZXcNCj4gDQo+IA0KPiAtLQ0KPiBBbGV4IEJlbm7DqWUNCg==
