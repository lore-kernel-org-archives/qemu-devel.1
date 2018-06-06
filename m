Received: from eggs.gnu.org ([2001:4830:134:3::10]:44809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQVZE-0007nj-48
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQVZB-0001u4-0F
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:21:24 -0400
Resent-Message-Id: <E1fQVZB-0001u4-0F@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fQVZA-0001td-O2
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:21:20 -0400
In-Reply-To: <20180605180836.21485-1-ppandit@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152828038278.435.16734601974487104752@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 6 Jun 2018 03:19:43 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/2] correct size computation in m_cat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ppandit@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, pjp@fedoraproject.org, jan.kiszka@siemens.com

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2Ug
ZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE4MDYw
NTE4MDgzNi4yMTQ4NS0xLXBwYW5kaXRAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0g
W1BBVENIIDAvMl0gY29ycmVjdCBzaXplIGNvbXB1dGF0aW9uIGluIG1fY2F0Cgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBiZSBpbnZv
a2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBjb21t
aXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJhbmNo
CnNldCAtZQplY2hvICI9PT0gRU5WID09PSIKZW52CmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJw
bSAtcWEKZWNobyAiPT09IFRFU1QgQkVHSU4gPT09IgpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0k
UFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZAplY2hvIC1uICJVc2luZyBDQzogIgpyZWFscGF0
aCAkQ0MKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2Nv
bmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVl
ZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKZmF0YWw6IHVuYWJsZSB0byBhY2Nlc3MgJ2h0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdS8nOiBFbmNvdW50ZXJlZCBlbmQgb2YgZmlsZQplcnJvcjog
Q291bGQgbm90IGZldGNoIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQK
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi9ob21lL2ZhbS9wYXRj
aGV3L3BhdGNoZXctY2xpIiwgbGluZSA0MDksIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVw
byhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YpCiAgRmlsZSAiL2hvbWUvZmFtL3Bh
dGNoZXcvcGF0Y2hldy1jbGkiLCBsaW5lIDQ4LCBpbiBnaXRfY2xvbmVfcmVwbwogICAgc3Rkb3V0
PWxvZ2YsIHN0ZGVycj1sb2dmKQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nl
c3MucHkiLCBsaW5lIDI5MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snZ2l0JywgJ3JlbW90ZScsICdhZGQnLCAnLWYnLCAnLS1taXJyb3I9ZmV0Y2gnLCAnM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NCcsICdodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMS4K
CgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==
