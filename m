Received: from eggs.gnu.org ([2001:4830:134:3::10]:60387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwJi-0005Fo-9Q
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwJh-0008FX-Fr
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:17:26 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89e0834b-e655-34f9-7634-9cb9f0fa3068@redhat.com>
Date: Wed, 2 May 2018 13:17:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] iotests: Test help option for
 unsupporting formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 04/21/2018 11:54 AM, Max Reitz wrote:
> This adds test cases to 082 for qemu-img create/convert/amend "-o help"
> on formats that do not support creation or amendment, respectively.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/082     | 9 +++++++++
>   tests/qemu-iotests/082.out | 9 +++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
> index d5c83d45ed..a872f771a6 100755
> --- a/tests/qemu-iotests/082
> +++ b/tests/qemu-iotests/082
> @@ -97,6 +97,9 @@ run_qemu_img create -f $IMGFMT -o backing_file="$TEST_IMG" -o ,, -o help "$TEST_
>   run_qemu_img create -f $IMGFMT -o help
>   run_qemu_img create -o help
>   
> +# Try help option for a format that does not support creation
> +run_qemu_img create -f bochs -o help

If we ever get brave enough to add creation support for bochs, hopefully 
we figure out what iotests need tweaking at that point (realistically, I 
don't see that ever happening).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
