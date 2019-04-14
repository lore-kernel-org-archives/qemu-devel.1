Received: from eggs.gnu.org ([209.51.188.92]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hFTkT-00088N-SO
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 21:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hFTkS-0000X1-LP
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 21:15:57 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33]:34179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hFTkS-0000Wf-9s
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 21:15:56 -0400
Received: by mail-yb1-xb33.google.com with SMTP id a3so5095715ybr.1
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 18:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
In-Reply-To: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 13 Apr 2019 18:15:43 -0700
Message-ID: <CAMo8BfLEEF2_FVU88ydBWVmcRbCJ9T0ULrDEKRa-+hmCYo9cmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to I trigger a rebuild?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joachim Durchholz <jo@durchholz.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sat, Apr 13, 2019 at 8:28 AM Joachim Durchholz <jo@durchholz.org> wrote:
> I did the usual ./configure; make dance.
> Then modified a source file (ui/curses.c), called make again, but didn't
> see curses.c recompiled, and the change was indeed ineffective.
> make clean; make didn't help either.

Perhaps you don't have CONFIG_CURSES enabled?
Did you call configure with --enable-curses ?

> Is there a list of make targets anywhere?

Typically in a Makefile.objs in each directory.

-- 
Thanks.
-- Max
