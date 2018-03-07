Received: from eggs.gnu.org ([2001:4830:134:3::10]:53785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaJF-00056Q-MZ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etaJE-0006Nm-Ux
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:44:49 -0500
References: <20180307144205.20619-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <291535c9-9f5e-7dd0-c701-a4152a1bb44b@redhat.com>
Date: Wed, 7 Mar 2018 15:44:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180307144205.20619-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 07/03/2018 15:42, Stefan Hajnoczi wrote:
> v3:
>  * Rebase on qemu.git/master after AIO_WAIT_WHILE() was merged [Fam]
> v2:
>  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeventfd
>    from a BH in the IOThread [Fam]
> 
> There are several race conditions in virtio-blk/virtio-scsi dataplane code.
> This patch series addresses them, see the commit description for details on the
> individual cases.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Paolo
