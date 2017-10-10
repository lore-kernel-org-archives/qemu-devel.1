Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e2052-0005DJ-Rr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e204z-00013K-NG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:20:40 -0400
Received: from smtp.citrix.com ([66.165.176.89]:30522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e204z-00012u-BA
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:20:37 -0400
Date: Tue, 10 Oct 2017 12:48:52 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010114852.GH1771@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-6-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1507564902-9000-6-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] xen: move xc_interface compatibility
 fallback further up the file
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

On Mon, Oct 09, 2017 at 05:01:39PM +0100, Ian Jackson wrote:
> We are going to want to use the dummy xendevicemodel_handle type in
> new stub functions in the CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
> section.  So we need to provide that definition, or (as applicable)
> include the appropriate header, earlier in the file.
> 
> (Ideally the newer compatibility layers would be at the bottom of the
> file, so that they can naturally benefit from the compatibility layers
> for earlier version.  But that's rather too much for this series.)
> 
> No functional change.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
