Received: from eggs.gnu.org ([209.51.188.92]:46346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzso-0007U5-Q4
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIzsk-0008O5-Ut
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:11:04 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 23 Apr 2019 18:10:53 +0000
Message-ID: <9b85bfbf-44c1-5b6b-8aca-c1354c9e3f05@virtuozzo.com>
References: <20190422221714.7630-1-jsnow@redhat.com>
In-Reply-To: <20190422221714.7630-1-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0D77E8D2912D54288AEF537324C4A62@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/2] docs/interop/bitmaps: rewrite and
 modernize doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aliang@redhat.com" <aliang@redhat.com>, "kchamart@redhat.com" <kchamart@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>

MjMuMDQuMjAxOSAxOjE3LCBKb2huIFNub3cgd3JvdGU6DQo+IFRoZSBkb2N1bWVudGF0aW9uIGFz
IHdyaXR0ZW4gaW4gdGhlIDQuMCByZWxlYXNlIGlzIG5vdCBxdWl0ZSBjb3JyZWN0IGFzDQo+IG9m
IHRoZSA0LjAgcmVsZWFzZTsgdGhvdWdoIHRoYW5rcyB0byBiYWNrd2FyZHMgY29tcGF0aWJpbGl0
eSBpdCdzIG5vdA0KPiBxdWl0ZSB3cm9uZyBlaXRoZXIuIEl0IGlzIHN1aXRhYmxlIGZvciBpbmNs
dXNpb24gaW4gNC4wLjEsIG9yIGFueQ0KPiBkb3duc3RyZWFtIHRoYXQgcGFja2FnZXMgNC4wLg0K
PiANCj4gVGhpcyBwYXRjaCBpcyBhbiBhdHRlbXB0IGF0IGEgbmVhcmx5IGZ1bGwgcmV3cml0ZSB0
aGF0IHJldml0YWxpemVzIHRoaXMNCj4gZG9jdW1lbnQgdG8gYWRkcmVzcyBmcmVxdWVudCBxdWVz
dGlvbnMgSSBlbmNvdW50ZXIgd2hlbiBkaXNjdXNzaW5nIHRoZQ0KPiBBUEkuDQo+IA0KPiBWMjoN
Cj4gICAgLSBTcGxpdCBvZmYgbWFrZWZpbGUgY2hhbmdlIGludG8gaXRzIG93biBsaXR0bGUgcGF0
Y2guDQo+IA0KPiAgICAtIEFkZHJlc3NlZCAoYWxtb3N0KSBhbGwgY29tbWVudHMgZnJvbSBWbGFk
aW1pci4NCj4gICAgICAtIEV4YW1wbGUgc3R5bGluZyB3YXMgbm90IHJld29ya2VkLg0KPiAgICAt
IFJlbmFtZWQgYWxsIGZpbGVuYW1lcyB0byBiZSBjb25zaXN0ZW50IHRocm91Z2hvdXQgdGhlIGRv
Y3VtZW50LA0KPiAgICAgIGZpeGluZyBhIGZldyBtb3JlIGZpbGUgZXh0ZW5zaW9ucyBpbiB0aGUg
cHJvY2Vzcw0KPiAgICAtIFJlZmxvd2VkIGFsbW9zdCBhbGwgcGFyYWdyYXBocyB0byA3OCBjb2x1
bW5zIGZvciBjb25zaXN0ZW5jeS4NCj4gICAgLSBDaGFuZ2VkIGEgZmV3IGJ1bGxldGVkIGxpc3Rz
IHRvIHBhcmFncmFwaHMgaW5zdGVhZA0KPiAgICAtIENoYW5nZWQgdGhlIGJpZyBhc2NpaSB0ZXh0
IGRpYWdyYW0gdG8gYSBtb3JlIGNvbXBhY3QgdmVyc2lvbg0KPiAgICAgIGFuZCBjbGFyaWZpZWQg
aXRzIGxhbmd1YWdlDQo+ICAgIC0gV2hpbGUgaW4gZ2VuZXJhbCBJIHByZWZlciB0byB1c2UgZW5f
VVMgc3BlbGxpbmdzLCBJIGhhdmUNCj4gICAgICByZXBsYWNlZCAiY2FuY2VsZWQiIHdpdGggImNh
bmNlbGxlZCIgc28gaXQgZG9lcyBub3QgbG9vaw0KPiAgICAgIG91dCBvZiBwbGFjZSBqdXh0YXBv
c2VkIHdpdGggQkxPQ0tfSk9CX0NBTkNFTExFRC4uLg0KPiANCj4gRnV0dXJlIHdvcmsgdGhhdCBy
ZW1haW5zIHRvIGJlIGRvbmU6DQo+IA0KPiAtIFBheWluZyBoZWVkIHRvIGJsb2NrZGV2LWJhY2t1
cCB3b3JrZmxvd3MNCj4gLSBBZGRpbmcgYSBzbWFsbCBtaWdyYXRpb24gc2VjdGlvbiBleHBsYWlu
aW5nIHRoZSBvcHRpb25zIHRoZXJlDQo+IC0gUG9zc2libHkgcmV3b3JraW5nIHNvbWUgb2YgdGhl
IHNlY3Rpb25zIHRoYXQgYWxsIG1ha2UgdGhlaXIgb3duDQo+ICAgIHJlcGVhdGVkIGF0dGVtcHRz
IHRvIGNsYXJpZnkgdGltZSBpbnRlcnZhbCBkaXNjcmV0aXphdGlvbiBhbmQgYWRkaW5nDQo+ICAg
IGEgcHJvcGVyIHRyZWF0bWVudCBvZiB0aGUgaWRlYSBzdGFydCB0byBmaW5pc2g7IHRoaXMgbWF5
IGJlIG5lY2Nlc3NhcnkNCj4gICAgdG8gZXhwbGFpbiB0aGUgdHdvIGJlbG93IGl0ZW1zIHByb3Bl
cmx5Og0KPiAtIERpZmZlcmVudGlhbCBCYWNrdXBzDQo+IC0gUHVsbCBCYWNrdXBzIGFuZCBOQkQN
Cg0KVGhpcyBhbGwgbG9va3MgYSBiaXQgbW9yZSB0aGFuIGp1c3QgImJpdG1hcHMucnN0Ii4gSSB0
aGluayBhdCBsZWFzdCBtb3N0IG9mIHRoaW5ncw0KYWJvdXQgYmFja3VwcyBzaG91bGQgYmUgc2Vw
YXJhdGVkIGludG8gYmFja3VwLnJzdC4gKEJ1dCwgcGxlYXNlLCBhcyBhIGZvbGxvdy11cCwgaWYN
CnlvdSBhZ3JlZSkuDQoNCj4gDQo+IEpvaG4gU25vdyAoMik6DQo+ICAgIE1ha2VmaWxlOiBhZGQg
bml0LXBpY2t5IG1vZGUgdG8gc3BoaW54LWJ1aWxkDQo+ICAgIGRvY3MvaW50ZXJvcC9iaXRtYXBz
OiByZXdyaXRlIGFuZCBtb2Rlcm5pemUgZG9jDQo+IA0KPiAgIGRvY3MvaW50ZXJvcC9iaXRtYXBz
LnJzdCB8IDE2MDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gICBN
YWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgICAyICstDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAx
MjY2IGluc2VydGlvbnMoKyksIDMzNiBkZWxldGlvbnMoLSkNCj4gDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K
