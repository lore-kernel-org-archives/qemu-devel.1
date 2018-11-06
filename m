Received: from eggs.gnu.org ([2001:4830:134:3::10]:59155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gJze3-0001xk-30
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gJze2-0005te-CF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:35:43 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 6 Nov 2018 11:35:28 +0000
Message-ID: <1ec7649e-f258-eeac-f513-10ec96437216@virtuozzo.com>
References: <1541004440-182262-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1541004440-182262-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51k1lrik1i.fsf@maestria.local.igalia.com>
In-Reply-To: <w51k1lrik1i.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A7B20CBC68DB24BA6413CF039132C3C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] The discard flag for
 block stream operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "jcody@redhat.com" <jcody@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

QmVydG8sDQoNCldlbGwgbm90ZWQgYWJvdXQgdGhlICJhZnRlciBpbXBsZW1lbnRhdGlvbiIuDQoN
CktpbmRseSwNCg0KQW5kcmV5IFNoaW5rZXZpY2gNCg0KDQpPbiAwNS4xMS4yMDE4IDE5OjA4LCBB
bGJlcnRvIEdhcmNpYSB3cm90ZToNCj4gT24gV2VkIDMxIE9jdCAyMDE4IDA1OjQ3OjE5IFBNIENF
VCwgQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+IHdy
b3RlOg0KPj4gQWRkaW5nIGEgcGFyYW1ldGVyIHRvIFFNUCBibG9jay1zdHJlYW0gY29tbWFuZCB0
byBhbGxvdyBkaXNjYXJkaW5nDQo+PiBibG9ja3MgaW4gdGhlIGJhY2tpbmcgY2hhaW4gd2hpbGUg
YmxvY2tzIGFyZSBiZWluZyBjb3BpZWQgdG8gdGhlDQo+PiBhY3RpdmUgbGF5ZXIuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1
b3p6by5jb20+DQo+IEkgaGF2ZW4ndCBjaGVja2VkIHRoZSBvdGhlciBwYXRjaCB5ZXQsIGJ1dCBp
ZiB5b3UncmUgZ29pbmcgdG8gYWRkIG5ldw0KPiBBUEkgKHRoaXMgbmV3ICdkaXNjYXJkJyBwYXJh
bWV0ZXIpIEkgc3VnZ2VzdCB5b3UgdG8gZG8gaXQgX2FmdGVyXyB0aGUNCj4gaW1wbGVtZW50YXRp
b24uDQo+DQo+PiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4gKysrIGIvcWFwaS9ibG9j
ay1jb3JlLmpzb24NCj4+IEBAIC0yMzI5LDYgKzIzMjksOSBAQA0KPj4gICAjDQo+PiAgICMgQHNw
ZWVkOiAgdGhlIG1heGltdW0gc3BlZWQsIGluIGJ5dGVzIHBlciBzZWNvbmQNCj4+ICAgIw0KPj4g
KyMgQGRpc2NhcmQ6IHRydWUgdG8gZGVsZXRlIGJsb2NrcyBkdXBsaWNhdGVkIGluIG9sZCBiYWNr
aW5nIGZpbGVzLg0KPj4gKyMgICAgICAgICAgIChkZWZhdWx0OiBmYWxzZSkuIFNpbmNlIDMuMS4N
Cj4+ICsjDQo+PiAgICMgQG9uLWVycm9yOiB0aGUgYWN0aW9uIHRvIHRha2Ugb24gYW4gZXJyb3Ig
KGRlZmF1bHQgcmVwb3J0KS4NCj4+ICAgIyAgICAgICAgICAgICdzdG9wJyBhbmQgJ2Vub3NwYycg
Y2FuIG9ubHkgYmUgdXNlZCBpZiB0aGUgYmxvY2sgZGV2aWNlDQo+PiAgICMgICAgICAgICAgICBz
dXBwb3J0cyBpby1zdGF0dXMgKHNlZSBCbG9ja0luZm8pLiAgU2luY2UgMS4zLg0KPj4gQEAgLTIz
NjEsNyArMjM2NCw3IEBADQo+PiAgIHsgJ2NvbW1hbmQnOiAnYmxvY2stc3RyZWFtJywNCj4+ICAg
ICAnZGF0YSc6IHsgJypqb2ItaWQnOiAnc3RyJywgJ2RldmljZSc6ICdzdHInLCAnKmJhc2UnOiAn
c3RyJywNCj4+ICAgICAgICAgICAgICAgJypiYXNlLW5vZGUnOiAnc3RyJywgJypiYWNraW5nLWZp
bGUnOiAnc3RyJywgJypzcGVlZCc6ICdpbnQnLA0KPj4gLSAgICAgICAgICAgICcqb24tZXJyb3In
OiAnQmxvY2tkZXZPbkVycm9yJywNCj4+ICsgICAgICAgICAgICAnKmRpc2NhcmQnOiAnYm9vbCcs
ICcqb24tZXJyb3InOiAnQmxvY2tkZXZPbkVycm9yJywNCj4+ICAgICAgICAgICAgICAgJyphdXRv
LWZpbmFsaXplJzogJ2Jvb2wnLCAnKmF1dG8tZGlzbWlzcyc6ICdib29sJyB9IH0NCj4gQmVydG8N
Cg0K
