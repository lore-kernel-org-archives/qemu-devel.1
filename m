Received: from eggs.gnu.org ([2001:4830:134:3::10]:55266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangxinxin.wang@huawei.com>) id 1d1Z6n-0007zX-0r
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangxinxin.wang@huawei.com>) id 1d1Z6j-0005fg-1n
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:00:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3454
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangxinxin.wang@huawei.com>) id 1d1Z6i-0005eI-EJ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:00:20 -0400
From: "wangxin (U)" <wangxinxin.wang@huawei.com>
Date: Fri, 21 Apr 2017 14:00:05 +0000
Message-ID: <8ADDA2EB7601DA429B6B2A43EF4620A55B575661@DGGEMA503-MBS.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [BUG]pcibus_reset assertion failure on guest reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

UWVtdS0yLjYuMg0KDQpTdGFydCBhIHZtIHdpdGggdmhvc3QtbmV0ICwgZG8gcmVib290IGFuZCBo
b3QtdW5wbHVnIHZpcml0aW8tbmV0IG5pYyBpbiBzaG9ydCB0aW1lLCB3ZSB0b3VjaCANCnBjaWJ1
c19yZXNldCBhc3NlcnRpb24gZmFpbHVyZS4NCg0KSGVyZSBpcyBxZW11IGxvZzoNCjIyOjI5OjQ2
LjM1OTM4NiswODowMCAgYWNwaV9wbTFfY250X3dyaXRlIC0+IGd1ZXN0IGRvIHNvZnQgcG93ZXIg
b2ZmDQoyMjoyOTo0Ni43ODUzMTArMDg6MDAgIHFlbXVfZGV2aWNlc19yZXNldA0KMjI6Mjk6NDYu
Nzg4MDkzKzA4OjAwICB2aXJ0aW9fcGNpX2RldmljZV91bnBsdWdnZWQgLT4gdmlydGlvIG5ldCB1
bnBsdWdlZA0KMjI6Mjk6NDYuODAzNDI3KzA4OjAwICBwY2lidXNfcmVzZXQ6IEFzc2VydGlvbiBg
YnVzLT5pcnFfY291bnRbaV0gPT0gMCcgZmFpbGVkLg0KDQpIZXJlIGlzIHN0YWNrIGluZm86IA0K
KGdkYikgYnQNCiMwICAweDAwMDA3ZjlhMzM2Nzk1ZDcgaW4gcmFpc2UgKCkgZnJvbSAvdXNyL2xp
YjY0L2xpYmMuc28uNg0KIzEgIDB4MDAwMDdmOWEzMzY3YWNjOCBpbiBhYm9ydCAoKSBmcm9tIC91
c3IvbGliNjQvbGliYy5zby42DQojMiAgMHgwMDAwN2Y5YTMzNjcyNTQ2IGluIF9fYXNzZXJ0X2Zh
aWxfYmFzZSAoKSBmcm9tIC91c3IvbGliNjQvbGliYy5zby42DQojMyAgMHgwMDAwN2Y5YTMzNjcy
NWYyIGluIF9fYXNzZXJ0X2ZhaWwgKCkgZnJvbSAvdXNyL2xpYjY0L2xpYmMuc28uNg0KIzQgIDB4
MDAwMDAwMDAwMDY0MTg4NCBpbiBwY2lidXNfcmVzZXQgKHFidXM9MHgyOWVlZTYwKSBhdCBody9w
Y2kvcGNpLmM6MjgzDQojNSAgMHgwMDAwMDAwMDAwNWJmYzMwIGluIHFidXNfcmVzZXRfb25lIChi
dXM9MHgyOWVlZTYwLCBvcGFxdWU9PG9wdGltaXplZCBvdXQ+KSBhdCBody9jb3JlL3FkZXYuYzoz
MTkNCiM2ICAweDAwMDAwMDAwMDA1YzFiMTkgaW4gcWRldl93YWxrX2NoaWxkcmVuIChkZXY9MHgy
OWVkMmIwLCBwcmVfZGV2Zm49MHgwLCBwcmVfYnVzZm49MHgwLCBwb3N0X2RldmZuPTB4NWMyNDQw
IC4uLg0KIzcgIDB4MDAwMDAwMDAwMDVjMWM1OSBpbiBxYnVzX3dhbGtfY2hpbGRyZW4gKGJ1cz0w
eDI3MzZmODAsIHByZV9kZXZmbj0weDAsIHByZV9idXNmbj0weDAsIHBvc3RfZGV2Zm49MHg1YzI0
NDAgLi4uDQojOCAgMHgwMDAwMDAwMDAwNTUxM2Y1IGluIHFlbXVfZGV2aWNlc19yZXNldCAoKSBh
dCB2bC5jOjE5OTgNCiM5ICAweDAwMDAwMDAwMDA0Y2FiOWQgaW4gcGNfbWFjaGluZV9yZXNldCAo
KSBhdCAvaG9tZS9hYnVpbGQvcnBtYnVpbGQvQlVJTEQvcWVtdS1rdm0tMi42LjAvaHcvaTM4Ni9w
Yy5jOjE5NzYNCiMxMCAweDAwMDAwMDAwMDA1NTE0OGIgaW4gcWVtdV9zeXN0ZW1fcmVzZXQgKHJl
cG9ydD1yZXBvcnRAZW50cnk9dHJ1ZSkgYXQgdmwuYzoyMDExDQojMTEgMHgwMDAwMDAwMDAwNTUx
NjRmIGluIG1haW5fbG9vcF9zaG91bGRfZXhpdCAoKSBhdCB2bC5jOjIxNjkNCiMxMiAweDAwMDAw
MDAwMDA1NTE3MTkgaW4gbWFpbl9sb29wICgpIGF0IHZsLmM6MjIxMg0KIzEzIDB4MDAwMDAwMDAw
MDQxYzlhOCBpbiBtYWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj08b3B0aW1pemVkIG91
dD4sIGVudnA9PG9wdGltaXplZCBvdXQ+KSBhdCB2bC5jOjUxMzANCihnZGIpIGYgNA0KLi4uDQoo
Z2RiKSBwIGJ1cy0+aXJxX2NvdW50WzBdDQokNiA9IDENCg0KU2VlbXMgcGNpX3VwZGF0ZV9pcnFf
ZGlzYWJsZWQgZG9lc24ndCB3b3JrIHdlbGwNCg0KY2FuIGFueW9uZSBoZWxwPw0K
