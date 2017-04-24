Received: from eggs.gnu.org ([2001:4830:134:3::10]:42850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1d2XSh-0001gr-EJ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1d2XSe-0007jC-A7
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:27:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3517
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1d2XSd-0007fE-NG
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:27:00 -0400
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Mon, 24 Apr 2017 06:26:27 +0000
Message-ID: <EC9759BC1E3E98429B5DE9A03DF86D8B59D1084B@DGGEML503-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [BUG] Migrate failes between boards with different PMC
 counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SGkgYWxsLA0KDQpSZWNlbnRseSwgSSBmb3VuZCBtaWdyYXRpb24gZmFpbGVkIHdoZW4gZW5hYmxl
IHZQTVUuDQoNCm1pZ3JhdGUgdlBNVSBzdGF0ZSB3YXMgaW50cm9kdWNlZCBpbiBsaW51eC0zLjEw
ICsgcWVtdS0xLjcuDQoNCkFzIGxvbmcgYXMgZW5hYmxlIHZQTVUsIHFlbXUgd2lsbCBzYXZlIC8g
bG9hZCB0aGUNCnZtc3RhdGVfbXNyX2FyY2hpdGVjdHVyYWxfcG11KG1zcl9nbG9iYWxfY3RybCkg
cmVnaXN0ZXIgZHVyaW5nIHRoZSBtaWdyYXRpb24uDQpCdXQgZ2xvYmFsX2N0cmwgZ2VuZXJhdGVk
IGJhc2VkIG9uIGNwdWlkKDB4QSksIHRoZSBudW1iZXIgb2YgZ2VuZXJhbC1wdXJwb3NlIHBlcmZv
cm1hbmNlDQptb25pdG9yaW5nIGNvdW50ZXJzKFBNQykgY2FuIHZhcnkgYWNjb3JkaW5nIHRvIElu
dGVsIFNETi4gVGhlIG51bWJlciBvZiBQTUMgcHJlc2VudGVkDQp0byB2bSwgZG9lcyBub3Qgc3Vw
cG9ydCBjb25maWd1cmF0aW9uIGN1cnJlbnRseSwgaXQgZGVwZW5kIG9uIGhvc3QgY3B1aWQsIGFu
ZCBlbmFibGUgYWxsIHBtYw0KZGVmYXVsdGx5IGF0IEtWTS4gSXQgY2F1c2UgbWlncmF0aW9uIHRv
IGZhaWwgYmV0d2VlbiBib2FyZHMgd2l0aCBkaWZmZXJlbnQgUE1DIGNvdW50cy4NCg0KVGhlIHJl
dHVybiB2YWx1ZSBvZiBjcHVpZCAoMHhBKSBpcyBkaWZmZXJlbnQgZHVyIHRvIGNwdSwgYWNjb3Jk
aW5nIHRvIEludGVsIFNETqOsMTgtMTAgVm9sLiAzQjoNCg0KTm90ZTogVGhlIG51bWJlciBvZiBn
ZW5lcmFsLXB1cnBvc2UgcGVyZm9ybWFuY2UgbW9uaXRvcmluZyBjb3VudGVycyAoaS5lLiBOIGlu
IEZpZ3VyZSAxOC05KQ0KY2FuIHZhcnkgYWNyb3NzIHByb2Nlc3NvciBnZW5lcmF0aW9ucyB3aXRo
aW4gYSBwcm9jZXNzb3IgZmFtaWx5LCBhY3Jvc3MgcHJvY2Vzc29yIGZhbWlsaWVzLCBvcg0KY291
bGQgYmUgZGlmZmVyZW50IGRlcGVuZGluZyBvbiB0aGUgY29uZmlndXJhdGlvbiBjaG9zZW4gYXQg
Ym9vdCB0aW1lIGluIHRoZSBCSU9TIHJlZ2FyZGluZw0KSW50ZWwgSHlwZXIgVGhyZWFkaW5nIFRl
Y2hub2xvZ3ksIChlLmcuIE49MiBmb3IgNDUgbm0gSW50ZWwgQXRvbSBwcm9jZXNzb3JzOyBOID00
IGZvciBwcm9jZXNzb3JzDQpiYXNlZCBvbiB0aGUgTmVoYWxlbSBtaWNyb2FyY2hpdGVjdHVyZTsg
Zm9yIHByb2Nlc3NvcnMgYmFzZWQgb24gdGhlIFNhbmR5IEJyaWRnZQ0KbWljcm9hcmNoaXRlY3R1
cmUsIE4gPSA0IGlmIEludGVsIEh5cGVyIFRocmVhZGluZyBUZWNobm9sb2d5IGlzIGFjdGl2ZSBh
bmQgTj04IGlmIG5vdCBhY3RpdmUpLg0KDQpBbHNvIEkgZm91bmQsIE49OCBpZiBIVCBpcyBub3Qg
YWN0aXZlIGJhc2VkIG9uIHRoZSBicm9hZHdlbGyjrCwNCnN1Y2ggYXMgQ1BVIEU3LTg4OTAgdjQg
QCAyLjIwR0h6ICAgDQoNCiMgLi94ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14ODZfNjQgLS1l
bmFibGUta3ZtIC1zbXAgNCAtbSA0MDk2IC1oZGENCi9kYXRhL3p5eS90ZXN0X3FlbXUuaW1nLnNs
ZXMxMnNwMSAtdm5jIDo5OSAtY3B1IGt2bTY0LHBtdT10cnVlIC1pbmNvbWluZyB0Y3A6Ojg4ODgN
CkNvbXBsZXRlZCAxMDAgJQ0KcWVtdS1zeXN0ZW0teDg2XzY0OiBlcnJvcjogZmFpbGVkIHRvIHNl
dCBNU1IgMHgzOGYgdG8gMHg3MDAwMDAwZmYNCnFlbXUtc3lzdGVtLXg4Nl82NDogL2RhdGEvenl5
L2dpdC90ZXN0L3FlbXUvdGFyZ2V0L2kzODYva3ZtLmM6MTgzMzoga3ZtX3B1dF9tc3JzOiANCkFz
c2VydGlvbiBgcmV0ID09IGNwdS0+a3ZtX21zcl9idWYtPm5tc3JzJyBmYWlsZWQuDQpBYm9ydGVk
DQoNClNvIG1ha2UgbnVtYmVyIG9mIHBtYyBjb25maWd1cmFibGUgdG8gdm0gPyBBbnkgYmV0dGVy
IGlkZWEgPw0KDQoNClJlZ2FyZHMsDQotWmh1YW5nIFlhbnlpbmcNCg==
