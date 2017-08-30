Received: from eggs.gnu.org ([2001:4830:134:3::10]:34412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn08c-0005MR-BT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn08Y-0003UJ-De
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:22:22 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn08Y-0003U2-78
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:22:18 -0400
Received: by mail-wm0-x241.google.com with SMTP id e204so1287447wma.2
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:22:18 -0700 (PDT)
Date: Wed, 30 Aug 2017 11:22:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830102215.GG24565@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-4-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-4-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/13] hvf: add compilation rules to
 Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:52AM -0500, Sergio Andres Gomez Del Real wrote:
> This commit adds to target/i386/Makefile.objs the necessary rules so
> that the new files for hvf are compiled by the build system.
> It also adds handling of the -enable-hvf argument in the main function
> in vl.c.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  target/i386/Makefile.objs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 6a26e9d9f0..0bef89c099 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -12,4 +12,5 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
>  endif
>  ifdef CONFIG_DARWIN
>  obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
> +obj-$(CONFIG_HVF) += hvf-utils/ hvf-all.o
>  endif

After this commit:

  make[1]: *** No rule to make target 'target/i386/hvf-all.o', needed by 'qemu-system-x86_64'.  Stop.

Please structure patch series so that each commit compiles and passes
tests successfully.

This is important so that git-bisect(1) can be used.  If some commits
break the build then it's hard to bisect because you need to diagnose
each failure and decide how to bisect around it.

This code change must be included in the same commit that adds hvf-all.o
and hvf-utils/ files.

Stefan
