Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epFiS-00053q-Hl
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epFiR-0001Xl-Jb
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:56:56 -0500
Date: Fri, 23 Feb 2018 16:56:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180223155647.GD3470@localhost.localdomain>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-19-kwolf@redhat.com>
	<80aaebea-b192-333f-aa35-3cdf0e71aef3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80aaebea-b192-333f-aa35-3cdf0e71aef3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/36] rbd: Fix use after free in
 qemu_rbd_set_keypairs() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Am 23.02.2018 um 16:15 hat Eric Blake geschrieben:
> On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> > If we want to include the invalid option name in the error message, we
> > can't free the string earlier than that.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/rbd.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> D'oh.  Should this one be cc'd to qemu-stable?

Yes, good point. Adding the CC to this reply, and also adding a Cc: line
in the commit message.

Kevin
