Received: from eggs.gnu.org ([2001:4830:134:3::10]:36200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGYf-0003jR-Kq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGYe-0000J2-DL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:51:41 -0400
Resent-Message-Id: <E1dTGYe-0000J2-DL@eggs.gnu.org>
In-Reply-To: <20170629060300.29869-1-el13635@mail.ntua.gr>
Message-ID: <149938496797.27.11708429179775046632@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:49:28 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] block: fix bs->file leak in
 bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: el13635@mail.ntua.gr
Cc: famz@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gYmxvY2s6IGZpeCBicy0+ZmlsZSBsZWFrIGluIGJkcnZfbmV3X29wZW5f
ZHJpdmVyKCkKTWVzc2FnZS1pZDogMjAxNzA2MjkwNjAzMDAuMjk4NjktMS1lbDEzNjM1QG1haWwu
bnR1YS5ncgpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2Mg
LWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9y
bWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hv
ICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRj
KS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVj
aG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApmYXRhbDogQ2Fubm90IHVwZGF0ZSBwYXRocyBhbmQgc3dpdGNoIHRvIGJyYW5jaCAndGVz
dCcgYXQgdGhlIHNhbWUgdGltZS4KRGlkIHlvdSBpbnRlbmQgdG8gY2hlY2tvdXQgJ29yaWdpbi9w
YXRjaGV3LzIwMTcwNjI5MDYwMzAwLjI5ODY5LTEtZWwxMzYzNUBtYWlsLm50dWEuZ3InIHdoaWNo
IGNhbiBub3QgYmUgcmVzb2x2ZWQgYXMgY29tbWl0PwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6CiAgRmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3IiwgbGluZSA0NDAsIGluIHRl
c3Rfb25lCiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxv
Z2YpCiAgRmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3IiwgbGluZSA1MywgaW4gZ2l0X2Nsb25l
X3JlcG8KICAgIGN3ZD1jbG9uZSkKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNS9zdWJwcm9j
ZXNzLnB5IiwgbGluZSAyNzEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NF
cnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5k
ICdbJ2dpdCcsICdjaGVja291dCcsICdvcmlnaW4vcGF0Y2hldy8yMDE3MDYyOTA2MDMwMC4yOTg2
OS0xLWVsMTM2MzVAbWFpbC5udHVhLmdyJywgJy1iJywgJ3Rlc3QnXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMTI4CgoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
