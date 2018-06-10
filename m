Received: from eggs.gnu.org ([2001:4830:134:3::10]:57040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fRpj1-0007pV-Iw
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 22:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fRpiy-0008Cg-DW
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 22:04:59 -0400
Received: from smtp66.cstnet.cn ([159.226.251.66]:58272 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fRpix-00089w-O8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 22:04:56 -0400
Date: Sun, 10 Jun 2018 10:04:32 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <20180609163252.27506-1-stefanha@redhat.com>
References: <20180609163252.27506-1-stefanha@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6d70ea23.116b3.163e77016fb.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH] loader: implement START_SEG_ADDR_RECORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefan hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, qemu.ml@steffen-goertz.de

U3VyZSwgVGhhbmtzIGZvciByZW1pbmQgbWUgb2YgdGhpcy4KT25lIHRoaW5nIEkgbXVzdCBwb2lu
dCBvdXQsIGluIGN1cnJlbnQgY29kZSBsb2dpYywgaWYgIlNUQVJUX1NFR19BRERSX1JFQ09SRCIK
b2NjdXJlZCBtdWx0aXBsZSB0aW1lcywgb25seSB0aGUgbGFzdCBvbmUgd29ya3MuIEkgZG9uJ3Qg
a25vdyB3aGV0aGVyIEdOVQpiaW51dGlscyB3b3VsZCBlbWl0ICdUaGUgUmVjb3JkJyBtYW55IHRp
bWVzLgoKQmVzdCwKU1UgSGFuZwoKCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlcy0tLS0tCj4gRnJv
bTogIlN0ZWZhbiBIYWpub2N6aSIgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Cj4gU2VudCBUaW1lOiAy
MDE4LTA2LTEwIDAwOjMyOjUyIChTdW5kYXkpCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZwo+
IENjOiAiU3UgSGFuZyIgPHN1aGFuZzE2QG1haWxzLnVjYXMuYWMuY24+LCBqdXN1YWxAbWFpbC5y
dSwgamltQGdyb2tsZWFybmluZy5jb20sIGpvZWxAam1zLmlkLmF1LCBxZW11Lm1sQHN0ZWZmZW4t
Z29lcnR6LmRlLCAiU3RlZmFuIEhham5vY3ppIiA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KPiBTdWJq
ZWN0OiBbUEFUQ0hdIGxvYWRlcjogaW1wbGVtZW50IFNUQVJUX1NFR19BRERSX1JFQ09SRAo+IAo+
IEl0IHR1cm5zIG91dCB0aGF0IEdOVSBiaW51dGlscyBlbWl0cyBTVEFSVF9TRUdfQUREUl9SRUNP
UkQgd2hlbiB0aGUgc3RhcnQKPiBhZGRyZXNzIGlzIHdpdGhpbiB0aGUgZmlyc3QgbWVnYWJ5dGUg
KDwgMHgxMDAwMDApLiAgVGhlcmVmb3JlIHdlIG11c3QKPiBoYW5kbGUgdGhpcyByZWNvcmQgdHlw
ZS4KPiAKPiBPcmlnaW5hbGx5IHdlIHRob3VnaHQgdGhpcyByZWNvcmQgdHlwZSB3YXMgeDg2LXNw
ZWNpZmljLCBidXQgYmludXRpbHMKPiBhbHNvIGVtaXRzIGl0IG9uIG5vbi14ODYgYXJjaGl0ZWN0
dXJlcy4KPiAKPiBCYXNlZC1vbjogPDE1MjcxNjEzNDAtMzIwMC0xLWdpdC1zZW5kLWVtYWlsLXN1
aGFuZzE2QG1haWxzLnVjYXMuYWMuY24+Cj4gQ2M6IFN1IEhhbmcgPHN1aGFuZzE2QG1haWxzLnVj
YXMuYWMuY24+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgo+IC0tLQo+IFN1IEhhbmc6IEZlZWwgZnJlZSB0byBzcXVhc2ggdGhpcyBpbnRvIHRo
ZSBuZXh0IHJldmlzaW9uIG9mIHlvdXIgaGV4Cj4gbG9hZGVyIHBhdGNoLiAgRG9uJ3Qgd29ycnkg
YWJvdXQgdGhlIGF1dGhvcnNoaXAgaW5mb3JtYXRpb24uCj4gCj4gIGh3L2NvcmUvbG9hZGVyLmMg
fCAxMCArKysrKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvbG9hZGVyLmMgYi9ody9jb3JlL2xv
YWRlci5jCj4gaW5kZXggM2MwMjAyY2FhOC4uNzg0M2I0ODdiMiAxMDA2NDQKPiAtLS0gYS9ody9j
b3JlL2xvYWRlci5jCj4gKysrIGIvaHcvY29yZS9sb2FkZXIuYwo+IEBAIC0xNDIzLDggKzE0MjMs
MTQgQEAgc3RhdGljIGludCBoYW5kbGVfcmVjb3JkX3R5cGUoSGV4UGFyc2VyICpwYXJzZXIpCj4g
ICAgICAgICAgYnJlYWs7Cj4gIAo+ICAgICAgY2FzZSBTVEFSVF9TRUdfQUREUl9SRUNPUkQ6Cj4g
LSAgICAgICAgLyogVE9ETzogU1RBUlRfU0VHX0FERFJfUkVDT1JEIGlzIHg4Ni1zcGVjaWZpYyAq
Lwo+IC0gICAgICAgIHJldHVybiAtMTsKPiArICAgICAgICBpZiAobGluZS0+Ynl0ZV9jb3VudCAh
PSA0ICYmIGxpbmUtPmFkZHJlc3MgIT0gMCkgewo+ICsgICAgICAgICAgICByZXR1cm4gLTE7Cj4g
KyAgICAgICAgfQo+ICsKPiArICAgICAgICAvKiB4ODYgMTYtYml0IENTOklQIHNlZ21lbnRlZCBh
ZGRyZXNzaW5nICovCj4gKyAgICAgICAgKihwYXJzZXItPnN0YXJ0X2FkZHIpID0gKCgobGluZS0+
ZGF0YVswXSA8PCA4KSB8IGxpbmUtPmRhdGFbMV0pIDw8IDQpIHwKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAobGluZS0+ZGF0YVsyXSA8PCA4KSB8IGxpbmUtPmRhdGFbM107Cj4g
KyAgICAgICAgYnJlYWs7Cj4gIAo+ICAgICAgY2FzZSBTVEFSVF9MSU5FQVJfQUREUl9SRUNPUkQ6
Cj4gICAgICAgICAgaWYgKGxpbmUtPmJ5dGVfY291bnQgIT0gNCAmJiBsaW5lLT5hZGRyZXNzICE9
IDApIHsKPiAtLSAKPiAyLjE3LjEK
