Received: from eggs.gnu.org ([2001:4830:134:3::10]:38638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e40mp-0008Gz-Jm
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e40mk-0000EK-NZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 04:30:11 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <372f3c20-ad1a-f7a7-322c-3de39303fe89@virtuozzo.com>
Date: Mon, 16 Oct 2017 11:30:00 +0300
MIME-Version: 1.0
In-Reply-To: <20171015010131.12172-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 1/8] nbd: Include error names in trace
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

15.10.2017 04:01, Eric Blake wrote:
> NBD errors were originally sent over the wire based on Linux errno
> values; but not all the world is Linux, and not all platforms share
> the same values.  Since a number isn't very easy to decipher on all
> platforms, update the trace messages to include the name of NBD
> errors being sent/received over the wire.  Tweak the trace messages
> to be at the point where we are using the NBD error, not the
> translation to the host errno values.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
