Received: from eggs.gnu.org ([2001:4830:134:3::10]:53984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHF-00012b-1T
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLEHB-0008Ra-HT
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:28 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLEHB-0008RO-D2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 15:48:25 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so2212300qtg.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 12:48:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 14 Jun 2017 12:48:16 -0700
Message-Id: <20170614194821.8754-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 0/5] Fixes for TCG hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, cota@braap.org, pbonzini@redhat.com

Some good detective work by all involved.  This is attemping to
get all of the feedback from this morning.


r~


Paolo Bonzini (1):
  target/mips: Exit after enabling interrupts

Richard Henderson (4):
  tcg: Refactor helper_lookup_tb_ptr
  target/alpha: Use tcg_gen_lookup_and_goto_ptr
  target/s390x: Exit after changing PSW mask
  target/arm: Exit after clearing interrupt mask

 target/alpha/translate.c   | 27 ++++++++++++++++++++++-----
 target/arm/translate-a64.c |  7 ++++++-
 target/mips/translate.c    |  6 ++++--
 target/s390x/translate.c   | 14 ++++++++++----
 tcg-runtime.c              | 34 ++++++++++++++++++----------------
 5 files changed, 60 insertions(+), 28 deletions(-)

-- 
2.9.4
