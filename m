Received: from eggs.gnu.org ([2001:4830:134:3::10]:36650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evV6q-00060f-OR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evV6p-0007wD-A5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:35:56 -0400
References: <22815ed651022a08563b60219a5dd9dd81f92ae5.1520890118.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d279c497-9180-2df1-d773-dab3b0f620e5@redhat.com>
Date: Mon, 12 Mar 2018 16:35:42 -0500
MIME-Version: 1.0
In-Reply-To: <22815ed651022a08563b60219a5dd9dd81f92ae5.1520890118.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix iotest 146 output
 expectations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 03/12/2018 04:29 PM, Jeff Cody wrote:
> Commit bff5554843 added "force_size" into the common.filter for
> _filter_img_create(), but test 146 still expects it in the output.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>   tests/qemu-iotests/146.out | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/146.out b/tests/qemu-iotests/146.out
> index db6b296b9e..1332189d87 100644
> --- a/tests/qemu-iotests/146.out
> +++ b/tests/qemu-iotests/146.out
> @@ -54,7 +54,7 @@ Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
>   
>   === Testing Image create, force_size ===
>   
> -Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296 force_size=on
> +Formatting 'TEST_DIR/IMGFMT-create-test.IMGFMT', fmt=IMGFMT size=4294967296
>   
>   === Read created image, default opts ====
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
