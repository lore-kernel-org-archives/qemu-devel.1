Received: from eggs.gnu.org ([2001:4830:134:3::10]:48160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgRh9-00087g-W2
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fgRh5-0008Va-1Y
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:27:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fgRh4-0008VR-Sn
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 05:27:22 -0400
Date: Fri, 20 Jul 2018 17:27:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180720092717.GB16910@xz-mi>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/17] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 18, 2018 at 06:41:43PM +0300, Denis Plotnikov wrote:
> The workflow to make a snapshot is the following:
> 1. Pause the vm
> 2. Make a snapshot of block devices using the scheme of your choice
> 3. Turn on background-snapshot migration capability
> 4. Start the migration using the destination (migration stream) of your choice.
>    The migration will resume the vm execution by itself
>    when it has the devices' states saved  and is ready to start ram writing
>    to the migration stream.
> 5. Listen to the migration finish event
> 
> The bakground snapshot works with support of KVM patch:
> "x86: mmu: report failed memory access to the userspace"
> (not applied to the mainstream, it's in the kvm mailing list)

Hello, Denis,

Do you mind to push your tree to an online repository in case to make
review easier?

Thanks,

-- 
Peter Xu
