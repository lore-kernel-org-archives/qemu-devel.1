Received: from eggs.gnu.org ([2001:4830:134:3::10]:48723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BpH-0000oe-NS
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6BpD-00035j-SW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:09:27 -0400
Date: Thu, 4 May 2017 16:09:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504080913.GD4725@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.10 00/17] Block layer thread safety,
 part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> This series uses mutexes or atomic operations around core block layer
> operations.  The remaining parts include:
> 
> - drivers, though most of them are already thread safe (part 2, 8 patches,
>   depends on Kevin's conversion of QED to coroutines)
> 
> - block jobs, before-write notifiers, the write threshold mechanism,
>   snapshots, replication, key management (part 3, 16 patches)
> 
> - devices (virtio-blk/virtio-scsi, part 4, 5 patches)
> 
> Once these four parts are done the AioContext lock can be removed
> together with all temporary workarounds that have accumulated.

Thanks! I had a few nits and questions, but it's pretty good in general:

Reviewed-by: Fam Zheng <famz@redhat.com>

Fam
