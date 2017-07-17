Received: from eggs.gnu.org ([2001:4830:134:3::10]:58818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX4Fl-000416-VY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX4Fl-0002n6-8g
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:31:53 -0400
Date: Mon, 17 Jul 2017 13:31:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717113142.GF5301@noname.redhat.com>
References: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499946095-8224-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] block: -device drive=<node-name>
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

Am 13.07.2017 um 13:41 hat Kevin Wolf geschrieben:
> Since 2.9 it is possible for a user to care only about nodes and qdev devices,
> but not about BlockBackends, by defining with -blockdev and using their node
> name in -device. Devices create an anonymous BlockBackend internally then.
> 
> One of the major problems in this setup is that such devices are not listed in
> query-block or HMP 'info block' because the BBs are not monitor-owned. A recent
> discussion concluded that we really want to replace query-block and friends
> with something that matches QEMU's internals better, but there's no way to do
> that in 2.10 (and I wouldn't bet on it to be completed for 2.11). So for now,
> just make the devices appear in query-block and add the qdev ID there in order
> to make the devices identifiable (they have 'device': '' because the BB is
> anonymous).
> 
> With the additional qdev field, it turned out that with empty drives, ide-cd
> and scsi-cd weren't even properly attached to the BlockBackend. If you do it
> right, this even results in crashes. (Floppy already gets it right, in case you
> wondered.)
> 
> After this series, -device drive=<node-name> should be reasonably usable
> without a major loss of functionality like before.

Applied to the block branch.

Kevin
