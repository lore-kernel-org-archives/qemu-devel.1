Received: from eggs.gnu.org ([2001:4830:134:3::10]:43929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYH-0000Ud-Kn
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9rYC-00041q-KZ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g9rYC-00041L-FD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:55:48 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 13:55:35 +0100
Message-Id: <20181009125541.24455-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/6] crypto: improve performance of XTS cipher
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>

The XTS cipher mode is significantly slower than CBC mode. This series
approximately doubles the XTS performance which will improve the I/O
rate for LUKS disks.

Daniel P. Berrang=C3=A9 (6):
  crypto: expand algorithm coverage for cipher benchmark
  crypto: remove code duplication in tweak encrypt/decrypt
  crypto: introduce a xts_uint128 data type
  crypto: convert xts_tweak_encdec to use xts_uint128 type
  crypto: convert xts_mult_x to use xts_uint128 type
  crypto: annotate xts_tweak_encdec as inlineable

 crypto/xts.c                    | 147 ++++++++++++++-----------------
 tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++++++++++++-----
 2 files changed, 191 insertions(+), 105 deletions(-)

--=20
2.17.1
