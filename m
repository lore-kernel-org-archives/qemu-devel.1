Received: from eggs.gnu.org ([209.51.188.92]:42595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUh0-000897-OO
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjUgy-0006yJ-Nu
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:10 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55339)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjUgx-0006wz-Ev
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:48:08 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 15 Jan 2019 14:47:52 -0500
Message-Id: <20190115194754.7670-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/2] cpu-exec fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

Just a couple of small fixes.

The first adds an assert that we should have added when performing
the conversion from tb_lock to per-page locks.

The second adds a missing reset of the BQL after the longjmp in
cpu_exec_step_atomic returns.

Thanks,

		Emilio
