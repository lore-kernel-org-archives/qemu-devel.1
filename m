Received: from eggs.gnu.org ([2001:4830:134:3::10]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJPxY-0000hq-Ry
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJPxV-0005w7-M6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:52:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJPxV-0005vw-7q
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 15:52:37 -0400
Date: Fri, 9 Jun 2017 15:52:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170609195234.GA14509@flamenco>
References: <20170609053719.26251-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170609053719.26251-1-rth@twiddle.net>
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

On Thu, Jun 08, 2017 at 22:37:12 -0700, Richard Henderson wrote:
> This is a follow-up to Emilio's patch set.
> 
> My primary changes to Emilio's patches are to the first patch, in
> merging the existing implementations from tcg/ppc/tcg-target.inc.c
> into util/cacheinfo.c.
> 
> Then I've a few follow-up patches to take advantage of the new TB
> placement for arm platforms.  I've had a look at the asm output for
> ppc64 and s390x, and don't see anything obvious that can be improved.
> 
> Changes since v4:
>   * The first patch reorganized a bit for aarch64 and ppc64.
>     Re-tested on win32, for which there was a Werror.
>     Incorporated feedback from Emilio re MacOS.
>   * Fixed the short description for the tcg/arm patches.

This is shaping up quite nicely. Some minor suggestions:

Can we get these checkpatch warnings fixed ..

> === OUTPUT BEGIN ===
> Checking PATCH 1/7: util: add cacheinfo...
> ERROR: do not initialise globals to 0 or NULL
> #149: FILE: util/cacheinfo.c:11:
> +int qemu_icache_linesize = 0;
> 
> ERROR: do not initialise globals to 0 or NULL
> #150: FILE: util/cacheinfo.c:12:
> +int qemu_dcache_linesize = 0;
> 
> ERROR: space prohibited after that '&&' (ctx:ExW)
> #191: FILE: util/cacheinfo.c:53:
> +            && buf[i].Cache.Level == 1) {
>              ^

.. as well as these?

> Checking PATCH 6/7: tcg/arm: Try pc-relative addresses for movi...
> ERROR: code indent should never use tabs
> #54: FILE: tcg/arm/tcg-target.inc.c:446:
> +^I}$
> 
> ERROR: code indent should never use tabs
> #64: FILE: tcg/arm/tcg-target.inc.c:453:
> +^I}$

While at it, we might want to add the tiny patch I'll send as
a reply to this message.

Thanks,

		Emilio
