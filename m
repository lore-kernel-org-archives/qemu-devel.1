Received: from eggs.gnu.org ([2001:4830:134:3::10]:53610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dSOWX-0001gs-Bf
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dSOWR-0004aA-49
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:09:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dSOWQ-0004YP-TN
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:09:47 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-30-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <09cc072b-68c1-5212-c9ad-8cb0cf64a892@redhat.com>
Date: Tue, 4 Jul 2017 16:09:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170628190047.26159-30-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 29/29] vhost-user: Claim support for postcopy
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
> Tell QEMU we understand the protocol features needed for postcopy.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   contrib/libvhost-user/libvhost-user.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index c1716d1a62..1c46aecfb3 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -797,7 +797,8 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
>   static bool
>   vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>   {
> -    uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
> +    uint64_t features = 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD |
> +                        1ULL << VHOST_USER_PROTOCOL_F_POSTCOPY;

Maybe advertising VHOST_USER_PROTOCOL_F_POSTCOPY could be done only
if userfaultfd syscall is supported?

>   
>       if (dev->iface->get_protocol_features) {
>           features |= dev->iface->get_protocol_features(dev);
> 
