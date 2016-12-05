Received: from eggs.gnu.org ([2001:4830:134:3::10]:39817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cDxYN-0005M2-7D
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cDxYJ-0001Zw-Cy
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:59:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cDxYJ-0001Wp-6E
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:59:47 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Dec 2016 17:59:34 +0000
Message-Id: <1480960775-5002-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/1] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

One patch for 2.8-rc3, which is Alex's partial revert
of 1dd089d0 to fix A64 ldaxp.

thanks
-- PMM

The following changes since commit bc66cedb4141fb7588f2462c74310d8fb5dd4cf1:

  Merge remote-tracking branch 'yongbok/tags/mips-20161204' into staging (2016-12-05 10:56:45 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20161205

for you to fetch changes up to 5460da501a57cd72eda6fec736d76539122e2f99:

  target-arm/translate-a64: fix gen_load_exclusive (2016-12-05 17:52:01 +0000)

----------------------------------------------------------------
target-arm queue:
 * fix gen_load_exclusive handling of ldaxp

----------------------------------------------------------------
Alex Bennée (1):
      target-arm/translate-a64: fix gen_load_exclusive

 target-arm/translate-a64.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)
