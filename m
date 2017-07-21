Received: from eggs.gnu.org ([2001:4830:134:3::10]:41509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfQg-0002Ad-7w
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYfQc-0005J7-WE
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:25:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYfQc-0005IX-Mp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 17:25:42 -0400
Date: Fri, 21 Jul 2017 17:25:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721212541.GB10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-4-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-4-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 03/34] target/i386: Use generic DISAS_*
 enumerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:12 -1000, Richard Henderson wrote:
> This target is not sophisticated in its use of cleanups at the
> end of the translation loop.  For the most part, any condition
> that exits the TB is dealt with by emitting the exiting opcode
> right then and there.  Therefore the only is_jmp indicator that
> is needed is DISAS_NORETURN.
> 
> For two stack segment modifying cases, we have not yet exited
> the TB (therefore DISAS_NORETURN feels wrong), but intend to exit.
> The caller of gen_movl_seg_T0 currently checks for any non-zero
> value, therefore DISAS_TOO_MANY seems acceptable for that usage.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
