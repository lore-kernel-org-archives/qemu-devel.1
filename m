Received: from eggs.gnu.org ([2001:4830:134:3::10]:47298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g8TA4-0007tA-4w
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g8T9z-0003ym-3c
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:41:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 5 Oct 2018 16:40:57 +0000
Message-ID: <05adf79a-4ae1-0ba1-aa7f-7696aa043594@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-14-vsementsov@virtuozzo.com>
	<20181004124421.GC6009@localhost.localdomain>
	<d691c927-e37a-1178-8180-9893278aa02c@virtuozzo.com>
	<20181004145241.GG6009@localhost.localdomain>
	<19e42ee8-fdbe-e637-6728-bfc10b137f63@virtuozzo.com>
	<46e224bd-8c1f-4565-944e-52440e85e2f0@virtuozzo.com>
	<20181005155213.GB4606@localhost.localdomain>
In-Reply-To: <20181005155213.GB4606@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF06DD561001084699A8EB982D66721B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 13/18] block: introduce new filter
 driver: fleecing-hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDUuMTAuMjAxOCAxODo1MiwgS2V2aW4gV29sZiB3cm90ZToNCj4gSGkgVmxhZGltaXIsDQo+DQo+
IGNhbiB5b3UgcGxlYXNlIGNoZWNrIHlvdXIgbWFpbGVyIHNldHRpbmdzPyBUaGUgcGxhaW4gdGV4
dCB2ZXJzaW9uIG9mIHRoZQ0KPiBlbWFpbHMgaXMgaGFyZGx5IGxlZ2libGUgYmVjYXVzZSBpdCBt
aXhlcyBxdW90ZXMgdGV4dCBhbmQgcmVwbGllcy4gSQ0KPiBoYWQgdG8gbWFudWFsbHkgb3BlbiB0
aGUgSFRNTCBwYXJ0IHRvIGZpZ3VyZSBvdXQgd2hhdCB5b3UgcmVhbGx5IHdyb3RlLg0KDQpJJ3Zl
IHNlbnQgaXQgZnJvbSBvdGhlciB0aHVuZGVyYmlyZCBpbnN0YW5jZSBmcm9tIGhvbWUsIEkgaG9w
ZSANCnRodW5kZXJiaXJkIGF0IHdvcmsgKHdoZXJlIEknbSBjb21wb3Npbmcgbm93KSBpcyBvay4u
DQoNCj4NCj4gQW0gMDUuMTAuMjAxOCB1bSAxNzowMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEhtbSwgaG93IHRvIHNoYXJlIGNoaWxkcmVuPw0KPj4N
Cj4+IGJhY2t1cCBqb2IgaGFzIHR3byBzb3VyY2UgQmRydkNoaWxkJ3JlbiAtIGNoaWxkX2pvYiBh
bmQgY2hpbGRfcm9vdCBvZg0KPj4gam9iIGJsayBhbmQgdHdvIHRhcmdldCBCZHJ2Q2hpbGQncmVu
IC0gYWdhaW4sIGNoaWxkX2pvYiBhbmQNCj4+IGNoaWxkX3Jvb3QuDQo+Pg0KPj4gYmFja3VwX3Rv
cCBoYXMgc291cmNlIGNoaWxkIC0gY2hpbGRfYmFja2luZyBhbmQgc2Vjb25kIC0gY2hpbGRfZmls
ZQ0KPj4gKG5hbWVkICJ0YXJnZXQiKS4uDQo+IFJpZ2h0LCB0aGVzZSBhcmUgc2l4IEJkcnZDaGls
ZCBpbnN0YW5jZXMgaW4gdG90YWwuIEkgdGhpbmsgd2UgY2FuIGlnbm9yZQ0KPiB0aGUgY2hpbGRf
am9iIG9uZXMsIHRoZXkgYXJlIGludGVybmFsIHRvIHRoZSBibG9jayBqb2IgaW5mcmFzdHJ1Y3R1
cmUsDQo+IHNvIHdlIGhhdmUgZm91ciBvZiB0aGVtIGxlZnQuDQo+DQo+PiBXaGljaCBCZHJ2Q2hp
bGQncmVuIHlvdSBzdWdnZXN0IHRvIHJlbW92ZT8gVGhleSBhcmUgYWxsIGRpZmZlcmVudC4NCj4g
Tm93IHRoYXQgeW91IGludHJvZHVjZWQgYmFja3VwX3RvcCwgSSB0aGluayB3ZSBkb24ndCBuZWVk
IGFueQ0KPiBCbG9ja0JhY2tlbmRzIGFueSBtb3JlLiBTbyBJIHN1Z2dlc3QgdG8gcmVtb3ZlIHRo
ZSBjaGlsZF9yb290IG9uZXMgYW5kDQo+IHRvIGRvIGFsbCBJL08gdGhyb3VnaCB0aGUgY2hpbGRf
YmFja2luZyBhbmQgY2hpbGRfZmlsZSBvbmVzIG9mDQo+IGJhY2t1cF90b3AuDQo+DQo+PiBJIGRv
bid0IGtub3csIHdoeSBqb2IgbmVlZHMgYm90aCB1bm5hbWVkIGJsaydzIGFuZCBjaGlsZF9qb2In
cywgYW5kIEkNCj4+IGRvbid0IGtub3cgaXMgaXQgbmVjZXNzYXJ5IGZvciBiYWNrdXAgdG8gdXNl
IGJsaydzIG5vdCBCZHJ2Q2hpbGQncmVuLi4NCj4gSSB0aGluayB3ZSBoYWQgYSBjYXNlIHJlY2Vu
dGx5IHdoZXJlIGl0IHR1cm5lZCBvdXQgdGhhdCBpdCBpcyBzdHJpY3RseQ0KPiBzcGVha2luZyBl
dmVuIHdyb25nIGZvciBqb2JzIHRvIHVzZSBCbG9ja0JhY2tlbmRzIGluIGEgZnVuY3Rpb24gdGhh
dA0KPiBpbnRlcmNlcHRzIGEgcmVxdWVzdCBvbiB0aGUgQkRTIGxldmVsIChsaWtlIHRoZSBjb3B5
LWJlZm9yZS13cml0ZSBvZg0KPiBiYWNrdXApLg0KPg0KPiBTbyBnZXR0aW5nIHJpZCBvZiB0aGUg
QmxvY2tCYWNrZW5kcyBpc24ndCBvbmx5IG9rYXksIGJ1dCBhY3R1YWxseSBhIGdvb2QNCj4gdGhp
bmcgYnkgaXRzZWxmLg0KPg0KPj4gQW5kIHdpdGggaW50ZXJuYWwgd2F5IGluIG5vbmUtbW9kZSB3
ZSdsbCBoYXZlIHR3byB1bnVzZWQgYmxrJ3MgIGFuZA0KPj4gZm91ciB1bnVzZWQgQmRydkNoaWxk
J3Jlbi4uIE9yIHdlIHdhbnQgdG8gcmV3cml0ZSBiYWNrdXAgdG8gdXNlDQo+PiBCZHJ2Q2hpbGQn
cmVuIGZvciBpbyBvcGVyYXRpb25zIGFuZCBkcm9wIGNoaWxkX2pvYiBCZHJ2Q2hpbGQncmVuPyBT
bw0KPj4gSSdtIGxvc3QuIFdoYXQgZGlkIHlvdSBtZWFuPw0KPiBjaGlsZF9qb2IgaXNuJ3QgYWN0
dWFsbHkgdW51c2VkLCBldmVuIHRob3VnaCB5b3UgbmV2ZXIgdXNlIHRoZW0gdG8gbWFrZQ0KPiBy
ZXF1ZXN0cy4gVGhlIGNoaWxkX2pvYiBCZHJ2Q2hpbGQgaXMgaW1wb3J0YW50IGJlY2F1c2Ugb2Yg
dGhlDQo+IEJkcnZDaGlsZFJvbGUgY2FsbGJhY2tzIGl0IHByb3ZpZGVzIHRvIHRoZSBibG9jayBq
b2IgaW5mcmFzdHJ1Y3R1cmUuDQo+DQo+IEtldmluDQoNCk9rLCB1bmRlcnN0YW5kLCB0aGFuayB5
b3UgZm9yIHRoZSBleHBsYW5hdGlvbiENCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
DQo=
