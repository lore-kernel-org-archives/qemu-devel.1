Received: from eggs.gnu.org ([2001:4830:134:3::10]:39396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cebsn-00059w-Hp
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cebsj-0005pF-Fd
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:19:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:4231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1cebsj-0005l4-6E
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 01:19:01 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Fri, 17 Feb 2017 06:18:53 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743900B73D@shsmsx102.ccr.corp.intel.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
	<1484026704-28027-9-git-send-email-mst@redhat.com>
	<A2975661238FB949B60364EF0F2C25743900AAEF@shsmsx102.ccr.corp.intel.com>
	<c1f86fba-6b22-8316-156f-2024bee46b0c@redhat.com>
In-Reply-To: <c1f86fba-6b22-8316-156f-2024bee46b0c@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 08/41] intel_iommu: support device iotlb
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, Alex Williamson <alex.williamson@redhat.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86
amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDE2LCAyMDE3
IDE6NDQgUE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPjsgTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmcNCj4g
Q2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEVkdWFyZG8gSGFi
a29zdA0KPiA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNv
bT47IFBhb2xvIEJvbnppbmkNCj4gPHBib256aW5pQHJlZGhhdC5jb20+OyBSaWNoYXJkIEhlbmRl
cnNvbiA8cnRoQHR3aWRkbGUubmV0PjsgVGlhbiwgS2V2aW4NCj4gPGtldmluLnRpYW5AaW50ZWwu
Y29tPjsgTGFuLCBUaWFueXUgPHRpYW55dS5sYW5AaW50ZWwuY29tPjsgQWxleCBXaWxsaWFtc29u
DQo+IDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtRZW11LWRl
dmVsXSBbUFVMTCAwOC80MV0gaW50ZWxfaW9tbXU6IHN1cHBvcnQgZGV2aWNlIGlvdGxiDQo+IGRl
c2NyaXB0b3INCj4gDQo+IA0KPiANCj4gT24gMjAxN+W5tDAy5pyIMTbml6UgMTM6MzYsIExpdSwg
WWkgTCB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTog
UWVtdS1kZXZlbA0KPiA+PiBbbWFpbHRvOnFlbXUtZGV2ZWwtYm91bmNlcyt5aS5sLmxpdT1pbnRl
bC5jb21Abm9uZ251Lm9yZ10NCj4gPj4gT24gQmVoYWxmIE9mIE1pY2hhZWwgUy4gVHNpcmtpbg0K
PiA+PiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDEwLCAyMDE3IDE6NDAgUE0NCj4gPj4gVG86IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBDYzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPjsgRWR1YXJkbyBIYWJrb3N0DQo+ID4+IDxlaGFia29zdEByZWRoYXQuY29t
PjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IFBldGVyIFh1DQo+ID4+IDxwZXRl
cnhAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBSaWNo
YXJkDQo+ID4+IEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0Pg0KPiA+PiBTdWJqZWN0OiBbUWVt
dS1kZXZlbF0gW1BVTEwgMDgvNDFdIGludGVsX2lvbW11OiBzdXBwb3J0IGRldmljZSBpb3RsYg0K
PiA+PiBkZXNjcmlwdG9yDQo+ID4+DQo+ID4+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+DQo+ID4+DQo+ID4+IFRoaXMgcGF0Y2ggZW5hYmxlcyBkZXZpY2UgSU9UTEIgc3Vw
cG9ydCBmb3IgaW50ZWwgaW9tbXUuIFRoZSBtYWpvcg0KPiA+PiB3b3JrIGlzIHRvIGltcGxlbWVu
dCBRSSBkZXZpY2UgSU9UTEIgZGVzY3JpcHRvciBwcm9jZXNzaW5nIGFuZCBub3RpZnkNCj4gPj4g
dGhlIGRldmljZSB0aHJvdWdoIGlvbW11IG5vdGlmaWVyLg0KPiA+Pg0KPiA+IEhpIEphc29uL01p
Y2hhZWwsDQo+ID4NCj4gPiBSZWNlbnRseSBQZXRlciBYdSdzIHBhdGNoIGFsc28gdG91Y2hlZCBp
bnRlbC1pb21tdSBlbXVsYXRpb24uIEhpcw0KPiA+IHBhdGNoIHNoYWRvd3Mgc2Vjb25kLWxldmVs
IHBhZ2UgdGFibGUgYnkgY2FwdHVyaW5nIGlvdGxiIGZsdXNoIGZyb20NCj4gPiBndWVzdC4gSXQg
d291bGQgcmVzdWx0IGluIHBhZ2UgdGFibGUgdXBkYXRpbmcgaW4gaG9zdC4gRG9lcyB0aGlzIHBh
dGNoDQo+ID4gYWxzbyB1c2UgdGhlIHNhbWUgbWFwL3VtYXAgQVBJIHByb3ZpZGVkIGJ5IFZGSU8/
DQo+IA0KPiBZZXMsIGl0IGRlcGVuZHMgb24gdGhlIGlvbW11IG5vdGlmaWVyIHRvby4NCj4gDQo+
ID4gSWYgaXQgaXMsIHRoZW4gSSB0aGluayBpdCB3b3VsZCBhbHNvIHVwZGF0ZSBwYWdlIHRhYmxl
IGluIGhvc3QuIEl0DQo+ID4gbG9va3MgdG8gYmUgYSBkdXBsaWNhdGUgdXBkYXRlLiBQbHMgcmVm
ZXIgdG8gdGhlIGZvbGxvd2luZyBzbmFwc2hvdA0KPiA+IGNhcHR1cmVkIGZyb20gc2VjdGlvbiA2
LjUuMi41IG9mIHZ0ZCBzcGVjLg0KPiA+DQo+ID4gIlNpbmNlIHRyYW5zbGF0aW9uIHJlcXVlc3Rz
IGZyb20gYSBkZXZpY2UgbWF5IGJlIHNlcnZpY2VkIGJ5IGhhcmR3YXJlDQo+ID4gZnJvbSB0aGUg
SU9UTEIsIHNvZnR3YXJlIG11c3QgYWx3YXlzIHJlcXVlc3QgSU9UTEIgaW52YWxpZGF0aW9uDQo+
ID4gKGlvdGxiX2ludl9kc2MpIGJlZm9yZSByZXF1ZXN0aW5nIGNvcnJlc3BvbmRpbmcgRGV2aWNl
LVRMQg0KPiA+IChkZXZfdGxiX2ludl9kc2MpIGludmFsaWRhdGlvbi4iDQo+ID4NCj4gPiBNYXli
ZSBmb3IgZGV2aWNlLWlvdGxiLCB3ZSBuZWVkIGEgc2VwYXJhdGUgQVBJIHdoaWNoIGp1c3QgcGFz
cyBkb3duDQo+ID4gdGhlIGludmFsaWRhdGUgaW5mbyB3aXRob3V0IHVwZGF0aW5nIHBhZ2UgdGFi
bGUuIEFueSB0aG91Z2h0cz8NCj4gDQo+IGNjIEFsZXguDQo+IA0KPiBJZiB3ZSB3YW50IEFUUyB0
byBiZSB2aXNpYmxlIGZvciBndWVzdCAoYnV0IEknbSBub3Qgc3VyZSBpZiBWRklPIHN1cHBvcnQg
dGhpcyksIHdlDQo+IHByb2JhYmx5IG5lZWQgYW5vdGhlciBub3RpZmllciBvciBhIG5ldyBmbGFn
Lg0KDQpKYXNvbiwgZm9yIGFzc2lnbmVkIGRldmljZSwgSSB0aGluayBndWVzdCBjb3VsZCBzZWUg
QVRTIGlmIHRoZSBhc3NpZ25lZCBkZXZpY2UNCnN1cHBvcnRzIEFUUy4gSSBjYW4gc2VlIGl0IHdo
ZW4gcGFzc3RocnUgaUdQVS4NCg0KUmVnYXJkcywNCllpIEwNCg==
