Received: from eggs.gnu.org ([2001:4830:134:3::10]:52999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgb-0000iS-06
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkga-00088V-7c
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cnkga-0007v8-19
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cnkgR-0002Dv-1J
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:32:07 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 11:32:03 +0000
Message-Id: <1489491125-23648-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 0/2] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Couple of minor patches to sneak in before rc0. The PSCI return
values fix is the most important one.

-- PMM

The following changes since commit 94b5d57d2f5a3c849cecd65e424bb6f50b998df9:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170314' into staging (2017-03-14 10:13:19 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170314

for you to fetch changes up to d5affb0d8677e1a8a8fe03fa25005b669e7cdc02:

  target/arm/arm-powerctl: Fix psci info return values (2017-03-14 11:28:54 +0000)

----------------------------------------------------------------
target-arm queue:
 * arm-powerctl: Fix psci info return values
 * implement armv8 PMUSERENR (user-mode enable bits)

----------------------------------------------------------------
Andrew Baumann (1):
      target/arm: implement armv8 PMUSERENR (user-mode enable bits)

Andrew Jones (1):
      target/arm/arm-powerctl: Fix psci info return values

 target/arm/cpu.h    |  4 +--
 target/arm/helper.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 73 insertions(+), 10 deletions(-)
