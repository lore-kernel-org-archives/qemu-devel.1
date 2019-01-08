Received: from eggs.gnu.org ([209.51.188.92]:37839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggthf-0003tC-M7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggthf-0006hN-1c
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:54:07 -0500
Date: Tue, 8 Jan 2019 16:53:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108155355.GH11492@linux.fritz.box>
References: <20181114145857.19720-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114145857.19720-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: Assert that refcount block
 offsets fit in the refcount table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Am 14.11.2018 um 15:58 hat Alberto Garcia geschrieben:
> Refcount table entries have a field to store the offset of the
> refcount block. The rest of the bits of the entry are currently
> reserved.
> 
> The offset is always taken from the entry using REFT_OFFSET_MASK to
> ensure that we only use the bits that belong to that field.
> 
> While that mask is used every time we read from the refcount table, it
> is never used when we write to it. Due to the other constraints of the
> qcow2 format QEMU can never produce refcount block offsets that don't
> fit in that field so any such offset when allocating a refcount block
> would indicate a bug in QEMU.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin
