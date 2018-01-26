Received: from eggs.gnu.org ([2001:4830:134:3::10]:47860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ef8X2-0006Sm-MU
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ef8Wy-0005zx-7Q
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:15:20 -0500
Resent-Message-Id: <E1ef8Wy-0005zx-7Q@eggs.gnu.org>
In-Reply-To: <5A6B5091.8030601@hisilicon.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151699048045.761.10000799444971174423@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 26 Jan 2018 10:14:42 -0800 (PST)
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
 before enabled the interruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xuwei5@hisilicon.com
Cc: famz@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, rob.herring@linaro.org, charles.chenxin@huawei.com, tiantao6@huawei.com, qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, linuxarm@huawei.com, z.liuxinliang@hisilicon.com, qemu-arm@nongnu.org, huangdaode@hisilicon.com, Jonathan.Cameron@huawei.com, liguozhu@hisilicon.com, zhangyi.ac@huawei.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDVBNkI1MDkxLjgwMzA2MDFAaGlzaWxpY29uLmNvbQpTdWJqZWN0OiBbUWVtdS1k
ZXZlbF0gW1FlbXUtYXJtXSBbUEFUQ0hdIHBsMDExOiBkbyBub3QgcHV0IGludG8gZmlmbyBiZWZv
cmUgZW5hYmxlZCB0aGUgaW50ZXJydXB0aW9uCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0Uu
LiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxv
ZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwog
ICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1h
dD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAg
ICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy81QTZCNTA5MS44MDMwNjAxQGhpc2ls
aWNvbi5jb20gLT4gcGF0Y2hldy81QTZCNTA5MS44MDMwNjAxQGhpc2lsaWNvbi5jb20KU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphYWM0MDQwNzBiIHBsMDExOiBkbyBub3QgcHV0IGlu
dG8gZmlmbyBiZWZvcmUgZW5hYmxlZCB0aGUgaW50ZXJydXB0aW9uCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHBsMDExOiBkbyBub3QgcHV0IGludG8gZmlmbyBiZWZv
cmUgZW5hYmxlZCB0aGUgaW50ZXJydXB0aW9uLi4uCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vz
c2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzI3OiBGSUxFOiBody9jaGFyL3Bs
MDExLmM6MjMyOgorICAgIGlmICghcy0+aW50X2VuYWJsZWQpClsuLi5dCgpFUlJPUjogY29kZSBp
bmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMyODogRklMRTogaHcvY2hhci9wbDAxMS5jOjIz
MzoKK15JcmV0dXJuIDA7JAoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxpbmVzIGNo
ZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
