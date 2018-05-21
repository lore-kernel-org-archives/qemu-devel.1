Received: from eggs.gnu.org ([2001:4830:134:3::10]:57821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOt-0002eC-3s
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOo-0005W5-7I
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOo-0005UO-1Z
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:10 -0400
Message-Id: <1526945967-9687-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

v2: https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg00656.html

Changes since v2:

- rebase onto master, fixing conflicts

- add R-b's

- add a missing page_lock to page_collection_lock

- add a couple of missing assert_page_locked assertions

- add page_lock_pair, as suggested by Alex and Richard

- use a per-thread GHashTable to keep track of locked pages

- get rid of page_collection assertions, and just export
  assert_no_pages_locked() [Alex: I removed your R-b.]

Thanks,

		Emilio
