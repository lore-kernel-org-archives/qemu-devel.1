Received: from eggs.gnu.org ([2001:4830:134:3::10]:34179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOrrV-0003X6-Fg
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOrrS-0000yK-4h
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:45:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fOrrR-0000su-QB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 17:45:26 -0400
References: <1527698252-86258-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1527698252-86258-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb7bd10d-c0eb-c2c8-40af-f22517b464ac@redhat.com>
Date: Fri, 1 Jun 2018 16:45:23 -0500
MIME-Version: 1.0
In-Reply-To: <1527698252-86258-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qapi: allow empty branches in flat
 unions
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

On 05/30/2018 11:37 AM, Anton Nefedov wrote:
> It often happens that just a few discriminator values imply extra data in
> a flat union. Existing checks did not make possible to leave other values
> uncovered. Such cases had to be worked around by either stating a dummy
> (empty) type or introducing another (subset) discriminator enumeration.
> 
> Both options create redundant entities in qapi files for little profit.
> 
> With this patch it is not necessary anymore to add designated union
> fields for every possible value of a discriminator enumeration.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
