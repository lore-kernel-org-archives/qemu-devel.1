Received: from eggs.gnu.org ([209.51.188.92]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj5RX-0006oH-Lv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gj5RW-0001xN-PY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:50:31 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gj5RW-0001u7-CD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:50:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 14 Jan 2019 11:50:14 -0500
Message-Id: <20190114165017.27298-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 0/3] Dynamic TLB sizing
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

v5: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg03708.html

Changes since v5:

- Drop quadrupling of TLB size when use rate == 100%.

- Limit TLB max sizes for 32 and 64-bit hosts, as suggested by rth.

- Handle failure when allocating the new TLB, as suggested by rth.
  Add a loop that halves the allocation size until the allocations
  succeed.

Performance numbers are in the last patch.

You can fetch this series from:
  https://github.com/cota/qemu/tree/tlb-dyn-v6

Thanks,

		Emilio
