Received: from eggs.gnu.org ([2001:4830:134:3::10]:59513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e20G3-00029D-TH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e20Fy-0005gb-V9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:32:03 -0400
Received: from smtp.citrix.com ([66.165.176.89]:47962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e20Fy-0005fS-I0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:31:58 -0400
Date: Tue, 10 Oct 2017 12:55:15 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010115515.GI1771@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-7-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1507564902-9000-7-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 6/8] xen: destroy_hvm_domain: Try
 xendevicemodel_shutdown
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

On Mon, Oct 09, 2017 at 05:01:40PM +0100, Ian Jackson wrote:
> xc_interface_open etc. is not going to work if we have dropped
> privilege, but xendevicemodel_shutdown will if everything is new
> enough.
> 
> xendevicemodel_shutdown is only availabe in Xen 4.10 and later, so
> provide a stub for earlier versions.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
