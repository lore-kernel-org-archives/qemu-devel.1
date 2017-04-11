Received: from eggs.gnu.org ([2001:4830:134:3::10]:53305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cyB0m-0000Na-0P
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cyB0i-0006rG-RW
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:40:12 -0400
Received: from mail-oln040092254010.outbound.protection.outlook.com
	([40.92.254.10]:10400
	helo=APC01-PU1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Prerna.Garg@live.com>)
	id 1cyB0i-0006nR-56
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 01:40:08 -0400
From: Prerna Garg <Prerna.Garg@live.com>
Date: Tue, 11 Apr 2017 20:04:43 +0000
Message-ID: <BM1PR01MB072299B8CAFBB379F8BF8DE584000@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_BM1PR01MB072299B8CAFBB379F8BF8DE584000BM1PR01MB0722INDP_"
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] Changed malloc and free to g_malloc and g_free
 in util/compatfd.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

--_004_BM1PR01MB072299B8CAFBB379F8BF8DE584000BM1PR01MB0722INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



--_004_BM1PR01MB072299B8CAFBB379F8BF8DE584000BM1PR01MB0722INDP_
Content-Type: text/x-patch;
	name="0002-Changed-malloc-and-free-to-g_malloc-and-g_free-in-ut.patch"
Content-Description: 0002-Changed-malloc-and-free-to-g_malloc-and-g_free-in-ut.patch
Content-Disposition: attachment;
	filename="0002-Changed-malloc-and-free-to-g_malloc-and-g_free-in-ut.patch";
	size=870; creation-date="Tue, 11 Apr 2017 20:03:38 GMT";
	modification-date="Tue, 11 Apr 2017 20:03:38 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5ZTI1ZmRmMWVhM2U0ZjUyYTcyYmZlZmMwNTNhNzAxOTg5YjdhZjI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcmVybmEgR2FyZyA8cHJlcm5hLmdhcmdAbGl2ZS5jb20+CkRh
dGU6IFdlZCwgMTIgQXByIDIwMTcgMDE6Mjk6NDAgKzA1MzAKU3ViamVjdDogW1BBVENIIDIvMl0g
Q2hhbmdlZCBtYWxsb2MgYW5kIGZyZWUgdG8gZ19tYWxsb2MgYW5kIGdfZnJlZSBpbgogdXRpbC9j
b21wYXRmZC5jCgpTaWduZWQtb2ZmLWJ5OiBQcmVybmEgR2FyZyA8cHJlcm5hLmdhcmdAbGl2ZS5j
b20+Ci0tLQogdXRpbC9jb21wYXRmZC5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3V0aWwvY29tcGF0ZmQuYyBi
L3V0aWwvY29tcGF0ZmQuYwppbmRleCA5ODBiZDMzLi43YmYxMzQ0IDEwMDY0NAotLS0gYS91dGls
L2NvbXBhdGZkLmMKKysrIGIvdXRpbC9jb21wYXRmZC5jCkBAIC03MSwxNCArNzEsMTQgQEAgc3Rh
dGljIGludCBxZW11X3NpZ25hbGZkX2NvbXBhdChjb25zdCBzaWdzZXRfdCAqbWFzaykKICAgICBR
ZW11VGhyZWFkIHRocmVhZDsKICAgICBpbnQgZmRzWzJdOwogCi0gICAgaW5mbyA9IG1hbGxvYyhz
aXplb2YoKmluZm8pKTsKKyAgICBpbmZvID0gZ19tYWxsb2Moc2l6ZW9mKCppbmZvKSk7CiAgICAg
aWYgKGluZm8gPT0gTlVMTCkgewogICAgICAgICBlcnJubyA9IEVOT01FTTsKICAgICAgICAgcmV0
dXJuIC0xOwogICAgIH0KIAogICAgIGlmIChwaXBlKGZkcykgPT0gLTEpIHsKLSAgICAgICAgZnJl
ZShpbmZvKTsKKyAgICAgICAgZ19mcmVlKGluZm8pOwogICAgICAgICByZXR1cm4gLTE7CiAgICAg
fQogCi0tIAoyLjcuNAoK

--_004_BM1PR01MB072299B8CAFBB379F8BF8DE584000BM1PR01MB0722INDP_--
