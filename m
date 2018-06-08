Received: from eggs.gnu.org ([2001:4830:134:3::10]:49365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRLaR-0007RV-3g
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRLaN-0003d2-6m
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:54:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fRLaN-0003cw-0Q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:54:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  8 Jun 2018 14:52:50 -0300
Message-Id: <20180608175252.25110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] python: Remove unused compatibility
 modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Changes v1 -> v2:
* Remove references to ordereddict.py from Makefiles
  (oops)

Now that we require Python >= 2.7, we don't need
scripts/argparse.py and scripts/ordereddict.py anymore.

Eduardo Habkost (2):
  python: Remove scripts/argparse.py
  python: Remove scripts/ordereddict.py

 Makefile               |    1 -
 scripts/argparse.py    | 2406 ----------------------------------------
 scripts/ordereddict.py |  128 ---
 scripts/qapi/common.py |    5 +-
 tests/Makefile.include |    1 -
 5 files changed, 1 insertion(+), 2540 deletions(-)
 delete mode 100644 scripts/argparse.py
 delete mode 100644 scripts/ordereddict.py


base-commit: 0d2fa03dae4fbe185a082f361342b1e30aed4582
prerequisite-patch-id: 85850a32e1cc81a0da74ab17f5529422dad95b84
prerequisite-patch-id: 7170cef9d18c1a7685e2fee388f91dc41f4904b6
prerequisite-patch-id: 7c129d8fffe290a3212658590b2d992b0cec41c7
prerequisite-patch-id: d7a2da6245ab7e7d3425d095ea910ff36564d852
prerequisite-patch-id: 0873603d721465a489159d648f31d1a067b056fa
prerequisite-patch-id: 076695a7cdd63726e02855227ce5488c76c11aa9
prerequisite-patch-id: 7df7c61e87116dd3ac9ad8a74735715e09030c62
prerequisite-patch-id: 4f454e504a80785079216d79289e737ba092a75c
prerequisite-patch-id: 5a6b8b611de8324d8a5083e855d5512a66c3680f
prerequisite-patch-id: 3e5e0849ce3a5149c75e088fd01974d1d5c9c6d5
prerequisite-patch-id: 6aa4739baafd181e2ae0027903b77a5267e983f7
-- 
2.18.0.rc1.1.g3f1ff2140
