Received: from eggs.gnu.org ([209.51.188.92]:35347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hIDJf-0004xe-Jw
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 10:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hIDJe-00076h-IY
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 10:19:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hIDJe-00075B-Cc
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 10:19:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id e5so6926720oii.0
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 07:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190419114502.20388-1-shahab.vahedi@gmail.com>
	<CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
	<20190421080314.GA1817@gmail.com>
In-Reply-To: <20190421080314.GA1817@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 21 Apr 2019 15:19:21 +0100
Message-ID: <CAFEAcA-=HXpUR0f84c9nMvmktsLZ9ooE7NvryQGstiZ+BnhpXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shahab Vahedi <shahab.vahedi@gmail.com>
Cc: "open list:Overall" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Sun, 21 Apr 2019 at 09:03, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
>
> Hi Peter,
>
> On Sat, Apr 20, 2019 at 07:57:31PM +0100, Peter Maydell wrote:
> > On Fri, 19 Apr 2019 at 12:46, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
> > >
> > > This change adapts io_readx() to its input access_type. Currently
> > > io_readx() treats any memory access as a read, although it has an
> > > input argument "MMUAccessType access_type". This results in:
> > >
> > > 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> > > 2) Considering only entry->addr_read as the tlb_addr
> > >
> > > Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
> > >
> > > Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> > > ---
> > > Changelog:
> > > - Extra space before closing parenthesis is removed
> > >
> > >  accel/tcg/cputlb.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > Hi; this patch mostly looks good; thanks for submitting it.
> >
> Please let me remind you that there is a newer [PATCH v3].

Oops, yes, I missed that (was going through a lot of
list emails after being away for a bit). Sorry.

> I have a question though: Richard (Henderson) has already
> _reviewed_ [PATCH v3]. Is it OK if I change the code further
> and submit yet a newer version?

If you think it's necessary, you can -- for instance if
you find a bug or other problem in it. If you change
the code much then you should drop the reviewed-by:
line as the code needs re-review. If the change is
entirely trivial (eg fixing a comment typo) then you
can let the reviewed-by tag stand (ie include it in
the version you send out).

But if you're thinking of doing it just to fiddle
with the ?: style issue I suggested above, don't
bother -- it doesn't matter that much (and not
trying to deal with all 3 cases means you don't
have the nested ?: anyway).

thanks
-- PMM
