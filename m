Received: from eggs.gnu.org ([209.51.188.92]:40198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1gz3zd-0006YI-0u
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1gz3zc-0004Ph-1K
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:31:44 -0500
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Wed, 27 Feb 2019 18:30:10 +0000
Message-ID: <BN6PR21MB0785CB5DAEB34BB0F1C465E09E740@BN6PR21MB0785.namprd21.prod.outlook.com>
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9G73yrRvj3AdyxAi2uUBH9GPPerwi7y38oMDKw8F0B=A@mail.gmail.com>
	<CADYoBw2pm=j8QejJyC17MNye==gcyM1TgG=jN+0nGjgYJ0qkFQ@mail.gmail.com>
In-Reply-To: <CADYoBw2pm=j8QejJyC17MNye==gcyM1TgG=jN+0nGjgYJ0qkFQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Added periodic IRQ support for
 bcm2836_control local timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bzt <bztemail@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

PiBGcm9tOiBienQgPGJ6dGVtYWlsQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAyNyBG
ZWJydWFyeSAyMDE5IDAzOjU0DQo+IA0KPiBJJ2QgbGlrZSB0byBhZGQgbW9yZSBkcml2ZXJzIGZv
ciB0aGUgYmNtMjgzWzU2N10gdG9vLCBhbmQgdGhpcyBxdWVzdGlvbiBnb2VzIHRvDQo+IEFuZHJl
dyBCYXVtYW5uIG1vc3RseS4gSSd2ZSBzZWVuIGltcGxlbWVudGVkIHRob3NlIG1pc3NpbmcgZHJp
dmVycyBpbiBoaXMNCj4gcmVwbywgd2hpY2ggYXJlbid0IGluIHRoZSBxZW11IG1haW5saW5lIHll
dC4gSSBkb24ndCB3YW50IHRvIHJlaW52ZW50IHRoZSB3aGVlbCwNCj4gc28gSSdtIHdpbGxpbmcg
dG8gZml4IHRob3NlIGNsYXNzZXMgdG8gZ2V0IHRoZW0gcmlnaHQsIGJ1dCBJJ2QgbGlrZSB0byBr
bm93IHdoYXQncw0KPiB3cm9uZyB3aXRoIHRoZW0gaW4gdGhlIGZpcnN0IHBsYWNlLg0KDQpOb3Ro
aW5nJ3Mgd3Jvbmcgd2l0aCB0aGVtIHBlciBzZSwgYnV0IHdoZW4gSSB3YXMgd29ya2luZyBvbiB1
cHN0cmVhbWluZyB0aGUgcmFzcGkgYm9hcmQgSSBwcmlvcml0aXNlZCB0aGUgZGV2aWNlIHN1cHBv
cnQgbmVlZGVkIHRvIGJvb3QgTGludXggYW5kIFdpbmRvd3Mgb24gcmFzcGkyLiBUaGUgcmVtYWlu
aW5nIGRldmljZXMgd2VyZSBhbHdheXMgcGxhbm5lZCBmb3IgZXZlbnR1YWwgaW5jbHVzaW9uLCBi
dXQganVzdCBmZWxsIG9mZiB0aGUgZW5kIG9mIG15IFRPRE8gbGlzdC4gVGhleSBuZXZlciB3ZW50
IHRocm91Z2ggY29kZSByZXZpZXcgb24gcWVtdS1kZXZlbCwgc28gd291bGQgcHJvYmFibHkgbmVl
ZCBzb21lIHdvcmsgdG8gYnJpbmcgdGhlbSB1cCB0byBtb2Rlcm4gcWVtdSBBUElzIGFuZCBzdGFu
ZGFyZHMuDQoNCj4gSSdtIGludGVyZXN0ZWQgaW4gZml4aW5nIHRoZQ0KPiBUWVBFX0JDTTI4MzVf
UE9XRVIgYW5kIFRZUEVfQkNNMjgzNV9TVCBkcml2ZXJzLCB3aGljaCBJIGtub3cgbWFueQ0KPiBo
b3BweSBPUyBkZXZlbG9wZXJzIGxhY2sgYW5kIHdvdWxkIGltcHJvdmUgdGhlIHJhc3BpIGVtdWxh
dGlvbiBleHBlcmllbmNlDQo+IHJlbWFya2FibHkuDQoNClNvdW5kcyBnb29kIHRvIG1lISANCg0K
PiBJdCB3b3VsZCBiZSBzdGlsbCBhIGxvbmcgd2F5IHRvIGJvb3QgYSByYXNwYmlhbiBpbWFnZSwg
YnV0IHN0aWxsLCBhDQo+IHNtYWxsIHN0ZXAgdG93YXJkcyB0aGF0IGdvYWwgYXQgbGVhc3QuDQoN
ClRoYXQncyBpbnRlcmVzdGluZy4gUmFzcGJpYW4gZGlkIHNlZW0gdG8gYmUgd29ya2luZyAob24g
cGkyKSB3aGVuIEkgbGFzdCB3b3JrZWQgb24gdGhpcy4gUGVyaGFwcyBpdCBub3cgZGVwZW5kcyBv
biB0aGVzZSBkZXZpY2VzLCBidXQgZGlkbid0IGJlZm9yZT8NCg0KQ2hlZXJzLA0KQW5kcmV3DQo=
