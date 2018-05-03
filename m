Received: from eggs.gnu.org ([2001:4830:134:3::10]:44843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEMpK-0006OI-Nb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEMpJ-0007QR-Su
	for qemu-devel@nongnu.org; Thu, 03 May 2018 18:35:50 -0400
References: <152538665256.2487.10250098083614769302@71c20359a636>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0336181d-8ae7-dec0-c78a-f0d91a321870@redhat.com>
Date: Thu, 3 May 2018 17:35:34 -0500
MIME-Version: 1.0
In-Reply-To: <152538665256.2487.10250098083614769302@71c20359a636>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/client: Relax handling of large
 NBD_CMD_BLOCK_STATUS reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com

On 05/03/2018 05:30 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 

> /tmp/qemu-test/src/block/nbd-client.c: In function 'nbd_parse_blockstatus_payload':
> /tmp/qemu-test/src/block/nbd-client.c:271:24: error: statement with no effect [-Werror=unused-value]
>           extent->length == orig_length;
>           ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~

I should quit sending patches at the end of my day.  This should 
obviously be =, not ==.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
