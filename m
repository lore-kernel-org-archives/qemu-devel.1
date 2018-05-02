Received: from eggs.gnu.org ([2001:4830:134:3::10]:52912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDxkN-0000FH-2P
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDxkJ-0006DZ-U3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:49:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fDxkJ-0006CV-MU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:48:59 -0400
References: <20180502105552.22925-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b00a364-911f-4dd8-a24f-a9961431dba6@redhat.com>
Date: Wed, 2 May 2018 14:48:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180502105552.22925-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user+postcopy: Use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org

On 05/02/2018 05:55 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Use qemu_set_nonblock rather than a simple fcntl; cleaner
> and I have no reason to change other flags.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(wonder if checkpatch.pl can be taught to easily recognize this one)

> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 38da8692bb..c2bbb622d6 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1076,7 +1076,7 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
>           error_setg(errp, "%s: Failed to get ufd", __func__);
>           return -1;
>       }
> -    fcntl(ufd, F_SETFL, O_NONBLOCK);
> +    qemu_set_nonblock(ufd);
>   
>       /* register ufd with userfault thread */
>       u->postcopy_fd.fd = ufd;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
