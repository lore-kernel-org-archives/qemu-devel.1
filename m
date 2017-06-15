Received: from eggs.gnu.org ([2001:4830:134:3::10]:51932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLUuE-0001IQ-Pk
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLUuE-0000ZO-3j
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:33:50 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLUuD-0000Z8-UJ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 09:33:50 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 77so22268006wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 06:33:49 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 14:33:27 +0100
Message-ID: <CAFEAcA_3Uf-t7MgvTqO52XX61z3Mcnmpk1XNJRqgdFJiVP1ALQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] spapr guests warn "System page size 0x2000 is not
 enabled in page_size_mask (0x11000). Performance may be slow" on SPARC
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

I've just noticed that on a SPARC host, some of the PPC guests
warn during make check:

  /ppc64/prom-env/pseries:
qemu-system-ppc64: System page size 0x2000 is not enabled in
page_size_mask (0x11000). Performance may be slow

Is this really a performance problem on a TCG guest?
It makes the 'make check' output a bit noisy, but not
unbearably so.

thanks
-- PMM
