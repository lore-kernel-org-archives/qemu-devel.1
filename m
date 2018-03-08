Received: from eggs.gnu.org ([2001:4830:134:3::10]:50990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etpOE-0004Cp-L6
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 01:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etpOD-0005j6-TR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 01:50:58 -0500
Date: Thu, 8 Mar 2018 01:50:52 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1651749911.5944222.1520491852256.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180307225732.155835-1-eblake@redhat.com>
References: <20180307225732.155835-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Honor FUA request on
 NBD_CMD_TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, kwolf@redhat.com


> The NBD spec states that since trim requests can affect disk contents,
> then they should allow for FUA semantics just like writes for ensuring
> the disk has settled before returning.  As bdrv_[co_]pdiscard() does
> not (yet?) support a flags argument, we can't pass FUA down the block
> layer stack, and must therefore emulate it with a flush at the NBD
> layer.

TRIM requests should not need FUA since they're just advisory.  On
the other hand, WRITE ZEROES requests need to support FUA.

Paolo
