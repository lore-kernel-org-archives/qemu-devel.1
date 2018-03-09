Received: from eggs.gnu.org ([2001:4830:134:3::10]:44463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOIK-0003JR-NF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOIJ-0006av-Un
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:07:12 -0500
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7d16f763-a8fe-7e0f-9bbf-7ec5b51d6222@redhat.com>
Date: Fri, 9 Mar 2018 14:06:47 -0600
MIME-Version: 1.0
In-Reply-To: <20180309172713.26318-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] luks: Create
 block_crypto_co_create_generic()
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
> Everything that refers to the protocol layer or QemuOpts is moved out of
> block_crypto_create_generic(), so that the remaining function is
> suitable to be called by a .bdrv_co_create implementation.
> 
> LUKS is the only driver that actually implements the old interface, and
> we don't intend to use it in any new drivers, so put the moved out code
> directly into a LUKS function rather than creating a generic
> intermediate one.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/crypto.c | 95 +++++++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 61 insertions(+), 34 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
