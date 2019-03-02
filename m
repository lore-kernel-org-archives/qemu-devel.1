Received: from eggs.gnu.org ([209.51.188.92]:41546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0DYu-0000Ae-9q
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0DR8-0005kr-Gx
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:48:55 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0DR8-0005jd-4K
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:48:54 -0500
Date: Sat, 2 Mar 2019 17:48:51 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190302224851.GA16678@flamenco>
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-40-cota@braap.org>
	<87ef8imto8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ef8imto8.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PATCH v6 39/73] i386: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Fri, Feb 08, 2019 at 11:00:23 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  target/i386/cpu.c        | 2 +-
> >  target/i386/helper.c     | 4 ++--
> >  target/i386/svm_helper.c | 4 ++--
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index a37b984b61..35dea8c152 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -5678,7 +5678,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
> >
> >  static bool x86_cpu_has_work(CPUState *cs)
> >  {
> > -    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
> > +    return x86_cpu_pending_interrupt(cs, cpu_interrupt_request(cs))
> >  != 0;
> 
> This is fine in itself but is there a chance of a race with the
> env->eflags/hflags/hflags2 that x86_cpu_pending_interrupt deals with?
> Are they only ever self vCPU references?

AFAICT they're all self-references; I have checked this via inspection
and with helgrind.

> Anyway:
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		E.
