Received: from eggs.gnu.org ([2001:4830:134:3::10]:34963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWe-000201-Cw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWd-0007gV-9r
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:36 -0400
Resent-Message-Id: <E1dTGWd-0007gV-9r@eggs.gnu.org>
In-Reply-To: <20170629045940.11242-1-sjitindarsingh@gmail.com>
Message-ID: <149938496016.27.3566829502934798013@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:49:20 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Only set PCR in kvm if
 actually in a compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sjitindarsingh@gmail.com
Cc: famz@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gdGFyZ2V0L3BwYzogT25seSBzZXQgUENSIGluIGt2bSBpZiBhY3R1YWxs
eSBpbiBhIGNvbXBhdCBtb2RlCk1lc3NhZ2UtaWQ6IDIwMTcwNjI5MDQ1OTQwLjExMjQyLTEtc2pp
dGluZGFyc2luZ2hAZ21haWwuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5l
ICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIk
KGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0
czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEg
LS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8
IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxl
ZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVk
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiBDYW5ub3QgdXBkYXRlIHBhdGhzIGFuZCBzd2l0Y2gg
dG8gYnJhbmNoICd0ZXN0JyBhdCB0aGUgc2FtZSB0aW1lLgpEaWQgeW91IGludGVuZCB0byBjaGVj
a291dCAnb3JpZ2luL3BhdGNoZXcvMjAxNzA2MjkwNDU5NDAuMTEyNDItMS1zaml0aW5kYXJzaW5n
aEBnbWFpbC5jb20nIHdoaWNoIGNhbiBub3QgYmUgcmVzb2x2ZWQgYXMgY29tbWl0PwpUcmFjZWJh
Y2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3
IiwgbGluZSA0NDAsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVw
byJdLCByWyJoZWFkIl0sIGxvZ2YpCiAgRmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3IiwgbGlu
ZSA1MywgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIGN3ZD1jbG9uZSkKICBGaWxlICIvdXNyL2xpYjY0
L3B5dGhvbjMuNS9zdWJwcm9jZXNzLnB5IiwgbGluZSAyNzEsIGluIGNoZWNrX2NhbGwKICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdjaGVja291dCcsICdvcmlnaW4vcGF0Y2hldy8y
MDE3MDYyOTA0NTk0MC4xMTI0Mi0xLXNqaXRpbmRhcnNpbmdoQGdtYWlsLmNvbScsICctYicsICd0
ZXN0J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEyOAoKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
