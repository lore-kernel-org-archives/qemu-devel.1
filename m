Received: from eggs.gnu.org ([2001:4830:134:3::10]:41256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erCog-0007Nc-Np
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 20:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erCof-0002rp-W5
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 20:15:26 -0500
Date: Thu, 1 Mar 2018 09:15:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180301011517.GH21336@lemon.usersys.redhat.com>
References: <20180228181946.22958-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228181946.22958-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Wed, 02/28 18:19, Stefan Hajnoczi wrote:
> v2:
>  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeventfd
>    from a BH in the IOThread [Fam]
> 
> There are several race conditions in virtio-blk/virtio-scsi dataplane code.
> This patch series addresses them, see the commit description for details on the
> individual cases.

This doesn't apply to master. Which branch is it based off?

Fam
