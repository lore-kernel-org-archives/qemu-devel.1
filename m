Received: from eggs.gnu.org ([2001:4830:134:3::10]:36030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJzxN-0003nb-0P
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJzxJ-0006wZ-8Z
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:55:39 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJzxF-0006W9-LE
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:55:33 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 40so10906832oth.4
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 03:55:22 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 11:55:01 +0000
Message-ID: <CAFEAcA9J__5kPwE7P4SwHYmOp=V0fzoGq5BzBKeStytb6W3=ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] aarch32 acquire/release vs mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Looking through code I noticed that in target/arm/translate.c there
is the following comment in the decode for the load-acquire/store-release
instructions:

      /* Since the emulation does not have barriers,
         the acquire/release semantics need no special
         handling */

This is out of date now we have MTTCG, isn't it?
The equivalent code in translate-a64.c has some calls to tcg_gen_mb()
to emit barriers...presumably we need to fix the a32 code to do
the same.

(We haven't noticed this because I think in practice nobody
much is compiling Armv8-specific AArch32 code.)

thanks
-- PMM
