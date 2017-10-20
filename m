Received: from eggs.gnu.org ([2001:4830:134:3::10]:40408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5SKQ-0002KD-VS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e5SKN-0005fj-R4
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 04:06:50 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2ad2becb-7f62-a0d7-e8b8-a70a15b01fc2@virtuozzo.com>
Date: Fri, 20 Oct 2017 11:06:44 +0300
MIME-Version: 1.0
In-Reply-To: <20171019222637.17890-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 04/11] nbd/server: Report error for
 write to read-only export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

20.10.2017 01:26, Eric Blake wrote:
> When the server is read-only, we were already reporting an error
> message for NBD_CMD_WRITE_ZEROES, but failed to set errp for a
> similar NBD_CMD_WRITE.  This will matter more once structured
> replies allow the server to propagate the errp information back
> to the client.  While at it, use an error message that makes a
> bit more sense if viewed on the client side.
>
> Note that when using qemu-io to test qemu-nbd behavior, it is
> rather difficult to convince qemu-io to send protocol violations
> (such as a read beyond bounds), because we have a lot of active
> checking on the client side that a qemu-io request makes sense
> before it ever goes over the wire to the server.  The case of a
> client attempting a write when the server is started as
> 'qemu-nbd -r' is one of the few places where we can easily test
> error path handling, without having to resort to hacking in known
> temporary bugs to either the server or client.  [Maybe we want a
> future patch to the client to do up-front checking on writes to a
> read-only export, the way it does up-front bounds checking; but I
> don't see anything in the NBD spec that points to a protocol
> violation in our current behavior.]
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
