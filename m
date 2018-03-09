Received: from eggs.gnu.org ([2001:4830:134:3::10]:39506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJWB-0006ap-Nk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:01:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJWA-0005Mt-UM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:01:11 -0500
References: <20180309104151.2431-1-apahim@redhat.com>
	<20180309104151.2431-2-apahim@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09c3d7cd-b7a0-6eb7-f6df-81f767be6958@redhat.com>
Date: Fri, 9 Mar 2018 09:01:01 -0600
MIME-Version: 1.0
In-Reply-To: <20180309104151.2431-2-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] qemu-iotests: skip test
 205 for unsupported formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 03/09/2018 04:41 AM, Amador Pahim wrote:
> Using bochs or cloop, qemu-img will fail with:
> 
>    Format driver 'bochs' does not support image creation
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>   tests/qemu-iotests/205 | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
> index e7b2eae51d..fff9be97d2 100644
> --- a/tests/qemu-iotests/205
> +++ b/tests/qemu-iotests/205
> @@ -24,6 +24,9 @@ import iotests
>   import time
>   from iotests import qemu_img_create, qemu_io, filter_qemu_io, QemuIoInteractive
>   
> +
> +iotests.verify_image_format(unsupported_fmts=['bochs', 'cloop'])
> +
>   nbd_sock = 'nbd_sock'
>   nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
>   disk = os.path.join(iotests.test_dir, 'disk')
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
