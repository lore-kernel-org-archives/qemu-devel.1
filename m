Received: from eggs.gnu.org ([2001:4830:134:3::10]:52145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gPJeu-0001zB-OU
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gPJU6-0000gI-Gd
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:47:29 -0500
Received: from m13-68.163.com ([220.181.13.68]:1746)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gPJU5-0000Yp-NR
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 22:47:26 -0500
Date: Wed, 21 Nov 2018 11:31:57 +0800 (CST)
From: =?GBK?B?wO7Hvw==?= <liq3ea@163.com>
In-Reply-To: <8e31bbc2-20c9-86b7-97f9-d4cc8fd35656@redhat.com>
References: <20181119154737.9840-1-liq3ea@163.com>
	<87bm6j8rvm.fsf@dusky.pond.sub.org>
	<8e31bbc2-20c9-86b7-97f9-d4cc8fd35656@redhat.com>
MIME-Version: 1.0
Message-ID: <169ff9e0.8b5b.16734530e0c.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, liq3ea@gmail.com

CgoKCgoKCgoKQXQgMjAxOC0xMS0yMSAwMzo1OToyOCwgIlBoaWxpcHBlIE1hdGhpZXUtRGF1ZKim
IiA8cGhpbG1kQHJlZGhhdC5jb20+IHdyb3RlOgo+SGkgTWFya3VzLCBMaS4KPgo+T24gMjAvMTEv
MTggMjA6MzQsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOgo+PiBMaSBRaWFuZyA8bGlxM2VhQDE2
My5jb20+IHdyaXRlczoKPj4gCj4+PiBBbmQgYWxzbyBkbyBzb21lIGNvZGUgY2xlYW51cC4KPj4+
IEEgbG90IG9mIHRoYW5rcyB0byBNYXJrdXMncyByZXZpZXcgYW5kIGFkdmljZS4KPj4+Cj4+PiBM
aSBRaWFuZyAoMyk6Cj4+PiAgICBmd19jZmc6IGZpeCAtYm9vdCBib290c3BsYXNoIGVycm9yIGNo
ZWNraW5nCj4+PiAgICBmd19jZmc6IGZpeCAtYm9vdCByZWJvb3QtdGltZW91dCBlcnJvciBjaGVj
a2luZwo+Pj4gICAgZndfY2ZnOiBtYWtlIHFlbXVfZXh0cmFfcGFyYW1zX2Z3IGxvY2FsbHkKPj4+
Cj4+PiAgIGh3L252cmFtL2Z3X2NmZy5jICAgICAgIHwgNjggKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+ICAgaW5jbHVkZS9zeXNlbXUvc3lzZW11LmggfCAgMSAt
Cj4+PiAgIHZsLmMgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0tCj4+PiAgIDMgZmlsZXMgY2hh
bmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNDEgZGVsZXRpb25zKC0pCj4+IAo+PiBmd19jZmcuYyBo
YXMgbm8gbWFpbnRhaW5lci4gIFdobyB3b3VsZCBiZSB3aWxsaW5nIHRvIG1lcmdlIHRoaXM/Cj4K
PkkgaGF2ZSB2YXJpb3VzIHBhdGNoZXMgZm9yIGZ3X2NmZyB3YWl0aW5nIDQuMCB0byBzdGFydCwg
b25lIGFkZCBhIAo+TUFJTlRBSU5FUlMgZW50cnkgY292ZXJlZCBieSBMYXN6bG8sIEdlcmQgYW5k
IG15c2VsZi4KCj4KCgpOaWNlLCB3aGVuIDQuMCB3aW5kb3cgb3Blbj8gSSBkb24ndCBmaW5kIHRo
ZSByZWxlYXNlIHBsYW5uaW5nLgpNYXliZSBteSBhbm90aGVyIGZ3X2NmZyBwYXRjaGVzIGNhbiBi
ZSBtZXJnZWQ6Ci0tPmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZl
bC8yMDE4LTExL21zZzAwMDA0Lmh0bWwKLS0+aHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUv
aHRtbC9xZW11LWRldmVsLzIwMTgtMTEvbXNnMDAwMDUuaHRtbAoKCkFsc28gSSd2ZSBwcmVwYXJl
ZCBzb21lIHF0ZXN0IHBhdGNoIGZvciBmd19jZmcuIAoKClBTOiBJJ20gcXVpdGUgc3VycHJpc2Ug
dGhlIHFlbXUncyB2ZXJzaW9uIHVwIHRvIDQgcXVpY2tseShhbnl3YXksIHRoZSAzLjEgaXMganVz
dCBiZWdpbikuLi4KCgpUaGFua3MsCkxpIFFpYW5nCgoKPlRoaXMgc2VyaWVzIHdhcyBwdWJsaXNo
ZWQgd2F5IGJlZm9yZSBzb2Z0IGZyZWV6ZSwgYnV0IEkgYW0gbm90IHN1cmUgaXQgCj5hcHBsaWVz
IGZvciBoYXJkIGZyZWV6ZS4gSWYgc28sIGl0IG1pZ2h0IGdvZXMgdGhydSBQYW9sbydzIE1pc2Mg
dHJlZSwgCgo+ZWxzZSB3ZSdsbCB0YWtlIGl0IGZvciA0LjAgKHZpYSBmd19jZmctbmV4dCkuCgoK
Pgo+UmVnYXJkcywKPgo+UGhpbC4K
