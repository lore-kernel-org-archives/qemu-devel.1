Received: from eggs.gnu.org ([209.51.188.92]:33530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEam8-0002rv-7L
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEam6-0004N4-RW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:34:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Apr 2019 14:33:46 +0000
Message-ID: <acb069c8-5207-368e-e972-baa2ba44d850@virtuozzo.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
	<20190410205715.2209-3-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-3-mreitz@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1551631D7758F4291502F5A2E12A034@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qemu-img: Add salvaging mode to
 convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>

MTAuMDQuMjAxOSAyMzo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIGFkZHMgYSBzYWx2YWdp
bmcgbW9kZSAoLS1zYWx2YWdlKSB0byBxZW11LWltZyBjb252ZXJ0IHdoaWNoIGlnbm9yZXMNCj4g
cmVhZCBlcnJvcnMgYW5kIHRyZWF0cyB0aGUgcmVzcGVjdGl2ZSBhcmVhcyBhcyBjb250YWluaW5n
IG9ubHkgemVyb2VzLg0KPiBUaGlzIGNhbiBiZSB1c2VkIGZvciBpbnN0YW5jZSB0byBhdCBsZWFz
dCBwYXJ0aWFsbHkgcmVjb3ZlciB0aGUgZGF0YQ0KPiBmcm9tIHRlcm1pbmFsbHkgY29ycnVwdGVk
IHFjb3cyIGltYWdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJl
ZGhhdC5jb20+DQo+IC0tLQ0KDQpbLi5dDQoNCj4gLS0tIGEvcWVtdS1pbWcudGV4aQ0KPiArKysg
Yi9xZW11LWltZy50ZXhpDQo+IEBAIC0xNzUsNiArMTc1LDExIEBAIGltcHJvdmUgcGVyZm9ybWFu
Y2UgaWYgdGhlIGRhdGEgaXMgcmVtb3RlLCBzdWNoIGFzIHdpdGggTkZTIG9yIGlTQ1NJIGJhY2tl
bmRzLA0KPiAgIGJ1dCB3aWxsIG5vdCBhdXRvbWF0aWNhbGx5IHNwYXJzaWZ5IHplcm8gc2VjdG9y
cywgYW5kIG1heSByZXN1bHQgaW4gYSBmdWxseQ0KPiAgIGFsbG9jYXRlZCB0YXJnZXQgaW1hZ2Ug
ZGVwZW5kaW5nIG9uIHRoZSBob3N0IHN1cHBvcnQgZm9yIGdldHRpbmcgYWxsb2NhdGlvbg0KPiAg
IGluZm9ybWF0aW9uLg0KPiArQGl0ZW0gLS1zYWx2YWdlDQo+ICtUcnkgdG8gaWdub3JlIEkvTyBl
cnJvcnMgd2hlbiByZWFkaW5nLiAgVW5sZXNzIGluIHF1aWV0IG1vZGUgKEBjb2Rley1xfSksIGVy
cm9ycw0KPiArd2lsbCBzdGlsbCBiZSBwcmludGVkLiAgQXJlYXMgdGhhdCBjYW5ub3QgYmUgcmVh
ZCBmcm9tIHRoZSBzb3VyY2Ugd2lsbCBiZQ0KPiArdHJlYXRlZCBhcyBjb250YWluaW5nIG9ubHkg
emVyb2VzLiAgVGhpcyBvcHRpb24gaGFzIG5vIGVmZmVjdCBpbiBjb3B5IG9mZmxvYWRpbmcNCj4g
K21vZGUgKEBjb2Rley1DfSkuDQoNCklzbid0IGl0IGJldHRlciB0byByZXN0cmljdCBzdWNoIGl0
LCBpbnN0ZWFkIG9mIGNyZWF0aW5nIG1lYW5pbmdsZXNzIGNvbWJpbmF0aW9uPw0KQW5kIGRyb3Ag
dGhlIHJlc3RyaWN0aW9uIGlmIHdlIHN1cHBvcnQgaXQgaW4gZnV0dXJlLCBpbnN0ZWFkIG9mIHNp
bGVudCBtb3ZlIGZyb20NCm5vb3AgdG8gdGhlIGZlYXR1cmU/DQoNCk90aGVyd2lzZSwgbG9va3Mg
T0sgZm9yIG1lLiBJIGRpc2xpa2UgbWl4aW5nIGJ5dGUtYmFzZWQgYW5kIHNlY3Rvci1iYXNlZCBs
b2dpYywgYnV0IGl0DQppcyBub3QgYWJvdXQgdGhlIHNlcmllcywgd2Ugc2hvdWxkIG1vdmUgdG8g
Ynl0ZS1iYXNlZCBsaWtlIGluIG90aGVyIHBsYWNlcywgYW5kIGl0IG1heQ0KYmUgZG9uZSBsYXRl
ci4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=
