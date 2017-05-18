Received: from eggs.gnu.org ([2001:4830:134:3::10]:45190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dBNEm-0007aI-46
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndevos@redhat.com>) id 1dBNEl-0004yX-18
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:21:12 -0400
Date: Thu, 18 May 2017 17:21:02 +0200
From: Niels de Vos <ndevos@redhat.com>
Message-ID: <20170518152102.GE2431@ndevos-x240.usersys.redhat.com>
References: <20170515191136.24314-1-ndevos@redhat.com>
	<20170518095422.12555-1-ndevos@redhat.com>
	<a194304c-1327-ec67-3f64-c0124c6482dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a194304c-1327-ec67-3f64-c0124c6482dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] gluster: add support for
 PREALLOC_MODE_FALLOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu, May 18, 2017 at 09:30:53AM -0500, Eric Blake wrote:
> On 05/18/2017 04:54 AM, Niels de Vos wrote:
> > Add missing support for "preallocation=falloc" to the Gluster block
> > driver. This change bases its logic on that of block/file-posix.c and
> > removed the gluster_supports_zerofill() and qemu_gluster_zerofill()
> > functiond in favour of #ifdef checks in an easy to read
> 
> s/functiond/functions/
> 
> > switch-statement.
> > 
> > Both glfs_zerofill() and glfs_fallocate() have been introduced with
> > GlusterFS 3.5.0 (pkg-config glusterfs-api = 6). A #define for the
> > availability of glfs_fallocate() has been added to ./configure.
> > 
> > Reported-by: Satheesaran Sundaramoorthi <sasundar@redhat.com>
> > URL: https://bugzilla.redhat.com/1450759
> > Signed-off-by: Niels de Vos <ndevos@redhat.com>
> > ---
> > v2 changes requested by Jeff Cody:
> > - add CONFIG_GLUSTERFS_FALLOCATE
> > - remove unneeded wrapper qemu_gluster_zerofill()
> 
> The automated tools prefer that v2 patches are sent as a new top-level
> thread, rather than buried in-reply-to the v1 thread.

Ok, I'm happy to resend it with the typo corrected if that helps.

Niels
