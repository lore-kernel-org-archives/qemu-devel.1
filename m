Received: from eggs.gnu.org ([2001:4830:134:3::10]:35748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eHA8d-0007Ad-2y
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eHA8X-0003Z5-0y
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:07:03 -0500
Resent-Message-Id: <E1eHA8X-0003Z5-0y@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eHA8W-0003YQ-PV
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:06:56 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151119113737.525.6410514696367533385@bafd83ae6430>
In-Reply-To: <20171120142216.17832-1-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 20 Nov 2017 07:18:57 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] msix: don't mask already masked vectors on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lprosek@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, marcel@redhat.com, geoff@hostfission.com, mst@redhat.com

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBtc2l4OiBkb24ndCBtYXNrIGFscmVhZHkg
bWFza2VkIHZlY3RvcnMgb24gcmVzZXQKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTcxMTIw
MTQyMjE2LjE3ODMyLTEtbHByb3Nla0ByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCnNldCAtZQpnaXQgc3VibW9kdWxlIHVwZGF0ZSAtLWluaXQgZHRjCiMg
TGV0IGRvY2tlciB0ZXN0cyBkdW1wIGVudmlyb25tZW50IGluZm8KZXhwb3J0IFNIT1dfRU5WPTEK
ZXhwb3J0IEo9OAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNgp0aW1lIG1ha2Ug
ZG9ja2VyLXRlc3QtYnVpbGRAbWluLWdsaWIKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtYmxvY2tAZmVkb3JhCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
CmVycm9yOiBSUEMgZmFpbGVkOyBjdXJsIDE4IHRyYW5zZmVyIGNsb3NlZCB3aXRoIG91dHN0YW5k
aW5nIHJlYWQgZGF0YSByZW1haW5pbmcKZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5l
eHBlY3RlZGx5CmVycm9yOiBDb3VsZCBub3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmls
ZSAiL3Vzci9iaW4vcGF0Y2hldyIsIGxpbmUgNDQyLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25l
X3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmKQogIEZpbGUgIi91c3IvYmlu
L3BhdGNoZXciLCBsaW5lIDQ4LCBpbiBnaXRfY2xvbmVfcmVwbwogICAgc3Rkb3V0PWxvZ2YsIHN0
ZGVycj1sb2dmKQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHkiLCBs
aW5lIDI5MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0Jywg
J3JlbW90ZScsICdhZGQnLCAnLWYnLCAnLS1taXJyb3I9ZmV0Y2gnLCAnM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NCcsICdodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMS4KCgoKLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3Rz
Lm9yZw==
