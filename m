Received: from eggs.gnu.org ([2001:4830:134:3::10]:50839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQd7r-0004oW-SZ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQd7n-0007OI-MD
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:48:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQd7n-0007Ni-E2
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:48:47 -0500
Date: Mon, 9 Jan 2017 18:48:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170109184252-mutt-send-email-mst@kernel.org>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
	<148192392306.37.10111381964118487672@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148192392306.37.10111381964118487672@790289a7ca88>
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, stefanha@redhat.com

On Fri, Dec 16, 2016 at 01:32:04PM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> Your series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Subject: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
> Message-id: 1481922841-4324-1-git-send-email-mst@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> # Useful git options
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1481922841-4324-1-git-send-email-mst@redhat.com -> patchew/1481922841-4324-1-git-send-email-mst@redhat.com
> Switched to a new branch 'test'
> f99ab3b virtio: avoid using guest_notifier_mask in vhost-user mode
> 3fb701c pci: fix error message for express slots
> 88360e6 i386: amd_iommu: fix MMIO register count and access
> 65e5776 tests/vhost-user-bridge: use contrib/libvhost-user
> b70c976 contrib: add libvhost-user
> b641366 tests/vhost-user-bridge: do not accept more than one connection
> a1416a7 tests/vhost-user-bridge: indicate peer disconnected
> 5ced0b7 tests/vhost-user-bridge: remove unnecessary dispatcher_remove
> ee5fbf8 tests/vhost-user-bridge: remove false comment

The strange thing here is that this actually seems to apply patches
from list instead of getting the tag from the tree.



> === OUTPUT BEGIN ===
> Checking PATCH 1/9: tests/vhost-user-bridge: remove false comment...
> Checking PATCH 2/9: tests/vhost-user-bridge: remove unnecessary dispatcher_remove...
> Checking PATCH 3/9: tests/vhost-user-bridge: indicate peer disconnected...
> Checking PATCH 4/9: tests/vhost-user-bridge: do not accept more than one connection...
> Checking PATCH 5/9: contrib: add libvhost-user...
> ERROR: Invalid UTF-8, patch and commit message should be encoded in UTF-8
> #75: FILE: contrib/libvhost-user/libvhost-user.c:9:
> + *  Marc-Andr Lureau <mlureau@redhat.com>
>               ^
> 
> ERROR: Invalid UTF-8, patch and commit message should be encoded in UTF-8
> #1579: FILE: contrib/libvhost-user/libvhost-user.h:8:
> + *  Marc-Andr Lureau <mlureau@redhat.com>
>               ^
> 
> total: 2 errors, 0 warnings, 1950 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 6/9: tests/vhost-user-bridge: use contrib/libvhost-user...
> Checking PATCH 7/9: i386: amd_iommu: fix MMIO register count and access...
> Checking PATCH 8/9: pci: fix error message for express slots...
> Checking PATCH 9/9: virtio: avoid using guest_notifier_mask in vhost-user mode...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
