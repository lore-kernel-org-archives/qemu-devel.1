Received: from eggs.gnu.org ([2001:4830:134:3::10]:47987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdZnw-0007y9-1N
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdZnv-0000qI-2t
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:53:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
References: <20170212014724.10618-1-mreitz@redhat.com>
	<w51lgtazdqs.fsf@maestria.local.igalia.com>
	<8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
Date: Tue, 14 Feb 2017 10:52:56 +0100
Message-ID: <w51k28tumiv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Swap request limit
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Mon 13 Feb 2017 06:13:38 PM CET, Max Reitz wrote:

>>> -#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
>>> -                                     INT_MAX >> BDRV_SECTOR_BITS)
>>> -#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
>>> +#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
>>> +#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BDRV_SECTOR_BITS)
>> 
>> I'm just pointing it out because I don't know if this can cause
>> problems, but this patch would make BDRV_REQUEST_MAX_BYTES not a
>> multiple of the sector size (INT_MAX is actually a prime number).
>
> Very good point. I don't think this could be an issue, though. For one
> thing, the use of BDRV_REQUEST_MAX_BYTES is very limited.

Ok, but then I wonder what's the benefit of increasing
BDRV_REQUEST_MAX_BYTES.

Berto
