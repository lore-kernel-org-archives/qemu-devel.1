Received: from eggs.gnu.org ([2001:4830:134:3::10]:38214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJQKa-0001Wb-QJ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJQKX-00074W-LS
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:16:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJQKX-00074Q-5t
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 16:16:25 -0400
Date: Fri, 9 Jun 2017 16:16:22 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170609201622.GA28180@flamenco>
References: <20170609053719.26251-1-rth@twiddle.net>
	<20170609195234.GA14509@flamenco>
	<18d9fd86-d190-cc2c-99dc-e304b6f71275@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d9fd86-d190-cc2c-99dc-e304b6f71275@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v5 0/7] tcg: allocate TB structs preceding
 translate
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

On Fri, Jun 09, 2017 at 12:58:17 -0700, Richard Henderson wrote:
> >>=== OUTPUT BEGIN ===
> >>Checking PATCH 1/7: util: add cacheinfo...
> >>ERROR: do not initialise globals to 0 or NULL
> >>#149: FILE: util/cacheinfo.c:11:
> >>+int qemu_icache_linesize = 0;
> >>
> >>ERROR: do not initialise globals to 0 or NULL
> >>#150: FILE: util/cacheinfo.c:12:
> >>+int qemu_dcache_linesize = 0;
> 
> These are bogus checkpatch warnings.  If we really want this, we should also
> use -fno-common.  But without that, there is a real difference between
> initialized and non-initialized global variables.
> 
> >>
> >>ERROR: space prohibited after that '&&' (ctx:ExW)
> >>#191: FILE: util/cacheinfo.c:53:
> >>+            && buf[i].Cache.Level == 1) {
> >>              ^
> 
> This is also bogus.  I have no idea what it's attempting to detect.

I think this one is just enforcing a certain coding style convention;
"A &&\nB" will pass but "A\n&&B" won't.

		E.
