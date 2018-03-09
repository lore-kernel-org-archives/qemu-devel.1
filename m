Received: from eggs.gnu.org ([2001:4830:134:3::10]:37961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNsi-0007Y8-DV
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euNsh-0001zd-FP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:40:44 -0500
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f253efc-70d7-ed25-3b7e-3f61f444280a@redhat.com>
Date: Fri, 9 Mar 2018 13:40:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180309172713.26318-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] luks: Separate image file creation
 from formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/09/2018 11:27 AM, Kevin Wolf wrote:
> The crypto driver used to create the image file in a callback from the
> crypto subsystem. If we want to implement .bdrv_co_create, this needs to
> go away because that callback will get a reference to an already
> existing block node.
> 
> Move the image file creation to block_crypto_create_generic().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/crypto.c | 37 +++++++++++++++++--------------------
>   1 file changed, 17 insertions(+), 20 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
