Received: from eggs.gnu.org ([2001:4830:134:3::10]:55680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj62b-000092-6J
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj62V-0001ct-AD
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:19:45 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:36324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj62V-0001cS-3E
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:19:39 -0500
Date: Wed, 1 Mar 2017 15:19:02 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170301151902.GB1760@perard.uk.xensource.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-2-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1487861635-17560-2-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] xen: make use of xen_xc implicit in
 xen_common.h inlines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Feb 23, 2017 at 02:53:51PM +0000, Paul Durrant wrote:
> Doing this will make the transition to using the new libxendevicemodel
> interface less intrusive on the callers of these functions, since using
> the new library will require a change of handle.
> 
> NOTE: The patch also moves the 'externs' for xen_xc and xen_fmem from
>       xen_backend.h to xen_common.h, and the declarations from
>       xen_backend.c to xen-common.c, which is where they belong.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
