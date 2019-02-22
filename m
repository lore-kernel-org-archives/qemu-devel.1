Received: from eggs.gnu.org ([209.51.188.92]:34801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxCHQ-0000QT-Gt
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxCDK-0004Qe-Hm
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:54:11 -0500
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <078b2a09-b86f-3705-68cf-452f7845cda5@redhat.com>
Date: Fri, 22 Feb 2019 08:53:50 -0600
MIME-Version: 1.0
In-Reply-To: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] iotests: handle TypeError for Python3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, mreitz@redhat.com, kwolf@redhat.com, ehabkost@redhat.com, philmd@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On 2/22/19 5:26 AM, Andrey Shinkevich wrote:
> The data type for bytes in Python3 differs from the one in Python2.
> Those cases should be managed separately.
> 
> v1:
> In the first version, the TypeError in Python3 was handled as the
> exception.
> Discussed in the e-mail thread with the Message ID:
> <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>

This paragraph belongs...

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> ---

...here, after the --- marker. It is useful to reviewers, but does not
need to land in the long-term git history (a year from now, we won't
care if it was v2 or v10 that landed, nor how it changed from the
versions that didn't land).  I can clean it up on staging.

Reviewed-by: Eric Blake <eblake@redhat.com>

Will stage through my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
