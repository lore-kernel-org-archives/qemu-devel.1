Received: from eggs.gnu.org ([2001:4830:134:3::10]:33805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewiuK-0007ei-GV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewiuH-0001TT-9k
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:32:04 -0400
Received: from smtp65.cstnet.cn ([159.226.251.65]:50814 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1ewiuG-0001Ru-MC
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:32:01 -0400
Date: Fri, 16 Mar 2018 14:31:56 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <20180316061520.GA27549@lemon.usersys.redhat.com>
References: <1521169105-32041-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<20180316061520.GA27549@lemon.usersys.redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <55c3c49b.14dfc.1622d81fc86.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v2] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fam zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, eblake@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org

QmVjYXVzZSBJIGdlbmVyYXRlIG15IGZpcnN0IHBhdGNoIG9uIG1hc3RlciwgaXQgc2hvdWxkIHdv
cmsuCgpJIGhhdmUgYSBsaXR0bGUgdHJvdWJsZSB1bmRlcnN0YW5kaW5nIHdoYXQgTXIuUGV0ZXIg
d2FudHMgbWUgdG8gZG8sCndvdWxkIHlvdSBwbGVhc2Ugc3BhcmUgYSBsaXR0bGUgb2YgeW91ciB0
aW1lIGFuZCBoYXZlIGEgbG9vayBhdCBpdD8KSXQgd2lsbCBoZWxwIG1lLiBQbGVhc2UuLi4KClN1
IEhhbmcKCgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0tLQo+IEZyb206ICJGYW0gWmhlbmci
IDxmYW16QHJlZGhhdC5jb20+Cj4gU2VudCBUaW1lOiAyMDE4LTAzLTE2IDE0OjE1OjIwIChGcmlk
YXkpCj4gVG86ICJTdSBIYW5nIiA8c3VoYW5nMTZAbWFpbHMudWNhcy5hYy5jbj4KPiBDYzogcGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnLCBlYmxha2VAcmVkaGF0LmNvbSwgdnNlbWVudHNvdkB2aXJ0
dW96em8uY29tLCBxZW11LWRldmVsQG5vbmdudS5vcmcKPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2
ZWxdICBbUEFUQ0ggdjJdIHNjcmlwdHMvY2hlY2twYXRjaC5wbDogQnVnIGZpeAo+IAo+IE9uIEZy
aSwgMDMvMTYgMTA6NTgsIFN1IEhhbmcgd3JvdGU6Cj4gPiAoU29ycnksIEkgZG9uJ3Qga25vdyB0
aGlzIHBhdGNoIHNob3VsZCBiYXNlIG9uIHdoaWNoIGNvbW1pdCwKPiA+ICBzbyBJIGdlbmVyYXRl
IHRoaXMgcGF0Y2ggYmFzZWQgb24KPiA+ICBjb21taXQ6ZmI4NDQ2ZDk0ZWM3YTNkYzBjM2E3ZTdk
YTY3MjQwNjQ3NmYwNzVhYywKPiA+ICBJIGNob29zZSB0aGlzIGJ5IGBnaXQgbG9nIC0yIHNjcmlw
dHMvY2hlY2twYXRoLnBsYC4KPiA+ICBTaW5jZXJlbHkgc2F5IHNvcnJ5LCBpZiBJIGhhdmUgbWlz
dW5kZXJzdGFuZCBhbnkgbWVhbmluZy4pCj4gCj4gVGhpcyBzaG91bGQgYmFzZSBvbiBtYXN0ZXIu
IEJhc2luZyBvbiBhbiBvbGRlciBjb21taXQgd2lsbCBvbmx5IG1ha2UgaXQgaGFyZCBmb3IKPiBt
YWludGFpbmVycyB0byBhcHBseSBpdC4KPiAKPiAoRG9uJ3QgYmUgc29ycnkgYXQgYWxsLCB0aGFu
ayB5b3UgZm9yIHNwZW5kaW5nIHlvdXIgdGltZSBpbXByb3ZpbmcgUUVNVSEpCj4gCj4gRmFtCg==
