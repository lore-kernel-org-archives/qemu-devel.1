Received: from eggs.gnu.org ([2001:4830:134:3::10]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5Dps-0002qg-Ny
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5Dpn-0004jr-OJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:38:20 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:49003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5Dpn-0004ip-Hq
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:38:15 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23016.54514.243025.328812@mariner.uk.xensource.com>
Date: Thu, 19 Oct 2017 17:38:10 +0100
In-Reply-To: <20171010103215.GD1771@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-2-git-send-email-ian.jackson@eu.citrix.com>
	<23003.41880.818255.728737@mariner.uk.xensource.com>
	<20171010103215.GD1771@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Anthony PERARD writes ("Re: [PATCH 1/8] xen: link against xentoolcore"):
> I don't think it is necessary to do anything in qemu. The linker should
> find on its own the new libxentoolcore as long as an option
> -Wl,-rpath-link= provide the right path to xentoolcore when building
> qemu from xen.git.  In other cases, the pkg-config files should be
> enough (configure doesn't need to known about a new xentoolcore.pc
> file).

It seems that the build still works, without this patch but without
the rest of my series too, because we end up passing
  -L/u/iwj/work/xen.git/tools/../tools/libs/toolcore
  -Wl,-rpath-link=/u/iwj/work/xen.git/tools/../tools/libs/toolcore
(or similar) on the qemu link line.  So when ld links against
libxenstore (say) it finds that xenstore needs toolcore and finds
toolcore in the relevant paths.

We still need this patch for the rest of the series, though.

Ian.
