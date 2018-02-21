Received: from eggs.gnu.org ([208.118.235.92]:59628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eocrY-0005Sq-KV
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 17:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eocoI-0008Kw-34
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 17:25:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eocoH-0008Jl-NF
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 17:24:21 -0500
Date: Wed, 21 Feb 2018 17:24:19 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180221222419.GA29667@flamenco>
References: <1519246509-4022-1-git-send-email-cota@braap.org>
	<1519246509-4022-2-git-send-email-cota@braap.org>
	<19ddf862-2525-50c0-4375-7c88e7fcebc2@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ddf862-2525-50c0-4375-7c88e7fcebc2@twiddle.net>
Subject: Re: [Qemu-devel] [PATCHv3 1/2] translator: merge max_insns into
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Wed, Feb 21, 2018 at 13:05:45 -0800, Richard Henderson wrote:
> On 02/21/2018 12:55 PM, Emilio G. Cota wrote:
> > While at it, use int for both num_insns and max_insns to make
> > sure we have same-type comparisons.
> > 
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  accel/tcg/translator.c     | 21 ++++++++++-----------
> >  include/exec/translator.h  |  8 ++++----
> >  target/alpha/translate.c   |  6 ++----
> >  target/arm/translate-a64.c |  8 +++-----
> >  target/arm/translate.c     |  9 +++------
> >  target/hppa/translate.c    |  7 ++-----
> >  target/i386/translate.c    |  5 +----
> >  target/ppc/translate.c     |  5 ++---
> >  8 files changed, 27 insertions(+), 42 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks.

To avoid merge conflicts, I'll send v2's of the other conversions
once this patch goes in.

		Emilio
