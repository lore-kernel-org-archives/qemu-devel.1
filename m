Received: from eggs.gnu.org ([2001:4830:134:3::10]:52634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLe8Z-0006tj-Hx
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 19:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLe8U-00015z-LH
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 19:25:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLe8U-00014v-CQ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 19:25:10 -0400
Date: Thu, 15 Jun 2017 19:25:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170615232507.GA15332@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615221911.GB26408@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615221911.GB26408@flamenco>
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Thu, Jun 15, 2017 at 18:19:11 -0400, Emilio G. Cota wrote:
> (snip)
> > +/**
> > + * DisasContextBase:
> > + * @tb: Translation block for this disassembly.
> > + * @pc_first: Address of first guest instruction in this TB.
> > + * @pc_next: Address of next guest instruction in this TB (current during
> > + *           disassembly).
> > + * @num_insns: Number of translated instructions (including current).
> > + * @singlestep_enabled: "Hardware" single stepping enabled.
> > + *
> > + * Architecture-agnostic disassembly context.
> > + */
> > +typedef struct DisasContextBase {
> > +    TranslationBlock *tb;
> > +    target_ulong pc_first;
> > +    target_ulong pc_next;
> > +    DisasJumpType jmp_type;
> > +    unsigned int num_insns;
> > +    bool singlestep_enabled;
> > +} DisasContextBase;
> 
> - @pc_next: I'd stick with @pc, it's shorter, it's everywhere already, and
>   with the documentation it's very clear what it is for.
> - @jmp_type: missing doc :-)

Also, consider keeping the @is_jmp name instead of renaming it to
@jmp_type. (@jmp would be shorter but it would be confusing though,
e.g. cris has both dc->jmp and dc->is_jmp.)

		E.
