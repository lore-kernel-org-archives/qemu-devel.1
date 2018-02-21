Received: from eggs.gnu.org ([2001:4830:134:3::10]:48444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoaqY-0004p5-IT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eoapR-0008LP-N3
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:18:34 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eoapR-0008K0-Ar
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:17:25 -0500
Date: Wed, 21 Feb 2018 15:17:23 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180221201723.GA30501@flamenco>
References: <1519093616-10563-1-git-send-email-cota@braap.org>
	<1519093616-10563-2-git-send-email-cota@braap.org>
	<512f6e39-9aa0-7e4f-fad4-7085d499ae65@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512f6e39-9aa0-7e4f-fad4-7085d499ae65@linaro.org>
Subject: Re: [Qemu-devel] [PATCHv2 1/2] translator: merge max_insns into
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Wed, Feb 21, 2018 at 10:19:05 -0800, Richard Henderson wrote:
> On 02/19/2018 06:26 PM, Emilio G. Cota wrote:
> > @@ -68,6 +69,7 @@ typedef struct DisasContextBase {
> >      target_ulong pc_next;
> >      DisasJumpType is_jmp;
> >      unsigned int num_insns;
> > +    int max_insns;
> >      bool singlestep_enabled;
> >  } DisasContextBase;
> 
> We really should pick the same type for max_insns and num_insns, which ever
> type we settle on.  I can't see how we can go wrong with unsigned...

I was just trying to avoid warnings with -Wsign-compare in case
we ever enabled it.

Should I bother converting the "bound" variables we use for
MIN(max_insns, bound) to unsigned as well? Or just leave them
alone and forget about -Wsign-compare?

Thanks,

		Emilio
