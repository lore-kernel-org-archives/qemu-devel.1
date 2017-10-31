Received: from eggs.gnu.org ([2001:4830:134:3::10]:49483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e9Tmj-0001zN-5o
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e9Tmi-0002SW-6I
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:28:41 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 31 Oct 2017 10:28:33 +0000
Message-ID: <MWHPR21MB0159D0542A55A8B36EB2B4509E5E0@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <20171020214918.18944-1-Andrew.Baumann@microsoft.com>
	<CAFEAcA-bW6CtLTN0omLoL7x7r996rY9BS1MvH4KdfS-2z6g1LQ@mail.gmail.com>
	<MWHPR21MB01591265BB44E18E19B910879E5E0@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CAFEAcA-oEu+bOHFp_vHKALnnkK=krP_1pMoar5t=MqY24JHRtA@mail.gmail.com>
In-Reply-To: <CAFEAcA-oEu+bOHFp_vHKALnnkK=krP_1pMoar5t=MqY24JHRtA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] arm: implement cache/shareability
 attribute bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

PiBGcm9tOiBQZXRlciBNYXlkZWxsIFttYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnXQ0K
PiBTZW50OiBUdWVzZGF5LCAzMSBPY3RvYmVyIDIwMTcgMTc6NTMNCj4gDQo+IE9uIDMxIE9jdG9i
ZXIgMjAxNyBhdCAwMToyMywgQW5kcmV3IEJhdW1hbm4NCj4gPEFuZHJldy5CYXVtYW5uQG1pY3Jv
c29mdC5jb20+IHdyb3RlOg0KPiA+PiBGcm9tOiBQZXRlciBNYXlkZWxsIFttYWlsdG86cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnXQ0KPiA+PiBIaS4gVGhpcyBpcyBsb29raW5nIHByZXR0eSBnb29k
LCBidXQgSSBoYXZlIGEgZmV3IGNvbW1lbnRzIGJlbG93LA0KPiA+PiBhbmQgd2UncmUgcHJldHR5
IG11Y2ggYXQgdGhlIHNvZnRmcmVlemUgZGF0ZSAoS1ZNIEZvcnVtIGxhc3Qgd2Vlaw0KPiA+PiBt
ZWFudCBJIGRpZG4ndCBnZXQgbXVjaCBjb2RlIHJldmlldyBkb25lLCB1bmZvcnR1bmF0ZWx5KS4g
V291bGQNCj4gPj4geW91IGJlIHRvbyBzYWQgaWYgdGhpcyBtaXNzZWQgMi4xMSA/DQo+ID4NCj4g
PiBObyB3b3JyaWVzLiBJdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgYSBzdGFibGUgcmVsZWFzZSB0
aGF0IHdlIGNhbiB0ZWxsIHBlb3BsZQ0KPiBzdXBwb3J0cyBhcm02NCBXaW5kb3dzLCBidXQgSSBy
ZWNvZ25pc2UgdGhhdCB0aGlzIGlzIGEgbm9uLXRyaXZpYWwgY2hhbmdlLCBzbyBpZg0KPiB3ZSBo
YXZlIHRvIHdhaXQgZm9yIDIuMTIgdG8gZ2V0IHRoYXQsIHRoZW4gZmFpciBlbm91Z2guDQo+IA0K
PiBJcyB0aGlzIHRoZSBvbmx5IG1pc3NpbmcgcGllY2UsIHRoZW4/IElmIHdlIHNxdWludCBhIGJp
dCB3ZSBjYW4NCj4gY2FsbCBpdCBhIGJ1ZyBmaXggYXMgbG9uZyBhcyB3ZSBjYW4gZ2V0IGl0IGlu
IGVhcmx5IGluIHRoZSBzb2Z0ZnJlZXplDQo+IHJhdGhlciB0aGFuIGxhdGVyLi4uDQoNCkl0IGlz
IHRoZSBsYXN0IHBpZWNlLCBhbmQgSSdsbCB0cnkgdG8gZ2V0IHlvdSBhIHYzIHNvb24sIGJ1dCB0
aGlzIHdlZWsgaXQncyBteSB0dXJuIHRvIGJlIHRyYXZlbGxpbmcsIHNvIGl0IG1heSB0YWtlIGEg
ZGF5IG9yIHR3by4gSSdsbCB1bmRlcnN0YW5kIGlmIHdlIGRvbid0IGdldCBpdCBpbiAtLSBub3Qg
YSBzaG93LXN0b3BwZXIuDQoNCj4gPj4gVGhlIHY4QSBBUk0gQVJNIHBzZXVkb2NvZGUgQ29tYmlu
ZVMxUzJBdHRySGludHMoKSBzYXlzIHRoYXQgdGhlIGhpbnQNCj4gPj4gYml0cyBhbHdheXMgY29t
ZSBmcm9tIHMxIHJlZ2FyZGxlc3Mgb2Ygd2hvc2UgYXR0cnMgd29uLg0KPiA+DQo+ID4gQWhhLCBJ
IHdhcyB3b25kZXJpbmcgYWJvdXQgdGhpcy4gVGhhbmtzIGZvciB0aGUgcG9pbnRlciB0byB0aGUg
cHNldWRvY29kZS4uLg0KPiBpdCBpc24ndCByZWZlcmVuY2VkIGFueXdoZXJlIGluIHRoZSByZWxl
dmFudCBzZWN0aW9uISBJdCdzIHJlYXNzdXJpbmcgdG8gc2VlIHRoYXQsDQo+IGFzaWRlIGZyb20g
dGhlIGhpbnRzICh3aGVyZSB0aGUgRW5nbGlzaCB3YXMgYW1iaWd1b3VzIElJUkMpLCBJIHNlZW0g
dG8gaGF2ZQ0KPiBnb3QgdGhlIHJlc3Qgb2YgdGhlIHRyYW5zbGF0aW9uIGNvcnJlY3QuDQo+IA0K
PiBJIGRpZG4ndCBmaW5kIGFueXRoaW5nIGluIHRoZSBFbmdsaXNoIHRleHQgYWJvdXQgaGludHMg
YXQgYWxsLg0KPiAoSSdsbCBoYXZlIHRvIGdvIGFuZCBoYXZlIGFub3RoZXIgbG9vay4pDQoNCkkg
ZGlkbid0IGZpbmQgYW55IG1lbnRpb24gb2YgaXQuIFRoYXQncyBwcmV0dHkgYW1iaWd1b3VzIElN
TyA6KQ0KDQpBbmRyZXcNCg==
