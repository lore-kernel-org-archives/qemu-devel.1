Received: from eggs.gnu.org ([2001:4830:134:3::10]:58889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fk92Y-0003fu-9w
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fk92X-0004MR-Ia
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:20:50 -0400
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 30 Jul 2018 16:20:48 +0200
Message-ID: <CABoDooMqFQz_ssUKxMgxRCArF0dLCAa+=cjY5bqR399ZoHcxvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ARM: SVE issue in cmpeq/cmpne
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hello Richard,

According to SVE definition, the operands of cmpeq/cmpne SVE
instructions are signed, so I guess the definitions of
sve_cmpeq_ppzw_[bhs] and sve_cmpne_ppzw_[bhs] should use signed types.
The other cmpcc instructions look good.

Thanks,

Laurent
