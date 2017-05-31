Received: from eggs.gnu.org ([2001:4830:134:3::10]:36664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Ma-0007S4-BJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3MX-0003bB-Ky
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:36 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:33091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3MX-0003ac-Bp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:33 -0400
Received: by mail-lf0-x229.google.com with SMTP id m18so8641741lfj.0
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:31 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:12 +0300
Message-Id: <cover.1496234766.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/15] Misc linux-user updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, Riku Voipio <riku.voipio@linaro.org>

From: Riku Voipio <riku.voipio@linaro.org>

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  git://git.linaro.org/people/riku.voipio/qemu.git tags/pull-linux-user-20170531

for you to fetch changes up to ba9fcea1cb6d80536f780760d870416fe5b85863:

  linux-user: add strace support for uinfo structure of rt_sigqueueinfo() and rt_tgsigqueueinfo() (2017-05-29 14:56:09 +0300)

----------------------------------------------------------------
Misc linux-user updates

----------------------------------------------------------------

Andreas Schwab (1):
  linux-user: remove all traces of qemu from /proc/self/cmdline

Laurent Vivier (4):
  linux-user: call fd_trans_target_to_host_data() for write()
  linux-user: fix eventfd
  linux-user: fix fadvise64_64() on ppc
  linux-user: fix inotify

Miloš Stojanović (9):
  linux-user: add strace for getuid(), gettid(), getppid(), geteuid()
  linux-user: add tkill(), tgkill() and rt_sigqueueinfo() strace
  linux-user: fix ssetmask() system call
  linux-user: fix mismatch of lock/unlock_user() invocations in
    rt_sigqueinfo() syscall
  linux-user: fix argument type declaration of rt_sigqueinfo() syscall
  linux-user: add support for rt_tgsigqueueinfo() system call
  linux-user: add rt_tgsigqueueinfo() strace
  linux-user: fix inconsistent spaces in print_siginfo() output
  linux-user: add strace support for uinfo structure of
    rt_sigqueueinfo() and rt_tgsigqueueinfo()

Prasad J Pandit (1):
  linux-user: allocate heap memory for execve arguments

 linux-user/strace.c    | 177 +++++++++++++++++++++++++++++++++++++++++++++++--
 linux-user/strace.list |  16 ++---
 linux-user/syscall.c   | 161 ++++++++++++++++++++++++++++----------------
 3 files changed, 284 insertions(+), 70 deletions(-)

-- 
2.11.0
