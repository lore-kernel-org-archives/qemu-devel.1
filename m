Received: from eggs.gnu.org ([2001:4830:134:3::10]:56443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjs-0007oZ-UI
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjp-0002if-8K
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:16 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7fjo-0002hw-G3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:12 -0400
Received: by mail-wr0-x243.google.com with SMTP id l1so2740135wrc.3
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 03:50:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 12:50:03 +0200
Message-Id: <20171026105007.31777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/4] target/i386 tcg updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com

Resurrecting some patches that were on the list in July.
There are two bug fixes in here, so we should at least
get those into 2.11.

Changes since v1:
  * Rebased, adjusting for x86_ldub_code.


r~


Ricardo Ribalda Delgado (1):
  target/i386: Fix ANDN (bmi)

Richard Henderson (3):
  target/i386: Decode AMD XOP prefix
  target/i386: Implement all TBM instructions
  target/i386: Fix BLSR and BLSI

 target/i386/cc_helper_template.h |  18 ++++
 target/i386/cpu.h                |   7 +-
 target/i386/cc_helper.c          |  28 +++++-
 target/i386/cpu.c                |   3 +-
 target/i386/translate.c          | 191 ++++++++++++++++++++++++++++++++-------
 5 files changed, 209 insertions(+), 38 deletions(-)

-- 
2.13.6
