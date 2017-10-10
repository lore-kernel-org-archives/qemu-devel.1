Received: from eggs.gnu.org ([2001:4830:134:3::10]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1r6D-0006uy-8q
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1r6C-0001NB-0W
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:45:17 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:55255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1r6B-0001LD-Im
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:45:15 -0400
Received: by mail-wm0-x22b.google.com with SMTP id i124so3483557wmf.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 02:45:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507622059-4493-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1507622059-4493-1-git-send-email-jiang.biao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 10:44:53 +0100
Message-ID: <CAFEAcA8YFPm3eCx62m7kEYgjY7SKCbnP=nZkGMWUt40JBA+ORQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: fix false error of
 externs checking.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: QEMU Developers <qemu-devel@nongnu.org>, zhong.weidong@zte.com.cn

On 10 October 2017 at 08:54, Jiang Biao <jiang.biao2@zte.com.cn> wrote:
> When adding a function declaration in a .c file without extern
> keywork decoration, checkpatch.pl will report *externs should be
> avoided in .c files* false error. This patch fixes the bug.

I don't think this is a bug. "extern int foo(void);" and
"int foo(void);" have the same effect: they declare a function
prototype that can be called from outside the file.
We don't want to permit that in QEMU. Either:
 (1) the function is for use only within this file: the
 declaration should be "static int foo(void);"
 (2) the function is for use by other files too: the
 declaration should be in a header file, not a .c file,
 so the other files can use it

Do you have an example of code where this warning is a problem?

thanks
-- PMM
