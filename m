Received: from eggs.gnu.org ([2001:4830:134:3::10]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ew4Ob-0005xK-V6
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ew4Ob-0004mP-7i
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:16:37 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <660ad007-7a00-6b0e-5700-e1c9274b2f6d@redhat.com>
Date: Wed, 14 Mar 2018 06:16:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, qemu-devel@nongnu.org

On 03/09/2018 03:46 PM, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to qcow, which
> enables image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |  21 +++++-
>   block/qcow.c         | 196 ++++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 150 insertions(+), 67 deletions(-)

>   ##
> +# @BlockdevCreateOptionsQcow:
> +#
> +# Driver specific image creation options for qcow.
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +# @backing-file     File name of the backing file if a backing file
> +#                   should be used
> +# @encrypt          Encryption options if the image should be encrypted

Idea for followup patch - we should strongly document that encryption of 
qcow is discouraged as insecure, and/or mention that qcow2 is generally 
a better option than qcow when creating images over QMP.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
