Received: from eggs.gnu.org ([2001:4830:134:3::10]:52552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cVgDH-0007kT-Au
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cVgDD-0008Pb-C8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:07:19 -0500
Resent-Message-Id: <E1cVgDD-0008Pb-C8@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cVgDD-0008PI-3n
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:07:15 -0500
Message-ID: <148518401873.56.11348627518773806095@b042e9bf0dd0>
In-Reply-To: <1485183295-10242-1-git-send-email-w.bumiller@proxmox.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 23 Jan 2017 07:06:59 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] cirrus: allow zero source pitch in pattern
 fill rops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: w.bumiller@proxmox.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGNpcnJ1czogYWxsb3cgemVybyBzb3VyY2UgcGl0
Y2ggaW4gcGF0dGVybiBmaWxsIHJvcHMKTWVzc2FnZS1pZDogMTQ4NTE4MzI5NS0xMDI0Mi0xLWdp
dC1zZW5kLWVtYWlsLXcuYnVtaWxsZXJAcHJveG1veC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGlu
ZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFT
RS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8k
dG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNo
b3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4r
MSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjAzOTEwMjUgY2lycnVzOiBhbGxvdyB6ZXJvIHNvdXJjZSBwaXRjaCBp
biBwYXR0ZXJuIGZpbGwgcm9wcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0gg
MS8xOiBjaXJydXM6IGFsbG93IHplcm8gc291cmNlIHBpdGNoIGluIHBhdHRlcm4gZmlsbCByb3Bz
Li4uCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMzI6IEZJTEU6IGh3L2Rpc3BsYXkv
Y2lycnVzX3ZnYS5jOjI5NDoKK3N0YXRpYyBib29sIGJsaXRfaXNfdW5zYWZlKHN0cnVjdCBDaXJy
dXNWR0FTdGF0ZSAqcywgYm9vbCBkc3Rfb25seSwgYm9vbCB6ZXJvX3NyY19waXRjaF9vaykKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNjQgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
