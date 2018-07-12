Received: from eggs.gnu.org ([2001:4830:134:3::10]:51021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fdeAy-0003Nm-59
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fdeAx-0003kp-2q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:10:40 -0400
Message-Id: <1531411830.3639858.1438698880.654F54F0@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CAFEAcA9GHFwscBzRGRbqAN+nWWYYbSZB-M0Kt+r=fFFG3xfm8w@mail.gmail.com>
References: <20180709143524.17480-1-andrew@aj.id.au>
	<CAFEAcA9GHFwscBzRGRbqAN+nWWYYbSZB-M0Kt+r=fFFG3xfm8w@mail.gmail.com>
Date: Fri, 13 Jul 2018 01:40:30 +0930
Subject: Re: [Qemu-devel] [PATCH] aspeed: Implement write-1-{set,
 clear} for AST2500 strapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, =?utf-8?Q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm <qemu-arm@nongnu.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>

On Fri, 13 Jul 2018, at 01:28, Peter Maydell wrote:
> On 9 July 2018 at 15:35, Andrew Jeffery <andrew@aj.id.au> wrote:
> > The AST2500 SoC family changes the runtime behaviour of the hardware
> > strapping register (SCU70) to write-1-set/write-1-clear, with
> > write-1-clear implemented on the "read-only" SoC revision register
> > (SCU7C). For the the AST2400, the hardware strapping is
> > runtime-configured with read-modify-write semantics.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> 
> Hi -- is this a bugfix suitable for 3.0, or something you'd
> like to wait until 3.1 ? The commit message sounds like a bugfix...

If we could get it into 3.0 that would be great. I ran into a case where the distinction was important so it would be good to have it resolved sooner rather than later.

Cheers,

Andrew
