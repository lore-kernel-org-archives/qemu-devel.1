Received: from eggs.gnu.org ([209.51.188.92]:45798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnPv-0000sX-ON
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Janakarajan.Natarajan@amd.com>) id 1hJnK0-0000R4-JB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:29 -0400
Received: from mail-eopbgr730086.outbound.protection.outlook.com
	([40.107.73.86]:18512
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Janakarajan.Natarajan@amd.com>)
	id 1hJnK0-0008Tp-9i
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:58:28 -0400
From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Date: Thu, 25 Apr 2019 22:58:18 +0000
Message-ID: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 0/3] Add RAM block encrypted notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>

Q3VycmVudGx5LCB0aGUgU0VWIGd1ZXN0IGxhdW5jaCByZWdpc3RlcnMgdG8gYSBSQU0gYmxvY2sg
bm90aWZpZXIuIFdoZW4NCmNhbGxlZCwgd2UgaXNzdWUgS1ZNX01FTU9SWV9FTkNSWVBUX3tSRUcs
VU5SRUd9X1JFR0lPTiBpb2N0bCB0byByZWdpc3Rlcg0KdGhlIG1lbW9yeSB3aXRoIHRoZSBLVk0g
ZHJpdmVyLiBUaGVzZSBpb2N0bHMgc2hvdWxkIGJlIGNhbGxlZCBvbmx5IGZvcg0KdGhlIHJlZ2lv
biB3aGljaCBjb250YWlucyB0aGUgZW5jcnlwdGVkIGRhdGEgYnV0IHRoZSBSQU0gYmxvY2sgbm90
aWZpZXINCmdldHMgY2FsbGVkIGZvciBhbnkgbWVtb3J5IHJlZ2lvbiBhbGxvY2F0ZWQgZHVyaW5n
IHRoZSBndWVzdCBjcmVhdGlvbi4NClNvbWUgb2YgdGhvc2UgbWVtb3J5IHJlZ2lvbnMgZG8gbm90
IGNvbnRhaW4gZW5jcnlwdGVkIGRhdGEgc28gd2UgZW5kIHVwDQpjYWxsaW5nIHRoZSBpb2N0bCBm
b3IgYSBtZW1vcnkgcmVnaW9uIHdoaWNoIGNvbnRhaW5zIHVuZW5jcnlwdGVkIGRhdGENCihlLmcu
IHZnYSBSQU0gZXRjLikuDQoNCkluIGNhc2Ugb2YgU0VWLCBvbmx5IHRoZSBndWVzdCBSQU0gYW5k
IHBmbGFzaCB1bml0PTAgY29udGFpbiB0aGUNCmVuY3J5cHRlZCBkYXRhLiBUbyBzb2x2ZSB0aGlz
IHByb2JsZW0sIHdlIGludHJvZHVjZSBhIG5ldyBub3RpZmllciAoUkFNDQpibG9jayBlbmNyeXB0
ZWQpLiBJZiBhIG1lbW9yeSByZWdpb24gd2lsbCBjb250YWluIGVuY3J5cHRlZCBkYXRhIHRoZW4N
CnRoZSBjYWxsZXIgY2FuIHVzZSBtZW1vcnlfcmVnaW9uX21hcmtfZW5jcnlwdGVkKCkgdG8gc2V0
IHRoZSBtZW1vcnkNCnJlZ2lvbiBhcyBlbmNyeXB0ZWQuIENsaWVudHMgY2FuIHJlZ2lzdGVyIHRv
IHRoZSBSQU0gYmxvY2sgZW5jcnlwdGVkDQpub3RpZmllciBhbmQgdGhleSB3aWxsIGJlIGNhbGxl
ZCB3aGVuIGEgbWVtb3J5IHJlZ2lvbiBpcyBzZXQgZW5jcnlwdGVkLg0KDQpKYW5ha2FyYWphbiBO
YXRhcmFqYW4gKDMpOg0KICByYW0tZW5jcnlwdGVkLW5vdGlmaWVyOiBJbnRyb2R1Y2UgYSBSQU0g
YmxvY2sgZW5jcnlwdGVkIG5vdGlmaWVyDQogIGh3OiBOb3RpZnkgbGlzdGVuZXJzIGFib3V0IGd1
ZXN0IHBhZ2VzIHdoaWNoIGNvbnRhaW4gZW5jcnlwdGVkIGRhdGENCiAgc2V2OiBDaGFuZ2UgU0VW
IHRvIHVzZSBFbmNyeXB0ZWRSQU1CbG9jayBOb3RpZmllcg0KDQogZXhlYy5jICAgICAgICAgICAg
ICAgICB8ICA2ICsrKysrKw0KIGh3L2kzODYvcGMuYyAgICAgICAgICAgfCAgMSArDQogaHcvaTM4
Ni9wY19zeXNmdy5jICAgICB8ICAyICsrDQogaHcvbWVtL21lbW9yeS1kZXZpY2UuYyB8ICAxICsN
CiBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggIHwgMTggKysrKysrKysrKysrKysrKysrDQogaW5jbHVk
ZS9leGVjL3JhbWxpc3QuaCB8IDE5ICsrKysrKysrKysrKysrKysrKysNCiBtZW1vcnkuYyAgICAg
ICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKw0KIG51bWEuYyAgICAgICAgICAgICAgICAg
fCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBzdHVicy9yYW0tYmxvY2su
YyAgICAgIHwgIDggKysrKysrKysNCiB0YXJnZXQvaTM4Ni9zZXYuYyAgICAgIHwgMjUgKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLQ0KIDEwIGZpbGVzIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCsp
LCAxNyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIwLjENCg0K
