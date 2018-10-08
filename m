Received: from eggs.gnu.org ([2001:4830:134:3::10]:47682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9X3O-0007Pg-JB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g9X3I-0001A3-AN
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:02:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 8 Oct 2018 15:02:21 +0000
Message-ID: <c319a070-453c-203a-899d-da9218948a56@virtuozzo.com>
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <338E81232CFB50459ECF5487AFF995D2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2 check improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

cGluZw0KDQpIaSwgd2hhdCBhYm91dCB0aGlzPw0KDQoxNy4wOC4yMDE4IDE1OjIyLCBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiBIaSBhbGwhDQo+DQo+IHYyOg0KPiAwMiwg
MDY6IGNoZWNrIGJkcnZfZ2V0bGVuZ3RoIGVycm9yIHJldHVybiBjb2RlDQo+DQo+IHYxOg0KPg0K
PiBXZSd2ZSBmYWNlZCB0aGUgZm9sbG93aW5nIHByb2JsZW06IGFmdGVyIGhvc3QgZnMgY29ycnVw
dGlvbiwgdm0gaW1hZ2VzDQo+IGJlY29tZXMgaW52YWxpZC4gQW5kIHdoaWNoIGlzIGludGVyZXN0
aW5nLCBzdGFydGluZyBxZW11LWltZyBjaGVjayBvbg0KPiB0aGVtIGxlZCB0byBhbGxvY2F0aW5n
IG9mIHRoZSB3aG9sZSBSQU0gYW5kIHRoZW4ga2lsbGluZyBxZW11LWltZyBieQ0KPiBPT00gS2ls
bGVyLg0KPg0KPiBUaGlzIHdhcyBkdWUgdG8gY29ycnVwdGVkIGwyIGVudHJpZXMsIHdoaWNoIHJl
ZmVyZW5jZWQgY2x1c3RlcnMgZmFyLWZhcg0KPiBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgcWNvdzIg
ZmlsZS4NCj4gMDIgaXMgYSBnZW5lcmljIGZpeCBmb3IgdGhlIGJ1ZywgMDEgaXMgdW5yZWxhdGVk
IGltcHJvdmVtZW50LCAwMy0wNyBhcmUNCj4gYWRkaXRpb25hbCBpbmZvIGFuZCBmaXhpbmcgZm9y
IHN1Y2ggY29ycnVwdGVkIHRhYmxlIGVudHJpZXMuDQo+DQo+IFF1ZXN0aW9ucyBvbiAwMiwgMDYg
YW5kIDA3Og0KPiAxLiBTaG91bGQgcmVzdHJpY3Rpb25zIGJlIG1vcmUgb3IgbGVzcyBzdHJpY3Q/
DQo+IDIuIEFyZSB0aGVyZSB2YWxpZCBjYXNlcywgd2hlbiBzdWNoIGVudHJpZXMgc2hvdWxkIG5v
dCBiZSBjb25zaWRlcmVkIGFzDQo+ICAgICBjb3JydXB0ZWQ/DQo+DQo+IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgKDcpOg0KPiAgICBibG9jay9xY293Mi1yZWZjb3VudDogZml4IGNoZWNr
X29mbGFnX2NvcGllZA0KPiAgICBibG9jay9xY293Mi1yZWZjb3VudDogYXZvaWQgZWF0aW5nIFJB
TQ0KPiAgICBibG9jay9xY293Mi1yZWZjb3VudDogY2hlY2tfcmVmY291bnRzX2wyOiByZWZhY3Rv
ciBjb21wcmVzc2VkIGNhc2UNCj4gICAgYmxvY2svcWNvdzItcmVmY291bnQ6IGNoZWNrX3JlZmNv
dW50c19sMjogcmVkdWNlIGlnbm9yZWQgb3ZlcmxhcHMNCj4gICAgYmxvY2svcWNvdzItcmVmY291
bnQ6IGNoZWNrX3JlZmNvdW50c19sMjogc3BsaXQgZml4X2wyX2VudHJ5X3RvX3plcm8NCj4gICAg
YmxvY2svcWNvdzItcmVmY291bnQ6IGZpeCBvdXQtb2YtZmlsZSBMMSBlbnRyaWVzIHRvIGJlIHpl
cm8NCj4gICAgYmxvY2svcWNvdzItcmVmY291bnQ6IGZpeCBvdXQtb2YtZmlsZSBMMiBlbnRyaWVz
IHRvIGJlIHJlYWQtYXMtemVybw0KPg0KPiAgIGJsb2NrL3Fjb3cyLXJlZmNvdW50LmMgfCAyNzAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyMTkgaW5zZXJ0aW9ucygrKSwgNTEgZGVsZXRpb25zKC0pDQo+DQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0KDQo=
