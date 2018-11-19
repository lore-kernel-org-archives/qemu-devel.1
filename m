Received: from eggs.gnu.org ([2001:4830:134:3::10]:44764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1gOtFX-0004Xy-1D
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1gOtFW-0008I8-AJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:46:39 -0500
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 20 Nov 2018 00:46:18 +0100
Message-ID: <CAHmME9qhe0ZemTkc2jkEO=_hu6PhvKUKGHC9QYTj2j+QHhNf8g@mail.gmail.com>
Content-Type: multipart/mixed; boundary="00000000000046243d057b0d209f"
Subject: [Qemu-devel] more serial ports on arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

--00000000000046243d057b0d209f
Content-Type: text/plain; charset="UTF-8"

Hey guys,

I sort of lost track of the discussion, but what ever happened to
adding an extra serial port to the arm virt machine? I'm still
carrying around the attached patch to run build.wireguard.com and I'd
of course like to see a real solution upstream.

Jason

--00000000000046243d057b0d209f
Content-Type: text/x-patch; charset="US-ASCII"; name="virt-serial-ports.patch"
Content-Disposition: attachment; filename="virt-serial-ports.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jooykdm00>
X-Attachment-Id: f_jooykdm00

ZGlmZiAtcnUgcWVtdS0zLjAuMC9ody9hcm0vdmlydC5jIHFlbXUtMy4wLjAtbW9kaWZpZWQvaHcv
YXJtL3ZpcnQuYwotLS0gcWVtdS0zLjAuMC9ody9hcm0vdmlydC5jCTIwMTgtMDgtMTQgMjE6MTA6
MzQuMDAwMDAwMDAwICswMjAwCisrKyBxZW11LTMuMC4wLW1vZGlmaWVkL2h3L2FybS92aXJ0LmMJ
MjAxOC0wOS0xNCAxMTo0ODozMS45MTQ3NzIyOTQgKzAyMDAKQEAgLTY3MiwxMyArNjcyLDcgQEAK
ICAgICBxZW11X2ZkdF9zZXRwcm9wKHZtcy0+ZmR0LCBub2RlbmFtZSwgImNsb2NrLW5hbWVzIiwK
ICAgICAgICAgICAgICAgICAgICAgICAgICBjbG9ja25hbWVzLCBzaXplb2YoY2xvY2tuYW1lcykp
OwogCi0gICAgaWYgKHVhcnQgPT0gVklSVF9VQVJUKSB7Ci0gICAgICAgIHFlbXVfZmR0X3NldHBy
b3Bfc3RyaW5nKHZtcy0+ZmR0LCAiL2Nob3NlbiIsICJzdGRvdXQtcGF0aCIsIG5vZGVuYW1lKTsK
LSAgICB9IGVsc2UgewotICAgICAgICAvKiBNYXJrIGFzIG5vdCB1c2FibGUgYnkgdGhlIG5vcm1h
bCB3b3JsZCAqLwotICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyh2bXMtPmZkdCwgbm9k
ZW5hbWUsICJzdGF0dXMiLCAiZGlzYWJsZWQiKTsKLSAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9z
dHJpbmcodm1zLT5mZHQsIG5vZGVuYW1lLCAic2VjdXJlLXN0YXR1cyIsICJva2F5Iik7Ci0gICAg
fQorICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKHZtcy0+ZmR0LCAiL2Nob3NlbiIsICJzdGRv
dXQtcGF0aCIsIG5vZGVuYW1lKTsKIAogICAgIGdfZnJlZShub2RlbmFtZSk7CiB9CkBAIC0xNDk3
LDExICsxNDkxLDExIEBACiAKICAgICBmZHRfYWRkX3BtdV9ub2Rlcyh2bXMpOwogCisgICAgY3Jl
YXRlX3VhcnQodm1zLCBwaWMsIFZJUlRfU0VDVVJFX1VBUlQsIHN5c21lbSwgc2VyaWFsX2hkKDEp
KTsKICAgICBjcmVhdGVfdWFydCh2bXMsIHBpYywgVklSVF9VQVJULCBzeXNtZW0sIHNlcmlhbF9o
ZCgwKSk7CiAKICAgICBpZiAodm1zLT5zZWN1cmUpIHsKICAgICAgICAgY3JlYXRlX3NlY3VyZV9y
YW0odm1zLCBzZWN1cmVfc3lzbWVtKTsKLSAgICAgICAgY3JlYXRlX3VhcnQodm1zLCBwaWMsIFZJ
UlRfU0VDVVJFX1VBUlQsIHNlY3VyZV9zeXNtZW0sIHNlcmlhbF9oZCgxKSk7CiAgICAgfQogCiAg
ICAgdm1zLT5oaWdobWVtX2VjYW0gJj0gdm1zLT5oaWdobWVtICYmICghZmlybXdhcmVfbG9hZGVk
IHx8IGFhcmNoNjQpOwo=
--00000000000046243d057b0d209f--
