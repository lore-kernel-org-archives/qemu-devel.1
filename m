Received: from eggs.gnu.org ([2001:4830:134:3::10]:55761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1egn23-0005Ez-Mr
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1egn22-0001jW-Mx
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:42:11 -0500
Resent-Message-Id: <E1egn22-0001jW-Mx@eggs.gnu.org>
In-Reply-To: <20180131072445.22783-1-aik@ozlabs.ru>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151738449819.2430.18043177344228679051@272c24dfa8ec>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 30 Jan 2018 23:41:39 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH qemu v6] vfio-pci: Allow mmap of MSIX
 BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@ozlabs.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMTMxMDcyNDQ1LjIyNzgzLTEtYWlrQG96bGFicy5ydQpTdWJqZWN0OiBb
UWVtdS1kZXZlbF0gW1JGQyBQQVRDSCBxZW11IHY2XSB2ZmlvLXBjaTogQWxsb3cgbW1hcCBvZiBN
U0lYIEJBUgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNl
Cm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAK
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZl
cnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBB
VENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYg
ISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAg
IG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZTg5MWU2OTY0NSB2ZmlvLXBjaTogQWxsb3cgbW1hcCBv
ZiBNU0lYIEJBUgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8xOiB2Zmlv
LXBjaTogQWxsb3cgbW1hcCBvZiBNU0lYIEJBUi4uLgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJh
Y3RlcnMKIzgyOiBGSUxFOiBody92ZmlvL2NvbW1vbi5jOjUxNzoKKyAgICAgICAgICAgIGVycm9y
X3JlcG9ydCgiUmVnaW9uICUiSFdBRERSX1BSSXgiLi4lIkhXQUREUl9QUkl4IiBpcyBub3QgYWxp
Z25lZCB0byAlIkhXQUREUl9QUkl4IiBhbmQgY2Fubm90IGJlIG1hcHBlZCBmb3IgRE1BIiwKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTU3IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2gg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
