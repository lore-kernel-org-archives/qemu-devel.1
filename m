Received: from eggs.gnu.org ([2001:4830:134:3::10]:53771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNlVg-0000fj-G4
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNlVd-0006Pd-Au
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:46:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fNlVd-0006PA-70
	for qemu-devel@nongnu.org; Tue, 29 May 2018 16:46:21 -0400
References: <1527612092-65980-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1527612092-65980-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <369e8ce9-2097-d42a-1835-b2272e552e95@redhat.com>
Date: Tue, 29 May 2018 15:46:19 -0500
MIME-Version: 1.0
In-Reply-To: <1527612092-65980-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: remove empty flat union
 branches and types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com

On 05/29/2018 11:41 AM, Anton Nefedov wrote:
> Flat unions may now have uncovered branches, so it is possible to get rid
> of empty types defined for that purpose only.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>   qapi/block-core.json | 55 ++++------------------------------------------------
>   qapi/crypto.json     | 13 +------------
>   qapi/misc.json       | 46 ++-----------------------------------------
>   qapi/net.json        | 12 ------------
>   qapi/ui.json         | 19 +-----------------
>   block/qcow2.c        |  1 -
>   cpus.c               |  2 --
>   7 files changed, 8 insertions(+), 140 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
