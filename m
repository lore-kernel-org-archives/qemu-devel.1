Received: from eggs.gnu.org ([2001:4830:134:3::10]:46045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangqian@sangfor.com.cn>) id 1cMaFv-0002U9-9c
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 07:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangqian@sangfor.com.cn>) id 1cMaFp-00033H-VS
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 07:56:27 -0500
Received: from m129-177.yeah.net ([123.58.177.129]:2355)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangqian@sangfor.com.cn>) id 1cMaFo-00032G-Vc
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 07:56:21 -0500
Message-ID: <ABkAAQD4AB3QlUFH9YYGDar2.1.1483013998163.Hmail.zhangqian@sangfor.com.cn>
MIME-Version: 1.0
From: Zhang Qian <zhangqian@sangfor.com.cn>
Date: Thu, 29 Dec 2016 20:19:58 +0800 (GMT+08:00)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] =?utf-8?q?=5BPATCH=5D_scsi-disk=3A_fix_crash_on_VERI?=
 =?utf-8?q?FY_command?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

RnJvbSBjMmYxNjMxMTMyODIxZDYxZTE5NDJhODcyM2JhNTk2ZjkxZDNlNjcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZyBRaWFuIDx6aGFuZ3FpYW5Ac2FuZ2Zvci5jb20uY24+
CkRhdGU6IFRodSwgMjkgRGVjIDIwMTYgMjA6MDA6MDEgKzA4MDAKU3ViamVjdDogW1BBVENIXSBz
Y3NpLWRpc2s6IGZpeCBjcmFzaCBvbiBWRVJJRlkgY29tbWFuZCBDb21taXQgMTY2ZGJkYQogInNj
c2ktZGlzazogZml4IFZFUklGWSBmb3Igc2NzaS1ibG9jayIgYWRkIGEgcHJvY2VzcyBvZiBWRVJJ
RlkgaW4KIHNjc2lfYmxvY2tfZG1hX2NvbW1hbmQuIEJ1dCwgdGhlIGNtZC5tb2RlIG9mIHJlcSBp
cyBTQ1NJX1hGRVJfTk9ORSwgdGhlIHJlcQogaXMgaGFuZGxlZCBhcyBhIHJlYWQgb3BlcmF0aW9u
LiBBIHZlcmlmeSBjb21tYW5kIGlzIG5vdCBhbiBhY3R1YWwgcmVhZCAod2UgZG8KIG5vdCBpbXBs
ZW1lbnQgY29tcGFyZSBtb2RlKSBhbmQgdGh1cyBkb2VzIG5vdCBoYXZlIGFuIEFJT0NCIGF0dGFj
aGVkLiBzbywgaXQKIHdpbGwgYmUgY3Jhc2ggaW4gc2NzaV9kbWFfY29tcGxldGUuIENvbW1pdCBl
Zjg0ODlkICJzY3NpOiBhdm9pZCBhc3NlcnRpb24KIGZhaWx1cmUgb24gVkVSSUZZIGNvbW1hbmQi
IGlzIGFkZGVkIHRvIHByb2Nlc3MgdmVyaWZ5IGNvbW1hbmQsIHNvIHdlIHRyZWF0CiB2ZXJpZnkg
Y29tbWFuZCBhcyBhIHdyaXRlIG9wZXJhdGlvbi4KU2lnbmVkLW9mZi1ieTogWmhhbmcgUWlhbiA8
emhhbmdxaWFuQHNhbmdmb3IuY29tLmNuPgotLS0KIGh3L3Njc2kvc2NzaS1kaXNrLmMgfCA0ICsr
KysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCgpkaWZmIC0tZ2l0IGEvaHcvc2Nz
aS9zY3NpLWRpc2suYyBiL2h3L3Njc2kvc2NzaS1kaXNrLmMKaW5kZXggYmRkMWU1Zi4uYWIwNWJm
OSAxMDA2NDQKLS0tIGEvaHcvc2NzaS9zY3NpLWRpc2suYworKysgYi9ody9zY3NpL3Njc2ktZGlz
ay5jCkBAIC0yMTcwLDYgKzIxNzAsMTAgQEAgc3RhdGljIGludDMyX3Qgc2NzaV9kaXNrX2RtYV9j
b21tYW5kKFNDU0lSZXF1ZXN0ICpyZXEsIHVpbnQ4X3QgKmJ1ZikKICAgICAgICAgaWYgKCFjaGVj
a19sYmFfcmFuZ2Uocywgci0+cmVxLmNtZC5sYmEsIGxlbikpIHsKICAgICAgICAgICAgIGdvdG8g
aWxsZWdhbF9sYmE7CiAgICAgICAgIH0KKyBpZiAoY29tbWFuZCA9PSBWRVJJRllfMTAgfHwgY29t
bWFuZCA9PSBWRVJJRllfMTIgfHwKKyAgICAgICAgICAgIGNvbW1hbmQgPT0gVkVSSUZZXzE2KSB7
CisgICAgICAgICAgICByLT5yZXEuY21kLm1vZGUgPSBTQ1NJX1hGRVJfVE9fREVWOworICAgICAg
ICB9CiAgICAgICAgIHItPnNlY3RvciA9IHItPnJlcS5jbWQubGJhICogKHMtPnFkZXYuYmxvY2tz
aXplIC8gNTEyKTsKICAgICAgICAgci0+c2VjdG9yX2NvdW50ID0gbGVuICogKHMtPnFkZXYuYmxv
Y2tzaXplIC8gNTEyKTsKICAgICAgICAgYnJlYWs7Ci0tIAoKCgoKDQoNCg==
