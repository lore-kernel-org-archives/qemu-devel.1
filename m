Received: from eggs.gnu.org ([2001:4830:134:3::10]:47524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cwCjc-0003zL-H5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 15:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cwCjb-0006Es-H5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 15:06:20 -0400
Date: Thu, 6 Apr 2017 21:06:05 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170406190605.o7f7hdaiskjf2pr3@eukaryote>
References: <1491501593-23613-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491501593-23613-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Ignore guest dev
 permissions during incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jcody@redhat.com, Ciprian.Barbu@enea.com, Alexandru.Avadanii@enea.com, armband@enea.com, eblake@redhat.com, qemu-devel@nongnu.org

On Thu, Apr 06, 2017 at 07:59:53PM +0200, Kevin Wolf wrote:
> Usually guest devices don't like other writers to the same image, so
> they use blk_set_perm() to prevent this from happening. In the migration
> phase before the VM is actually running, though, they don't have a
> problem with writes to the image. On the other hand, storage migration
> needs to be able to write to the image in this phase, so the restrictive
> blk_set_perm() call of qdev devices breaks it.
> 
> This patch flags all BlockBackends with a qdev device as
> blk->disable_perm during incoming migration, which means that the
> requested permissions are stored in the BlockBackend, but not actually
> applied to its root node yet.
> 
> Once migration has finished and the VM should be resumed, the
> permissions are applied. If they cannot be applied (e.g. because the NBD
> server used for block migration hasn't been shut down), resuming the VM
> fails.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Kashyap Chamarthy <kchamart@redhat.com>

Thanks.  Posted the test evidence on your RFC thread:

    http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg01086.html

[...]

-- 
/kashyap
