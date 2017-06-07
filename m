Received: from eggs.gnu.org ([2001:4830:134:3::10]:34787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoI-0002gY-7n
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoF-0000hN-48
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:18 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:33360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dIjoF-0000hI-04
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:15 -0400
Received: by mail-yw0-x243.google.com with SMTP id y64so1307618ywe.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 15:52:14 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed,  7 Jun 2017 18:52:09 -0400
Message-Id: <20170607225212.23714-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 0/3] Remove code buffer size limitation on
 aarch64 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

Hi,

The following patches apply on top of tcg-next of rth's branch. These
patches make use of LDR (literal) on aarch64 and enable us to remove
the 128MB code buffer size limitation.

Pranith Kumar (3):
  tcg/aarch64: Introduce and use jump to register
  tcg/aarch64: Introdue LDR (literal) generation for aarch64
  tcg/aarch64: Remove code buffer size limitation

 include/exec/exec-all.h      |  6 +-----
 tcg/aarch64/tcg-target.inc.c | 42 +++++++++++++++++++++---------------------
 translate-all.c              |  2 --
 3 files changed, 22 insertions(+), 28 deletions(-)

-- 
2.13.0
