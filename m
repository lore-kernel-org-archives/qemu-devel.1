Received: from eggs.gnu.org ([2001:4830:134:3::10]:49247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81dI-00022Z-6H
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81dE-0008Uk-6r
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:12:56 -0400
Received: from smtp.citrix.com ([66.165.176.89]:5488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=466efc5b4=Ian.Jackson@citrix.com>)
	id 1e81dE-0008Tx-0Y
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:12:52 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23027.1696.620560.710955@mariner.uk.xensource.com>
Date: Fri, 27 Oct 2017 11:12:48 +0100
In-Reply-To: <alpine.DEB.2.10.1710261539420.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<alpine.DEB.2.10.1710261539420.3086@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] [PATCH v5.1 1/8] xen: link against xentoolcore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org

Stefano Stabellini writes ("Re: [PATCH v5.1 1/8] xen: link against xentoolcore"):
> On Fri, 20 Oct 2017, Ian Jackson wrote:
> >        then
> > -      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
> > +      xen_stable_libs="-lxendevicemodel $xen_stable_libs -lxentoolcore"
> 
> Is it on purpose that -lxentoolcore is at the end of this string rather
> than before $xen_stable_libs?

Yes.  xentoolcore is required by the other libraries, and this is
therefore the correct ordering for situations where the link order
matters.

> In any case
> 
> Acked-by: Stefano Stabellini <sstabellini@kernel.org>

Thanks,
Ian.
