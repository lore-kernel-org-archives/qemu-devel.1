Received: from eggs.gnu.org ([2001:4830:134:3::10]:40374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Ij-0002et-4z
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gB1Ig-0001AG-0B
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:32:37 -0400
References: <20181012115532.12645-1-kwolf@redhat.com>
	<20181012115532.12645-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a02f348e-34e7-0c96-665a-0d14b913bf19@redhat.com>
Date: Fri, 12 Oct 2018 12:32:21 -0500
MIME-Version: 1.0
In-Reply-To: <20181012115532.12645-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] iscsi: Support auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On 10/12/18 6:55 AM, Kevin Wolf wrote:
> If read-only=off, but auto-read-only=on is given, open the volume
> read-write if we have the permissions, but instead of erroring out for
> read-only volumes, just degrade to read-only.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/iscsi.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
