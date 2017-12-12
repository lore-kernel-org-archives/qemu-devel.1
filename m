Received: from eggs.gnu.org ([2001:4830:134:3::10]:46141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ePI6y-000889-3K
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ePI6u-0006bh-Uw
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:14:56 -0500
Resent-Message-Id: <E1ePI6u-0006bh-Uw@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1ePI6u-0006b1-Mm
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:14:52 -0500
In-Reply-To: <20171212172208.13588-1-marcandre.lureau@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151309960454.30.17116821935601659232@449822a21bf0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 12 Dec 2017 09:26:46 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] dump-guest-memory.py: fix "You can't do
 that without a process to debug"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, crosa@redhat.com, lersek@redhat.com, ehabkost@redhat.com, mst@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzEyMTIxNzIyMDguMTM1ODgtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20KU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gZHVtcC1ndWVzdC1tZW1vcnkucHk6IGZpeCAiWW91IGNh
bid0IGRvIHRoYXQgd2l0aG91dCBhIHByb2Nlc3MgdG8gZGVidWciClR5cGU6IHNlcmllcwoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0k
KGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4p
Igpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3Rh
bDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAk
YyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsg
dGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkK
ZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNo
ZXcvMjAxNzEyMDcyMDMwMzYuMTQ5OTMtMS1lYmxha2VAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIw
MTcxMjA3MjAzMDM2LjE0OTkzLTEtZWJsYWtlQHJlZGhhdC5jb20KICogW25ldyB0YWddICAgICAg
ICAgICAgICAgcGF0Y2hldy8yMDE3MTIxMjE3MjIwOC4xMzU4OC0xLW1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTcxMjEyMTcyMjA4LjEzNTg4LTEtbWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKN2MwNTQ0YjFh
NyBkdW1wLWd1ZXN0LW1lbW9yeS5weTogZml4ICJZb3UgY2FuJ3QgZG8gdGhhdCB3aXRob3V0IGEg
cHJvY2VzcyB0byBkZWJ1ZyIKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEv
MTogZHVtcC1ndWVzdC1tZW1vcnkucHk6IGZpeCAiWW91IGNhbid0IGRvIHRoYXQgd2l0aG91dCBh
IHByb2Nlc3MgdG8gZGVidWciLi4uCkVSUk9SOiBVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3
cm9uZzogc2VlIERvY3VtZW50YXRpb24vdm9sYXRpbGUtY29uc2lkZXJlZC1oYXJtZnVsLnR4dAoj
NDY6IEZJTEU6IGh3L21pc2Mvdm1jb3JlaW5mby5jOjM5OgorICAgIHN0YXRpYyBWTUNvcmVJbmZv
U3RhdGUgKiB2b2xhdGlsZSB2bWNvcmVpbmZvX3N0YXRlIEdfR05VQ19VTlVTRUQ7Cgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDI0IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
