Received: from eggs.gnu.org ([209.51.188.92]:44053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoZP-0001QT-Nj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjoZO-0001Bf-Rp
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:39 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gjoZO-00017N-L3
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 12:01:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 16 Jan 2019 12:01:11 -0500
Message-Id: <20190116170114.26802-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v7 0/3] Dynamic TLB sizing
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

v6: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02998.html

Changes since v6:

- Define TCG_TARGET_IMPLEMENTS_DYN_TLB for tcg/riscv (patch 2).

- Fix --disable-tcg breakage (reported by Alex) by moving
  tlb_entry_is_empty to cputlb.c, since the function's only caller
  is in that file (patch 1).

You can fetch this series from:
  https://github.com/cota/qemu/tree/tlb-dyn-v7

Thanks,

		Emilio
