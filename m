Received: from eggs.gnu.org ([2001:4830:134:3::10]:52270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLWa-00074d-3S
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLWW-0000Rs-Vu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLWW-0000Qn-Q8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:39:32 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:39:25 +0000
Message-Id: <20170227133927.759-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/2] Merge qcrypto 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit d992f2f1368ceb92e6bfd8efece174110f4236ff:

  Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170226' into staging (2017-02-26 22:40:23 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qcrypto-2017-02-27-1

for you to fetch changes up to 32c813e6c2a857b93b897901b7e20281397528a3:

  crypto: assert cipher algorithm is always valid (2017-02-27 13:37:14 +0000)

----------------------------------------------------------------
Merge qcrypto 2017/02/27 v1

----------------------------------------------------------------

Li Qiang (1):
  crypto: fix leak in ivgen essiv init

Prasad J Pandit (1):
  crypto: assert cipher algorithm is always valid

 crypto/cipher.c      | 8 ++------
 crypto/ivgen-essiv.c | 1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.9.3
