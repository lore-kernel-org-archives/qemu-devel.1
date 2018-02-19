Received: from eggs.gnu.org ([2001:4830:134:3::10]:56496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enslL-0002YH-LL
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 16:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enslI-0000Rq-9U
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 16:14:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1enslI-0000RP-39
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 16:14:12 -0500
Date: Mon, 19 Feb 2018 16:14:09 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180219211409.GA24054@flamenco>
References: <1518751105-17211-1-git-send-email-cota@braap.org>
	<1518751105-17211-2-git-send-email-cota@braap.org>
	<f8f48954-e803-c8ba-9b84-5ebb68da006d@linaro.org>
	<c86f8b84-b056-0669-ef01-dc72e25d0efa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c86f8b84-b056-0669-ef01-dc72e25d0efa@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] translator: pass max_insns to tb_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Mon, Feb 19, 2018 at 11:34:52 -0800, Richard Henderson wrote:
> On 02/19/2018 11:31 AM, Richard Henderson wrote:
> > On 02/15/2018 07:18 PM, Emilio G. Cota wrote:
> >> sh4 will need it.
> >>
> >> Signed-off-by: Emilio G. Cota <cota@braap.org>
> >> ---
> >>  accel/tcg/translator.c     | 2 +-
> >>  include/exec/translator.h  | 3 ++-
> >>  target/alpha/translate.c   | 3 ++-
> >>  target/arm/translate-a64.c | 4 +++-
> >>  target/arm/translate.c     | 4 +++-
> >>  target/hppa/translate.c    | 4 +++-
> >>  target/i386/translate.c    | 3 ++-
> >>  7 files changed, 16 insertions(+), 7 deletions(-)
> > 
> > There is another possibility, which is to move max_insns into DisasContextBase
> > where it can be modified.  This would allow the gusa sequence to be handled
> > differently as an instance of the translate_insn hook, which would allow a
> > breakpoint to be placed on the first insn of a gusa sequence.
> > 
> > I guess I don't have strong feelings either way.
> 
> Thinking some more, I *do* prefer max_insns in DisasContextBase.
> 
> For ARM SVE, implementing MOVPRFX, I would like to be able to tell if we intend
> to break the TB between MOVPRFX and the instruction being prefixed.  I can't do
> that if the data is private to translator.c.

Will move to DisasContextBase. Will also remove its passing to
insn_disas_context, since base.max_insns will be accessible.

Thanks,

		E.
