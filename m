Received: from eggs.gnu.org ([2001:4830:134:3::10]:33682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLhE-0002HB-42
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLhD-0004TO-8j
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:09:16 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <339f2fe3-5981-80a1-63b4-6fd758aa7584@redhat.com>
Date: Tue, 20 Mar 2018 13:09:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 01/12] vdi: Change 'static' create
 option to 'preallocation' in QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> What static=on really does is what we call metadata preallocation for
> other block drivers. While we can still change the QMP interface, make
> it more consistent by using 'preallocation' for VDI, too.

The x- naming of the command means we don't HAVE to get this patch in 
for 2.12, but I agree that sooner is better than later and that doing 
this in 2.12 is worth the effort.

> 
> This doesn't implement any new functionality, so the only supported
> preallocation modes are 'off' and 'metadata' for now.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |  6 ++----
>   block/vdi.c          | 24 ++++++++++++++++++++++--
>   2 files changed, 24 insertions(+), 6 deletions(-)
> 

> +++ b/qapi/block-core.json
> @@ -3834,16 +3834,14 @@
>   #
>   # @file             Node to create the image format on
>   # @size             Size of the virtual disk in bytes
> -# @static           Whether to create a statically (true) or
> -#                   dynamically (false) allocated image
> -#                   (default: false, i.e. dynamic)
> +# @preallocation    Preallocation mode for the new image (default: off)

Do we want to document that 'full' is not supported yet?  Or is just 
relying on the error message good enough?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
