Received: from eggs.gnu.org ([2001:4830:134:3::10]:44967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gV0U6-0002Mp-6j
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gV0U1-0007mK-Ke
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:42:58 -0500
References: <20181206192544.3987-1-jsnow@redhat.com>
	<20181206192544.3987-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bba0107-89d3-eb83-b242-9faebaac3ec4@redhat.com>
Date: Thu, 6 Dec 2018 14:37:28 -0600
MIME-Version: 1.0
In-Reply-To: <20181206192544.3987-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] blockdev: abort transactions in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

On 12/6/18 1:25 PM, John Snow wrote:
> Presently, we abort transactions in the same order they were processed in.
> Bitmap commands, though, attempt to restore backup data structures on abort.
> To that end, though, they need to be aborted in reverse chronological order.
> 
> Replace the QSIMPLEQ data structure with a QTAILQ one, so we can iterate
> in reverse for the abort phase of the transaction.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Does this need to cc qemu-stable? I'm trying to figure out if it affects 
any of the transactions issued by my libvirt code demo'd at KVM Forum.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
