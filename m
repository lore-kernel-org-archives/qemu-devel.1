Received: from eggs.gnu.org ([2001:4830:134:3::10]:52543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cy37g-0006ry-W9
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cy36l-0008UY-5C
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:14:48 -0400
Received: from mail-oln040092255066.outbound.protection.outlook.com
	([40.92.255.66]:39680
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Prerna.Garg@live.com>)
	id 1cy36k-0008T8-FC
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 17:13:50 -0400
From: Prerna Garg <Prerna.Garg@live.com>
Date: Tue, 11 Apr 2017 20:41:26 +0000
Message-ID: <BM1PR01MB0722EAF9BB6F0804187CF81984000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_BM1PR01MB0722EAF9BB6F0804187CF81984000BM1PR01MB0722INDP_"
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and g_free
 in util/envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>

--_004_BM1PR01MB0722EAF9BB6F0804187CF81984000BM1PR01MB0722INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



--_004_BM1PR01MB0722EAF9BB6F0804187CF81984000BM1PR01MB0722INDP_
Content-Type: text/x-patch;
	name="0003-Changed-malloc-and-free-to-g_malloc-and-g_free-respe.patch"
Content-Description: 0003-Changed-malloc-and-free-to-g_malloc-and-g_free-respe.patch
Content-Disposition: attachment;
	filename="0003-Changed-malloc-and-free-to-g_malloc-and-g_free-respe.patch";
	size=2169; creation-date="Tue, 11 Apr 2017 20:41:15 GMT";
	modification-date="Tue, 11 Apr 2017 20:41:15 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmM2VlM2NmOWI2OWFjYTg2Yzc4ZWMyNjQ2OGEwYjQ1MzM3NDRjZGFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcmVybmEgR2FyZyA8cHJlcm5hLmdhcmdAbGl2ZS5jb20+CkRh
dGU6IFdlZCwgMTIgQXByIDIwMTcgMDI6MDQ6MzYgKzA1MzAKU3ViamVjdDogW1BBVENIIDMvM10g
Q2hhbmdlZCBtYWxsb2MgYW5kIGZyZWUgdG8gZ19tYWxsb2MgYW5kIGdfZnJlZQogcmVzcGVjdGl2
ZWx5IGluIHV0aWwvZW52bGlzdC5jIGZpbGUKClNpZ25lZC1vZmYtYnk6IFByZXJuYSBHYXJnIDxw
cmVybmEuZ2FyZ0BsaXZlLmNvbT4KLS0tCiB1dGlsL2Vudmxpc3QuYyB8IDIyICsrKysrKysrKysr
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS91dGlsL2Vudmxpc3QuYyBiL3V0aWwvZW52bGlzdC5jCmluZGV4
IGU4Njg1N2UuLjAzMjRmZTIgMTAwNjQ0Ci0tLSBhL3V0aWwvZW52bGlzdC5jCisrKyBiL3V0aWwv
ZW52bGlzdC5jCkBAIC0yNSw3ICsyNSw3IEBAIGVudmxpc3RfY3JlYXRlKHZvaWQpCiB7CiAJZW52
bGlzdF90ICplbnZsaXN0OwogCi0JaWYgKChlbnZsaXN0ID0gbWFsbG9jKHNpemVvZiAoKmVudmxp
c3QpKSkgPT0gTlVMTCkKKwlpZiAoKGVudmxpc3QgPSBnX21hbGxvYyhzaXplb2YgKCplbnZsaXN0
KSkpID09IE5VTEwpCiAJCXJldHVybiAoTlVMTCk7CiAKIAlRTElTVF9JTklUKCZlbnZsaXN0LT5l
bF9lbnRyaWVzKTsKQEAgLTQ4LDEwICs0OCwxMCBAQCBlbnZsaXN0X2ZyZWUoZW52bGlzdF90ICpl
bnZsaXN0KQogCQllbnRyeSA9IGVudmxpc3QtPmVsX2VudHJpZXMubGhfZmlyc3Q7CiAJCVFMSVNU
X1JFTU9WRShlbnRyeSwgZXZfbGluayk7CiAKLQkJZnJlZSgoY2hhciAqKWVudHJ5LT5ldl92YXIp
OwotCQlmcmVlKGVudHJ5KTsKKwkJZ19mcmVlKChjaGFyICopZW50cnktPmV2X3Zhcik7CisJCWdf
ZnJlZShlbnRyeSk7CiAJfQotCWZyZWUoZW52bGlzdCk7CisJZ19mcmVlKGVudmxpc3QpOwogfQog
CiAvKgpAQCAtMTU1LDE2ICsxNTUsMTYgQEAgZW52bGlzdF9zZXRlbnYoZW52bGlzdF90ICplbnZs
aXN0LCBjb25zdCBjaGFyICplbnYpCiAKIAlpZiAoZW50cnkgIT0gTlVMTCkgewogCQlRTElTVF9S
RU1PVkUoZW50cnksIGV2X2xpbmspOwotCQlmcmVlKChjaGFyICopZW50cnktPmV2X3Zhcik7Ci0J
CWZyZWUoZW50cnkpOworCQlnX2ZyZWUoKGNoYXIgKillbnRyeS0+ZXZfdmFyKTsKKwkJZ19mcmVl
KGVudHJ5KTsKIAl9IGVsc2UgewogCQllbnZsaXN0LT5lbF9jb3VudCsrOwogCX0KIAotCWlmICgo
ZW50cnkgPSBtYWxsb2Moc2l6ZW9mICgqZW50cnkpKSkgPT0gTlVMTCkKKwlpZiAoKGVudHJ5ID0g
Z19tYWxsb2Moc2l6ZW9mICgqZW50cnkpKSkgPT0gTlVMTCkKIAkJcmV0dXJuIChlcnJubyk7CiAJ
aWYgKChlbnRyeS0+ZXZfdmFyID0gc3RyZHVwKGVudikpID09IE5VTEwpIHsKLQkJZnJlZShlbnRy
eSk7CisJCWdfZnJlZShlbnRyeSk7CiAJCXJldHVybiAoZXJybm8pOwogCX0KIAlRTElTVF9JTlNF
UlRfSEVBRCgmZW52bGlzdC0+ZWxfZW50cmllcywgZW50cnksIGV2X2xpbmspOwpAQCAtMjAxLDgg
KzIwMSw4IEBAIGVudmxpc3RfdW5zZXRlbnYoZW52bGlzdF90ICplbnZsaXN0LCBjb25zdCBjaGFy
ICplbnYpCiAJfQogCWlmIChlbnRyeSAhPSBOVUxMKSB7CiAJCVFMSVNUX1JFTU9WRShlbnRyeSwg
ZXZfbGluayk7Ci0JCWZyZWUoKGNoYXIgKillbnRyeS0+ZXZfdmFyKTsKLQkJZnJlZShlbnRyeSk7
CisJCWdfZnJlZSgoY2hhciAqKWVudHJ5LT5ldl92YXIpOworCQlnX2ZyZWUoZW50cnkpOwogCiAJ
CWVudmxpc3QtPmVsX2NvdW50LS07CiAJfQpAQCAtMjI1LDcgKzIyNSw3IEBAIGVudmxpc3RfdG9f
ZW52aXJvbihjb25zdCBlbnZsaXN0X3QgKmVudmxpc3QsIHNpemVfdCAqY291bnQpCiAJc3RydWN0
IGVudmxpc3RfZW50cnkgKmVudHJ5OwogCWNoYXIgKiplbnYsICoqcGVudjsKIAotCXBlbnYgPSBl
bnYgPSBtYWxsb2MoKGVudmxpc3QtPmVsX2NvdW50ICsgMSkgKiBzaXplb2YgKGNoYXIgKikpOwor
CXBlbnYgPSBlbnYgPSBnX21hbGxvYygoZW52bGlzdC0+ZWxfY291bnQgKyAxKSAqIHNpemVvZiAo
Y2hhciAqKSk7CiAJaWYgKGVudiA9PSBOVUxMKQogCQlyZXR1cm4gKE5VTEwpOwogCi0tIAoyLjcu
NAoK

--_004_BM1PR01MB0722EAF9BB6F0804187CF81984000BM1PR01MB0722INDP_--
