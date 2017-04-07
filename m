Received: from eggs.gnu.org ([2001:4830:134:3::10]:46488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cwPQ1-0008DI-1q
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1cwPPx-0008Di-VP
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:38:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sahid.ferdjaoui@redhat.com>)
	id 1cwPPx-0008D7-PG
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:38:53 -0400
Date: Fri, 7 Apr 2017 10:38:49 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170407083849.GA26482@redhat>
References: <1491548326-60072-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491548326-60072-1-git-send-email-weiqi4@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] vhost: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: weiqi <weiqi4@huawei.com>
Cc: mst@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

On Fri, Apr 07, 2017 at 02:58:46PM +0800, weiqi wrote:
> From: Wei Qi <weiqi4@huawei.com>
> 
> It is unnecessary to assign 'hdev->nvqs' to 'i', because 'hdev->nvqs' unused after assignment, so remove it.

nit: The line should not be longer than 76 characters [0].

[0] http://wiki.qemu-project.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

> 
> Signed-off-by: Wei Qi <weiqi4@huawei.com>
> ---
>  hw/virtio/vhost.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-By: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>

> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 613494d..5c57983 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1557,7 +1557,6 @@ fail_vq:
>                               hdev->vqs + i,
>                               hdev->vq_index + i);
>      }
> -    i = hdev->nvqs;
>  
>  fail_mem:
>  fail_features:
> -- 
> 1.8.3.1
> 
> 
