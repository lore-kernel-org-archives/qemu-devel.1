Received: from eggs.gnu.org ([2001:4830:134:3::10]:53674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fjCd7-0003Rl-Ft
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 19:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1fjCd6-0007uH-LP
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 19:58:41 -0400
Date: Sat, 28 Jul 2018 07:58:17 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <0c2c23f3-5ec9-5446-17ca-683d267d0f4c@amsat.org>
References: <20180725085944.11856-1-stefanha@redhat.com>
	<20180725085944.11856-8-stefanha@redhat.com>
	<0c2c23f3-5ec9-5446-17ca-683d267d0f4c@amsat.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6c1020b8.17461.164de2dc109.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 7/7] Add QTest testcase for
 the Intel Hexadecimal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?philippe_mathieu-daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, peter.maydell@linaro.org, alistair@alistair23.me, sundeep.lkml@gmail.com, qemu.ml@steffen-goertz.de, joel@jms.id.au, jusual@mail.ru, qemu-arm@nongnu.org, jim@groklearning.com, mail@steffen-goertz.de, ilg@livius.net

PiA+ICsjZGVmaW5lIEJJTl9TSVpFIDE0Ngo+ID4gKwo+ID4gK3N0YXRpYyB1bnNpZ25lZCBjaGFy
IHByZV9zdG9yZVtCSU5fU0laRV0gPSB7Cj4gPiArICAgIDQsICAgMjA4LCAxNTksIDIyOSwgMjIs
ICAwLCAgIDAsICAgMjM1LCAyNTQsIDI1NSwgMjU1LCAyMzQsIDE1MiwgMTYsICAxLAo+ID4gKyAg
ICAwLCAgIDQsICAgMTc2LCA0NSwgIDIyOSwgMCwgICAxNzYsIDE0MSwgMjI2LCAxMiwgIDIwOCwg
NzcsICAyMjYsIDgsICAgMCwKPiA+ICsgICAgMTEsICAyMjksIDYsICAgMCwgICAwLCAgIDIzNCwg
OCwgICA0OCwgIDI3LCAgMjI5LCAwLCAgIDMyLCAgMjExLCAyMjksIDQ0LAo+ID4gKyAgICA0OCwg
IDE1OSwgMjI5LCAwLCAgIDMyLCAgMTMxLCAyMjksIDgsICAgNDgsICAyNywgIDIyOSwgMSwgICA0
OCwgIDEzMSwgMjI2LAo+ID4gKyAgICA4LCAgIDQ4LCAgMTEsICAyMjksIDgsICAgNDgsICAyNywg
IDIyOSwgMCwgICA0OCwgIDIxMSwgMjI5LCAwLCAgIDAsICAgODMsCj4gPiArICAgIDIyNywgMjQ0
LCAyNTUsIDI1NSwgMjYsICAwLCAgIDAsICAgMTYwLCAyMjUsIDAsICAgMjA4LCAxMzksIDIyNiwg
NCwgICAxNzYsCj4gPiArICAgIDE1NywgMjI4LCAzMCwgIDI1NSwgNDcsICAyMjUsIDAsICAgMTYs
ICAzMSwgIDE2LCAgMCwgICA3MiwgIDQ1LCAgMjMzLCA0LAo+ID4gKyAgICAxNzYsIDE0MSwgMjI2
LCA4LCAgIDAsICAgMTU5LCAyMjksIDIzMCwgMjU1LCAyNTUsIDIzNSwgMCwgICAwLCAgIDE2MCwg
MjI1LAo+ID4gKyAgICAwLCAgIDEzNiwgMTg5LCAyMzIsIDEzMiwgMCwgICAxLCAgIDAsICAgMCwg
ICAxNiwgIDMxLCAgMTYsICA3MiwgIDEwMSwgMTA4LAo+ID4gKyAgICAxMDgsIDExMSwgMzIsICAx
MTksIDExMSwgMTE0LCAxMDgsIDEwMCwgMzMsICAxMCwgIDB9Owo+IAo+IENhbiB0aGlzIGJlOgo+
IAo+ICAgMHgwNCwgMHhkMCwgMHg5ZiwgMHhlNSwgICAweDE2LCAweDAwLCAweDAwLCAweGViLCAg
IDB4ZmUsIDB4ZmYsIDB4ZmYsCj4gMHhlYSwKPiAgIDB4OTgsIDB4MTAsIDB4MDEsIDB4MDAsICAg
MHgwNCwgMHhiMCwgMHgyZCwgMHhlNSwgICAweDAwLCAweGIwLCAweDhkLAo+IDB4ZTIsCj4gICAw
eDBjLCAweGQwLCAweDRkLCAweGUyLCAgIDB4MDgsIDB4MDAsIDB4MGIsIDB4ZTUsICAgMHgwNiwg
MHgwMCwgMHgwMCwKPiAweGVhLAo+ICAgMHgwOCwgMHgzMCwgMHgxYiwgMHhlNSwgICAweDAwLCAw
eDIwLCAweGQzLCAweGU1LCAgIDB4MmMsIDB4MzAsIDB4OWYsCj4gMHhlNSwKPiAgIDB4MDAsIDB4
MjAsIDB4ODMsIDB4ZTUsICAgMHgwOCwgMHgzMCwgMHgxYiwgMHhlNSwgICAweDAxLCAweDMwLCAw
eDgzLAo+IDB4ZTIsCj4gICAweDA4LCAweDMwLCAweDBiLCAweGU1LCAgIDB4MDgsIDB4MzAsIDB4
MWIsIDB4ZTUsICAgMHgwMCwgMHgzMCwgMHhkMywKPiAweGU1LAo+ICAgMHgwMCwgMHgwMCwgMHg1
MywgMHhlMywgICAweGY0LCAweGZmLCAweGZmLCAweDFhLCAgIDB4MDAsIDB4MDAsIDB4YTAsCj4g
MHhlMSwKPiAgIDB4MDAsIDB4ZDAsIDB4OGIsIDB4ZTIsICAgMHgwNCwgMHhiMCwgMHg5ZCwgMHhl
NCwgICAweDFlLCAweGZmLCAweDJmLAo+IDB4ZTEsCj4gICAweDAwLCAweDEwLCAweDFmLCAweDEw
LCAgIDB4MDAsIDB4NDgsIDB4MmQsIDB4ZTksICAgMHgwNCwgMHhiMCwgMHg4ZCwKPiAweGUyLAo+
ICAgMHgwOCwgMHgwMCwgMHg5ZiwgMHhlNSwgICAweGU2LCAweGZmLCAweGZmLCAweGViLCAgIDB4
MDAsIDB4MDAsIDB4YTAsCj4gMHhlMSwKPiAgIDB4MDAsIDB4ODgsIDB4YmQsIDB4ZTgsICAgMHg4
NCwgMHgwMCwgMHgwMSwgMHgwMCwgICAweDAwLCAweDEwLCAweDFmLAo+IDB4MTAsCj4gICAnSCcs
ICAnZScsICAnbCcsICAnbCcsICAgICdvJywgICcgJywgICd3JywgICdvJywgICAgJ3InLCAgJ2wn
LCAgJ2QnLCAgJyEnLAo+ICAgJ1xuJywgJ1wwJwo+IH07Cj4gCj4gPwoKWWVzLCBnb29kIHN1Z2dl
c3Rpb24uIFlvdXIgdmVyc2lvbiBpcyBjbGVhcmVyIGFuZCBtb3JlIHJlYWRhYmxlIGZvciBodW1h
bnMuCgpCZXN0LApTdSBIYW5n
