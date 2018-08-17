Received: from eggs.gnu.org ([2001:4830:134:3::10]:57745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqoPF-0004vU-AB
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqoBj-0003HX-Mq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:29:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58227)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqoBj-0003Gu-EN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 19:29:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 19:29:17 -0400
Message-Id: <20180817232923.28899-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/6] qht improvements for 3.1
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

A small series with:

- The addition of qht_iter_remove, necessary to safely remove
  a set of elements. This currently has no users, but it's
  easy to implement and very useful to have. (I initially wrote
  it for the sync-profiler, but for unrelated reasons I ended up
  changing the profiler's design not to remove elements.)

- A 3.75X speedup for test-qht

- Improvements to qht.c's code coverage with test-qht

You can fetch this series from:
  https://github.com/cota/qemu/tree/qht-for-3.1

Thanks,

		Emilio
