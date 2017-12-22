Received: from eggs.gnu.org ([2001:4830:134:3::10]:45713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNcC-000528-CC
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNcB-0001QL-JG
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:43:56 -0500
Date: Fri, 22 Dec 2017 14:43:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222134344.GH3763@localhost.localdomain>
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
	<20171212160450.17510-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212160450.17510-4-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] iotests: add dirty bitmap migration
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, den@openvz.org, jsnow@redhat.com

Am 12.12.2017 um 17:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
> The test creates two vms (vm_a, vm_b), create dirty bitmap in
> the first one, do several writes to corresponding device and
> then migrate vm_a to vm_b with dirty bitmaps.
> 
> For now, only migration through shared storage for persistent
> bitmaps is available, so it is tested here. Only offline variant
> is tested for now (a kind of suspend-resume), as it is needed
> to test that this case is successfully fixed by recent patch.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

> [...]
> +        self.vm_b.launch()
> +        self.vm_b.event_wait("RESUME", timeout=10.0)

Wasn't this racy because the RESUME event may be sent before we connect
to the socket?

Kevin
