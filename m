Received: from eggs.gnu.org ([209.51.188.92]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hHRv5-0001TF-DL
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hHRfu-0003FK-HZ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:27:23 -0400
Resent-Message-Id: <E1hHRfu-0003FK-HZ@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hHRfu-0003Co-8X
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:27:22 -0400
In-Reply-To: <20190419103722.17062-1-shahab.vahedi@gmail.com>
Message-ID: <155567048223.24.9366683312010640413@c2072b67cc0c>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 19 Apr 2019 03:41:23 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: shahab.vahedi@gmail.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxOTEwMzcyMi4xNzA2
Mi0xLXNoYWhhYi52YWhlZGlAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA0MTkxMDM3MjIu
MTcwNjItMS1zaGFoYWIudmFoZWRpQGdtYWlsLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BB
VENIXSBjcHV0bGI6IEZpeCBpb19yZWFkeCgpIHRvIHJlc3BlY3QgdGhlIGFjY2Vzc190eXBlCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkw
NDE5MTAzNzIyLjE3MDYyLTEtc2hhaGFiLnZhaGVkaUBnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE5
MDQxOTEwMzcyMi4xNzA2Mi0xLXNoYWhhYi52YWhlZGlAZ21haWwuY29tClN3aXRjaGVkIHRvIGEg
bmV3IGJyYW5jaCAndGVzdCcKZjQ0NDY5NzZlYyBjcHV0bGI6IEZpeCBpb19yZWFkeCgpIHRvIHJl
c3BlY3QgdGhlIGFjY2Vzc190eXBlCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogc3BhY2Ug
cHJvaGliaXRlZCBiZWZvcmUgdGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScKIzMzOiBGSUxFOiBh
Y2NlbC90Y2cvY3B1dGxiLmM6ODg1OgorICAgICAgICAgICAgKGFjY2Vzc190eXBlID09IE1NVV9E
QVRBX0xPQUQgKSA/IGVudHJ5LT5hZGRyX3JlYWQgIDoKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMTUgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGY0NDQ2OTc2ZWMyMyAoY3B1dGxiOiBGaXgg
aW9fcmVhZHgoKSB0byByZXNwZWN0IHRoZSBhY2Nlc3NfdHlwZSkgaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTA0MTkxMDM3MjIuMTcwNjItMS1zaGFoYWIudmFoZWRpQGdtYWlsLmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
