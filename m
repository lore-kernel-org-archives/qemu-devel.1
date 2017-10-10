Received: from eggs.gnu.org ([2001:4830:134:3::10]:55337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O7-0005W8-2d
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O5-0004l3-GL
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:35 -0400
Received: from smtp.citrix.com ([66.165.176.89]:21360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44954d255=Ian.Jackson@citrix.com>)
	id 1e23O5-0004k6-Ao
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:52:33 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23004.65480.880021.99078@mariner.uk.xensource.com>
Date: Tue, 10 Oct 2017 18:13:44 +0100
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
> On Mon, Oct 09, 2017 at 05:28:08PM +0100, Ian Jackson wrote:
> > The xentoolcore library was just committed to xen.git#staging, so at
> > least this patch (or something like it) should go into qemu RSN.
> 
> I don't think it is necessary to do anything in qemu. The linker should
> find on its own the new libxentoolcore as long as an option
> -Wl,-rpath-link= provide the right path to xentoolcore when building
> qemu from xen.git.

But, the -rpath-link= specification in libxendevicemodel refers not to
the xen.git build tree, but to the eventual installed copy.

In my tests, this does in fact break the build.

>  In other cases, the pkg-config files should be
> enough (configure doesn't need to known about a new xentoolcore.pc
> file).

In that case, yes, the .pc works.

Ian.
