Received: from eggs.gnu.org ([2001:4830:134:3::10]:46723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQB8M-0001Ex-Vr
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQB8M-0001aJ-6W
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:27:46 -0400
Date: Wed, 28 Jun 2017 13:27:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628112736.GD5378@noname.redhat.com>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170623124700.1389-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH RFC v3 2/8] block: Add aio_context field in
 ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>

Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
> timer_cb() needs to know about the current Aio context of the throttle
> request that is woken up. In order to make ThrottleGroupMember backend
> agnostic, this information is stored in an aio_context field instead of
> accessing it from BlockBackend.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

You're copying the AioContext when the BlockBackend is registered for
the throttle group, but what keeps both sides in sync when the context
is changed later on? Don't we need to update the ThrottleGroupMember in
blk_set_aio_context?

Kevin
