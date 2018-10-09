Received: from eggs.gnu.org ([2001:4830:134:3::10]:54268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9wAU-0006lL-Sh
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9wAR-0002Er-JQ
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:51:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34691)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9wAR-0002DX-9x
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:51:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  9 Oct 2018 13:51:24 -0400
Message-Id: <20181009175129.17888-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 0/5] Dynamic TLB sizing
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01495.html

Changes since v2:

- Add R-b's

- Apply on top of tlb-lock-v5 series, fixing the alpha
  boot segfault due to the early tlb_flush
  + The series now passes `make check-qtest'

- Alloc the iotlb with g_new instead of g_new0

- Remove an unnecessary style change from patch 1 (reported by Alex)

- Minor tweak to the last patch's commit message

You can fetch this series from:
  https://github.com/cota/qemu/tree/tlb-dyn-v3

Thanks,

		Emilio
