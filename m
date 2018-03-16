Received: from eggs.gnu.org ([2001:4830:134:3::10]:51625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewsJs-0008Il-7L
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewsJp-0007bc-S1
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:35:04 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewsJp-0007au-Nr
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:35:01 -0400
Received: by mail-ot0-x244.google.com with SMTP id q5-v6so298531oth.12
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:35:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
References: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 16:34:40 +0000
Message-ID: <CAFEAcA-x8PryWiOdh3CR-0o5UvL=0day0LMUyPRKzy2dE0XL=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead
 of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 16 March 2018 at 16:23, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
> Since the commit:
> commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:   Wed Mar 7 14:42:05 2018 +0000
>
>     vl: introduce vm_shutdown()
>
> GDB crash when qemu exits (at least on sparc-softmmu):
> Remote communication error.  Target disconnected.: Connection reset by peer.
> Quitting: putpkt: write failed: Broken pipe.
>
> So send a packet to kill GDB before we exit QEMU:
> [Inferior 1 (Thread 0) exited normally]
>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  gdbstub.c              | 7 +++++++
>  include/exec/gdbstub.h | 2 ++
>  vl.c                   | 2 ++
>  3 files changed, 11 insertions(+)

We didn't send an exiting packet before commit 4486e89c219c0,
so do you know why this worked before then? (Telling gdb we're
exiting seems like the right thing, though.)

thanks
-- PMM
