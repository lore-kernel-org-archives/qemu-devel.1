Received: from eggs.gnu.org ([2001:4830:134:3::10]:54006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gTegI-0006Oc-Hw
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 22:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gTegF-0003Fl-BU
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 22:13:58 -0500
Resent-Message-Id: <E1gTegF-0003Fl-BU@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gTegF-0003FJ-2d
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 22:13:55 -0500
In-Reply-To: <20181203023728.26774-1-yan.y.zhao@intel.com>
Message-ID: <154380677370.11560.5293308165087469846@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 2 Dec 2018 19:12:55 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] xen/pt: Fix a xen passthrough failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yan.y.zhao@intel.com
Cc: famz@redhat.com, anthony.perard@citrix.com, sstabellini@kernel.org, roger.pau@citrix.com, JBeulich@suse.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKCgpNZXNzYWdlLWlkOiAy
MDE4MTIwMzAyMzcyOC4yNjc3NC0xLXlhbi55LnpoYW9AaW50ZWwuY29tClR5cGU6IHNlcmllcwpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSB4ZW4vcHQ6IEZpeCBhIHhlbiBwYXNzdGhyb3Vn
aCBmYWlsdXJlCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJh
c2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9
MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4u
KSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90
YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cg
JGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07
IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkp
CmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCmM1NjE0OTAgeGVuL3B0OiBGaXggYSB4ZW4gcGFzc3Rocm91Z2ggZmFpbHVy
ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiB4ZW4vcHQ6IEZpeCBh
IHhlbiBwYXNzdGhyb3VnaCBmYWlsdXJlLi4uCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUg
dGhlIG9wZW4gcGFyZW50aGVzaXMgJygnCiMyNzogRklMRTogaHcveGVuL3hlbl9wdC5jOjg1MDoK
KyAgICBpZihtYWNoaW5lX2lycSA9PSAwKSB7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojNDc6IEZJTEU6IGh3L3hlbi94ZW5fcHRfY29uZmlnX2luaXQuYzozMDY6CisgICAgICAg
IFhFTl9QVF9MT0coJnMtPmRldiwgIm1hY2hpbmUgaXJxIGlzIDAsIGluaXQgZ3Vlc3QgUENJX0lO
VEVSUlVQVF9QSU4gdG8gMFxuIik7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDI0IGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
