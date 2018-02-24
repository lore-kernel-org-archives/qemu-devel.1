Received: from eggs.gnu.org ([2001:4830:134:3::10]:44528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1epqOS-0005NP-Ce
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 02:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1epqOP-00014o-6j
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 02:06:44 -0500
Resent-Message-Id: <E1epqOP-00014o-6j@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1epqOO-000134-Tf
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 02:06:41 -0500
In-Reply-To: <1519480458-9573-1-git-send-email-suhang16@mails.ucas.ac.cn>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151950000703.982.2460528504585384842@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 24 Feb 2018 11:20:07 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH RFC] scripts/checkpatch.pl:Add check for
 `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: suhang16@mails.ucas.ac.cn
Cc: famz@redhat.com, thuth@redhat.com, stefanha@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTk0ODA0NTgtOTU3My0xLWdpdC1zZW5kLWVtYWlsLXN1aGFuZzE2QG1haWxz
LnVjYXMuYWMuY24KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBSRkNdIHNjcmlwdHMvY2hl
Y2twYXRjaC5wbDpBZGQgY2hlY2sgZm9yIGB3aGlsZWAgYW5kIGBmb3JgCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAt
LW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQg
bG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRv
CiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9y
bWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQog
ICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmQ1NTdkOThjYTkg
c2NyaXB0cy9jaGVja3BhdGNoLnBsOkFkZCBjaGVjayBmb3IgYHdoaWxlYCBhbmQgYGZvcmAKCj09
PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogc2NyaXB0cy9jaGVja3BhdGNo
LnBsOkFkZCBjaGVjayBmb3IgYHdoaWxlYCBhbmQgYGZvcmAuLi4KRVJST1I6IGxpbmUgb3ZlciA5
MCBjaGFyYWN0ZXJzCiMzMjogRklMRTogc2NyaXB0cy9jaGVja3BhdGNoLnBsOjIzNTY6CisJCWlm
ICgkbGluZSA9fiAvKF4uKilcYihpZnxmb3J8d2hpbGUpXGIvICYmICRsaW5lICF+IC9cI1xzKihp
Znxmb3J8d2hpbGUpLykgewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxpbmVzIGNo
ZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
