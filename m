Received: from eggs.gnu.org ([209.51.188.92]:35084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gs6tw-0000lf-Hb
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gs6tv-000897-4y
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 09:13:08 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 8 Feb 2019 14:13:03 +0000
Message-ID: <9228cac5-7971-e099-afe5-78252c511684@virtuozzo.com>
References: <20190208141122.53046-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190208141122.53046-1-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_9228cac57971e099afe578252c511684virtuozzocom_"
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH] coroutines: generate wrapper code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>

--_002_9228cac57971e099afe578252c511684virtuozzocom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <82B41B13CE915E46BB950D01AF3D5C16@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64

YXR0YWNoZWQgZ2VuZXJhdGVkIGZpbGUNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

--_002_9228cac57971e099afe578252c511684virtuozzocom_
Content-Type: text/x-csrc; name="block-gen.c"
Content-Description: block-gen.c
Content-Disposition: attachment; filename="block-gen.c"; size=2225;
	creation-date="Fri, 08 Feb 2019 14:13:03 GMT";
	modification-date="Fri, 08 Feb 2019 14:13:03 GMT"
Content-ID: <FE628A561ED937468B29809C9D1D3DC0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64

LyoNCiAqIEZpbGUgaXMgZ2VuZXJhdGVkIGJ5IHNjcmlwdHMvY29yb3V0aW5lLXdyYXBwZXIucHkN
CiAqLw0KDQojaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KI2luY2x1ZGUgImJsb2NrL2Jsb2NrX2lu
dC5oIg0KDQoNCg0KLyoNCiAqIFdyYXBwZXJzIGZvciBiZHJ2X2NvX2NoZWNrDQogKi8NCg0KdHlw
ZWRlZiBzdHJ1Y3QgYmRydl9jb19jaGVja19fQXJndW1lbnRzUGFjayB7DQogICAgQmxvY2tEcml2
ZXJTdGF0ZSAqYnM7DQogICAgQmRydkNoZWNrUmVzdWx0ICpyZXM7DQogICAgQmRydkNoZWNrTW9k
ZSBmaXg7DQoNCiAgICBpbnQgX3JldDsNCiAgICBib29sIF9pbl9wcm9ncmVzczsNCn0gYmRydl9j
b19jaGVja19fQXJndW1lbnRzUGFjazsNCg0Kc3RhdGljIHZvaWQgYmRydl9jb19jaGVja19fZW50
cnkodm9pZCAqb3BhcXVlKQ0Kew0KICAgIGJkcnZfY29fY2hlY2tfX0FyZ3VtZW50c1BhY2sgKnBh
Y2sgPSBvcGFxdWU7DQogICAgcGFjay0+X3JldCA9IGJkcnZfY29fY2hlY2socGFjay0+YnMsIHBh
Y2stPnJlcywgcGFjay0+Zml4KTsNCiAgICBwYWNrLT5faW5fcHJvZ3Jlc3MgPSBmYWxzZTsNCiAg
ICBhaW9fd2FpdF9raWNrKCk7DQp9DQoNCmludCBiZHJ2X2NoZWNrKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLCBCZHJ2Q2hlY2tSZXN1bHQgKnJlcywgQmRydkNoZWNrTW9kZSBmaXgpDQp7DQogICAgaWYg
KHFlbXVfaW5fY29yb3V0aW5lKCkpIHsNCiAgICAgICAgLyogRmFzdC1wYXRoIGlmIGFscmVhZHkg
aW4gY29yb3V0aW5lIGNvbnRleHQgKi8NCiAgICAgICAgcmV0dXJuIGJkcnZfY29fY2hlY2soYnMs
IHJlcywgZml4KTsNCiAgICB9IGVsc2Ugew0KICAgICAgICBiZHJ2X2NvX2NoZWNrX19Bcmd1bWVu
dHNQYWNrIHBhY2sgPSB7DQogICAgICAgICAgICAuYnMgPSBicywNCiAgICAgICAgICAgIC5yZXMg
PSByZXMsDQogICAgICAgICAgICAuZml4ID0gZml4LA0KDQogICAgICAgICAgICAuX2luX3Byb2dy
ZXNzID0gdHJ1ZSwNCiAgICAgICAgfTsNCiAgICAgICAgQ29yb3V0aW5lICpjbyA9IHFlbXVfY29y
b3V0aW5lX2NyZWF0ZShiZHJ2X2NvX2NoZWNrX19lbnRyeSwgJnBhY2spOw0KICAgICAgICBiZHJ2
X2Nvcm91dGluZV9lbnRlcihicywgY28pOw0KICAgICAgICBCRFJWX1BPTExfV0hJTEUoYnMsIHBh
Y2suX2luX3Byb2dyZXNzKTsNCg0KICAgICAgICByZXR1cm4gcGFjay5fcmV0Ow0KICAgIH0NCn0N
Cg0KDQovKg0KICogV3JhcHBlcnMgZm9yIGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZQ0KICovDQoN
CnR5cGVkZWYgc3RydWN0IGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZV9fQXJndW1lbnRzUGFjayB7
DQogICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnM7DQogICAgRXJyb3IgKiplcnJwOw0KDQogICAgYm9v
bCBfaW5fcHJvZ3Jlc3M7DQp9IGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZV9fQXJndW1lbnRzUGFj
azsNCg0Kc3RhdGljIHZvaWQgYmRydl9jb19pbnZhbGlkYXRlX2NhY2hlX19lbnRyeSh2b2lkICpv
cGFxdWUpDQp7DQogICAgYmRydl9jb19pbnZhbGlkYXRlX2NhY2hlX19Bcmd1bWVudHNQYWNrICpw
YWNrID0gb3BhcXVlOw0KICAgIGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZShwYWNrLT5icywgcGFj
ay0+ZXJycCk7DQogICAgcGFjay0+X2luX3Byb2dyZXNzID0gZmFsc2U7DQogICAgYWlvX3dhaXRf
a2ljaygpOw0KfQ0KDQp2b2lkIGJkcnZfaW52YWxpZGF0ZV9jYWNoZShCbG9ja0RyaXZlclN0YXRl
ICpicywgRXJyb3IgKiplcnJwKQ0Kew0KICAgIGlmIChxZW11X2luX2Nvcm91dGluZSgpKSB7DQog
ICAgICAgIC8qIEZhc3QtcGF0aCBpZiBhbHJlYWR5IGluIGNvcm91dGluZSBjb250ZXh0ICovDQog
ICAgICAgIGJkcnZfY29faW52YWxpZGF0ZV9jYWNoZShicywgZXJycCk7DQogICAgfSBlbHNlIHsN
CiAgICAgICAgYmRydl9jb19pbnZhbGlkYXRlX2NhY2hlX19Bcmd1bWVudHNQYWNrIHBhY2sgPSB7
DQogICAgICAgICAgICAuYnMgPSBicywNCiAgICAgICAgICAgIC5lcnJwID0gZXJycCwNCg0KICAg
ICAgICAgICAgLl9pbl9wcm9ncmVzcyA9IHRydWUsDQogICAgICAgIH07DQogICAgICAgIENvcm91
dGluZSAqY28gPSBxZW11X2Nvcm91dGluZV9jcmVhdGUoYmRydl9jb19pbnZhbGlkYXRlX2NhY2hl
X19lbnRyeSwgJnBhY2spOw0KICAgICAgICBiZHJ2X2Nvcm91dGluZV9lbnRlcihicywgY28pOw0K
ICAgICAgICBCRFJWX1BPTExfV0hJTEUoYnMsIHBhY2suX2luX3Byb2dyZXNzKTsNCiAgICB9DQp9
DQo=

--_002_9228cac57971e099afe578252c511684virtuozzocom_--
