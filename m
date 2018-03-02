Received: from eggs.gnu.org ([2001:4830:134:3::10]:43078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ernLk-00013k-Tc
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ernLh-0002tD-Ow
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:16:00 -0500
Date: Fri, 2 Mar 2018 19:15:37 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180302161536.GA2454@rkaganb.sw.ru>
References: <20180227115651.30762-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227115651.30762-1-rpalethorpe@suse.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/2] Increase usability of
 external snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

On Tue, Feb 27, 2018 at 12:56:49PM +0100, Richard Palethorpe wrote:
> Following on from the discussion about creating savevm/loadvm QMP
> equivalents. I decided to take the advice given that we should use external
> snapshots. However reverting to a snapshot currently requires QEMU to be
> restarted with "-incoming".  Restarting QEMU requires a fair bit of
> book keeping to be done by the management application and may take
> measurably more time.

AFAICT "-incoming" is not the only reason for starting QEMU anew.  The
block devices will need to be pointed at different nodes in the backing
chains.  Moreover the snapshot you're reverting to may have been taken
at a point where the VM had different configuration than it has now.

So the management application will need to do a lot of bookkeeping stuff
anyway, and it'll probably have harder time applying all of the
configuration changes to a live QEMU instance.

Is the cost of killing the old QEMU process and starting a new one big
enough to be worth all the hassle?

Thanks,
Roman.
