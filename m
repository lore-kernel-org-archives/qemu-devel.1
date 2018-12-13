Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXS8K-0002Bm-BL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXS8G-0008QJ-2H
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:38:36 -0500
Date: Thu, 13 Dec 2018 15:38:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181213143817.GG5427@linux.fritz.box>
References: <20181212220410.569069-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212220410.569069-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-io: Prefer stderr for error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>

Am 12.12.2018 um 23:04 hat Eric Blake geschrieben:
> When a qemu-io command fails, it's best if the failure message
> goes to stderr rather than stdout.
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> RFC because at least iotest 60 (found by -qcow2 -g quick) breaks due
> to reordering of output lines, and I'd rather know if we like this
> idea before bothering to revisit all affected iotests (including
> discovering if other slower ones have similar problems).

So if we decide to actually do this, should this be error_report()
instead so that HMP 'qemu-io' gets the errors printed to the monitor
rather than stderr? Though I think in that case, we'd also want to
redirect the messages that still go stdout to the monitor as well.

But as I said in another reply, I'm not sure if mixing stdout and stderr
with their different buffering settings is even a good idea in a mostly
interactive program.

Kevin
