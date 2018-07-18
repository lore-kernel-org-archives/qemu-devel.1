Received: from eggs.gnu.org ([2001:4830:134:3::10]:57330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1fff6X-0002bv-8I
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 01:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1fff6T-0002kl-6h
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 01:34:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:30929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@intel.com>) id 1fff6S-0002cG-RI
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 01:34:21 -0400
From: "He, Junyan" <junyan.he@intel.com>
Date: Wed, 18 Jul 2018 05:34:09 +0000
Message-ID: <EC8A4E314CF1574AB62C80421BD98339340ABB30@SHSMSX104.ccr.corp.intel.com>
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
	<1531809130-31088-3-git-send-email-junyan.he@gmx.com>
	<5a3a6160-e7ed-0bfb-7f52-a067a9a0762f@linaro.org>
In-Reply-To: <5a3a6160-e7ed-0bfb-7f52-a067a9a0762f@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/7 V10] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, "junyan.he@gmx.com" <junyan.he@gmx.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhang, Yi Z" <yi.z.zhang@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

T0ssIEkgd2lsIGNoYW5nIGFsbCBmbGFncyB0byAzMmJpdHMNCkl0IGlzIGEgbGl0dGxlIHN0cmFu
Z2UgdGhhdCB0aGUgY29tcGlsZXIgZ2l2ZSBubyB3YXJuaW5nIHdoZW4gbG9zaW5nIHByZWNpc2lv
bi4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gW21haWx0bzpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnXSANClNlbnQ6IFdlZG5lc2Rh
eSwgSnVseSAxOCwgMjAxOCAxMjowMyBBTQ0KVG86IGp1bnlhbi5oZUBnbXguY29tOyBxZW11LWRl
dmVsQG5vbmdudS5vcmcNCkNjOiBlaGFia29zdEByZWRoYXQuY29tOyBpbWFtbWVkb0ByZWRoYXQu
Y29tOyBwYm9uemluaUByZWRoYXQuY29tOyBjcm9zdGh3YWl0ZS5wZXRlckBnbWFpbC5jb207IHhp
YW9ndWFuZ3JvbmcuZXJpY0BnbWFpbC5jb207IG1zdEByZWRoYXQuY29tOyBxdWludGVsYUByZWRo
YXQuY29tOyBkZ2lsYmVydEByZWRoYXQuY29tOyBzdGVmYW5oYUByZWRoYXQuY29tOyBaaGFuZywg
WWkgWiA8eWkuei56aGFuZ0BpbnRlbC5jb20+OyBIZSwgSnVueWFuIDxqdW55YW4uaGVAaW50ZWwu
Y29tPjsgSGFvemhvbmcgWmhhbmcgPGhhb3pob25nLnpoYW5nQGludGVsLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0ggMi83IFYxMF0gbWVtb3J5LCBleGVjOiBzd2l0Y2ggZmlsZSByYW0gYWxsb2Nh
dGlvbiBmdW5jdGlvbnMgdG8gJ2ZsYWdzJyBwYXJhbWV0ZXJzDQoNCk9uIDA3LzE2LzIwMTggMTE6
MzIgUE0sIGp1bnlhbi5oZUBnbXguY29tIHdyb3RlOg0KPiAgUkFNQmxvY2sgKnFlbXVfcmFtX2Fs
bG9jX2Zyb21fZmQocmFtX2FkZHJfdCBzaXplLCBNZW1vcnlSZWdpb24gKm1yLA0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBzaGFyZSwgaW50IGZkLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgcmFtX2ZsYWdzLCBpbnQgZmQsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApICB7DQo+ICAg
ICAgUkFNQmxvY2sgKm5ld19ibG9jazsNCj4gQEAgLTIyODAsMTQgKzIyODAsMTQgQEAgUkFNQmxv
Y2sgKnFlbXVfcmFtX2FsbG9jX2Zyb21fZmQocmFtX2FkZHJfdCBzaXplLCBNZW1vcnlSZWdpb24g
Km1yLA0KPiAgICAgIG5ld19ibG9jay0+bXIgPSBtcjsNCj4gICAgICBuZXdfYmxvY2stPnVzZWRf
bGVuZ3RoID0gc2l6ZTsNCj4gICAgICBuZXdfYmxvY2stPm1heF9sZW5ndGggPSBzaXplOw0KPiAt
ICAgIG5ld19ibG9jay0+ZmxhZ3MgPSBzaGFyZSA/IFJBTV9TSEFSRUQgOiAwOw0KPiArICAgIG5l
d19ibG9jay0+ZmxhZ3MgPSByYW1fZmxhZ3M7DQoNClRoZSB0eXBlIG9mICJmbGFncyIgd2l0aGlu
IFJBTUJsb2NrIGlzIHVpbnQzMl90Lg0KDQpZb3Ugc2hvdWxkIGVpdGhlciBjaGFuZ2UgdGhlIG1l
bWJlciB0eXBlIGluIHRoZSBzdHJ1Y3QsIG9yIGNoYW5nZSB0aGUgYXJndW1lbnQgdHlwZSBpbiBh
bGwgb2YgdGhlc2UgZnVuY3Rpb25zLg0KDQpNb3JlIGxpa2VseSB0aGUgbGF0dGVyLCBzaW5jZSB5
b3Ugc2VlbSB0byBoYXZlIGp1c3QgZml2ZSB1c2VkIGJpdHMgYXQgdGhlIG1vbWVudC4NCg0KDQpy
fg0K
