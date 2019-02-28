Received: from eggs.gnu.org ([209.51.188.92]:41497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gzMFw-0004P8-1N
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gzMFm-0005FI-02
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:01:41 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 28 Feb 2019 14:01:12 +0000
Message-ID: <c6f9b3ac-35dc-375c-83a5-41696160073f@virtuozzo.com>
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-2-jsnow@redhat.com>
	<5678ed17-fda7-4083-b4c6-488b3d6f916d@virtuozzo.com>
	<86bbc4f0-288b-4b3a-1f6a-cb3de29d80f4@virtuozzo.com>
	<fb9fc496-02f7-5724-06fd-fc4dcfc2b9c9@redhat.com>
	<8337ab64-9bf2-6990-be87-731fd92fe043@virtuozzo.com>
	<537c57d3-abb8-567b-3ee0-09c4ded81ad1@redhat.com>
In-Reply-To: <537c57d3-abb8-567b-3ee0-09c4ded81ad1@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A41136BE3473943A69CB60DC5923C53@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block/dirty-bitmaps: add
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>

MjguMDIuMjAxOSAxNjo0NCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMi8yOC8xOSA0OjEzIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pj4+PiArKysgYi9x
YXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4+Pj4+IEBAIC00NzAsMTIgKzQ3MCwxNiBAQA0KPj4+Pj4+
ICAgwqAgIyBAcGVyc2lzdGVudDogdHJ1ZSBpZiB0aGUgYml0bWFwIHdpbGwgZXZlbnR1YWxseSBi
ZSBmbHVzaGVkIHRvIHBlcnNpc3RlbnQNCj4+Pj4+PiAgIMKgICPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdG9yYWdlIChzaW5jZSA0LjApDQo+Pj4+DQo+Pj4+IHNvLCBiaXRtYXAgY2FuJ3Qg
YmUgaW5jb25zaXN0ZW50IGFuZCBwZXJzaXN0ZW50LCBhcyB3ZSBkb24ndCB3YW50IHRvIGZsdXNo
DQo+Pj4+IGluY29uc2lzdGVudCBiaXRtYXBzLi4uDQo+Pj4+DQo+Pj4NCj4+PiBJIHRoaW5rIGlk
ZWFsbHkgSSdkIGp1c3QgY2hhbmdlIHRoaXMgcGhyYXNpbmcgdG8gc2F5IHNvbWV0aGluZyBsaWtl
DQo+Pj4gInRydWUgaWYgdGhlIGJpdG1hcCBpcyBzdG9yZWQgb24tZGlzaywgb3IgaXMgc2NoZWR1
bGVkIHRvIGJlIGZsdXNoZWQgdG8NCj4+PiBkaXNrLiINCj4+DQo+PiBBbmQgc3VjaCB3b3JkaW5n
IGxlYWRzIHRvIGltbWVkaWF0ZSBxdWVzdGlvbjogd2h5IGl0IGNvdWxkIGJlIHN0b3JlZCBvbiBk
aXNrIGJ1dA0KPj4gX25vdF8gc2NoZWR1bGVkIHRvIGJlIGZsdXNoZWQuLg0KPj4NCj4+IFNvIGlm
IHlvdSB3YW50LCBtb3JlIGhvbmVzdCBpcyBzb21ldGhpbmcgbGlrZSAidHJ1ZSBpZiBiaXRtYXAg
d2lsbCBiZSBmbHVzaGVkIHRvDQo+PiBzdG9yYWdlIG9yIGlmIGl0IGlzIEBpbmNvbnNpc3RlbnQg
KHJlYWQgYWhlYWQpLiIgYnV0IGl0J3Mgbm90IGxvb2tpbmcgbmljZS4uLg0KPj4NCj4+IE1heSBi
ZSBzb21ldGhpbmcgbGlrZSB0aGlzPw0KPj4NCj4+IHRydWUgaWYgYml0bWFwIGlzIG1hcmtlZCB0
byBiZSBmbHVzaGVkIHRvIHBlcnNpc3RlbnQgc3RvcmFnZS4gQml0bWFwIG1heSBvciBtYXkgbm90
DQo+PiBhbHJlYWR5IHBlcnNpc3QgaW4gdGhlIHN0b3JhZ2UuIEFsc28gdHJ1ZSBpZiBiaXRtYXAg
cGVyc2lzdCBpbiB0aGUgc3RvcmFnZSBidXQNCj4+IGNvbnNpZGVyZWQgaW5jb25zaXN0ZW50LCBp
biB3aGljaCBjYXNlIGl0IHdpbGwgbm90IGJlIGZsdXNoZWQgYW5kIG9ubHkgbWF5IGJlIHJlbW92
ZWQsDQo+PiBsb29rIGF0IEBpbmNvbnNpc3RlbnQgZmllbGQgZGVzY3JpcHRpb24uDQo+IA0KPiBU
b28gbG9uZy4gQXMgQGluY29uc2lzdGVudCBpcyByYXJlLCBJJ2QgYmUgaGFwcHkgd2l0aCBqdXN0
Og0KPiANCj4gQHBlcnNpc3RlbnQ6IHRydWUgaWYgdGhlIGJpdG1hcCBpcyBtYXJrZWQgZm9yIGFz
c29jaWF0aW9uIHdpdGgNCj4gcGVyc2lzdGVudCBzdG9yYWdlDQo+IA0KPiB3aGljaCBjb3ZlcnMg
Ym90aCBmdXR1cmUgZmx1c2hlcyAoZm9yIGEgYml0bWFwIHRoYXQgaXMgbm90IHlldCBvbiBkaXNr
LA0KPiBidXQgd2lsbCBnZXQgdGhlcmUgbGF0ZXIpIGFuZCBwcmlvciBpbmNvbnNpc3RlbnQgaW1h
Z2VzICh3aGVyZSB3ZQ0KPiBsZWFybmVkIHRoYXQgaXQgd2FzIGluY29uc2lzdGVudCBiZWNhdXNl
IG9mIGl0cyBleGlzdGluZyBhc3NvY2lhdGUgd2l0aA0KPiBwZXJzaXN0ZW50IHN0b3JhZ2UpLg0K
DQpPa2F5DQoNCj4gDQo+Pg0KPj4gQW5vdGhlciB0aGluZzogd2hhdCBhYm91dCBtaWdyYXRpb24/
IEkgZG9uJ3QgdGhpbmsgd2UgYXJlIGdvaW5nIHRvIHRlYWNoIG1pZ3JhdGlvbiBwcm90b2NvbA0K
Pj4gdG8gbWlncmF0ZSB0aGVtLiBTbywgbWlncmF0aW9uIGlzIGEgd2F5IHRvIGdldCByaWQgb2Yg
aW5jb25zaXN0ZW50IGJpdG1hcHM/IE9yIHdoYXQ/IE9yDQo+PiB3ZSBzaG91bGQgcmVzdHJpY3Qg
bWlncmF0aW9uLCBpZiB0aGVyZSBhcmUgYW55IGluY29uc2lzdGVudCBiaXRtYXAsIHRvIGZvcmNl
IHVzZXIgdG8gcmVtb3ZlDQo+PiB0aGVtIGZpcnN0Pw0KPiANCj4gQSBjb25zZXJ2YXRpdmUgYXBw
cm9hY2ggaXMgdG8gc3RhcnQgYnkgdHJlYXRpbmcgYW4gaW5jb25zaXN0ZW50IGJpdG1hcA0KPiBh
cyBhIG1pZ3JhdGlvbiBibG9ja2VyLCBhbmQgY291bGQgYmUgcmVsYXhlZCBsYXRlciBpZiBzb21l
b25lIGhhcyBhbg0KPiBhcmd1bWVudCBmb3Igd2h5IG1ha2luZyBtaWdyYXRpb24gYSBiYWNrZG9v
ciBmb3IgZGVsZXRpb24gb2YNCj4gaW5jb25zaXN0ZW50IGJpdG1hcHMgaXMgYSBnb29kIHRoaW5n
Lg0KPiANCg0KQWdyZWUNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
