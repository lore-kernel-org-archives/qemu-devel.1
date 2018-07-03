Received: from eggs.gnu.org ([2001:4830:134:3::10]:47008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1faV60-0007zq-HZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 19:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1faV5z-0001g6-Eo
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 19:52:32 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:37489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1faV5z-0001fy-82
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 19:52:31 -0400
Received: by mail-vk0-x242.google.com with SMTP id h22-v6so2112488vke.4
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180702151023.24532-1-shorne@gmail.com>
	<20180702151023.24532-23-shorne@gmail.com>
	<feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
In-Reply-To: <feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
From: Stafford Horne <shorne@gmail.com>
Date: Wed, 4 Jul 2018 08:51:42 +0900
Message-ID: <CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 22/25] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

Hello,

On Wed, Jul 4, 2018, 7:34 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:

> Hi Stafford,
>
> On 07/02/2018 12:10 PM, Stafford Horne wrote:
> > From: Richard Henderson <richard.henderson@linaro.org>
> >
> > All of the existing code was boilerplate from elsewhere,
> > and would crash the guest upon the first signal.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> >
> > ---
> > v2:
> >   Add a comment to the new definition of target_pt_regs.
> >   Install the signal mask into the ucontext.
> > v3:
> >   Incorporate feedback from Laurent.
>
> Oops this is not supposed to enter git history, something is wrong with
> your pull request script.
>

Sorry, I brought these in from Richards tree and saw them but thought it
was fine to keep the annotations.

I'll remove them from patches in the future.

Richard, how do you usually remove these before your pr?  I suppose you
have some kind of script?

-stafford




> > ---
> >  linux-user/openrisc/signal.c         | 217 +++++++++++----------------
> >  linux-user/openrisc/target_syscall.h |  28 +---
> >  linux-user/signal.c                  |   2 +-
> >  target/openrisc/cpu.c                |   1 +
> >  4 files changed, 94 insertions(+), 154 deletions(-)
>
> <snip>
>
