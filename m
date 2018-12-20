Received: from eggs.gnu.org ([2001:4830:134:3::10]:38086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZuqs-0004yB-LP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZuqr-0006Xp-VO
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:42:46 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 20 Dec 2018 09:42:38 +0000
Message-ID: <4adea5be-9598-50be-79eb-74d5cc86cb99@virtuozzo.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-8-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-8-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E60F3EFDBFF0364D8CD3F4DD374DB5D0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 07/11] iotests: add qmp recursive
 sorting function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

MjAuMTIuMjAxOCA1OjI5LCBKb2huIFNub3cgd3JvdGU6DQo+IFB5dGhvbiBiZWZvcmUgMy42IGRv
ZXMgbm90IHNvcnQgZGljdGlvbmFyaWVzIChpbmNsdWRpbmcga3dhcmdzKS4NCj4gVGhlcmVmb3Jl
LCBwcmludGluZyBRTVAgb2JqZWN0cyBpbnZvbHZlcyBzb3J0aW5nIHRoZSBrZXlzIHRvIGhhdmUN
Cj4gYSBwcmVkaWN0YWJsZSBvcmRlcmluZyBpbiB0aGUgaW90ZXN0cyBvdXRwdXQuDQo+IA0KPiBI
b3dldmVyLCBpZiB3ZSB3YW50IHRvIHByZXR0eS1wcmludCBRTVAgb2JqZWN0cyBiZWluZyBzZW50
IHRvIHRoZQ0KPiBRRU1VIHByb2Nlc3MsIHdlIG5lZWQgdG8gYnVpbGQgdGhlIGVudGlyZSBjb21t
YW5kIGJlZm9yZSBsb2dnaW5nIGl0Lg0KPiBPcmRpbmFyaWx5LCB0aGlzIHdvdWxkIHRoZW4gaW52
b2x2ZSAiYXJndW1lbnRzIiBiZWluZyBzb3J0ZWQgYWJvdmUNCj4gImV4ZWN1dGUiLCB3aGljaCB3
b3VsZCBuZWNlc3NpdGF0ZSBhIHJhdGhlciB1Z2x5IGFuZCBoYXJkZXItdG8tcmVhZA0KPiBjaGFu
Z2UgdG8gbWFueSBpb3Rlc3RzIG91dHB1dHMuDQoNCkknbSB1bnN1cmUgYWJvdXQgd2hhdCBpdCBt
ZWFucyAnYnVpbGQgdGhlIGVudGlyZSBjb21tYW5kIGJlZm9yZSBsb2dnaW5nJy4NClt1cGQsIGFm
dGVyIGEgc2Vjb25kXQ0KYWhhLCBpdCdzIGFib3V0ICd7ImV4ZWN1dGUiOi4uLicgLT4geydleGVj
dXRlJzogLi4ufQ0KDQptYXkgYmUsIGJ1aWxkIHRoZSBlbnRpcmUgY29tbWFuZCBvYmplY3QgdG8g
YmUgcGFzc2VkIHRvIGpzb24uZHVtcHMsIG9yDQpsaWtlIHRoaXMgd291bGQgYmUgYmV0dGVyLCBp
ZiB5b3Ugd2FudC4NCg0KPiANCj4gVG8gZmFjaWxpdGF0ZSBwcmV0dHktcHJpbnRpbmcgQU5EIG1h
aW50YWluaW5nIHByZWRpY3RhYmxlIG91dHB1dCBBTkQNCj4gaGF2aW5nICJhcmd1bWVudHMiIHNv
cnQgYmVmb3JlICJleGVjdXRlIiwgYWRkIGEgY3VzdG9tIHNvcnQgZnVuY3Rpb24NCj4gdGhhdCB0
YWtlcyBhIGRpY3Rpb25hcnkgYW5kIHJlY3Vyc2l2ZWx5IGJ1aWxkcyBhbiBPcmRlcmVkRGljdCB0
aGF0DQo+IG1haW50YWlucyB0aGUgc3BlY2lmaWMga2V5IG9yZGVyIHdlIHdpc2ggdG8gc2VlIGlu
IGlvdGVzdHMgb3V0cHV0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93PGpzbm93QHJl
ZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==
