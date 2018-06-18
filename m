Received: from eggs.gnu.org ([2001:4830:134:3::10]:39016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV1xO-0002nm-0E
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV1xN-0000tD-8m
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 17:45:02 -0400
References: <20180614142944.10084-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08d9acfb-a17a-1e86-a0b3-582c3c8db82a@redhat.com>
Date: Mon, 18 Jun 2018 16:44:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180614142944.10084-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/crypto: Simplify block_crypto_{open,
 create}_opts_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 06/14/2018 09:29 AM, Markus Armbruster wrote:
> block_crypto_open_opts_init() and block_crypto_create_opts_init()
> contain a virtual visit of QCryptoBlockOptions and
> QCryptoBlockCreateOptions less member "format", respectively.
> 
> Change their callers to put member "format" in the QDict, so they can
> use the generated visitors for these types instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/crypto.c | 95 ++++++--------------------------------------------
>   block/crypto.h |  8 ++---
>   block/qcow.c   |  5 ++-
>   block/qcow2.c  | 10 +++---
>   4 files changed, 18 insertions(+), 100 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
