Received: from eggs.gnu.org ([2001:4830:134:3::10]:40736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fH3Ks-00089a-Ju
	for qemu-devel@nongnu.org; Fri, 11 May 2018 04:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fH3Kp-0000Y8-Vq
	for qemu-devel@nongnu.org; Fri, 11 May 2018 04:23:30 -0400
Resent-Message-Id: <E1fH3Kp-0000Y8-Vq@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fH3Kp-0000Xo-NE
	for qemu-devel@nongnu.org; Fri, 11 May 2018 04:23:27 -0400
In-Reply-To: <20180507123014.C67BE3818FB@moya.office.hostfission.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152569646461.2607.18327444225584749992@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 7 May 2018 05:34:25 -0700 (PDT)
Subject: Re: [Qemu-devel] (resend)[PATCH 1/2] ps2: Clear the queue on PS/2
 mouse reset and obey device disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNTA3MTIzMDE0LkM2N0JFMzgxOEZCQG1veWEub2ZmaWNlLmhvc3RmaXNz
aW9uLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gKHJlc2VuZClbUEFUQ0ggMS8yXSBwczI6IENs
ZWFyIHRoZSBxdWV1ZSBvbiBQUy8yIG1vdXNlIHJlc2V0IGFuZCBvYmV5IGRldmljZSBkaXNhYmxl
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRv
dGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoK
Y29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMg
aW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0
IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3Jt
YXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAg
ICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4
aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTgw
NTA3MTIzMDE0LkM2N0JFMzgxOEZCQG1veWEub2ZmaWNlLmhvc3RmaXNzaW9uLmNvbSAtPiBwYXRj
aGV3LzIwMTgwNTA3MTIzMDE0LkM2N0JFMzgxOEZCQG1veWEub2ZmaWNlLmhvc3RmaXNzaW9uLmNv
bQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjRkYTEyYWY5ODUgKHJlc2VuZClbUEFU
Q0ggMS8yXSBwczI6IENsZWFyIHRoZSBxdWV1ZSBvbiBQUy8yIG1vdXNlIHJlc2V0IGFuZCBvYmV5
IGRldmljZSBkaXNhYmxlCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6
IChyZXNlbmQpW1BBVENIIDEvMl0gcHMyOiBDbGVhciB0aGUgcXVldWUgb24gUFMvMiBtb3VzZSBy
ZXNldCBhbmQgb2JleSBkZXZpY2UgZGlzYWJsZS4uLgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNl
c3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiMyMTogRklMRTogaHcvaW5wdXQv
cHMyLmM6Njc2OgorICAgIGlmICghKHMtPm1vdXNlX3N0YXR1cyAmIE1PVVNFX1NUQVRVU19FTkFC
TEVEKSkKWy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMgY2hlY2tl
ZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
