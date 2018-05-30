Received: from eggs.gnu.org ([2001:4830:134:3::10]:36044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO2AP-0007YB-Gz
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO2AK-0003sh-Kp
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:33:33 -0400
Date: Wed, 30 May 2018 16:33:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180530143320.GB4311@localhost.localdomain>
References: <20180529203910.7615-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529203910.7615-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] block: Make blockdev-create a job
 and stable API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, jcody@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Am 29.05.2018 um 22:38 hat Kevin Wolf geschrieben:
> This changes the x-blockdev-create QMP command so that it doesn't block
> the monitor and the main loop any more, but starts a background job that
> performs the image creation.
> 
> The basic job as implemented here is all that is necessary to make image
> creation asynchronous and to provide a QMP interface that can be marked
> stable, but it still lacks a few features that jobs usually provide: The
> job will ignore pause commands and it doesn't publish progress yet (so
> both current-progress and total-progress stay at 0). These features can
> be added later without breaking compatibility.
> 
> At the end of the series, the interface is declared stable and the x-
> prefix is removed.

Applied to the block branch.

Kevin
