Received: from eggs.gnu.org ([2001:4830:134:3::10]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=442de58c5=roger.pau@citrix.com>)
	id 1dzLSP-0001Aj-0d
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=442de58c5=roger.pau@citrix.com>)
	id 1dzLSL-00035p-3m
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:33:49 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:45554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=442de58c5=roger.pau@citrix.com>)
	id 1dzLSK-00034X-Jt
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:33:45 -0400
Date: Tue, 3 Oct 2017 12:33:37 +0100
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20171003113337.nkde7v236fww3npt@MacBook-Pro-de-Roger.local>
References: <20171002163058.15651-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171002163058.15651-1-anthony.perard@citrix.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] migration,
 xen: Fix block image lock issue on live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu2@citrix.com>, Juan Quintela <quintela@redhat.com>, Ian Jackson <ian.jackson@eu.citrix.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, xen-devel@lists.xenproject.org

On Mon, Oct 02, 2017 at 04:30:58PM +0000, Anthony PERARD wrote:
> When doing a live migration of a Xen guest with libxl, the images for
> block devices are locked by the original QEMU process, and this prevent
> the QEMU at the destination to take the lock and the migration fail.
> 
> From QEMU point of view, once the RAM of a domain is migrated, there is
> two QMP commands, "stop" then "xen-save-devices-state", at which point a
> new QEMU is spawned at the destination.
> 
> Release locks in "xen-save-devices-state" so the destination can takes
> them.

What happens if the migration fails on the destination? Will QEMU pick
the lock again when resuming on the source in this case?

Thanks, Roger.
