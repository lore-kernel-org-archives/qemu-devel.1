Received: from eggs.gnu.org ([2001:4830:134:3::10]:42836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYYcb-00051J-Pf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eYYca-0000gt-16
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:41:53 -0500
Date: Mon, 8 Jan 2018 15:41:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180108144136.GF8052@localhost.localdomain>
References: <20180105065538.13375-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105065538.13375-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-img: Let "info" warn and go ahead
 without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 05.01.2018 um 07:55 hat Fam Zheng geschrieben:
> Management and users are accustomed to "qemu-img info" to query status of
> images even when they are used by guests. Since image locking was added, the -U
> (--force-share) option is needed for that to work. The reason has been that due
> to possible race with image header update, the output can be misleading.
> 
> But what are likely to happen after we emit the error are that, for interactive
> users, '-U' will be used and the command retried; for management (nova, RHV,
> etc.), the operation is broken with no knob to workaround this.
> 
> This series changes that error to a warning so that it doesn't get in the way.

Are management tools actually doing this? There is no good reason to
call 'qemu-img info' for an image that is in use by a VM.

If no, NACK. Automatically disabling locking because it can be
inconvenient defeats the purpose of locking.

If yes, clearly indicate that this usage is deprecated and we'll turn
this into an error again with 2.13. Then management tools can be fixed
in time.

Kevin
