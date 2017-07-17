Received: from eggs.gnu.org ([2001:4830:134:3::10]:57551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX8Oo-0003Pi-5D
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX8On-0007ju-ET
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:57:30 -0400
Date: Mon, 17 Jul 2017 17:57:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717155719.GK5301@noname.redhat.com>
References: <20170717151207.24919-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717151207.24919-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix compiler warning with gcc
 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>

Am 17.07.2017 um 17:12 hat Max Reitz geschrieben:
> gcc 7 complains that the sprintf() might write a null byte beyond the
> end of the tail buffer.  That is wrong, but we can silence it by making
> i unsigned (it can never be negative anyway, see the if condition right
> before).  For some reason, this allows gcc to suddenly accurately
> calculate the range of i so we can give the tail[] array the exact size
> it needs to have (which is 8 bytes) without gcc complaining.
> 
> In addition, let us convert the sprintf() to snprintf(), because that is
> always nicer, and add an assertion about the range of the return value
> afterwards so we can see that "8 - len" will never be negative and thus
> "entry->name + MIN(j, 8 - len)" will never be out of bounds.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin
