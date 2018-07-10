Received: from eggs.gnu.org ([2001:4830:134:3::10]:53161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fchpe-0007VO-IS
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fchpd-0007Hj-RW
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:52:46 -0400
Date: Tue, 10 Jul 2018 09:52:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180710015233.GG17581@lemon.usersys.redhat.com>
References: <20180709163719.87107-1-vsementsov@virtuozzo.com>
	<20180709163719.87107-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709163719.87107-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] block: split flags in copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org

On Mon, 07/09 19:37, Vladimir Sementsov-Ogievskiy wrote:
> Pass read flags and write flags separately. This is needed to handle
> coming BDRV_REQ_NO_SERIALISING clearly in following patches.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
