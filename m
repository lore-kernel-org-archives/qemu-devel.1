Received: from eggs.gnu.org ([2001:4830:134:3::10]:49746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYdPK-0004Dq-9W
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYdPH-0005ey-5i
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:16:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYdPG-0005eU-Ud
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 15:16:11 -0400
Date: Fri, 21 Jul 2017 15:16:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721191609.GA3154@flamenco>
References: <20170719233455.8740-1-rth@twiddle.net>
	<20170719233455.8740-7-rth@twiddle.net>
	<20170721054210.GA16334@flamenco>
	<CAFEAcA8mPyF+X1CHSAGdZ5VAXLFoHx24e7h0gadFHfecDttQyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8mPyF+X1CHSAGdZ5VAXLFoHx24e7h0gadFHfecDttQyQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/arm: fix TCG temp leak in aarch64
 rev16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jul 21, 2017 at 14:16:46 +0100, Peter Maydell wrote:
> On 21 July 2017 at 06:42, Emilio G. Cota <cota@braap.org> wrote:
> > const leak! patch below -- cut with `git am --scissors'.
> >
> >                 Emilio
> >
> > ---8<---
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> 
> Applied to target-arm.next, thanks -- but in future could you
> send patches as proper patch emails, please (output of
> git format-patch, sent as its own top level email, not a
> reply to an existing thread) ? Otherwise the automated tools
> don't recognise them as patches and it requires some tedious
> manual application at this end.

Will do, sorry about that.

		E.
