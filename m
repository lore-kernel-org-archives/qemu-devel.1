Received: from eggs.gnu.org ([2001:4830:134:3::10]:60935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJKe-0008Pf-Mv
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUJKb-0004DF-Mj
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:01:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUJKb-0004DB-IL
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:01:29 -0400
Date: Sun, 9 Jul 2017 17:01:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170709210128.GB32582@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-12-git-send-email-cota@braap.org>
	<5c33bb26-0f55-3362-525b-bed041e163b9@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c33bb26-0f55-3362-525b-bed041e163b9@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 11/22] translate-all: use a binary search
 tree to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Sun, Jul 09, 2017 at 10:33:41 -1000, Richard Henderson wrote:
> On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> > #if defined(DEBUG_TB_FLUSH)
> >+    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
> >     printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%ld\n",
> >            (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
> >-           tcg_ctx.tb_ctx.nb_tbs, tcg_ctx.tb_ctx.nb_tbs > 0 ?
> >+           nb_tbs, nb_tbs > 0 ?
> >            ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)) /
> >-           tcg_ctx.tb_ctx.nb_tbs : 0);
> >+           nb_tbs : 0);
> > #endif
> 
> Variable declaration within braces within the ifdef.  Better as size_t or
> unsigned long.  Using int to count thing on 64-bit hosts always seems like a
> bug.

g_tree_nnodes returns a gint, which is documented to be a typedef for 'int'.
So I went with that.

But yes, a size_t here is better.

		E.
