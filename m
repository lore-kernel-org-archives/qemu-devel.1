Received: from eggs.gnu.org ([209.51.188.92]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hAnkS-0000f2-Lb
	for qemu-devel@nongnu.org; Sun, 31 Mar 2019 23:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hAnkK-0004l3-E2
	for qemu-devel@nongnu.org; Sun, 31 Mar 2019 23:36:30 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f]:42186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tedheadster@gmail.com>)
	id 1hAnkC-0004ea-L4
	for qemu-devel@nongnu.org; Sun, 31 Mar 2019 23:36:22 -0400
Received: by mail-ua1-x92f.google.com with SMTP id h4so127438uaj.9
	for <qemu-devel@nongnu.org>; Sun, 31 Mar 2019 20:36:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From: tedheadster <tedheadster@gmail.com>
Date: Sun, 31 Mar 2019 23:36:02 -0400
Message-ID: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Pentium Pro Feature Bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I just noticed this in the code regarding MMX and I wonder if it is correct:

target/i386/cpu.c:

#define PPRO_FEATURES (CPUID_FP87 | CPUID_DE | CPUID_PSE | CPUID_TSC | \
          CPUID_MSR | CPUID_MCE | CPUID_CX8 | CPUID_PGE | CPUID_CMOV | \
          CPUID_PAT | CPUID_FXSR | CPUID_MMX | CPUID_SSE | CPUID_SSE2 | \
          CPUID_PAE | CPUID_SEP | CPUID_APIC)

The problem I see is that the PentiumPro never supported the MMX
instruction extensions (oddly supported in the the Pentium MMX), nor
the even later SSE (Pentium III) and SSE2 (Pentium 4) features.

Also, the Pentium Pro never officially supported  SYSENTER/SYSEXIT
(CPUID_SEP), though they originally intended to. Intel discovered
shortly before the product release that the hardware didn't work
correctly, so they never documented it as a feature to prevent its
use.

Should these be removed?

- Matthew
