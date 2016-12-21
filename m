Received: from eggs.gnu.org ([2001:4830:134:3::10]:55929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJYSk-0008AP-AO
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 23:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJYSf-0002Zu-Qb
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 23:25:10 -0500
Resent-Message-Id: <E1cJYSf-0002Zu-Qb@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([74.201.84.163]:21468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cJYSf-0002ZX-J9
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 23:25:05 -0500
In-Reply-To: <1482294077-29807-1-git-send-email-peterx@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148229426899.76.308352055873122582@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 20 Dec 2016 20:24:31 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] intel_iommu: allow dynamic switch of
 IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMTQ4
MjI5NDA3Ny0yOTgwNy0xLWdpdC1zZW5kLWVtYWlsLXBldGVyeEByZWRoYXQuY29tClN1YmplY3Q6
IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGludGVsX2lvbW11OiBhbGxvdyBkeW5hbWljIHN3aXRj
aCBvZiBJT01NVSByZWdpb24KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJB
U0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVz
IFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLiki
CmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFs
OiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRj
IC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0
aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpk
b25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8xNDgy
Mjk0MDc3LTI5ODA3LTEtZ2l0LXNlbmQtZW1haWwtcGV0ZXJ4QHJlZGhhdC5jb20gLT4gcGF0Y2hl
dy8xNDgyMjk0MDc3LTI5ODA3LTEtZ2l0LXNlbmQtZW1haWwtcGV0ZXJ4QHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0NDA2OTcyIGludGVsX2lvbW11OiBhbGxvdyBk
eW5hbWljIHN3aXRjaCBvZiBJT01NVSByZWdpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNr
aW5nIFBBVENIIDEvMTogaW50ZWxfaW9tbXU6IGFsbG93IGR5bmFtaWMgc3dpdGNoIG9mIElPTU1V
IHJlZ2lvbi4uLgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUg
YW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM4MTogRklMRTogaHcvaTM4Ni9pbnRlbF9pb21tdS5j
OjEyMDk6CisgICAgd2hpbGUgKGdfaGFzaF90YWJsZV9pdGVyX25leHQgKCZpdGVyLCBOVUxMLCAo
dm9pZCAqKikmdnRkX2J1cykpIHsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTI4IGxp
bmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMu
b3Jn
