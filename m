Received: from eggs.gnu.org ([209.51.188.92]:36175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ghvB3-0008FK-Cb
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ghvB2-0001tI-JE
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:40:41 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 11 Jan 2019 11:40:33 +0000
Message-ID: <b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
In-Reply-To: <20190111104126.GC5010@dhcp-200-186.str.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <82362A166CCA824E86B443EB1B8CE993@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

MTEuMDEuMjAxOSAxMzo0MSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTAuMDEuMjAxOSB1bSAx
NDoyMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IGRy
dl9jb19ibG9ja19zdGF0dXMgZGlncyBicy0+ZmlsZSBmb3IgYWRkaXRpb25hbCwgbW9yZSBhY2N1
cmF0ZSBzZWFyY2gNCj4+IGZvciBob2xlIGluc2lkZSByZWdpb24sIHJlcG9ydGVkIGFzIERBVEEg
YnkgYnMgc2luY2UgNWRhYTc0YTZlYmMuDQo+Pg0KPj4gVGhpcyBhY2N1cmFjeSBpcyBub3QgZnJl
ZTogYXNzdW1lIHdlIGhhdmUgcWNvdzIgZGlzay4gQWN0dWFsbHksIHFjb3cyDQo+PiBrbm93cywg
d2hlcmUgYXJlIGhvbGVzIGFuZCB3aGVyZSBpcyBkYXRhLiBCdXQgZXZlcnkgYmxvY2tfc3RhdHVz
DQo+PiByZXF1ZXN0IGNhbGxzIGxzZWVrIGFkZGl0aW9uYWxseS4gQXNzdW1lIGEgYmlnIGRpc2ss
IGZ1bGwgb2YNCj4+IGRhdGEsIGluIGFueSBpdGVyYXRpdmUgY29weWluZyBibG9jayBqb2IgKG9y
IGltZyBjb252ZXJ0KSB3ZSdsbCBjYWxsDQo+PiBsc2VlayhIT0xFKSBvbiBldmVyeSBpdGVyYXRp
b24sIGFuZCBlYWNoIG9mIHRoZXNlIGxzZWVrcyB3aWxsIGhhdmUgdG8NCj4+IGl0ZXJhdGUgdGhy
b3VnaCBhbGwgbWV0YWRhdGEgdXAgdG8gdGhlIGVuZCBvZiBmaWxlLiBJdCdzIG9idmlvdXNseQ0K
Pj4gaW5lZmZlY3RpdmUgYmVoYXZpb3IuIEFuZCBmb3IgbWFueSBzY2VuYXJpb3Mgd2UgZG9uJ3Qg
bmVlZCB0aGlzIGxzZWVrDQo+PiBhdCBhbGwuDQo+Pg0KPj4gU28sIGxldCdzICI1ZGFhNzRhNmVi
YyIgYnkgZGVmYXVsdCwgbGVhdmluZyBhbiBvcHRpb24gdG8gcmV0dXJuDQo+PiBwcmV2aW91cyBi
ZWhhdmlvciwgd2hpY2ggaXMgbmVlZGVkIGZvciBzY2VuYXJpb3Mgd2l0aCBwcmVhbGxvY2F0ZWQN
Cj4+IGltYWdlcy4NCj4+DQo+PiBBZGQgaW90ZXN0IGlsbHVzdHJhdGluZyBuZXcgb3B0aW9uIHNl
bWFudGljcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IA0KPiBJIHN0aWxsIHRoaW5rIHRoYXQg
YW4gb3B0aW9uIGlzbid0IGEgZ29vZCBzb2x1dGlvbiBhbmQgd2Ugc2hvdWxkIHRyeSB1c2UNCj4g
c29tZSBoZXVyaXN0aWNzIGluc3RlYWQuDQoNCkRvIHlvdSB0aGluayB0aGF0IGhldXJpc3RpY3Mg
d291bGQgYmUgYmV0dGVyIHRoYW4gZmFpciBjYWNoZSBmb3IgbHNlZWsgcmVzdWx0cz8NCg0KSSBk
b24ndCBzZWUgZ29vZCBoZXVyaXN0aWNzLCBuZWl0aGVyIHdhbnQgdG8gaW1wbGVtZW50IGxzZWVr
IG9wdGltaXphdGlvbnMuDQpJbiBvdXIgY2FzZXMgd2UgZG9uJ3QgbmVlZCBsc2VlayB1bmRlciBx
Y293MiBhdCBhbGwsIGFuZCBpdCdzIG9idmlvdXNseSBiZXR0ZXINCmp1c3QgZG9uJ3QgbHNlZWsg
aW4gdGhlc2UgY2FzZXMuDQoNCk1vcmVvdmVyLCBhcyBJIHVuZGVyc3RhbmQsIHRoZSBjYXNlcyB3
aGVuIHdlIG5lZWQgbHNlZWsgYXJlIHRob3NlIHdoZW4gcWNvdzIgdGhpbmtzDQp0aGF0IHRoZSBj
bHVzdGVyIGlzIGRhdGEsIGJ1dCBhY3R1YWxseSBpdCdzIGEgaG9sZSBvbiBmcy4uLiBJc24ndCBp
dCBiZXR0ZXIgdG8NCnN1cHBvcnQgdGhpcyB0aGluZyBpbiBxY293Mj8gQSBraW5kIG9mIGFsbG9j
YXRlZC16ZXJvZXMgY2x1c3Rlcj8gV2UgaGF2ZSBlbm91Z2gNCnJlc2VydmVkIGJpdHMgaW4gY2x1
c3RlciBkZXNjcmlwdG9yIHRvIGFkZCB0aGlzIGZlYXR1cmUuIEFuZCB0aGFuIHdlIGRvbid0IG5l
ZWQNCnRoaXMga2luZCBvZiBjaGVhdGluZyB3aGVuIHVzZXIgImJldHRlciBrbm93cyIgd2hlcmUg
YXJlIGhvbGVzIHRoYW4gZm9ybWF0IGxheWVyDQp3aGljaCBvd25zIHRoZSBkYXRhLi4NCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
