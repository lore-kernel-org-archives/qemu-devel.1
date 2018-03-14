Received: from eggs.gnu.org ([2001:4830:134:3::10]:59964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ew8AO-0006JU-FR
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ew8AJ-0005ei-IK
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:18:12 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180312220753.20096-4-farosas@linux.vnet.ibm.com>
References: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
	<20180312220753.20096-4-farosas@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 16:18:06 +0100
Message-ID: <w51a7vaele9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/5] block/throttle: Remove
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Mon 12 Mar 2018 11:07:51 PM CET, Fabiano Rosas wrote:
> The throttle driver is not a protocol so it should implement bdrv_open
> instead of bdrv_file_open and not provide a protocol_name.
>
> Attempts to invoke this driver using protocol syntax
> (i.e. throttle:<filename:options:...>) will now fail gracefully:
>
>   $ qemu-img info throttle:foo
>   qemu-img: Could not open 'throttle:foo': Unknown protocol 'throttle'
>
> Signed-off-by: Fabiano Rosas <farosas@linux.vnet.ibm.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
