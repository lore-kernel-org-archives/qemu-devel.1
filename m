Received: from eggs.gnu.org ([2001:4830:134:3::10]:41818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP8G-0001qD-Hn
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drP8F-0002Kj-LR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:52:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 14:52:03 +0100
Message-Id: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/7] ARMv8M: some bugfixes and prep. cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Seven simple patches off the top of my v8M work in progress:
three bugfixes which are also relevant for v7M:
 * need to clear exclusive monitor on exception entry/exit
 * wrong BFSR bits set on aborts
 * negative exception priorities were being wrongly handled
and four code cleanup patches, including one which is a change
suggested in review of my last series which I forgot to make.

thanks
-- PMM

Peter Maydell (7):
  target/arm: Use M_REG_NUM_BANKS rather than hardcoding 2
  target/arm: Clear exclusive monitor on v7M reset, exception entry/exit
  target/arm: Get PRECISERR and IBUSERR the right way round
  nvic: Don't apply group priority mask to negative priorities
  target/arm: Remove unnecessary '| 0xf0000000' from
    do_v7m_exception_exit()
  target/arm: Add and use defines for EXCRET constants
  target/arm: Rename 'type' to 'excret' in do_v7m_exception_exit()

 target/arm/cpu.h       | 35 +++++++++++++++++++----------------
 target/arm/internals.h | 20 ++++++++++++++++++++
 hw/intc/armv7m_nvic.c  | 11 +++++++++--
 target/arm/cpu.c       |  6 ++++++
 target/arm/helper.c    | 43 +++++++++++++++++++++++++------------------
 target/arm/op_helper.c |  2 +-
 6 files changed, 80 insertions(+), 37 deletions(-)

-- 
2.7.4
