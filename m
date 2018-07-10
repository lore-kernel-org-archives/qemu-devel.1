Received: from eggs.gnu.org ([2001:4830:134:3::10]:33176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fciiJ-0005aC-Fr
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fciiG-0002WI-Du
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:49:15 -0400
Resent-Message-Id: <E1fciiG-0002WI-Du@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fciiG-0002UX-84
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:49:12 -0400
In-Reply-To: <1531190661-19327-1-git-send-email-qiaochong@loongson.cn>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153119091798.1503.16066005947112586883@946cad8fd14e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 9 Jul 2018 19:48:39 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] make pci_bridge_region_cleanup to be done
 in rcu queue after flatview_destroy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qiaochong@loongson.cn
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MzExOTA2NjEtMTkzMjctMS1naXQtc2VuZC1lbWFpbC1xaWFvY2hvbmdAbG9v
bmdzb24uY24KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gbWFrZSBwY2lfYnJpZGdlX3Jl
Z2lvbl9jbGVhbnVwIHRvIGJlIGRvbmUgaW4gcmN1IHF1ZXVlIGFmdGVyIGZsYXR2aWV3X2Rlc3Ry
b3kuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0x
CnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9y
IGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQo
Z2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1m
b3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4K
ICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUK
CmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1
MzExOTA2NjEtMTkzMjctMS1naXQtc2VuZC1lbWFpbC1xaWFvY2hvbmdAbG9vbmdzb24uY24gLT4g
cGF0Y2hldy8xNTMxMTkwNjYxLTE5MzI3LTEtZ2l0LXNlbmQtZW1haWwtcWlhb2Nob25nQGxvb25n
c29uLmNuClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDdiZTVmNDE5OSBtYWtlIHBj
aV9icmlkZ2VfcmVnaW9uX2NsZWFudXAgdG8gYmUgZG9uZSBpbiByY3UgcXVldWUgYWZ0ZXIgZmxh
dHZpZXdfZGVzdHJveS4KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTog
bWFrZSBwY2lfYnJpZGdlX3JlZ2lvbl9jbGVhbnVwIHRvIGJlIGRvbmUgaW4gcmN1IHF1ZXVlIGFm
dGVyIGZsYXR2aWV3X2Rlc3Ryb3kuLi4uCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwoj
NTU6IEZJTEU6IGh3L3BjaS9wY2lfYnJpZGdlLmM6MjM4OgorYmVjYXVzZSBtZW1vcnlfcmVnaW9u
X3VucmVmIG5lZWQgYWNjZXNzIG1lbW9yeSByZWdpb25zIGluIFBDSUJyaWRnZVdpbmRvd3MgaW4g
ZmxhdHZpZXdfZGVzdHJveS4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzEgbGluZXMg
Y2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
