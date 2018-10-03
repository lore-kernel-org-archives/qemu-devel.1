Received: from eggs.gnu.org ([2001:4830:134:3::10]:42134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7mAr-00073H-EM
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7mAo-0002TX-My
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 14:47:05 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 18:46:58 +0000
Message-ID: <0a5861c8-c413-79e4-0b94-2e065981ddab@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-19-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-19-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D9BD90FA788CE488F3D0DD9BD3C4DA5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 18/18] block/backup: use fleecing-hook
 instead of write notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDEuMTAuMjAxOCAxMzoyOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
RHJvcCB3cml0ZSBub3RpZmllcnMgYW5kIHVzZSBmaWx0ZXIgbm9kZSBpbnN0ZWFkLiBDaGFuZ2Vz
Og0KPg0KPiAxLiBjb3B5LWJlZm9yZS13cml0ZXMgbm93IGhhbmRsZWQgYnkgZmlsdGVyIG5vZGUs
IHNvLCBkcm9wIGFsbA0KPiAgICAgaXNfd3JpdGVfbm90aWZpZXIgYXJndW1lbnRzLg0KPg0KPiAy
LiB3ZSBkb24ndCBoYXZlIGludGVyc2VjdGluZyByZXF1ZXN0cywgc28gdGhlaXIgaGFuZGxpbmcg
aXMgZHJvcHBlZC4NCj4gSW5zdGVhZCwgc3luY2hyb25pemF0aW9uIHdvcmtzIGFzIGZvbGxvd3M6
DQo+IHdoZW4gYmFja3VwIG9yIGZsZWVjaW5nLWhvb2sgc3RhcnRzIGNvcHlpbmcgb2Ygc29tZSBh
cmVhIGl0IGZpcnN0bHkNCj4gY2xlYXJzIGNvcHktYml0bWFwIGJpdHMsIGFuZCBub2JvZHkgdG91
Y2hlcyBhcmVhcywgbm90IG1hcmtlZCB3aXRoDQo+IGRpcnR5IGJpdHMgaW4gY29weS1iaXRtYXAs
IHNvIHRoZXJlIG5vIGludGVyc2VjdGlvbi4gQWxzbywgcmVhZA0KPiByZXF1ZXN0cyBhcmUgbWFy
a2VkIHNlcmlhbGl6aW5nLCB0byBub3QgaW50ZXJmZXIgd2l0aCBndWVzdCB3cml0ZXMgYW5kDQo+
IG5vdCByZWFkIGNoYW5nZWQgZGF0YSBmcm9tIHNvdXJjZSAoYmVmb3JlIHJlYWRpbmcgd2UgY2xl
YXINCj4gY29ycmVzcG9uZGluZyBiaXQgaW4gY29weS1iaXRtYXAsIHNvLCB0aGlzIGFyZWEgaXMg
bm90IG1vcmUgaGFuZGxlZCBieQ0KPiBmbGVlY2luZy1ob29rKS4NCj4NCj4gMy4gVG8gc3luYyB3
aXRoIGluLWZsaWdodCByZXF1ZXN0cyB3ZSBubyBqdXN0IGRyYWluIGhvb2sgbm9kZSwgd2UgZG9u
J3QNCj4gbmVlZCBydy1sb2NrLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPg0KDQpUaGVy
ZSBpcyBhIHByb2JsZW0gaW4gdGhpcyBwYXRjaDogdG8gYmUgc3VyZSwgdGhhdCBpZiBiYWNrdXAg
am9iIHN0YXJ0ZWQgDQp0byByZWFkIGZyb20gc291cmNlLCBndWVzdCB3aWxsIG5vdCB3cml0ZSB0
byB0aGUgYXJlYSwgSSB1c2UNCjEuIGRpcnR5IGJpdG1hcDogaWYgaXQgaXMgc2V0IHRoaXMgbWVh
bnMgdGhlcmUgbXVzdCBub3QgYmUgYW55IGluIGZsaWdodCANCndyaXRlIHJlcXVlc3RzIG9uIHNv
dXJjZSBvbiB0aGlzIHJlZ2lvbg0KMi4gc2VyaWFsaXplZCByZWFkOiB3ZSBzdGFydCBpdCwgc28g
dW50aWwgaXQgZmluaXNoZXMgbm9ib2R5IHdyaXRlcw0KDQpCdXQgYmFja3VwIG1heSByZXN0YXJ0
IGNvcHkgb3BlcmF0aW9uIGlmIGl0IGZhaWxlZC4gQW5kIG9mIGNvdXJzZSwgDQpzZWNvbmQgdHJ5
IG9mIHJlYWQgbWF5IGFwcGVhciBhZnRlciBndWVzdCB3cml0ZS4uIEkgc2VlIHRoZSBmb2xsb3dp
bmcgDQp3YXkgdG8gZml4Og0KDQpkb24ndCByZXRyeSB0aGUgd2hvbGUgb3BlcmF0aW9uLCBidXQg
b25seSByZWFkLiBUaGVuIGFsbCB0aGVyZSByZWFkcyANCndpbGwgYmUgc2VyaWFsaXplZCBhbmQg
bm8geWllbGQgcG9pbnQgYmV0d2VlbiB0aGVtLCBzbywgZ3Vlc3QgY2FuJ3QgDQp3cml0ZSB1bnRp
bCB3ZSBmaW5pc2guLg0KDQppbiB0aGUgc2FtZSB0aW1lLCByZXRyeWluZyBvZiBjb3B5X3Jhbmdl
KCkgb3BlcmF0aW9uIHNob3VsZCBiZSBPSyBhcyBpcywgDQphcyBpdCBrZWVwcyByZWFkIHNlcmlh
bGl6ZWQgcmVxdWVzdHMgZHVyaW5nIHRoZSB3aG9sZSBvcGVyYXRpb24uDQoNCnNvLCBhIGtpbmQg
b2YgcmVmYWN0b3JpbmcgbmVlZGVkIGhlcmUuDQoNCk9yLCBpcyBpdCBiZXR0ZXIgdG8gY3JlYXRl
IGV4dGVybmFsIGludGVyZmFjZSBmb3IgY3JlYXRpbmcgc2VyaWFsaXplZCANCnJlcXVlc3RzPyBz
b21ldGhpbmcgbGlrZSBiZHJ2X2NvX3BibG9ja3dyaXRlLCB3aGljaCB3aWxsIGJsb2NrIHdyaXRl
cyBvbiANCnRoaXMgcmVnaW9uLCBieSBjcmVhdGluZyBzcGVjaWFsIHNlcmlhbGl6ZWQgcmVxdWVz
dCwgdW50aWwgcGFpcmVkIA0KYmRydl9jb19wdW5ibG9ja3dyaXRlKCk/DQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg0K
