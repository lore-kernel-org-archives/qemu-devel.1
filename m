Received: from eggs.gnu.org ([2001:4830:134:3::10]:55763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg8p1-0001zA-Pv
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg8p0-0001NU-Kn
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:13:47 -0400
Date: Fri, 11 Aug 2017 14:13:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170811121333.GC4162@localhost.localdomain>
References: <20170811114447.25187-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170811114447.25187-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10? v3 0/2] block: Do OFD lock check
 at runtime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>, christian.ehrhardt@canonical.com, Andrew Baumann <Andrew.Baumann@microsoft.com>, eblake@redhat.com

Am 11.08.2017 um 13:44 hat Fam Zheng geschrieben:
> v3: Fix mingw build. [patchew]
> 
> v2: Probe /dev/null to save LOC. [Eric]
>     Mention "new glibc + old kernel" in commit message. [Kevin, Daniel, Eric,
>     Christian]
> 
> This fixes the image opening failure reported by Andrew Baumann:
> 
> > I'm running a recent Linux build of qemu on Windows Subsystem for Linux (WSL)
> > which doesn't appear to implement file locking:
> >
> > $ qemu-system-aarch64 ... -drive file=test.vhdx,if=none,id=hd0 -device virtio-blk-pci,drive=hd0
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to unlock byte 100
> > qemu-system-aarch64: -drive file=test.vhdx,if=none,id=hd0: Failed to lock byte 100
> 
> It appears to be that the binary is built for Linux targets, but the WSL
> runtime doesn't recognize the ops (-EINVAL).
> 
> This is also a practical problem for Linux considering it's possible to run
> QEMU which is built against a new glibc on an old kernel that doesn't have OFD
> API.
> 
> Convert to runtime check to cope with that.

Thanks, applied to the block branch.

Kevin
