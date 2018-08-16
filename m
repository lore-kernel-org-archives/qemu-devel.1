Received: from eggs.gnu.org ([2001:4830:134:3::10]:37051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fq9za-0001ew-DB
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fq9zX-0003sE-9a
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:34:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fq9zX-0003rH-4z
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:34:35 -0400
Date: Thu, 16 Aug 2018 12:34:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180816043430.GA19880@lemon.usersys.redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
	<CAFEAcA9FU7_PzzLgam6AC0P_F_N4zBC=fxCaNqZq0sR4kB1bFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9FU7_PzzLgam6AC0P_F_N4zBC=fxCaNqZq0sR4kB1bFQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/17] Block and testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 08/15 16:35, Peter Maydell wrote:
> On 15 August 2018 at 04:12, Fam Zheng <famz@redhat.com> wrote:
> > The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:
> >
> >   Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)
> 
> 
> >   tests/vm: Only use -cpu 'host' if KVM is available
> 
> Incidentally, why did you go with this one rather than just
> using -cpu max all the time? The point of -cpu max is to work
> everywhere, so you don't need to have special casing to decide
> whether to use it or something else...

My apology for dropping the patch but forgot to send a note.

The only reason is this was queued first, and yours couldn't be applied without
rebasing (which effectively drops the former). But I agree with your point, and
am open for a further clean up.

Fam
