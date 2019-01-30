Received: from eggs.gnu.org ([209.51.188.92]:44378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1gowNt-0004KJ-KG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1gowNr-0008MR-DC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:22:56 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:45777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mathew1800@gmail.com>)
	id 1gowNq-0008LG-5y
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:22:55 -0500
Received: by mail-io1-xd2b.google.com with SMTP id c2so650633iom.12
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:22:52 -0800 (PST)
From: Mathew Maidment <mathew1800@gmail.com>
Date: Wed, 30 Jan 2019 15:22:42 -0500
Message-Id: <20190130202243.79545-1-mathew1800@gmail.com>
Subject: [Qemu-devel] [PATCH 0/1] target/arm: Amend erroneous BRAA/BLRAA
 opcode check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Hi,

This is a patch that fixes a condition within disas_uncond_b_reg() related to
BRAA and BLRAA that would always result in the unallocated encoding path being
taken.

Hopefully everything is in order. This is only my second patch, so if anything
is wrong, that's my bad.

Thanks in advance for reviewing =)

Mathew Maidment (1):
  target/arm: Amend erroneous BRAA/BLRAA opcode check

 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.2 (Apple Git-113)
