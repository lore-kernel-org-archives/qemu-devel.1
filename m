Received: from eggs.gnu.org ([2001:4830:134:3::10]:60606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cmWiX-00017G-9P
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cmWiS-0001M2-AX
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:25:13 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1cmWiS-0001KV-3l
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:25:08 -0500
Date: Fri, 10 Mar 2017 21:25:06 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170311022506.GB26530@flamenco>
References: <20170310012339.GA7400@flamenco> <20170310114531.GB2480@work-vm>
	<CAFEAcA9s0tHLYFwm+SP22ecB9uw1oyXdJSf5iG0iKzwRQuoGpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9s0tHLYFwm+SP22ecB9uw1oyXdJSf5iG0iKzwRQuoGpQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Benchmarking linux-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Mar 10, 2017 at 12:48:31 +0100, Peter Maydell wrote:
> On 10 March 2017 at 12:45, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Emilio G. Cota (cota@braap.org) wrote:
> >>                      x86_64 NBench Floating Point Performance
> >>                   Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz
> >>
> >>   1.88 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+
> >>        |   +   +  +  *A*#*A*  +  +   +   +   +   +  +   +   +   +  +   +   |
> >>   1.86 +-+           *** ***                                             +-+
> >>        |            #       #   *A*#***                                    |
> >>        |      *A*# #         # ##   *A*                                    |
> >>   1.84 +-+    #  *A*         *A*      #                                  +-+
> >>        |      #                        #                              *A*  |
> >>   1.82 +-+   #                          #                            ##  +-+
> >>        |     #                          *A*#                        #      |
> >>    1.8 +-+  #                               #  #*A*               *A*    +-+
> >>        |    #                               *A*   #                #       |
> >>   1.78 +-+*A*                                      #       *A*    #      +-+
> >>        |                                           #   ***#  #    #        |
> >>        |                                           *A*#*A*    #  #         |
> >>   1.76 +-+                                         ***         # #       +-+
> >>        |   +   +  +   +   +   +  +   +   +   +   +  +   +   +  *A* +   +   |
> >>   1.74 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+
> >>          v1.v1.v1.2v1.3v1.4v1.v1.6v1.7v2.0v2.1v2.v2.3v2.4v2.5v2.v2.7v2.8.0
> >>                                    QEMU version
> >
> > I'm assuming the dips are where QEMU fixed something and cared about corner
> > cases/accuracy?
> 
> Given the scale on the LHS is from 1.74 to 1.88 my guess is that the
> variation is in large part noise and the major thing is "our fp
> performance is bounded by softfloat, which doesn't change and is
> always very slow".

It isn't "measurement noise" -- if you look at the PNGs the measurements
are very stable (all points have error bars): http://imgur.com/a/nF7Ls

It's true that performance here varies very little. This is just the
result of Amdahl's law, as you point out. (upon re-reading your message,
I see that perhaps what you meant by "noise" is exactly this.)

		E.
