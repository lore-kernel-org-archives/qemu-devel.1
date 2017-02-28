Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinAs-0004zN-Bx
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinAr-000075-3l
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:11:02 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cinAq-00005q-P1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:11:01 -0500
Received: by mail-wm0-x235.google.com with SMTP id v77so19529331wmv.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:11:00 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 19:10:39 +0000
Message-ID: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

I got a make check failure on aarch64 host running a sparc64 test:


TEST: tests/prom-env-test... (pid=13573)
  /sparc64/prom-env/sun4u:                                             **
ERROR:/home/pm215/qemu/translate-common.c:34:tcg_handle_interrupt:
assertion failed: (qemu_mutex_iothread_locked())
Broken pipe
FAIL
GTester: last random seed: R02Sa5fa983185fe5e65cfb5b7fcb39ed3d1
(pid=13579)
FAIL: tests/prom-env-test

This is with commit 9514f2648ca05b3.

It didn't reproduce on a rerun of 'make check' and it didn't
look like the merge in question was particularly relevant to
the failure, so I went ahead and pushed it to master.

I'm (perhaps unfairly) assuming that this is fallout from MTTCG
landing. (prom-env-test is one of the handful of tests in
'make check' that actually runs TCG code.)

thanks
-- PMM
