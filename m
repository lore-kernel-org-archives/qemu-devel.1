Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehFrr-0003np-MA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehFrn-0001iW-Nk
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:29:35 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1517494591-39369-1-git-send-email-anton.nefedov@virtuozzo.com>
Date: Thu, 01 Feb 2018 15:29:28 +0100
Message-ID: <w51bmh86awn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: fix write with zero
 flag set and iovector provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On Thu 01 Feb 2018 03:16:31 PM CET, Anton Nefedov wrote:
> The normal bdrv_co_pwritev() use is either
>   - BDRV_REQ_ZERO_WRITE reset and iovector provided
>   - BDRV_REQ_ZERO_WRITE set and iovector == NULL
>
> while
>   - the flag reset and iovector == NULL is an assertion failure
>     in bdrv_co_do_zero_pwritev()

Where is that assertion?

Berto
