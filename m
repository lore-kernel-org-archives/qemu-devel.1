Received: from eggs.gnu.org ([2001:4830:134:3::10]:42969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fbyNN-0004dR-9d
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fbyNK-0003Lj-4r
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:20:33 -0400
Resent-Message-Id: <E1fbyNK-0003Lj-4r@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fbyNJ-0003H8-Sc
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:20:30 -0400
In-Reply-To: <20180704132239.6506-1-douly.fnst@cn.fujitsu.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153071107684.1035.733913721259204094@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 4 Jul 2018 06:31:17 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: douly.fnst@cn.fujitsu.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNzA0MTMyMjM5LjY1MDYtMS1kb3VseS5mbnN0QGNuLmZ1aml0c3UuY29t
ClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGh3L21hY2hpbmU6IFJlbW92ZSB0aGUg
WmVybyBjaGVjayBvZiBuYl9udW1hX25vZGVzIGZvciBudW1hX2NvbXBsZXRlX2NvbmZpZ3VyYXRp
b24oKQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49
MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZv
ciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAk
KGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0t
Zm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVu
CiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25l
CgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8x
NTMwNzA5OTQyLTg3OTQ3LTEtZ2l0LXNlbmQtZW1haWwtamluZ3FpLmxpdUBpbnRlbC5jb20gLT4g
cGF0Y2hldy8xNTMwNzA5OTQyLTg3OTQ3LTEtZ2l0LXNlbmQtZW1haWwtamluZ3FpLmxpdUBpbnRl
bC5jb20KICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE4MDcwNDEzMjIzOS42
NTA2LTEtZG91bHkuZm5zdEBjbi5mdWppdHN1LmNvbSAtPiBwYXRjaGV3LzIwMTgwNzA0MTMyMjM5
LjY1MDYtMS1kb3VseS5mbnN0QGNuLmZ1aml0c3UuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKMzcxZmU3ZThmMSBody9tYWNoaW5lOiBSZW1vdmUgdGhlIFplcm8gY2hlY2sgb2Yg
bmJfbnVtYV9ub2RlcyBmb3IgbnVtYV9jb21wbGV0ZV9jb25maWd1cmF0aW9uKCkKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogaHcvbWFjaGluZTogUmVtb3ZlIHRoZSBa
ZXJvIGNoZWNrIG9mIG5iX251bWFfbm9kZXMgZm9yIG51bWFfY29tcGxldGVfY29uZmlndXJhdGlv
bigpLi4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhp
cyBzdGF0ZW1lbnQKIzMxOiBGSUxFOiBody9jb3JlL21hY2hpbmUuYzo3OTU6CisgICAgaWYgKG5i
X251bWFfbm9kZXMpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEyIGxpbmVz
IGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
