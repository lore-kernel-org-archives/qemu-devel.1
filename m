Received: from eggs.gnu.org ([2001:4830:134:3::10]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewqvD-0007Wb-8c
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewqvC-0003ec-8S
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:05:31 -0400
Date: Fri, 16 Mar 2018 16:05:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180316150514.GC5851@localhost.localdomain>
References: <20180315115144.801202-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315115144.801202-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] iotests: Avoid realpath,
 for CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, Max Reitz <mreitz@redhat.com>

Am 15.03.2018 um 12:51 hat Eric Blake geschrieben:
> CentOS 6 lacks a realpath binary on the base install, which makes
> all iotests runs fail since the 2.11 release:
> 
> 001         - output mismatch (see 001.out.bad)
> ./check: line 815: realpath: command not found
> diff: missing operand after `/home/dummy/qemu/tests/qemu-iotests/001.out'
> diff: Try `diff --help' for more information.
> 
> Many of the uses of 'realpath' in the check script were being
> used on the output of 'type -p' - but that is already an
> absolute file name.  While a canonical name can often be
> shorter (realpath gets rid of /../), it can also be longer (due
> to symlink expansion); and we really don't care if the name is
> canonical, merely that it was an executable file with an
> absolute path.  These were broken in commit cceaf1db.
> 
> The remaining use of realpath was to convert a possibly relative
> filename into an absolute one before calling diff to make it
> easier to copy-and-paste the filename for moving the .bad file
> into place as the new reference file even when running iotests
> out-of-tree (see commit 93e53fb6), but $PWD can achieve the same
> purpose.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
