Received: from eggs.gnu.org ([2001:4830:134:3::10]:47458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezJFE-0005D3-Jq
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezJFA-0003VY-6W
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:44:20 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezJFA-0003VG-0U
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:44:16 -0400
Received: by mail-ot0-x243.google.com with SMTP id t2-v6so12592527otj.4
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 02:44:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180322215833.7713-1-laurent@vivier.eu>
References: <20180322215833.7713-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 09:43:54 +0000
Message-ID: <CAFEAcA8MKD2LxgouprA9pRWD6F+c50LoWyLS1o-PVJPYRodt2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.13 0/5] linux-user: move arch
 specific parts to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 22 March 2018 at 21:58, Laurent Vivier <laurent@vivier.eu> wrote:
> Some files like signal.c are really hard to read
> because all architectures are mixed in the same
> file.
>
> This series moves from signal.c these parts to
> the architecture dedicated directories in linux-user.
> Moerover, this allows to compare easier functions
> between architectures (it helps to debug problems).
> Adding new functions for a new architecture will
> be facilitated too.
>
> As we are doing that for signal.c, we can also
> do that for main.c, for the cpu loop part
> and the cpu loop prologue too.

Yeah, this is something I've kind of had on my backlog
of "it would be nice to do this" for years. Thanks
for putting in the work!

> checkpatch.pl is not happy... but I only want to
> move code from a file to another. I don't want
> to change the content of the parts I move.

Yeah, that's reasonable. (Since the move will reduce
the effectiveness of git blame anyway we might want
to do a fix-coding-style pass afterwards, but we can
do that as a separate patchset.)

thanks
-- PMM
