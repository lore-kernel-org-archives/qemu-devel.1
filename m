Received: from eggs.gnu.org ([2001:4830:134:3::10]:37531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=814ff0a1f=anthony.perard@citrix.com>)
	id 1gAEjs-0001BP-OF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=814ff0a1f=anthony.perard@citrix.com>)
	id 1gAEjo-0000h7-Kv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:41:24 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:48635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=814ff0a1f=anthony.perard@citrix.com>)
	id 1gAEjo-0000gj-CV
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:41:20 -0400
Date: Wed, 10 Oct 2018 14:31:01 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181010133101.GE1331@perard.uk.xensource.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-16-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181008173125.19678-16-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/31] xen/pt: Fix incomplete conversion to
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Mon, Oct 08, 2018 at 07:31:09PM +0200, Markus Armbruster wrote:
> The conversion of "xen-pci-passthrough" to realize() (commit
> 5a11d0f7549, v2.6.0) neglected to convert the xen_pt_config_init()
> error path.  If xen_pt_config_init() fails, xen_pt_realize() reports
> the error, then returns success without completing its job.  I don't
> know the exact impact, but it can't be good.
> 
> Belatedly convert the error path.
> 
> Fixes: 5a11d0f7549e24a10e178a9dc8ff5e698031d9a6
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
