Received: from eggs.gnu.org ([2001:4830:134:3::10]:52281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gSd21-0001Mw-KC
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gSd20-0007xm-Qx
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:16:09 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1gSd20-0007ws-Ll
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 02:16:08 -0500
Received: by mail-qk1-x743.google.com with SMTP id m5so2609849qka.9
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 23:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20181128053834.10861-1-richard.henderson@linaro.org>
	<20181128221530.GA32160@flamenco>
	<9d890088-8dd6-517d-52a7-a6166f0cd8a6@linaro.org>
	<20181130003915.GA3323@flamenco> <20181130030009.GA14990@flamenco>
In-Reply-To: <20181130030009.GA14990@flamenco>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 30 Nov 2018 08:15:56 +0100
Message-ID: <CABoDooOcT-Yp__TJMj4roHMeq_T20=14-kf4L1gGNemv-gRoZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/12] tcg: Improve register allocation for
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Nov 30, 2018 at 4:00 AM Emilio G. Cota <cota@braap.org> wrote:
>
> On Thu, Nov 29, 2018 at 19:39:15 -0500, Emilio G. Cota wrote:
> > A64 and POWER9 host numbers:
> >
> >   https://imgur.com/a/m6Pss99
> >
> > There's quite a bit of noise in the P9 measurements, but it's
> > a shared machine so I can't do much about that.
> >
> > I'll update the A64 results with error bars later tonight,
> > when I get further results.
>
> Here they are:
>
>   https://imgur.com/a/EAAapSW

What is a X-Gene A57? It's either X-Gene or A57 :-)

Thanks,

Laurent

> The second image is the same results, but zoomed in. I could
> bring the confidence intervals down by running this many times,
> but each run takes 2h and I only have access to the
> machine for a few hours at a time.
>
> Those confidence intervals are generated from only 2 runs per benchmark,
> which explains why they're so large.
>
>                 E.
>
