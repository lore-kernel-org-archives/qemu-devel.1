Received: from eggs.gnu.org ([2001:4830:134:3::10]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCjNF-00033a-Qr
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCjNE-0002Aq-Th
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:43:49 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <916e97c1-3737-165c-d7e0-9d5078d070a9@virtuozzo.com>
Date: Thu, 9 Nov 2017 12:43:29 +0300
MIME-Version: 1.0
In-Reply-To: <20171108215703.9295-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 7/7] nbd/server: Fix structured read of
 length 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com

09.11.2017 00:57, Eric Blake wrote:
> The NBD spec was recently clarified to state that a read of length 0
> should not be attempted by a compliant client; but that a server must
> still handle it correctly in an unspecified manner (that is, either
> a successful no-op or an error reply, but not a crash) [1].  However,
> it also implies that NBD_REPLY_TYPE_OFFSET_DATA must have a non-zero
> payload length, but our existing code was replying with a chunk
> that a picky client could reject as invalid because it was missing
> a payload.
>
> We are already doing successful no-ops for 0-length writes and for
> non-structured reads; so for consistency, we want structured reply
> reads to also be a no-op.  The easiest way to do this is to return
> a NBD_REPLY_TYPE_NONE chunk; this is best done via a new helper
> function (especially since future patches for other structured
> replies may benefit from using the same helper).
>
> [1] https://github.com/NetworkBlockDevice/nbd/commit/ee926037
>
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
