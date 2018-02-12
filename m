Received: from eggs.gnu.org ([2001:4830:134:3::10]:40901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHOT-0004f7-2B
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elHOO-0004SN-Ij
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:55:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elHOO-0004Ry-Dw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:55:48 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fdc34f2c-f034-d2a1-9be9-02085c439238@redhat.com>
Date: Mon, 12 Feb 2018 10:55:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/29] Include qapi/qmp/qerror.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block.c                 | 1 -
>   block/qcow2.c           | 1 -
>   chardev/char-fe.c       | 1 +
>   chardev/char.c          | 1 +
>   qom/object_interfaces.c | 1 +
>   scripts/qapi-visit.py   | 2 +-
>   6 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(May get stale again soon; we'll have fun with last-minute rebasing at 
the time this is ready for a pull request)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
