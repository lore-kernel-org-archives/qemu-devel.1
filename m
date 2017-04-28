Received: from eggs.gnu.org ([2001:4830:134:3::10]:43800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d41gG-0001XX-I4
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1d41gB-0001qN-On
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:55:12 -0400
Resent-Message-Id: <E1d41gB-0001qN-On@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1d41gB-0001oY-FU
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:55:07 -0400
In-Reply-To: <20170428075612.9997-1-kraxel@redhat.com>
Message-ID: <149336968838.114.17475756723744551535@c05f1edc8ed1>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 28 Apr 2017 01:54:48 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] audio: release capture buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, PSIRT@huawei.com, ppandit@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gYXVkaW86IHJlbGVhc2UgY2FwdHVyZSBidWZmZXJzCk1lc3NhZ2UtaWQ6
IDIwMTcwNDI4MDc1NjEyLjk5OTctMS1rcmF4ZWxAcmVkaGF0LmNvbQpUeXBlOiBzZXJpZXMKCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9
JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBn
aXQgb3B0aW9ucwpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0
PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJD
aGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4u
LiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8K
ICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjI0N2M0MGMgYXVkaW86IHJlbGVhc2Ug
Y2FwdHVyZSBidWZmZXJzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6
IGF1ZGlvOiByZWxlYXNlIGNhcHR1cmUgYnVmZmVycy4uLgpFUlJPUjogc3BhY2UgcHJvaGliaXRl
ZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiMyNjogRklM
RTogYXVkaW8vYXVkaW8uYzoyMDMxOgorICAgICAgICAgICAgICAgIGdfZnJlZSAoY2FwLT5ody5t
aXhfYnVmKTsKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJldHdlZW4gZnVuY3Rpb24gbmFtZSBh
bmQgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzI3OiBGSUxFOiBhdWRpby9hdWRpby5jOjIwMzI6Cisg
ICAgICAgICAgICAgICAgZ19mcmVlIChjYXAtPmJ1Zik7Cgp0b3RhbDogMiBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDggbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QGZyZWVsaXN0cy5vcmc=
