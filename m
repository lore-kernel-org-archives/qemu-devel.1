Received: from eggs.gnu.org ([2001:4830:134:3::10]:59504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ew88M-0005Nc-6K
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ew88H-0004Yp-Cr
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:16:06 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180312220753.20096-3-farosas@linux.vnet.ibm.com>
References: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
	<20180312220753.20096-3-farosas@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 16:15:22 +0100
Message-ID: <w51d106elit.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/5] block/quorum: Remove
 protocol-related fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Mon 12 Mar 2018 11:07:50 PM CET, Fabiano Rosas wrote:
> The quorum driver is not a protocol so it should implement bdrv_open
> instead of bdrv_file_open and not provide a protocol_name.
>
> Attempts to invoke this driver using protocol syntax
> (i.e. quorum:<filename:options:...>) will now fail gracefully:
>
>   $ qemu-img info quorum:foo
>   qemu-img: Could not open 'quorum:foo': Unknown protocol 'quorum'
>
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
