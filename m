Received: from eggs.gnu.org ([2001:4830:134:3::10]:50433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <myastar@126.com>) id 1clWV0-00013m-HZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <myastar@126.com>) id 1clWUx-0007XS-Gy
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:59:06 -0500
Received: from m15-112.126.com ([220.181.15.112]:56137)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <myastar@126.com>) id 1clWUw-0007Ud-GR
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 02:59:03 -0500
Date: Wed, 8 Mar 2017 15:58:54 +0800
From: "myastar@126.com" <myastar@126.com>
Mime-Version: 1.0
Message-ID: <2017030815585308829528@126.com>
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] can not enable replaying and miss object type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

VG8gcmVjb3JkIGJsb2NrIG9wZXJhdGlvbnMgdGhlIGRyaXZlLEkgdXNlIHBhcmFtZXRlcnMgYXMg
c2hvd24gaW4gRmlndXJlIDEsIGl0IHN1Y2NlZWQsIGJ1dCB0aGUgd2hvbGUgcHJvY2VzcyBpcyB2
ZXJ5IHNsb3cuDQoNClRvIHJlcGxheSBibG9jayBvcGVyYXRpb25zIHRoZSBkcml2ZSxJIHVzZSBw
YXJhbWV0ZXJzIGFzIHNob3duIGluIEZpZ3VyZSAyLCBhZnRlciBlbnRlcmluZyB0aGUgc3RhcnR1
cCBvcHRpb25zLCB0aGUgc3lzdGVtIHN0YXkgYmxhY2sgc2NyZWVuLg0KDQpJIGNhbid0IHNvbHZl
IHRoaXMgcHJvYmxlbSwgSSBob3BlIHRvIGdldCBzb21lIGFkdmljZS4NCg0KQm90aCBibG9jay1y
ZWNvcmQuaW1nIGFuZCBibG9jay1yZXBsYXkuaW1nIGFyZSB0aGUgc2FtZSBtaXJyb3IgaW5jcmVt
ZW50cy4NCg0KV2hlbiBJIGFkZCBwYXJhbWV0ZXIgICItbmV0ZGV2IHVzZXIsaWQ9bmV0MSAtZGV2
aWNlIHJ0bDgxMzksbmV0ZGV2PW5ldDEgLW9iamVjdCBmaWx0ZXItcmVwbGF5LGlkPXJlcGxheSxu
ZXRkZXY9bmV0MSIsIEkgZW5jb3VudGVyZWQgYW4gZXJyb3IgYXMgc2hvd24gaW4gRmlndXJlIDYu
DQoNCkkgY2FuJ3QgdW5kZXJzdGFuZCB3aHkgdGhlIG9iamVjdCB0eXBlICBpcyBtaXNzaW5nLCBJ
IGhvcGUgSSBjYW4gZ2V0IGhlbHAuDQoNCiBGaWd1cmU6DQoxLnFlbXUtc3lzdGVtLXg4Nl82NCAg
LW0gM0cgLWRyaXZlIGZpbGU9YmxvY2stcmVjb3JkLmltZyxpZj1ub25lLGlkPWltZy1kaXJlY3Qg
LWRyaXZlIGRyaXZlcj1ibGtyZXBsYXksaWY9bm9uZSxpbWFnZT1pbWctZGlyZWN0LGlkPWltZy1i
bGtyZXBsYXkgLWRldmljZSBpZGUtaGQsZHJpdmU9aW1nLWJsa3JlcGxheSAgIC1pY291bnQgc2hp
ZnQ9MCxycj1yZWNvcmQscnJmaWxlPXJlcGxheS1ibG9jay5iaW4gLWxvY2FsdGltZSAgLW1vbml0
b3Igc3RkaW8gIC12bmMgOjENCjIucWVtdS1zeXN0ZW0teDg2XzY0ICAtbSAzRyAtZHJpdmUgZmls
ZT1ibG9jay1yZXBsYXkuaW1nLGlmPW5vbmUsaWQ9aW1nLWRpcmVjdCAtZHJpdmUgZHJpdmVyPWJs
a3JlcGxheSxpZj1ub25lLGltYWdlPWltZy1kaXJlY3QsaWQ9aW1nLWJsa3JlcGxheSAtZGV2aWNl
IGlkZS1oZCxkcml2ZT1pbWctYmxrcmVwbGF5ICAgLWljb3VudCBzaGlmdD0wLHJyPXJlcGxheSxy
cmZpbGU9cmVwbGF5LWJsb2NrLmJpbiAtbG9jYWx0aW1lICAtbW9uaXRvciBzdGRpbyAgLXZuYyA6
MQ0KMy5xZW11LWltZyBjcmVhdGUgLWYgcWNvdzIgLWIgdWJ1bnR1MTEuMDQuaW1nICBibG9jay1y
ZWNvcmQuaW1nDQo0LnFlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiAtYiB1YnVudHUxMS4wNC5pbWcg
YmxvY2stcmVwbGF5LmltZw0KNS4tbmV0ZGV2IHVzZXIsaWQ9bmV0MSAtZGV2aWNlIHJ0bDgxMzks
bmV0ZGV2PW5ldDEgLW9iamVjdCBmaWx0ZXItcmVwbGF5LGlkPXJlcGxheSxuZXRkZXY9bmV0MQ0K
Ni5xZW11LXN5c3RlbS14ODZfNjQ6IC1vYmplY3QgZmlsdGVyLXJlcGxheSxpZD1yZXBsYXksbmV0
ZGV2PW5ldDE6IGludmFsaWQgb2JqZWN0IHR5cGU6IGZpbHRlci1yZXBsYXkNCg0KDQoNCg0KDQoN
Cg==
