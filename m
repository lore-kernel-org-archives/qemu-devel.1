Received: from eggs.gnu.org ([209.51.188.92]:50360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24mg-0006Wo-3M
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24md-0007gq-4P
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:48 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:41352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h24mZ-0007RG-4V
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:43 -0500
Received: by mail-pg1-x52a.google.com with SMTP id k11so11809923pgb.8
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:58:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 17:58:28 -0800
Message-Id: <20190308015830.10980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] target/hppa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2a6:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-03-07 16:16:02 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190307

for you to fetch changes up to b35aec8597e86911d5553c94769f914a52a8b389:

  target/hppa: Optimize blr r0,rn (2019-03-07 17:43:12 -0800)

----------------------------------------------------------------
Fix use after free on temporary.
Optmize branch to next insn via br r0.

----------------------------------------------------------------
Richard Henderson (2):
      target/hppa: Do not return freed temporary
      target/hppa: Optimize blr r0,rn

 target/hppa/translate.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)
