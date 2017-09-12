Received: from eggs.gnu.org ([2001:4830:134:3::10]:40504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <louis.lifei@huawei.com>) id 1drbGs-000448-IB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 22:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <louis.lifei@huawei.com>) id 1drbGp-0003Xg-Dd
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 22:49:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <louis.lifei@huawei.com>) id 1drbGo-0003VZ-Eu
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 22:49:51 -0400
From: "Lifei (Louis)" <louis.lifei@huawei.com>
Date: Tue, 12 Sep 2017 02:49:33 +0000
Message-ID: <0D4B427206E615459C4FEB71FC00EF8CFE74E5@dggemi509-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: multipart/mixed;
	boundary="_004_0D4B427206E615459C4FEB71FC00EF8CFE74E5dggemi509mbxchina_"
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC] vfio/pci: don't reset bar address when pci
 device no_soft_reset bit is set to "1"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Ido Yariv <ido@wizery.com>

--_004_0D4B427206E615459C4FEB71FC00EF8CFE74E5dggemi509mbxchina_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all

In commit a52a4c471703e995ceb06f6157d70747823e8a0d said:

The VFIO configuration space stays untouched, so the guest OS may choose
    to skip restoring the BAR addresses as they would seem intact. The PCI
    device may be left non-operational.

While the guest OS choose to restore the BAR addresses only when pci device=
 no_soft_reset
is not set. So we may not reset the BAR address when no_soft_reset is set.

Thanks.
Louis


--_004_0D4B427206E615459C4FEB71FC00EF8CFE74E5dggemi509mbxchina_
Content-Type: application/octet-stream;
	name="0001-vfio-pci-don-t-reset-bar-address-when-no_soft_rst-se.patch"
Content-Description: 0001-vfio-pci-don-t-reset-bar-address-when-no_soft_rst-se.patch
Content-Disposition: attachment;
	filename="0001-vfio-pci-don-t-reset-bar-address-when-no_soft_rst-se.patch";
	size=1662; creation-date="Tue, 12 Sep 2017 02:39:22 GMT";
	modification-date="Tue, 12 Sep 2017 02:24:04 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4NDU5MTRjZjViY2Q0ODg3MjIyNGRmN2YwOGU1M2NhMmExOWE1NzdlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMb3VpcyBMaWZlaSA8bG91aXMubGlmZWlAaHVhd2VpLmNvbT4K
RGF0ZTogVHVlLCAxMiBTZXAgMjAxNyAxMDoxNzo1OSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHZm
aW8vcGNpOiBkb24ndCByZXNldCBiYXIgYWRkcmVzcyB3aGVuIG5vX3NvZnRfcnN0IHNldAoKU2ln
bmVkLW9mZi1ieTogTG91aXMgTGlmZWkgPGxvdWlzLmxpZmVpQGh1YXdlaS5jb20+Ci0tLQogaHcv
dmZpby9wY2kuYyB8IDIxICsrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2ku
YyBiL2h3L3ZmaW8vcGNpLmMKaW5kZXggMzFlMWVkZi4uNjc2NmY2YiAxMDA2NDQKLS0tIGEvaHcv
dmZpby9wY2kuYworKysgYi9ody92ZmlvL3BjaS5jCkBAIC0yMDI5LDE0ICsyMDI5LDE5IEBAIHN0
YXRpYyB2b2lkIHZmaW9fcGNpX3Bvc3RfcmVzZXQoVkZJT1BDSURldmljZSAqdmRldikKICAgICAg
ICAgZXJyb3JfcmVwb3J0Zl9lcnIoZXJyLCBFUlJfUFJFRklYLCB2ZGV2LT52YmFzZWRldi5uYW1l
KTsKICAgICB9CiAKLSAgICBmb3IgKG5yID0gMDsgbnIgPCBQQ0lfTlVNX1JFR0lPTlMgLSAxOyAr
K25yKSB7Ci0gICAgICAgIG9mZl90IGFkZHIgPSB2ZGV2LT5jb25maWdfb2Zmc2V0ICsgUENJX0JB
U0VfQUREUkVTU18wICsgKDQgKiBucik7Ci0gICAgICAgIHVpbnQzMl90IHZhbCA9IDA7Ci0gICAg
ICAgIHVpbnQzMl90IGxlbiA9IHNpemVvZih2YWwpOwotCi0gICAgICAgIGlmIChwd3JpdGUodmRl
di0+dmJhc2VkZXYuZmQsICZ2YWwsIGxlbiwgYWRkcikgIT0gbGVuKSB7Ci0gICAgICAgICAgICBl
cnJvcl9yZXBvcnQoIiVzKCVzKSByZXNldCBiYXIgJWQgZmFpbGVkOiAlbSIsIF9fZnVuY19fLAot
ICAgICAgICAgICAgICAgICAgICAgICAgIHZkZXYtPnZiYXNlZGV2Lm5hbWUsIG5yKTsKKyAgICAv
KiBXaGVuIE5vX1NvZnRfUmVzZXQgYml0IGlzIHNldCB0byAiMSIsIG5vIGFkZGl0aW9uYWwgb3Bl
cmF0aW5nCisgICAgICogc3lzdGVtIGludGVydmVudGlvbiBpcyByZXF1aXJlZCBiZXlvbmQgd3Jp
dGluZyB0aGUgUG93ZXJTdGF0ZSBiaXRzLgorICAgICAqLworICAgIGlmICh2ZGV2LT5oYXNfcG1f
cmVzZXQpIHsKKyAgICAgICAgZm9yIChuciA9IDA7IG5yIDwgUENJX05VTV9SRUdJT05TIC0gMTsg
KytucikgeworICAgICAgICAgICAgb2ZmX3QgYWRkciA9IHZkZXYtPmNvbmZpZ19vZmZzZXQgKyBQ
Q0lfQkFTRV9BRERSRVNTXzAgKyAoNCAqIG5yKTsKKyAgICAgICAgICAgIHVpbnQzMl90IHZhbCA9
IDA7CisgICAgICAgICAgICB1aW50MzJfdCBsZW4gPSBzaXplb2YodmFsKTsKKworICAgICAgICAg
ICAgaWYgKHB3cml0ZSh2ZGV2LT52YmFzZWRldi5mZCwgJnZhbCwgbGVuLCBhZGRyKSAhPSBsZW4p
IHsKKyAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIiVzKCVzKSByZXNldCBiYXIgJWQgZmFp
bGVkOiAlbSIsIF9fZnVuY19fLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZGV2LT52
YmFzZWRldi5uYW1lLCBucik7CisgICAgICAgICAgICB9CiAgICAgICAgIH0KICAgICB9CiB9Ci0t
IAoxLjkuMQoK

--_004_0D4B427206E615459C4FEB71FC00EF8CFE74E5dggemi509mbxchina_--
