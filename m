Received: from eggs.gnu.org ([2001:4830:134:3::10]:60666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fAWH4-0008GG-JU
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fAWH1-0008RZ-IH
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:52:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:25560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1fAWH1-0008QS-8B
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 03:52:31 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Mon, 23 Apr 2018 09:51:51 +0200
Message-ID: <20180423075215.4572-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [ARM/FDPIC v2 0/4] FDPIC ABI for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu

Hello,

This is v2 of:
https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00783.html

Compared to v1, I have addressed Peter's comments:
- patch #1 removes CONFIG_USE_FDPIC
- patch #2 corresponds to the previous patch #1, and is now simpler
  without configure option
- patch #3 corresponds to the previous patch #2, and uses TaskState
  instead of CPUARMState
- patch #4 corresponds to the previous patch #3, and fixes guest
  pointer dereferencing

Is this now OK?

Thanks,

Christophe

Christophe Lyon (4):
  Remove CONFIG_USE_FDPIC.
  linux-user: ARM-FDPIC: Identify ARM FDPIC binaries
  linux-user: ARM-FDPIC: Add support of FDPIC for ARM.
  linux-user: ARM-FDPIC: Add support for signals for FDPIC targets

 include/elf.h        |  1 +
 linux-user/elfload.c | 53 +++++++++++++++++++++++-------
 linux-user/main.c    |  3 ++
 linux-user/qemu.h    | 10 ++++--
 linux-user/signal.c  | 91 +++++++++++++++++++++++++++++++++++++++++++---------
 5 files changed, 129 insertions(+), 29 deletions(-)

-- 
2.6.3
