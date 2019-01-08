Received: from eggs.gnu.org ([209.51.188.92]:52352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ggrhe-0001G4-LR
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ggrhZ-0008HB-G0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:45:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 8 Jan 2019 13:45:31 +0000
Message-ID: <872d42b0-c794-c104-30a9-fa1296f812d6@virtuozzo.com>
References: <1546200557-774583-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1546200557-774583-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1546200557-774583-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F289CA49462F9F4DA5B8C7409B6BCCAF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 1/6] Stream block job involves
 copy-on-read filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

MzAuMTIuMjAxOCAyMzowOSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBjb3B5LW9u
LXJlYWQgZmlsdGVyIGlzIGFwcGxpZWQgdG8gYmxvY2stc3RyZWFtIG9wZXJhdGlvbi4NCj4gSXQg
aXMgbmVjZXNzYXJ5IGZvciBmdXJ0aGVyIGJsb2NrIGRpc2NhcmQgb3B0aW9uLg0KDQpJZiB3ZSBt
b3ZlIHRvIGMtby1yIGZpbHRlciBpbiBzdHJlYW0sIEkgdGhpbmsgd2Ugc2hvdWxkOg0KMS4gZ2V0
IHJpZCBvZiBDT1BZX09OX1JFQUQgZmxhZyBpbiBzdHJlYW0gY29kZSAoc28sIHRoaXMgdGhpbmcg
dG8gYmUgZG9uZSBpbiBvbmUgcGxhY2UpDQoyLiBhZGQgYmFzZSBwYXJhbWV0ZXIgdG8gYy1vLXIg
ZmlsdGVyLCB0byBub3QgY29weSB0aGluZ3MgdGhhdCBhcmUgYmVsb3cgYmFzZS4NCg0KQ3VycmVu
dCBiZWhhdmlvciBvZiBzdHJlYW0gaXMgZW5hYmxpbmcgY29weS1vbi1yZWFkIG9uIGJzIGR1cmlu
ZyBzdHJlYW0gaWYgYmFzZSA9PSBOVUxMLg0KU28sIGlmIHdlIGp1c3QgYWRkIGMtby1yIGZpbHRl
ciwgd2Ugd2lsbCBjb3B5IGV4dHJhIGJsb2Nrcy4gT24gdGhlIG90aGVyIGhhbmQsIGlmIHdlDQpz
dXBwb3J0IGJhc2UgcGFyYW1ldGVyIGluIGMtby1yIGZpbHRlciB3ZSB3aWxsIGludm9sdmUgZ3Vl
c3QgcmVhZHMgdG8gdGhlIHN0cmVhbQ0KcHJvY2VzcyBmb3IgY2FzZXMgd2l0aCBiYXNlICE9IE5V
TEwsIHNvIHN0cmVhbSBvcGVyYXRpb24gc2hvdWxkIGJlY29tZSBtb3JlIGVmZmljaWVudC4NCg0K
U28gZm9yIG1lIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2Ugc2VlbXMgcmVhc29uYWJsZToNCg0KLSBw
cmVwYXJlIGlvdGVzdHMgZm9yIGdyYXBoIGNoYW5nZXMNCi0gYWRkIGJhc2UgcGFyYW1ldGVyIHRv
IGMtby1yIGZpbHRlcg0KLSB1c2UgYy1vLXIgaW4gc3RyZWFtIGFuZCBkcm9wIENPUFlfT05fUkVB
RCBmbGFnIGZyb20gc3RyZWFtIGNvZGUNCg0KdGhlbiAobWF5IGJlIGluIHNlcGFyYXRlIHNlcmll
cykgYWRkIGRpc2NhcmQgZnVuY3Rpb25hbGl0eS4gQW5kIGxvb2tzIGxpa2UgYWdhaW4sIGl0IHNo
b3VsZA0KYmUgcHJvcGVydHkgb2YgYy1vLXIgZmlsdGVyLCBub3Qgc3RyZWFtIGpvYiBpdHNlbGYs
IHRvIGludm9sdmUgZ3Vlc3QgcmVhZHMgdG8gZGlzY2FyZGluZyB0b28uDQoNCkluIGdlbmVyYWws
IE1heCwgaXMgdGhhdCBjb3JyZXNwb25kIHRvIHdoYXQgeW91IG1lYW4/DQoNCkFueSBzdWdnZXN0
aW9ucz8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
