Received: from eggs.gnu.org ([2001:4830:134:3::10]:34974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGTD-0002M0-1M
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dXGT8-000600-Vp
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dXGT8-0005zd-Rl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:30 -0400
Date: Mon, 17 Jul 2017 20:34:29 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170718003429.GC7414@flamenco>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-22-git-send-email-cota@braap.org>
	<05b969cf-a6a0-eb3c-f9ec-0c536dbe9491@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b969cf-a6a0-eb3c-f9ec-0c536dbe9491@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 21/45] tcg: check CF_PARALLEL instead of
 parallel_cpus
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

On Mon, Jul 17, 2017 at 13:55:42 -1000, Richard Henderson wrote:
> On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> >Thereby decoupling the resulting translated code from the current state
> >of the system.
> >
> >The tb->cflags field is not passed to tcg generation functions. So
> >we add a bit to TCGContext, storing there whether CF_PARALLEL is set
> >before translating every TB.
> >
> >Most architectures have <= 32 registers, which results in a 4-byte hole
> >in TCGContext. Use this hole for the bit we need; use a uint8_t instead
> >of a bool, since a bool might take more than one byte in some systems.
> 
> I would much rather use bool.
> 
> (1) I don't care about OSX and its broken ABI,
> (2) Even then OSX still *works*.

Will do.

> Otherwise,

Missing R-b tag?

		E.
