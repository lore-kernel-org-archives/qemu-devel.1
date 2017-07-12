Received: from eggs.gnu.org ([2001:4830:134:3::10]:52697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMdn-0006cw-2t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMdk-0001BT-0l
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:45:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dVMdj-0001BA-QX
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:45:35 -0400
Date: Wed, 12 Jul 2017 14:45:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170712184534.GD7547@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-13-git-send-email-cota@braap.org>
	<87fue18yo6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fue18yo6.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 12/22] translate-all: report correct avg
 host TB size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 16:25:45 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> I think having the __attribute__ stuff is confusing. Why don't we just
> do what the newer debug stuff does:
> 
> modified   accel/tcg/translate-all.c
> @@ -66,6 +66,12 @@
>  /* make various TB consistency checks */
>  /* #define DEBUG_TB_CHECK */
> 
> +#if defined(DEBUG_TB_FLUSH)
> +#define DEBUG_TB_FLUSH_GATE 1
> +#else
> +#define DEBUG_TB_FLUSH_GATE 0
> +#endif
(snip)
> Which will a) ensure all the debug code is compiled even when not
> enabled and b) the compiler won't bitch at you when it optimises stuff
> away.
> 
> Better?

Much better! The unused attribute was there to achieve this, but what
you propose is much better.

		E.
