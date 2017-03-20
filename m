Received: from eggs.gnu.org ([2001:4830:134:3::10]:44019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpi-0007dZ-RY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwph-0003o8-W2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cpwph-0003lz-PK
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpZ-0007T7-ID
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:54:37 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 12:54:32 +0000
Message-Id: <1490014476-25672-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.9 0/4] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Small target-arm queue for 2.9: just the patches
which fix bugs in our MRS/MSR decoding for M profile,
including a fix for a regression introduced in commit
58117c9bb429cd.

thanks
-- PMM

The following changes since commit 00e7c07b06d004cf54b19724f82afde8a7a37f37:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170320' into staging (2017-03-20 10:51:30 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170320

for you to fetch changes up to b28b3377d7e9ba35611d454d5a63ef50cab1f8c5:

  arm: Fix APSR writes via M profile MSR (2017-03-20 12:41:44 +0000)

----------------------------------------------------------------
target-arm queue:
 * fix MSR/MRS decoding for M profile CPUs

----------------------------------------------------------------
Peter Maydell (4):
      arm: HVC and SMC encodings don't exist for M profile
      arm: Don't decode MRS(banked) or MSR(banked) for M profile
      arm: Enforce should-be-1 bits in MRS decoding
      arm: Fix APSR writes via M profile MSR

 target/arm/helper.c    | 26 ++++++++++++++++++++++----
 target/arm/translate.c | 26 +++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 7 deletions(-)
