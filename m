Received: from eggs.gnu.org ([2001:4830:134:3::10]:34855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFfxa-0006VW-2A
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFfxZ-0001Qu-2Y
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:41:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eFfxY-0001QX-St
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 07:41:29 -0500
Date: Fri, 17 Nov 2017 13:41:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171117124123.GD4795@localhost.localdomain>
References: <20171116151419.694-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116151419.694-1-anthony.perard@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] migration,
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
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, Wei Liu <wei.liu2@citrix.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Am 16.11.2017 um 16:14 hat Anthony PERARD geschrieben:
> When doing a live migration of a Xen guest with libxl, the images for
> block devices are locked by the original QEMU process, and this prevent
> the QEMU at the destination to take the lock and the migration fail.
> 
> From QEMU point of view, once the RAM of a domain is migrated, there is
> two QMP commands, "stop" then "xen-save-devices-state", at which point a
> new QEMU is spawned at the destination.
> 
> Release locks in "xen-save-devices-state" so the destination can takes
> them, if it's a live migration.
> 
> This patch add the "live" parameter to "xen-save-devices-state" which
> default to true so older version of libxenlight can work with newer
> version of QEMU.
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
> Changes in V2:
> - add the live parameter
> 
> CC: Kevin Wolf <kwolf@redhat.com>

Makes sense to me.

Kevin
