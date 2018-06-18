Received: from eggs.gnu.org ([2001:4830:134:3::10]:57258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV2zu-0005vR-Ho
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fV2zr-0005Zc-G6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fV2zr-0005Yc-90
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:51:39 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 18 Jun 2018 19:51:28 -0300
Message-Id: <20180618225131.13113-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] python: Revert sys.path hacks used for
 compat modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Now that the 'argparse' and 'ordereddict' compat modules were
removed, we can remove some sys.path hacks added because of them.

Eduardo Habkost (3):
  device-crash-test: No need for sys.path hack
  Revert "docker.py: Python 2.6 argparse compatibility"
  Revert "tests: migration/guestperf Python 2.6 argparse compatibility"

 scripts/device-crash-test          | 1 -
 tests/docker/docker.py             | 4 +---
 tests/migration/guestperf/shell.py | 8 +++-----
 3 files changed, 4 insertions(+), 9 deletions(-)


base-commit: 2ef2f16781af9dee6ba6517755e9073ba5799fa2
prerequisite-patch-id: 4d0af8c27a87cf124ad37fd18e3adf47fd45a93a
prerequisite-patch-id: 4376551471959cc464ac8f061e84780710dd9121
prerequisite-patch-id: 0e23e8822f87d5d0e77d897ff9ff2a952297b1ef
prerequisite-patch-id: b8acae4f74302b01f4d6805b39d27ce2cdaceafa
prerequisite-patch-id: f11e7b483ff5f356f52d16b3ae252688002518a0
prerequisite-patch-id: 4db77f7dd9ff0bc89641e3cce8a4634eb661b476
prerequisite-patch-id: afd96367ba6e592a33fef5003a01a6560596c204
-- 
2.18.0.rc1.1.g3f1ff2140
