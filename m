Received: from eggs.gnu.org ([2001:4830:134:3::10]:46749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUeBJ-00039b-5M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUeBH-0002Zy-Vq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:45:01 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 18:44:37 +0000
Message-Id: <1484937883-1068-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] ARMv7M: some simple bugfixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Liviu Ionescu <ilg@livius.net>, Michael Davidsaver <mdavidsaver@gmail.com>

This set of six patches is some simple bug fixes which
I've pulled out of Michael Davidsaver's old NVIC rewrite
patchset, as an initial start on getting it upstream.
None of them are particularly exciting, but they're
self-contained so they might as well go through code
review and get into master ahead of the main rewrite.

NB the patch which pulls the FIELD macros out of register.h;
they're too useful to be only accessible in softmmu builds.

I've CC'd Michael as the original author and Liviu
as somebody interested in v7M; if either of you would
prefer not to be cc'd let me know and I'll leave you off
subsequent respins and later NVIC related patchset emails.

thanks
-- PMM

Michael Davidsaver (5):
  armv7m: MRS/MSR: handle unprivileged access
  armv7m: Replace armv7m.hack with unassigned_access handler
  armv7m: Explicit error for bad vector table
  armv7m: Fix reads of CONTROL register bit 1
  armv7m: Clear FAULTMASK on return from non-NMI exceptions

Peter Maydell (1):
  hw/registerfields.h: Pull FIELD etc macros out of hw/register.h

 include/hw/register.h       |  47 +-------------
 include/hw/registerfields.h |  60 ++++++++++++++++++
 target/arm/cpu.h            |   1 -
 target/arm/internals.h      |   7 +++
 hw/arm/armv7m.c             |   8 ---
 target/arm/cpu.c            |  28 +++++++++
 target/arm/helper.c         | 147 +++++++++++++++++++++++++++-----------------
 target/arm/machine.c        |   6 +-
 target/arm/translate.c      |  12 ++--
 9 files changed, 195 insertions(+), 121 deletions(-)
 create mode 100644 include/hw/registerfields.h

-- 
2.7.4
