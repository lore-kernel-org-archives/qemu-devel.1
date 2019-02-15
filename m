Received: from eggs.gnu.org ([209.51.188.92]:59146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gueWN-0007np-J4
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gueWM-0000B8-Np
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:19 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gueWM-0000AI-DJ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id x10so10536114wrs.8
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:31:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Feb 2019 14:31:12 +0000
Message-Id: <20190215143115.28777-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v3 0/3] softmmu demacro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, mark.cave-ayland@ilande.co.uk, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is hopefully the final version of the softmmu demacro series. I
tracked down the remaining failures to:

  - not always using the correct victim tlb
  - not masking reads when we unrolled the unaligned helpers

Other than that I've rolled in the changes that were made to support
dynamic TLB code and the follow-up fixes. All patches need some review
before we can merge them.

Alex Bennée (3):
  accel/tcg: demacro cputlb
  accel/tcg: remove softmmu_template.h
  accel/tcg: move unaligned helpers out of core helpers

 accel/tcg/cputlb.c           | 501 +++++++++++++++++++++++++++++++++--
 accel/tcg/softmmu_template.h | 454 -------------------------------
 2 files changed, 475 insertions(+), 480 deletions(-)
 delete mode 100644 accel/tcg/softmmu_template.h

-- 
2.20.1
