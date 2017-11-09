Received: from eggs.gnu.org ([2001:4830:134:3::10]:44915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCiuP-0003Au-Ul
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCiuP-00055Y-2L
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:14:01 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <59661717-99fb-942e-8768-4206239c2b74@virtuozzo.com>
Date: Thu, 9 Nov 2017 12:13:43 +0300
MIME-Version: 1.0
In-Reply-To: <20171108215703.9295-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 4/7] nbd: Fix struct name for structured
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

09.11.2017 00:57, Eric Blake wrote:
> A closer read of the NBD spec shows that a structured reply chunk
> for a hole is not quite identical to the prefix of a data chunk,
> because the hole has to also send a 32-bit size field.  Although
> we do not yet send holes, we should fix the misleading information
> in our header and make it easier for a future patch to support
> sparse reads.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
