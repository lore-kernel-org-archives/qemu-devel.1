Received: from eggs.gnu.org ([2001:4830:134:3::10]:57058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAywH-0003CM-C2
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAywD-0004th-Fe
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:29:01 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:53282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAywD-0004tB-60
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:28:57 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23263.16162.507919.766810@mariner.uk.xensource.com>
Date: Tue, 24 Apr 2018 15:28:50 +0100
In-Reply-To: <20180423150553.GC1980@perard>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-4-git-send-email-ian.jackson@eu.citrix.com>
	<20180423150553.GC1980@perard>
Subject: Re: [Qemu-devel] [PATCH 03/16] xen: link against xentoolcore
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

Anthony PERARD writes ("Re: [PATCH 03/16] xen: link against xentoolcore"):
> On Thu, Apr 19, 2018 at 05:45:06PM +0100, Ian Jackson wrote:
> >      xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
> > -    xen_pc="$xen_pc xenevtchn xendevicemodel"
> > +    xen_pc="$xen_pc xenevtchn xendevicemodel xentoolcore"
> 
> I think we want to check if "xentoolcore" pkg_config exist before trying
> to use it. Otherwith, that is not going to work with Xen older than
> 4.10.

Yes.  Thanks for spotting this.  My tests were all with builds from in
the Xen tree and I hadn't spotted that that is handled as a special
case.

> Instead, we could do this:
> if $pkg_config --exists xentoolcore; then
>   xen_pc+=" xentoolcore"
> fi

I will test that.

Ian.
