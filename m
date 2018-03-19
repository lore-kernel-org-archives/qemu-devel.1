Received: from eggs.gnu.org ([2001:4830:134:3::10]:60065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1exwjD-0006Yy-Kk
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1exwjC-0007Fh-Hi
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:29:39 -0400
Date: Mon, 19 Mar 2018 16:29:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180319152932.GD30864@localhost.localdomain>
References: <20180119224735.12169-1-jsnow@redhat.com>
	<086ccaa6-eefb-47e4-a865-78075ddd827d@redhat.com>
	<56b7204f-a0d8-3a4e-6e48-6913b1f52a5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b7204f-a0d8-3a4e-6e48-6913b1f52a5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 13.03.2018 um 18:20 hat John Snow geschrieben:
> 
> 
> On 01/19/2018 06:03 PM, Eric Blake wrote:
> > On 01/19/2018 04:47 PM, John Snow wrote:
> >> Adjust each caller of raw_open_common to specify if they are expecting
> >> host and character devices or not. Tighten expectations of file types upon
> >> open in the common code and refuse types that are not expected.
> >>
> >> This has two effects:
> >>
> >> (1) Character and block devices are now considered deprecated for the
> >>     'file' driver, which expects only S_IFREG, and
> >> (2) no file-posix driver (file, host_cdrom, or host_device) can open
> >>     directories now.
> >>
> >> I don't think there's a legitimate reason to open directories as if
> >> they were files. This prevents QEMU from opening and attempting to probe
> >> a directory inode, which can break in exciting ways. One of those ways
> >> is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
> >> size instead of EISDIR. This can coax QEMU into responding with a
> >> confusing "file too big" instead of "Hey, that's not a file".
> >>
> >> See: https://bugs.launchpad.net/qemu/+bug/1739304/
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Whoops, I let this one rot. It could still be considered a bugfix for
> next week.

Yes, we should take this as a bugfix. Needs a rebase, though.

Kevin
