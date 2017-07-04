Received: from eggs.gnu.org ([2001:4830:134:3::10]:48127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dSTfH-0003dn-AC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dSTfE-00082p-6S
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:39:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dSTfD-00082e-Ve
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:39:12 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-26-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <a8f8d2a6-d38c-4437-ebc2-57491c703348@redhat.com>
Date: Tue, 4 Jul 2017 21:38:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170628190047.26159-26-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 25/29] vhu: enable = false on get_vring_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com



On 06/28/2017 09:00 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When we receive a GET_VRING_BASE message set enable = false
> to stop any new received packets modifying the ring.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Maxime
> ---
>   contrib/libvhost-user/libvhost-user.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index ceddeac74f..d37052b7b0 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -652,6 +652,7 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
>       vmsg->size = sizeof(vmsg->payload.state);
>   
>       dev->vq[index].started = false;
> +    dev->vq[index].enable = false;
>       if (dev->iface->queue_set_started) {
>           dev->iface->queue_set_started(dev, index, false);
>       }
> 
