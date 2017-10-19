Received: from eggs.gnu.org ([2001:4830:134:3::10]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=458e47f2f=anthony.perard@citrix.com>)
	id 1e5Dyp-0002Xj-1O
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=458e47f2f=anthony.perard@citrix.com>)
	id 1e5Dyk-0002rz-Tw
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:47:35 -0400
Received: from smtp.citrix.com ([66.165.176.89]:7795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=458e47f2f=anthony.perard@citrix.com>)
	id 1e5Dyk-0002rm-NU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:47:30 -0400
Date: Thu, 19 Oct 2017 17:47:28 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171019164728.GC11934@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-2-git-send-email-ian.jackson@eu.citrix.com>
	<23003.41880.818255.728737@mariner.uk.xensource.com>
	<20171010103215.GD1771@perard.uk.xensource.com>
	<23016.54514.243025.328812@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23016.54514.243025.328812@mariner.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Thu, Oct 19, 2017 at 05:38:10PM +0100, Ian Jackson wrote:
> Anthony PERARD writes ("Re: [PATCH 1/8] xen: link against xentoolcore"):
> > I don't think it is necessary to do anything in qemu. The linker should
> > find on its own the new libxentoolcore as long as an option
> > -Wl,-rpath-link= provide the right path to xentoolcore when building
> > qemu from xen.git.  In other cases, the pkg-config files should be
> > enough (configure doesn't need to known about a new xentoolcore.pc
> > file).
> 
> It seems that the build still works, without this patch but without
> the rest of my series too, because we end up passing
>   -L/u/iwj/work/xen.git/tools/../tools/libs/toolcore
>   -Wl,-rpath-link=/u/iwj/work/xen.git/tools/../tools/libs/toolcore
> (or similar) on the qemu link line.  So when ld links against
> libxenstore (say) it finds that xenstore needs toolcore and finds
> toolcore in the relevant paths.
> 
> We still need this patch for the rest of the series, though.

Of course, I was only arguing that this patch on its own is not usefull.

Do you need a signed-off-by or review-by from me? Since it looks like
I'm the author.

-- 
Anthony PERARD
