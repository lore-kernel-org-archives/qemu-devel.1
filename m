Received: from eggs.gnu.org ([2001:4830:134:3::10]:35140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyuiF-0002Lf-0Z
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyuiE-00075r-19
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:28:07 -0400
Date: Fri, 14 Apr 2017 14:27:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170414062757.GB12191@lemon>
References: <20170207235757.2026-1-mreitz@redhat.com>
	<efaef6ef-a1a5-a767-72a6-8c93ba0d9dd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efaef6ef-a1a5-a767-72a6-8c93ba0d9dd1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] progress: Show current progress on SIGINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu, 04/13 22:38, Max Reitz wrote:
> On 08.02.2017 00:57, Max Reitz wrote:
> > Currently we only print progress information on retrieval of SIGUSR1.
> > Some systems have a dedicated SIGINFO for this, however, so it should be
> > handled appropriately if it is available.
> > 
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1662468
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> > Can anyone test this on a BSD system? O:-)
> > ---
> >  util/qemu-progress.c | 3 +++
> >  qemu-img.texi        | 3 ++-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Ping
> 
> (If nobody replies in the next month or so, I'm just going to merge
> this, as util/qemu-progress.c doesn't have a maintainer.)

qemu-img.c is the sole user, so it implicitly belongs to the block maintainers,
I assume.

Actually, why not add this file under block layer section of MAINTAINERS?

Fam
