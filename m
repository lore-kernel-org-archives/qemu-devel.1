Received: from eggs.gnu.org ([2001:4830:134:3::10]:52771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1wu2-0003Ze-Md
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1wty-00029f-13
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:57:06 -0400
Received: from smtp.citrix.com ([66.165.176.89]:48627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1wtx-00026I-Hx
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:57:01 -0400
Date: Tue, 10 Oct 2017 11:32:15 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010103215.GD1771@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-2-git-send-email-ian.jackson@eu.citrix.com>
	<23003.41880.818255.728737@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23003.41880.818255.728737@mariner.uk.xensource.com>
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

On Mon, Oct 09, 2017 at 05:28:08PM +0100, Ian Jackson wrote:
> Ian Jackson writes ("[PATCH 1/8] xen: link against xentoolcore"):
> > From: Anthony PERARD <anthony.perard@citrix.com>
> > 
> > Xen libraries 4.10 will include a new xentoolcore library, without
> > which xendevicemodel et al will not work.
> 
> The xentoolcore library was just committed to xen.git#staging, so at
> least this patch (or something like it) should go into qemu RSN.

I don't think it is necessary to do anything in qemu. The linker should
find on its own the new libxentoolcore as long as an option
-Wl,-rpath-link= provide the right path to xentoolcore when building
qemu from xen.git.  In other cases, the pkg-config files should be
enough (configure doesn't need to known about a new xentoolcore.pc
file).

> Anthony, do you plan to cherry pick this into the xen-specific qemu
> branch used for osstest tests ?
> 
> Thanks,
> Ian.

-- 
Anthony PERARD
