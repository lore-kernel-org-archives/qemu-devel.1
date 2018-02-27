Received: from eggs.gnu.org ([2001:4830:134:3::10]:50932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzG-0004aW-8x
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzC-0000PZ-9h
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:38 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eqXzC-0000NJ-13
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Feb 2018 00:39:09 -0500
Message-Id: <1519709965-29833-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 00/16] tcg: tb_lock removal redux v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

With this set we finally remove tb_lock. The performance gains
when booting a guest are compelling at low core counts. However,
beyond 8 cores performance doesn't improve due to unrelated
contention--see results in the last patch of the series
("tcg: remove tb_lock").

I have another series that greatly reduces this other contention by
using per-CPU locks instead of the BQL to keep track of a subset
of CPUState. But that series is pretty large so let's deal with
this first.

You can fetch the patches from:
  https://github.com/cota/qemu/tree/tb-lock-removal-redux-v1

Thanks,

		Emilio
