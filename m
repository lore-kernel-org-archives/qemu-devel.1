Received: from eggs.gnu.org ([2001:4830:134:3::10]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jayanto@gmail.com>) id 1dN418-0004ux-Iq
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jayanto@gmail.com>) id 1dN417-0001id-Qo
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:15:26 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:32878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jayanto@gmail.com>) id 1dN417-0001hq-I9
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:15:25 -0400
Received: by mail-lf0-x22b.google.com with SMTP id m77so63223352lfe.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 14:15:24 -0700 (PDT)
MIME-Version: 1.0
From: Jayanto Minocha <jayanto@gmail.com>
Date: Mon, 19 Jun 2017 14:15:21 -0700
Message-ID: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I think there have been a few threads on the mailing list regarding tracing
guest virtual addresses for load and store instructions, but I have been
unable to get it to work. I am trying this for an AArch64 machine, and am
using the softmmu.

The tracing infrastructure provides the following event:

vcpu tcg guest_mem_before(...).

But that is only used to instrument the cpu_ld/cpu_st macros, which is only
called in the case of a tlb miss.

I've been going over the archives, and it looks like I need to instrument
tcg_out_tlb_load. Am I on the right path ?

Regards,
-Jayanto
