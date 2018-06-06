Received: from eggs.gnu.org ([2001:4830:134:3::10]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQUJB-0006W1-SI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQUJ2-0005Ee-HA
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:00:45 -0400
Resent-Message-Id: <E1fQUJ2-0005Ee-HA@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fQUJ2-0005De-68
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:00:36 -0400
In-Reply-To: <20180605180836.21485-1-ppandit@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152827551872.435.17485619154432637368@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 6 Jun 2018 01:58:39 -0700 (PDT)
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

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNjA1MTgwODM2LjIxNDg1LTEtcHBhbmRpdEByZWRoYXQuY29tClN1Ympl
Y3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC8yXSBjb3JyZWN0IHNpemUgY29tcHV0YXRpb24gaW4g
bV9jYXQKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpu
PTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpm
b3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDog
JChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAt
LWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhl
bgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9u
ZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKNzY5MDU5YWJiOCBzbGlycDogcmVmb3JtYXQgbV9jYXQgcm91dGluZQo5ZjkzOGRj
NmE2IHNsaXJwOiBjb3JyZWN0IHNpemUgY29tcHV0YXRpb24gd2hpbGUgY29uY2F0ZW5hdGluZyBt
YnVmCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzI6IHNsaXJwOiBjb3Jy
ZWN0IHNpemUgY29tcHV0YXRpb24gd2hpbGUgY29uY2F0ZW5hdGluZyBtYnVmLi4uCkVSUk9SOiBj
b2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzI0OiBGSUxFOiBzbGlycC9tYnVmLmM6
MTQxOgorXkleSW1faW5jKG0sIG0tPm1fbGVuICsgbi0+bV9sZW4pOyQKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMzAgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKQ2hlY2tpbmcgUEFUQ0ggMi8yOiBzbGlycDogcmVmb3JtYXQgbV9jYXQg
cm91dGluZS4uLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==
