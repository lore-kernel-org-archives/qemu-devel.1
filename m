Received: from eggs.gnu.org ([2001:4830:134:3::10]:36413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gPRLn-0006qm-1f
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gPRCN-0005X5-FO
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:01:44 -0500
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Wed, 21 Nov 2018 12:01:19 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201F7B38A@DGGEMA503-MBX.china.huawei.com>
References: <1541672989-15967-1-git-send-email-gengdongjiu@huawei.com>
	<1541672989-15967-8-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA9wLv96u_GYCBPFtkQMvntoHDKhQjremmN1noaJxsvhAQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9wLv96u_GYCBPFtkQMvntoHDKhQjremmN1noaJxsvhAQ@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiAgW1BBVENIIFJFU0VORCB2MTUgMDcv?=
 =?utf-8?q?10=5D_KVM=3A_Move_related_hwpoison_page_functions_to_accel/kvm/?=
 =?utf-8?q?_folder?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, "zhengxiang (A)" <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

SGkgUGV0ZXIsDQogICBUaGFua3MgdmVyeSBtdWNoIGZvciB0aGUgY29tbWFuZHMgYW5kIHJldmll
dy4NCg0KPiBPbiA4IE5vdmVtYmVyIDIwMTggYXQgMTA6MjksIERvbmdqaXUgR2VuZyA8Z2VuZ2Rv
bmdqaXVAaHVhd2VpLmNvbT4gd3JvdGU6DQo+ID4ga3ZtX2h3cG9pc29uX3BhZ2VfYWRkKCkgYW5k
IGt2bV91bnBvaXNvbl9hbGwoKSB3aWxsIGJlIHVzZWQgYm90aCBieQ0KPiA+IFg4NiBhbmQgQVJN
IHBsYXRmb3Jtcywgc28gbW92ZSB0aGVzZSBmdW5jdGlvbnMgdG8gYSBjb21tb24gYWNjZWwva3Zt
Lw0KPiA+IGZvbGRlciB0byBhdm9pZCBkdXBsaWNhdGUgY29kZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IERvbmdqaXUgR2VuZyA8Z2VuZ2RvbmdqaXVAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4g
PiBBZGRyZXNzIFBldGVyJ3MgY29tbWVudHMgdG8gbW92ZSByZWxhdGVkIGh3cG9pc29uIHBhZ2Ug
ZnVuY3Rpb24gdG8NCj4gPiBhY2NlbC9rdm0gZm9sZGVyIGluIFsxXSBBZGRyZXNzIFBhb2xvJ3Mg
Y29tbWVudHMgdG8gbW92ZSBIV1BvaXNvblBhZ2UNCj4gPiBkZWZpbml0aW9uIGJhY2sgdG8gYWNj
ZWwva3ZtL2t2bS1hbGwuYw0KPiA+DQo+ID4gWzFdOg0KPiA+IGh0dHBzOi8vbGlzdHMuZ251Lm9y
Zy9hcmNoaXZlL2h0bWwvcWVtdS1hcm0vMjAxNy0wOS9tc2cwMDA3Ny5odG1sDQo+ID4gaHR0cHM6
Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWFybS8yMDE3LTA5L21zZzAwMTUyLmh0
bWwNCj4gPiAtLS0NCj4gDQo+ID4gLS0tIGEvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaA0KPiA+IEBAIC0xMTUsNiArMTE1LDExIEBAIHZv
aWQgcWVtdV9yYW1fZnJlZShSQU1CbG9jayAqYmxvY2spOw0KPiA+DQo+ID4gIGludCBxZW11X3Jh
bV9yZXNpemUoUkFNQmxvY2sgKmJsb2NrLCByYW1fYWRkcl90IG5ld3NpemUsIEVycm9yDQo+ID4g
KiplcnJwKTsNCj4gPg0KPiA+ICsvKiBBZGQgYSBwb2lzb25lZCBwYWdlIHRvIHRoZSBsaXN0ICov
IHZvaWQNCj4gPiAra3ZtX2h3cG9pc29uX3BhZ2VfYWRkKHJhbV9hZGRyX3QgcmFtX2FkZHIpOw0K
PiA+ICsvKiBGcmVlIGFuZCByZW1vdmUgYWxsIHRoZSBwb2lzb25lZCBwYWdlcyBpbiB0aGUgbGlz
dCAqLyB2b2lkDQo+ID4gK2t2bV91bnBvaXNvbl9hbGwodm9pZCAqcGFyYW0pOw0KPiA+ICsNCj4g
DQo+IEluIG15IHByZXZpb3VzIHJldmlldyBjb21tZW50cyBJIHNhaWQ6DQo+ID4+PiBBbnkgbmV3
IGdsb2JhbGx5LXZpc2libGUgZnVuY3Rpb24gcHJvdG90eXBlIGluIGEgaGVhZGVyIHNob3VsZCBo
YXZlDQo+ID4+PiBhIGRvYy1jb21tZW50IGZvcm1hdHRlZCBkb2N1bWVudGF0aW9uIGNvbW1lbnQs
IHBsZWFzZS4NCj4gPj4NCj4gPj4NCj4gPj4gT2ssIHRoYW5rcyBmb3IgdGhpcyByZW1pbmRlci4g
RG8geW91IG1lYW4gSSBuZWVkIHRvIGFkZCBjb21tZW50cyBmb3INCj4gPj4gdGhpcyBnbG9iYWxs
eS12aXNpYmxlIGZ1bmN0aW9uLCBzdWNoIGFzIGJlbG93Og0KPiA+Pg0KPiA+PiAvKg0KPiA+PiAg
KiB4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4DQo+ID4+ICAqLw0KPiA+PiB2b2lk
IGt2bV9od3BvaXNvbl9wYWdlX2FkZChyYW1fYWRkcl90IHJhbV9hZGRyKTsNCj4gPg0KPiA+IEl0
IHNob3VsZCBiZSBpbiB0aGUgZG9jLWNvbW1lbnQgZm9ybWF0LCB3aGljaCBiZWdpbnMgIi8qKiIg
YW5kIGhhcw0KPiA+IHNvbWUgc3R5bGl6YXRpb24gb2YgaG93IHlvdSBsaXN0IHBhcmFtZXRlcnMg
YW5kIHNvIG9uLiBMb3RzIG9mDQo+ID4gZXhhbXBsZXMgaW4gdGhlIGV4aXN0aW5nIGhlYWRlcnMu
DQo+IA0KPiBDYW4gd2UgaGF2ZSBhIGRvYy1jb21tZW50IGluIHRoZSBwcm9wZXIgZm9ybWF0IGFu
ZCB3aXRoIGEgbGl0dGxlIG1vcmUgZGV0YWlsIHRoYW4gYSBzaW5nbGUgbGluZSwgcGxlYXNlPw0K
DQpTdXJlLCBJIHdpbGwgYWRkIGl0IGluIHRoZSBwcm9wZXIgZm9ybWF0LCB0aGFua3MsIE1heSBi
ZSBJIGZvcmdldCBpdC4gDQoNCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg0K
