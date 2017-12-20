Received: from eggs.gnu.org ([2001:4830:134:3::10]:36951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eShcd-0006K7-DO
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 06:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eShcY-0005g4-QZ
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 06:05:43 -0500
Resent-Message-Id: <E1eShcY-0005g4-QZ@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eShcY-0005fc-H0
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 06:05:38 -0500
In-Reply-To: <20171220002941.14560-1-palmer@dabbelt.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151378287585.90.8638590888365142538@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 20 Dec 2017 07:14:37 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] linux-user: Implement renameat2 when
 defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: palmer@dabbelt.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com, sagark@eecs.berkeley.edu

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcxMjIwMDAyOTQxLjE0NTYwLTEtcGFsbWVyQGRhYmJlbHQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGxpbnV4LXVzZXI6IEltcGxlbWVudCByZW5hbWVhdDIg
d2hlbiBkZWZpbmVkCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNF
PWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWls
ZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAt
LXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tp
bmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAg
ICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBm
aQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiY2ZmNWE0ODI5IGxpbnV4LXVzZXI6IEltcGxl
bWVudCByZW5hbWVhdDIgd2hlbiBkZWZpbmVkCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2lu
ZyBQQVRDSCAxLzE6IGxpbnV4LXVzZXI6IEltcGxlbWVudCByZW5hbWVhdDIgd2hlbiBkZWZpbmVk
Li4uCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9p
ZGVkCiM1NzogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6ODM0NToKKyNpZiBkZWZpbmVkKFRB
UkdFVF9OUl9yZW5hbWVhdDIpICYmIGRlZmluZWQoX19OUl9yZW5hbWVhdDIpCgpFUlJPUjogYnJh
Y2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM2Mzog
RklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6ODM1MToKKyAgICAgICAgICAgIGlmICghcCB8fCAh
cDIpClsuLi5dCisgICAgICAgICAgICBlbHNlClsuLi5dCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAg
Y2hhcmFjdGVycwojNjY6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjgzNTQ6CisgICAgICAg
ICAgICAgICAgcmV0ID0gZ2V0X2Vycm5vKHN5c2NhbGwoX19OUl9yZW5hbWVhdDIsIGFyZzEsIHAs
IGFyZzMsIHAyLCBhcmc1KSk7Cgp0b3RhbDogMSBlcnJvcnMsIDIgd2FybmluZ3MsIDIxIGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
