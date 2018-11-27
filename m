Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRRzo-0006B4-WC
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:17:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gRRzk-0007kQ-3x
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:17:00 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gRRzj-0007kD-Rp
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:16:56 -0500
Date: Mon, 26 Nov 2018 20:16:51 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181127011651.GC22108@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-13-cota@braap.org>
	<871s7dhw8t.fsf@linaro.org> <20181124000938.GD17229@flamenco>
	<87r2f83x06.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2f83x06.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 12/48] atomic_template: define pre/post macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Mon, Nov 26, 2018 at 11:21:13 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Thu, Nov 22, 2018 at 17:12:34 +0000, Alex Bennée wrote:
> >>
> >> Emilio G. Cota <cota@braap.org> writes:
> >>
> >> > In preparation for plugin support.
> >> >
> >> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> >>
> >> More macros for the macro-god. I guess this works but I wonder if it's
> >> possible to do a clean-up ala softfloat and the experimental softmmu
> >> re-factor that makes this less a mess of macros?
> >
> > Heh, point taken.
> >
> > I'll try to fix this once (and if!) the series graduates from RFC
> > to proper patchset. BTW I'm planning to pick rth's softfloat
> > cleanup soon, so that should help.
> 
> Yeah I was in the middle of re-spinning the softmmu demacro patches but
> ran into a bug I didn't get time to track down. I'll get it re-spun once
> I've finished going through this.

Nice!

> I assume the rth's softfloat cleanup is for hardfloat support? I stand
> ready to review the next version. We should get it in well before the
> 4.0 soft freeze (next release).

Yes I meant hardfloat, not softfloat :P

I submitted v6 over the weekend. You'll be happy to hear that after
applying rth's cleanups, the series only has four macros left,
the largest of which only takes 8 lines :-)

		Emilio
