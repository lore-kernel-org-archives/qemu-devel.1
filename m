Received: from eggs.gnu.org ([2001:4830:134:3::10]:60586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUPm8-0001BC-Jm
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 23:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUPm5-0003Qq-Ik
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 23:54:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUPm5-0003Qg-Eh
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 23:54:17 -0400
Date: Sun, 9 Jul 2017 23:54:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170710035416.GB25231@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-22-git-send-email-cota@braap.org>
	<3fabc9d4-86b5-9d01-9499-3468bd2f2e5e@twiddle.net>
	<20170709212910.GA3027@flamenco>
	<15f9af98-4c04-7bdb-2502-a2e7a37eda8c@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f9af98-4c04-7bdb-2502-a2e7a37eda8c@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 21/22] tcg: enable per-thread TCG for
 softmmu
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

On Sun, Jul 09, 2017 at 11:48:53 -1000, Richard Henderson wrote:
> On 07/09/2017 11:29 AM, Emilio G. Cota wrote:
(snip)
> >Exactly. Also, in user-mode "vCPU threads" (i.e. host threads) come and
> >go all the time, so this doesn't work well with having a single
> >code_gen_buffer, which I assumed was non-negotiable.
> 
> Ah, yes.  For any subdivision N of code_gen_buffer that we choose, at some
> point we may have N+1 threads and need to do Something Else.
> 
> That's probably something worth commenting somewhere with the "first"
> #ifndef CONFIG_USER_ONLY.

Yep, will do.

Thanks,

		Emilio
