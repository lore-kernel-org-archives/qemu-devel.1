Received: from eggs.gnu.org ([2001:4830:134:3::10]:53317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpZCP-00030C-Qd
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpZCP-0005G8-4I
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:17:25 -0400
Date: Tue, 14 Aug 2018 15:17:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814131714.GM5025@dhcp-200-186.str.redhat.com>
References: <20180814124320.39481-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814124320.39481-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: make .bdrv_close optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jcody@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru, mreitz@redhat.com, den@openvz.org

Am 14.08.2018 um 14:43 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Several block drivers have to define empty .bdrv_close handler. Let's
> instead make it optional.

Thanks, applied to the block branch.

Kevin
