Received: from eggs.gnu.org ([2001:4830:134:3::10]:59720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHDUY-0000Jj-KW
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHDUT-0004bj-Su
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:41:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHDUT-0004bE-NF
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:41:49 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171116151419.694-1-anthony.perard@citrix.com> (Anthony
	PERARD's message of "Thu, 16 Nov 2017 15:14:19 +0000")
References: <20171116151419.694-1-anthony.perard@citrix.com>
Reply-To: quintela@redhat.com
Date: Tue, 21 Nov 2017 19:41:46 +0100
Message-ID: <87r2srpj85.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <wei.liu2@citrix.com>, Ian Jackson <ian.jackson@eu.citrix.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Anthony PERARD <anthony.perard@citrix.com> wrote:
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
>
> also CCing libxl maintainers:
> CC: Ian Jackson <ian.jackson@eu.citrix.com>
> CC: Wei Liu <wei.liu2@citrix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued
