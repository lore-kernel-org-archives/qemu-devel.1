Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5c-00035x-1N
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9w5X-0005nt-Ay
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:52453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9w5W-0005gf-Uu
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:46:31 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  9 Oct 2018 13:45:51 -0400
Message-Id: <20181009174557.16125-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 0/6] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v4: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01421.html

Changes since v4:

- Add two patches to remove early calls to tlb_flush.

You can fetch the series from:
  https://github.com/cota/qemu/tree/tlb-lock-v5

Thanks,

		Emilio
