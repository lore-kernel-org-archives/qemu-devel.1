Received: from eggs.gnu.org ([2001:4830:134:3::10]:53140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw8Xw-00053h-1v
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw8Xv-0007hH-Bw
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:38:00 -0400
Date: Thu, 6 Apr 2017 16:37:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406143748.GI4341@noname.redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406142527.25835-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/5] mirror: Fix aio context of
 mirror_top_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 06.04.2017 um 16:25 hat Fam Zheng geschrieben:
> It should be moved to the same context as source, before inserting to the
> graph.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
