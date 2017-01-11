Received: from eggs.gnu.org ([2001:4830:134:3::10]:48277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <h158309@126.com>) id 1cRFUD-0000K6-Du
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <h158309@126.com>) id 1cRFU9-0007bA-HB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:46:29 -0500
Received: from m15-9.126.com ([220.181.15.9]:7504)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <h158309@126.com>) id 1cRFU8-0007YO-Rq
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:46:25 -0500
Date: Wed, 11 Jan 2017 17:15:31 +0800 (CST)
From: =?GBK?B?u8a7tA==?= <h158309@126.com>
MIME-Version: 1.0
Message-ID: <32da9f1f.9022.1598ccf96ce.Coremail.h158309@126.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] vhost-user: fix crash when chardev-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

RnJvbTogSHVhaSBIdWFuZzxoMTU4MzA5QDEyNi5jb20+CgoKZGlmZiAtLWdpdCBhL2h3L25ldC92
aG9zdF9uZXQuYyBiL2h3L25ldC92aG9zdF9uZXQuYwppbmRleCBmMmQ0OWFkLi40MDM3Y2Y0IDEw
MDY0NAotLS0gYS9ody9uZXQvdmhvc3RfbmV0LmMKKysrIGIvaHcvbmV0L3Zob3N0X25ldC5jCkBA
IC00MTIsNyArNDEyLDYgQEAgVkhvc3ROZXRTdGF0ZSAqZ2V0X3Zob3N0X25ldChOZXRDbGllbnRT
dGF0ZSAqbmMpCiAgICAgICAgIGJyZWFrOwogICAgIGNhc2UgTkVUX0NMSUVOVF9EUklWRVJfVkhP
U1RfVVNFUjoKICAgICAgICAgdmhvc3RfbmV0ID0gdmhvc3RfdXNlcl9nZXRfdmhvc3RfbmV0KG5j
KTsKLSAgICAgICAgYXNzZXJ0KHZob3N0X25ldCk7CiAgICAgICAgIGJyZWFrOwogICAgIGRlZmF1
bHQ6CiAgICAgICAgIGJyZWFrOwpkaWZmIC0tZ2l0IGEvbmV0L3Zob3N0LXVzZXIuYyBiL25ldC92
aG9zdC11c2VyLmMKaW5kZXggYjA1OTVmOC4uNGU1NDQ3OCAxMDA2NDQKLS0tIGEvbmV0L3Zob3N0
LXVzZXIuYworKysgYi9uZXQvdmhvc3QtdXNlci5jCkBAIC0xNjAsNyArMTYwLDEwIEBAIHN0YXRp
YyB2b2lkIHZob3N0X3VzZXJfY2xlYW51cChOZXRDbGllbnRTdGF0ZSAqbmMpCiAgICAgICAgIHFl
bXVfY2hyX2ZlX3JlbGVhc2Uocy0+Y2hyKTsKICAgICAgICAgcy0+Y2hyID0gTlVMTDsKICAgICB9
Ci0KKyAgICBpZiAocy0+d2F0Y2gpIHsKKyAgICAgICAgZ19zb3VyY2VfcmVtb3ZlKHMtPndhdGNo
KTsKKyAgICAgICAgcy0+d2F0Y2ggPSAwOworICAgIH0KICAgICBxZW11X3B1cmdlX3F1ZXVlZF9w
YWNrZXRzKG5jKTsKIH0KCgpAQCAtMTkyLDcgKzE5NSw4IEBAIHN0YXRpYyBnYm9vbGVhbiBuZXRf
dmhvc3RfdXNlcl93YXRjaChHSU9DaGFubmVsICpjaGFuLCBHSU9Db25kaXRpb24gY29uZCwKIHsK
ICAgICBWaG9zdFVzZXJTdGF0ZSAqcyA9IG9wYXF1ZTsKCgotICAgIHFlbXVfY2hyX2Rpc2Nvbm5l
Y3Qocy0+Y2hyKTsKKyAgICBpZiAocy0+Y2hyKQorICAgICAgICBxZW11X2Nocl9kaXNjb25uZWN0
KHMtPmNocik7CgoKICAgICByZXR1cm4gRkFMU0U7CiB9
