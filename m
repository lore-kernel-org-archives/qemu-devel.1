Received: from eggs.gnu.org ([2001:4830:134:3::10]:48986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceeEq-0006Cu-AY
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceeEp-00076w-Lq
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:50:00 -0500
Date: Fri, 17 Feb 2017 09:49:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170217084951.GA5338@noname.redhat.com>
References: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block,
 migration: Use qemu_madvise inplace of madvise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com

Am 17.02.2017 um 09:06 hat Pankaj Gupta geschrieben:
>  To maintain consistency at all the places use qemu_madvise wrapper
>  inplace of madvise call.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Juan/Dave, if one of you can give an Acked-by, I can take this through
my tree.

Kevin
