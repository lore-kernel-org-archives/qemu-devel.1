Received: from eggs.gnu.org ([2001:4830:134:3::10]:40482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1ciH1W-0006IZ-2i
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mbenes@suse.cz>) id 1ciH1S-0000bO-TJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:51:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:57206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mbenes@suse.cz>) id 1ciH1S-0000aw-N8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:51:10 -0500
Date: Mon, 27 Feb 2017 09:51:07 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
In-Reply-To: <d9d4d2c5-bede-6ea6-81cf-c2eaa2fccbd5@twiddle.net>
Message-ID: <alpine.LSU.2.20.1702270949000.7654@pobox.suse.cz>
References: <20170224135045.10613-1-mbenes@suse.cz>
	<d9d4d2c5-bede-6ea6-81cf-c2eaa2fccbd5@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement lpp instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: agraf@suse.de, qemu-devel@nongnu.org, mmarek@suse.com, ebischoff@suse.com

On Sat, 25 Feb 2017, Richard Henderson wrote:

> On 02/25/2017 12:50 AM, Miroslav Benes wrote:
> > Linux arch/s390/kernel/head(64).S uses lpp instruction if it is
> > available in facilities list provided by stfl/stfle instruction. This is
> > the case of newer z/System generations and their qemu definition.
> > 
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > ---
> 
> I can't find LPP in my PoO 11th edition...
> 
> > +static ExitStatus op_lpp(DisasContext *s, DisasOps *o)
> > +{
> > +    check_privileged(s);
> > +    potential_page_fault(s);
> > +
> > +    tcg_gen_st_i64(o->in2, cpu_env, offsetof(CPUS390XState, pp));
> 
> But you don't need the potential_page_fault, since this is not a store to
> guest memory.

Right. I got confused by Access Program Exception in the spec. Sending v2.

Thanks for the review!

Miroslav
