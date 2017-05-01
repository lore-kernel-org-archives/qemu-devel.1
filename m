Received: from eggs.gnu.org ([2001:4830:134:3::10]:55358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jayanto@gmail.com>) id 1d5ENz-0003mK-RU
	for qemu-devel@nongnu.org; Mon, 01 May 2017 12:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jayanto@gmail.com>) id 1d5ENy-00040t-W9
	for qemu-devel@nongnu.org; Mon, 01 May 2017 12:41:19 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:34640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jayanto@gmail.com>) id 1d5ENy-00040i-O6
	for qemu-devel@nongnu.org; Mon, 01 May 2017 12:41:18 -0400
Received: by mail-lf0-x22c.google.com with SMTP id t144so62610773lff.1
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 09:41:18 -0700 (PDT)
MIME-Version: 1.0
From: Jayanto Minocha <jayanto@gmail.com>
Date: Mon, 1 May 2017 09:41:16 -0700
Message-ID: <CADR1n+XpiLvtc3mKhQH8qNTJYR0UaNx1e5r-We3aheTYXdhQxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Instruction tracing for ARM64 targets
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

I am trying to generate instruction traces for an ARM64 VM (on an x86_64
host). There is a thread on this very topic in the archives (
https://lists.nongnu.org/archive/html/qemu-devel/2008-04/msg00038.html),
but the embdedded link is not functional at this point. Also, given that
the thread is ~8 years old, some of the internals might have changed.

I did go over the documentation on tracing, and it appears that I can
instrument the execution of the translation blocks generated via TCG
(cpu_exec.c:exec_tb*). And if I stare at target/arm/translate-a64.c, it
looks like I might be able to dump out the constituent instructions of
every tracing block, the first time it is encountered. With those two
pieces, it should theoretically be possible to get the exact sequences of
instructions executed.

I'd really appreciate if anyone can advise me on the relative
merits/demerits of this approach; and suggest better alternatives.

Regards,
-Jayanto
