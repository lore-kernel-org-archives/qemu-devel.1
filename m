Received: from eggs.gnu.org ([2001:4830:134:3::10]:41632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cO9hN-0006PN-W2
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cO9hF-0000a7-Fa
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:59:13 -0500
Resent-Message-Id: <E1cO9hF-0000a7-Fa@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cO9hF-0000Zz-9J
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 15:59:09 -0500
In-Reply-To: <20170102205521.4101-1-jcd@tribudubois.net>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148339074019.142.527852821853191602@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 2 Jan 2017 12:59:00 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] [i.MX] fix CS handling during SPI access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcd@tribudubois.net
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, mar.krzeminski@gmail.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gW2kuTVhdIGZpeCBDUyBoYW5kbGluZyBkdXJpbmcgU1BJIGFjY2Vzcy4K
TWVzc2FnZS1pZDogMjAxNzAxMDIyMDU1MjEuNDEwMS0xLWpjZEB0cmlidWR1Ym9pcy5uZXQKVHlw
ZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJh
c2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9
MAoKIyBVc2VmdWwgZ2l0IG9wdGlvbnMKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0
IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBk
bwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZv
cm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEK
ICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE3MDEwMjIwNTUyMS40MTAxLTEtamNk
QHRyaWJ1ZHVib2lzLm5ldCAtPiBwYXRjaGV3LzIwMTcwMTAyMjA1NTIxLjQxMDEtMS1qY2RAdHJp
YnVkdWJvaXMubmV0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKM2QyNWE4NyBmaXgg
Q1MgaGFuZGxpbmcgZHVyaW5nIFNQSSBhY2Nlc3MuCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVj
a2luZyBQQVRDSCAxLzE6IGZpeCBDUyBoYW5kbGluZyBkdXJpbmcgU1BJIGFjY2Vzcy4uLi4KRVJS
T1I6IHN1c3BlY3QgY29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDQsIDcp
CiM4NjogRklMRTogaHcvc3NpL2lteF9zcGkuYzoyNjE6CisgICAgZm9yIChpID0gMDsgaSA8IDQ7
IGkrKykgeworICAgICAgIHFlbXVfc2V0X2lycShzLT5jc19saW5lc1tpXSwgMSk7Cgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDc2IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
