Received: from eggs.gnu.org ([2001:4830:134:3::10]:57748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtyb-0001FX-LR
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLtyX-0004mq-Gd
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:20:01 -0400
Date: Fri, 16 Jun 2017 18:19:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170616161954.GD4366@noname.fritz.box>
References: <1495486409-5197-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495486409-5197-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Move the qemu-ga description
 into a separate chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Am 22.05.2017 um 22:53 hat Thomas Huth geschrieben:
> The qemu-ga description is currently a subsection of the Disk Images
> chapter - which does not make much sense since the qemu-ga is not
> directly related to disk images. So let's move this information
> into a separate chapter instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

This patch messed up the start of the manpage (qemu.1).

It refers to "qemu-ga - QEMU Guest Agent" now and the synopsis section
includes the description of a part of the targets as well as some
literal texinfo code.

Kevin
