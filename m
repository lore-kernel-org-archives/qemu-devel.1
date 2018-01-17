Received: from eggs.gnu.org ([2001:4830:134:3::10]:34157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebhsH-0004KQ-TI
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 02:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebhsE-0008Sl-NQ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 02:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebhsE-0008Ru-Ek
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 02:11:02 -0500
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
	<7711f157-5863-fc75-0730-a631362ffd06@redhat.com>
	<FF7FC980937D6342B9D289F5F3C7C2625B5EFE58@SHSMSX103.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa671cfd-f03d-5f12-9797-f1c7d9e7583c@redhat.com>
Date: Wed, 17 Jan 2018 08:10:50 +0100
MIME-Version: 1.0
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B5EFE58@SHSMSX103.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Harris, James R" <james.r.harris@intel.com>, "Busch, Keith" <keith.busch@intel.com>, "famz@redhat.com" <famz@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>, "mst@redhat.com" <mst@redhat.com>

On 17/01/2018 01:53, Liu, Changpeng wrote:
>> Second, virtio-based vhost-user remains QEMU's preferred method for
>> high-performance I/O in guests.  Discard support is missing and that is
>> important for SSDs; that should be fixed in the virtio spec.  Are there
> Previously I have a patch adding DISCARD support to virtio-blk, but I didn't find
> the way using svn to update the spec patch, any git repository I can use
> to update the virtio-blk spec ? I think I can pick up the feature again.

There is https://github.com/oasis-tcs/virtio-spec.

You should add support for all of:

1) a command that can do WRITE ZERO, WRITE ZERO with discard, and
advisory DISCARD of a range of blocks.  The command must be controlled
by a new feature bit.

2) a configuration space element for discard granularity, controlled by
the same feature bit as (1)

3) a feature bit that is 1 if WRITE ZERO with discard can actually
discard parts that are aligned to the granularity

Thanks,

Paolo
