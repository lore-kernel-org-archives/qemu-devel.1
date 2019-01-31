Received: from eggs.gnu.org ([209.51.188.92]:53477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGfd-0003ER-7a
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGfS-0007fW-7I
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:02:29 -0500
Resent-Message-Id: <E1gpGfS-0007fW-7I@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpGfP-0007dy-EI
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:02:24 -0500
Message-ID: <154895770979.23946.13777842004324918683@ebba9967afc0>
In-Reply-To: <1548859760-10654-1-git-send-email-liam.merwick@oracle.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 10:01:51 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] kvm: Potential NULL pointer dereference in
 kvm_arch_init_vcpu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liam.merwick@oracle.com
Cc: fam@euphon.net, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQ4ODU5NzYwLTEwNjU0LTEt
Z2l0LXNlbmQtZW1haWwtbGlhbS5tZXJ3aWNrQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJp
ZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBi
ZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hd
IGt2bTogUG90ZW50aWFsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBrdm1fYXJjaF9pbml0
X3ZjcHUoKQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTU0ODg1OTc2MC0xMDY1NC0xLWdpdC1z
ZW5kLWVtYWlsLWxpYW0ubWVyd2lja0BvcmFjbGUuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwpm
MDE1MzliMjJiIGt2bTogUG90ZW50aWFsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBrdm1f
YXJjaF9pbml0X3ZjcHUoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGNvZGUgaW5kZW50
IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjY6IEZJTEU6IHRhcmdldC9pMzg2L2t2bS5jOjEzMTM6
CiteSX0kCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEwIGxpbmVzIGNoZWNrZWQKCkNv
bW1pdCBmMDE1MzliMjJiZGEgKGt2bTogUG90ZW50aWFsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZSBpbiBrdm1fYXJjaF9pbml0X3ZjcHUoKSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU0ODg1OTc2
MC0xMDY1NC0xLWdpdC1zZW5kLWVtYWlsLWxpYW0ubWVyd2lja0BvcmFjbGUuY29tL3Rlc3Rpbmcu
Y2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
