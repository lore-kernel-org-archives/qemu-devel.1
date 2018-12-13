Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXQJl-0004Hi-Da
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gXQJg-00083M-AE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:17 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 13 Dec 2018 12:42:07 +0000
Message-ID: <afc020d9-b3be-21b6-764c-a4a2fb1a7cd1@virtuozzo.com>
References: <20181213015013.15350-1-jsnow@redhat.com>
	<20181213015013.15350-5-jsnow@redhat.com>
In-Reply-To: <20181213015013.15350-5-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB1818DE58FFEB4CB1B86E2347F95E17@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/7] iotests.py: don't abort if
 IMGKEYSECRET is undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

MTMuMTIuMjAxOCA0OjUwLCBKb2huIFNub3cgd3JvdGU6DQo+IEluc3RlYWQgb2YgdXNpbmcgb3Mu
ZW52aXJvbltdLCB1c2UgLmdldCB3aXRoIGEgZGVmYXVsdCBvZiBlbXB0eSBzdHJpbmcNCj4gdG8g
bWF0Y2ggdGhlIHNldHVwIGluIGNoZWNrIHRvIGFsbG93IHVzIHRvIGltcG9ydCB0aGUgaW90ZXN0
cyBtb2R1bGUNCj4gKGZvciBkZWJ1Z2dpbmcsIHNheSkgd2l0aG91dCBuZWVkaW5nIGEgY3JhZnRl
ZCBlbnZpcm9ubWVudCBqdXN0IHRvDQo+IGltcG9ydCB0aGUgbW9kdWxlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoN
Cj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgfCAyICstDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgYi90ZXN0cy9xZW11LWlvdGVzdHMv
aW90ZXN0cy5weQ0KPiBpbmRleCBkNTM3NTM4YmEwLi5hMzRlNjY4MTNhIDEwMDY0NA0KPiAtLS0g
YS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvaW90ZXN0cy5weQ0KPiBAQCAtNjMsNyArNjMsNyBAQCBzb2NrZXRfc2NtX2hlbHBlciA9IG9z
LmVudmlyb24uZ2V0KCdTT0NLRVRfU0NNX0hFTFBFUicsICdzb2NrZXRfc2NtX2hlbHBlcicpDQo+
ICAgZGVidWcgPSBGYWxzZQ0KPiAgIA0KPiAgIGx1a3NfZGVmYXVsdF9zZWNyZXRfb2JqZWN0ID0g
J3NlY3JldCxpZD1rZXlzZWMwLGRhdGE9JyArIFwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgb3MuZW52aXJvblsnSU1HS0VZU0VDUkVUJ10NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgb3MuZW52aXJvbi5nZXQoJ0lNR0tFWVNFQ1JFVCcsICcnKQ0KPiAgIGx1a3NfZGVm
YXVsdF9rZXlfc2VjcmV0X29wdCA9ICdrZXktc2VjcmV0PWtleXNlYzAnDQo+ICAgDQo+ICAgDQo+
IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
