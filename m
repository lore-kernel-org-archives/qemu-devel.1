Received: from eggs.gnu.org ([2001:4830:134:3::10]:51596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYWo-0004ED-J2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYWn-0006Rk-LS
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:28:18 -0500
References: <20181213175154.5242-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6661fe80-96a0-8a9f-453f-afe171a775b6@redhat.com>
Date: Thu, 13 Dec 2018 15:28:06 -0600
MIME-Version: 1.0
In-Reply-To: <20181213175154.5242-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Replace qdict_put() by
 qdict_put_obj() where appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, ari@tuxera.com, mreitz@redhat.com

On 12/13/18 11:51 AM, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>    $  spatch --sp-file scripts/coccinelle/qobject.cocci \
> 	    --macro-file scripts/cocci-macro-file.h \
> 	    --dir block --in-place
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/blklogwrites.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
