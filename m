Received: from eggs.gnu.org ([2001:4830:134:3::10]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccGCM-0004Al-J8
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccGCH-0004p9-P5
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:34 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:35465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ccGCH-0004ok-JP
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:45:29 -0500
Received: by mail-yw0-x244.google.com with SMTP id l16so3175505ywb.2
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:45:29 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 10 Feb 2017 13:45:23 -0500
Message-Id: <20170210184525.10966-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] mttcg: Handle exception and flags in
 atomic execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

The previous version, though ideal, needs more work to enable calling
start_exclusive() from cpu_exec() and also does not properly handle
exception from atomic context. Exceptions in atomic context will not
call exclusive_end() and would go to the outer most loop causing a deadlock.

The following patches allow proper handling of flags set and
exceptions from the atomic exectuion context.

Alex, please fold/squash them as you feel necessary.

Pranith Kumar (2):
  tcg: Save cpu flags in atomic execution
  tcg: Set jmp_env to handle exceptions from atomic execution

 cpu-exec.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.11.0
