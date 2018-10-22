Received: from eggs.gnu.org ([2001:4830:134:3::10]:49037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEjd6-00033j-Sc
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEjd3-0003kE-N9
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:29:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gEjd3-0003jx-Fk
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:28:57 -0400
Date: Mon, 22 Oct 2018 19:28:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181022232855.GB29980@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-26-cota@braap.org>
	<e6b30bac-9f43-70f7-4176-a8a3913980fe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b30bac-9f43-70f7-4176-a8a3913980fe@linaro.org>
Subject: Re: [Qemu-devel] [RFC v3 25/56] exec: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Sun, Oct 21, 2018 at 14:17:01 +0100, Richard Henderson wrote:
> On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> > -    cpu->interrupt_request &= ~0x01;
> > +    cpu_reset_interrupt(cpu, ~0x01);
> 
> cpu_reset_interrupt(cpu, 1);

Ouch. Fixed.

> Although this is during vmload, and I'm not sure what locks you really want to
> play with here.  Perhaps it's ok...

I checked with check-qtest that it's OK -- note that the lock
is initialized right after the CPU thread is created.

I'd like to keep the locked version, so that race checkers don't
get confused.

Thanks,

		Emilio
