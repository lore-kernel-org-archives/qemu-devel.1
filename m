Received: from eggs.gnu.org ([2001:4830:134:3::10]:49613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTSV9-0006EB-Md
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTSV8-0002Iz-RM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:41:23 -0400
Date: Thu, 14 Jun 2018 15:41:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180614134113.GI8564@localhost.localdomain>
References: <20180614095544.31549-1-kwolf@redhat.com>
	<20180614095544.31549-4-kwolf@redhat.com>
	<20180614130912.GA16293@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614130912.GA16293@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

Am 14.06.2018 um 15:09 hat Richard W.M. Jones geschrieben:
> On Thu, Jun 14, 2018 at 11:55:43AM +0200, Kevin Wolf wrote:
> > The -drive option serial was deprecated in QEMU 2.10. It's time to
> > remove it.
> > 
> > Tests need to be updated to set the serial number with -global instead
> > of using the -drive option.
> 
> Libguestfs uses this option to set the disk serial/label.  What is
> the alternate syntax?

Just set it in -device (for the disk, e.g. the one for ide-hd) rather
than -drive.

Kevin
