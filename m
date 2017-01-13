Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS2QJ-0008Gd-6K
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cS2QI-0000vj-Bt
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:01:43 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:35735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cS2QI-0000vP-97
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:01:42 -0500
Received: by mail-ua0-x232.google.com with SMTP id y9so37434681uae.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 06:01:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2017 14:01:20 +0000
Message-ID: <CAFEAcA9WvZbup0AkuUDBPqaA3_xoUncKTKWj-ZHx5F0NBaOwXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/30] target-sparc sun4v support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 12 January 2017 at 02:55, Richard Henderson <rth@twiddle.net> wrote:
> Mark Cave-Ayland asked me to handle the merge of this patch set
> while he is traveling.
>
> This is the v2 that Artyom posted today.  I had reviewed the majority
> of v1 earlier.  I re-read through the rebase and saw nothing amiss.
> It passes my tests for sparc32, and does run the OpenSolaris image
> to which Artyom links.
>
>
> r~
>
>
> The following changes since commit 41a0e54756a9ae6b60be34bb33302a7e085fdb07:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-01-10 10:46:21 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-sparc-20170111
>
> for you to fetch changes up to 224be7cc93a37ccd38342811a8925de889de1a49:
>
>   target-sparc: fix up niagara machine (2017-01-11 12:23:58 -0800)
>
> ----------------------------------------------------------------
> Sun4v support

This hits clang's unused-function error;

/home/petmay01/linaro/qemu-for-merges/target/sparc/ldst_helper.c:346:20:
error: unused function 'do_check_asi' [-Werror,-Wunused-function]
static inline void do_check_asi(CPUSPARCState *env, int asi, uintptr_t ra)
                   ^
1 error generated.

thanks
-- PMM
