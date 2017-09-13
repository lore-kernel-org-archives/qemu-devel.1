Received: from eggs.gnu.org ([2001:4830:134:3::10]:41616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds3nX-0005Wu-MM
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds3nW-0000R0-Nn
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:17:31 -0400
References: <20170913091038.2900-1-cohuck@redhat.com>
	<20170913091038.2900-4-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a4ce40fc-6f21-041b-b27c-863944782422@redhat.com>
Date: Wed, 13 Sep 2017 11:17:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170913091038.2900-4-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] iotests: use virtio aliases for 067
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, haoqf@linux.vnet.ibm.com

On 13.09.2017 11:10, Cornelia Huck wrote:
> The default cpu model on s390x does not provide zPCI, which is
> not yet wired up on tcg. Moreover, virtio-ccw is the standard
> on s390x.
> 
> Using virtio-scsi will implicitly pick the right device, so just
> switch to that for simplicity.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  tests/qemu-iotests/067     | 3 ++-
>  tests/qemu-iotests/067.out | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
> index 5d4ca4bc61..cbb3da286a 100755
> --- a/tests/qemu-iotests/067
> +++ b/tests/qemu-iotests/067
> @@ -141,7 +141,7 @@ echo
>  echo === Empty drive with -device and device_del ===
>  echo
>  
> -run_qemu -device virtio-scsi-pci -device scsi-cd,id=cd0 <<EOF
> +run_qemu -device virtio-scsi -device scsi-cd,id=cd0 <<EOF
>  { "execute": "qmp_capabilities" }
>  { "execute": "query-block" }
>  { "execute": "device_del", "arguments": { "id": "cd0" } }
> @@ -150,6 +150,7 @@ run_qemu -device virtio-scsi-pci -device scsi-cd,id=cd0 <<EOF
>  { "execute": "quit" }
>  EOF
>  
> +

Superfluous white space change?

With that nit removed:

Reviewed-by: Thomas Huth <thuth@redhat.com>
