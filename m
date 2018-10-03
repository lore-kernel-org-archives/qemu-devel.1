Received: from eggs.gnu.org ([2001:4830:134:3::10]:41149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7nOI-0002cf-Ro
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7nOF-0006w8-B0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:05:02 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7nOE-0006u1-V2
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:04:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  3 Oct 2018 16:04:50 -0400
Message-Id: <20181003200454.18384-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 0/4] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00395.html

Changes since v1:

- Rebase on master

- Expand lock usage to other tlb_table/tlb_v_table updates, which I
  missed in v1

- Fix assert_cpu_is_self macro

- Add comment on why the owner thread doesn't need to use atomic_set
  for updates

- Add more calls to assert_cpu_is_self macro, which together with
  the added comment should make the code simpler to understand

- Include perf numbers in the last patch

The series is checkpatch-clean. You can fetch the code from:
  https://github.com/cota/qemu/tree/tlb-lock-v2

Thanks,

		Emilio
