Received: from eggs.gnu.org ([2001:4830:134:3::10]:52276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijMy-0003e8-1t
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cijMu-0002m0-0p
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:16 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cijMt-0002lJ-QZ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:07:11 -0500
Received: by mail-wm0-x22f.google.com with SMTP id i17so3363396wmf.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:07:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 28 Feb 2017 15:07:06 +0000
Message-Id: <20170228150709.27453-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/3] MTTCG start-up tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

These are a couple of quick tweaks to command line handling for MTTCG.
The first patch moves the paring of --accel tcg to after icount and
simplifies the logic to disable mttcg when icount is enabled. There is
still a regression to icount to be fixed (caused by 8d04fb5).

Finally there is a patch to declare the TCG_GUEST_DEFAULT_MO for x86
guests to avoid the bogus warning about memory order when forcing
mttcg on. A new warning has been added specifically for guests that
haven't declared TARGET_SUPPORT_MTTCG which means the front-end has
had atomics/barrier/helpers converted for a MTTCG world.

Alex Bennée (3):
  vl/cpus: be smarter with icount and MTTCG
  target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
  cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG

 cpus.c            | 11 +++++++----
 target/i386/cpu.h |  3 +++
 vl.c              |  7 ++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.11.0
