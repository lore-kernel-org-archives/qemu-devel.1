Received: from eggs.gnu.org ([2001:4830:134:3::10]:39042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgU9w-0003iJ-5t
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgU9v-0007Ms-Dw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:28:32 -0500
Date: Wed, 22 Feb 2017 11:28:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222102823.GE4112@noname.str.redhat.com>
References: <20170131115728.5244.21690.stgit@PASHA-ISP>
	<20170131115745.5244.36762.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170131115745.5244.36762.stgit@PASHA-ISP>
Subject: Re: [Qemu-devel] [PATCH 3/3] replay: disable default snapshot for
 record/replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Am 31.01.2017 um 12:57 hat Pavel Dovgalyuk geschrieben:
> This patch disables setting '-snapshot' option on by default
> in record/replay mode. This is needed for creating vmstates in record
> and replay modes.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Looks good the me. (Though obviously, record/replay mode really comes
with a lot more restrictions for block devices that aren't checked yet.
But it's a start.)

Kevin
