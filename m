Received: from eggs.gnu.org ([2001:4830:134:3::10]:49054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPO-0001GK-6C
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPI-00019A-9X
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39169)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRP8-0000zI-Lp
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:24 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:47 -0400
Message-Id: <20180910185859.27917-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/12] qht improvements for 3.1
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

v1: https://github.com/cota/qemu/tree/qht-for-3.1-v2

Changes since v1:

- Added Alex's R-b tags to patches 1-6
- Added a patch to drop *ht from qht_iter and qht_iter_remove,
  as suggested by Alex.
- Added some constification patches
- Added a flag to qht-bench to precompute the hashes, which
  allows us to spend more time accessing the hash table
  thereby yielding higher throughput.

You can fetch this series from:
  https://github.com/cota/qemu/tree/qht-for-3.1-v2

Thanks,

		Emilio
