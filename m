Received: from eggs.gnu.org ([2001:4830:134:3::10]:33196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3MOn-0005uf-UV
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1f3MOi-0000Fd-4F
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:54:58 -0400
Date: Tue, 3 Apr 2018 09:54:30 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180403135430.GA31365@localhost.localdomain>
References: <f7011b6ebc323b45b46a8f01310249e2e6d77617.1522730165.git.jcody@redhat.com>
	<c9b947ec-a9ea-bcd3-efb9-c6d0bce1e150@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9b947ec-a9ea-bcd3-efb9-c6d0bce1e150@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] block: handle invalid lseek
 returns gracefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Tue, Apr 03, 2018 at 07:57:14AM -0500, Eric Blake wrote:
> On 04/02/2018 11:37 PM, Jeff Cody wrote:
> > In commit 223a23c198787328ae75bc65d84edf5fde33c0b6, we implemented a
> > workaround in the gluster driver to handle invalid values returned for
> > SEEK_DATA or SEEK_HOLE.
> > 
> > In some instances, these same invalid values can be seen in the posix
> > file handler as well - for example, it has been reported on FUSE gluster
> > mounts.
> 
> Yuck - that should be reported to the FUSE and gluster folks, as it does
> not scale to have everyone else work around their bug.  But in the
> meantime, working around it here is acceptable.
> 

Yes - there is a bug report on gluster still open for the lseek issue, I'll
make sure to add on it that it affects FUSE as well, so that they are aware.

-Jeff
