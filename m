Received: from eggs.gnu.org ([2001:4830:134:3::10]:42761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d19Nh-0004Ex-De
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d19Ng-0007zf-GD
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:32:09 -0400
Date: Thu, 20 Apr 2017 18:31:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420103158.GK24486@lemon.lan>
References: <20170420075237.18219-1-famz@redhat.com>
	<20170420075237.18219-5-famz@redhat.com>
	<20170420102040.GD4747@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420102040.GD4747@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 04/20] qemu-img: Add --unsafe-read
 option to subcommands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 04/20 12:20, Kevin Wolf wrote:
> Am 20.04.2017 um 09:52 hat Fam Zheng geschrieben:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> This one conflicts with my block-next branch, probably Peter's
> simplification of img_convert().

Probably, thanks for pointing out. I've tried to resolve it and it's
straightforward. I'll send v14 basing off your block-next, once you've done
reviewing.

For now, the rebased branch, including the two small fixes, is pushed to my
github branch:

    git://github.com/famz/qemu.git image-lock

Fam
