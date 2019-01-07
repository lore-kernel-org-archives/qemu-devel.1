Received: from eggs.gnu.org ([209.51.188.92]:34249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ggUa8-0004YD-VC
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ggUa7-0002rw-B0
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:04:40 -0500
Resent-Message-Id: <E1ggUa7-0002rw-B0@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ggUa7-0002qR-2U
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:04:39 -0500
In-Reply-To: <20190107103426.2669-1-ppandit@redhat.com>
Message-ID: <154686624655.22866.14881829544470322179@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 7 Jan 2019 05:04:07 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] qga: check length of command-line &
 environment variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ppandit@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, niuguoxiang@huawei.com, pjp@fedoraproject.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDEwNzEwMzQyNi4yNjY5
LTEtcHBhbmRpdEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IFNIT1dfRU5WPTEgSj04Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIExJTksgICAgcWVtdS1l
ZGlkLmV4ZQogIExJTksgICAgcWVtdS1pbWcuZXhlCi90bXAvcWVtdS10ZXN0L3NyYy9xZ2EvY29t
bWFuZHMuYzogSW4gZnVuY3Rpb24gJ2d1ZXN0X2V4ZWNfZ2V0X2FyZ3MnOgovdG1wL3FlbXUtdGVz
dC9zcmMvcWdhL2NvbW1hbmRzLmM6MjM2OjE2OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24gJ3N5c2NvbmYnOyBkaWQgeW91IG1lYW4gJ3N3c2NhbmYnPyBbLVdlcnJvcj1p
bXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICBhcmdzX21heCA9IHN5c2NvbmYoX1ND
X0FSR19NQVgpOwogICAgICAgICAgICAgICAgXn5+fn5+fgogICAgICAgICAgICAgICAgc3dzY2Fu
ZgovdG1wL3FlbXUtdGVzdC9zcmMvcWdhL2NvbW1hbmRzLmM6MjM2OjE2OiBlcnJvcjogbmVzdGVk
IGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnc3lzY29uZicgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNd
Ci90bXAvcWVtdS10ZXN0L3NyYy9xZ2EvY29tbWFuZHMuYzoyMzY6MjQ6IGVycm9yOiAnX1NDX0FS
R19NQVgnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBt
ZWFuICdTQ0hBUl9NQVgnPwogICAgIGFyZ3NfbWF4ID0gc3lzY29uZihfU0NfQVJHX01BWCk7CiAg
ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAg
IFNDSEFSX01BWAoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTAxMDcxMDM0MjYuMjY2OS0xLXBwYW5kaXRAcmVkaGF0LmNvbS90ZXN0aW5n
LmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
