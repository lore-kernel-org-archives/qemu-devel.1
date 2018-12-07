Received: from eggs.gnu.org ([2001:4830:134:3::10]:33550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVLET-0000Br-Vm
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVLEQ-0000kp-Ba
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:52:13 -0500
Date: Fri, 7 Dec 2018 18:52:02 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207185202.GO18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-17-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-17-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Dec 06, 2018 at 03:08:42PM +0000, Paul Durrant wrote:
> This patch adds a creator function for XenBlockDevice-s so that they can
> be created automatically when the Xen toolstack instantiates a new
> PV backend. When the XenBlockDevice is created this way it is also
> necessary to create a drive which matches the configuration that the Xen
> toolstack has written into xenstore. This drive is marked 'auto_del' so
> that it will be removed when the XenBlockDevice is destroyed. Also, for
> compatibility with the legacy 'xen_disk' implementation, an iothread
> is automatically created for the new XenBlockDevice. This will also be
> removed when the XenBlockDevice is destroyed.
> 
> Correspondingly the legacy backend scan for 'qdisk' is removed.
> 
> After this patch is applied the legacy 'xen_disk' code is redundant. It
> will be removed by a subsequent patch.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
