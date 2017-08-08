Received: from eggs.gnu.org ([2001:4830:134:3::10]:35108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dezwh-0004n0-8D
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dezwg-0002JE-32
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:32:59 -0400
Date: Tue, 8 Aug 2017 10:32:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170808083248.GE4850@dhcp-200-186.str.redhat.com>
References: <20170807203007.19033-1-eblake@redhat.com>
	<20170807203007.19033-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807203007.19033-5-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] qcow2: Check failure of
 bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 07.08.2017 um 22:30 hat Eric Blake geschrieben:
> qcow2_co_pwritev_compressed() should not call bdrv_truncate()
> if determining the size failed.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
