Received: from eggs.gnu.org ([2001:4830:134:3::10]:54420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIoO-0005nW-Vp
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duIoM-0002EU-ES
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:43:41 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:48712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duIoM-0002EB-7h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:43:38 -0400
Received: by mail-wm0-f44.google.com with SMTP id r68so11067wmg.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:43:38 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-4-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09b52e82-484e-a840-7300-0fcd0f40d1d7@redhat.com>
Date: Tue, 19 Sep 2017 15:43:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/27] libvhost-user: improve
 vu_queue_pop() doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

On 23/08/2017 18:19, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> index 53ef222c0b..9b9b00e191 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -351,7 +351,8 @@ void vu_queue_notify(VuDev *dev, VuVirtq *vq);
>   * @vq: a VuVirtq queue
>   * @sz: the size of struct to return (must be >= VuVirtqElement)
>   *
> - * Returns: a VuVirtqElement filled from the queue or NULL.
> + * Returns: a VuVirtqElement filled from the queue or NULL. The
> + * returned element must be free() by the caller.

Maybe free()-d or freed.

Otherwise

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

>   */
>  void *vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz);
>  
> 
