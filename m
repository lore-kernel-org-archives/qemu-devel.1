Received: from eggs.gnu.org ([2001:4830:134:3::10]:40612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjv-0003al-K8
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbR-0005IN-Uw
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbR-0005HX-MQ
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:40 -0400
Message-Id: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/12] i386 + x86_64 mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

v1: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00237.html

Changes since v1:

- Add Alex's R-b tags
- Introduce atomic64 to just use a spinlock when doing atomic_set/read
  on i64's and u64's if !CONFIG_ATOMIC64, just like the kernel does.
  + Add a benchmark for these types of accesses to tests/
  + Add i/d cacheline_size_log
- Convert qsp to atomic64
- Convert test-rcu-list to atomic64
  + Add comments about what the patch does, as suggested by Murilo
- Convert cpus.c to atomic64
- Always use seqlock_write on cpu_update_icount

There's one checkpatch error, but it's a false positive.

You can fetch this series from:
  https://github.com/cota/qemu/tree/i386-mttcg-v2

Thanks,

		Emilio
