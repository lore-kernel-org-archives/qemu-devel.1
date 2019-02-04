Received: from eggs.gnu.org ([209.51.188.92]:35926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqa0j-0006Dl-1e
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gqa0h-0001RL-2l
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:53:48 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gqa0a-0001Es-PH
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:53:42 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so12231175wmj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 00:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20190204045543.21238-1-mst@redhat.com>
In-Reply-To: <20190204045543.21238-1-mst@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Feb 2019 09:53:11 +0100
Message-ID: <CAJ+F1CKBLKkn332TC9PKXQcLXcG7Xpij7eTLtLZuNPRxkJvm_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fixup: include: update Linux headers to
 4.21-rc1/5.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Yongji Xie <xieyongji@baidu.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Feb 4, 2019 at 5:56 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This update switched structures from __u64 to uint64_t.
> Accordingly, need to print with PRIx64.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index a6b46cdc03..3f14b4138b 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -790,10 +790,10 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vm=
sg)
>      DPRINT("vhost_vring_addr:\n");
>      DPRINT("    index:  %d\n", vra->index);
>      DPRINT("    flags:  %d\n", vra->flags);
> -    DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);
> -    DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);
> -    DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr);
> -    DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);
> +    DPRINT("    desc_user_addr:   0x%016" PRIx64 "\n", vra->desc_user_ad=
dr);
> +    DPRINT("    used_user_addr:   0x%016" PRIx64 "\n", vra->used_user_ad=
dr);
> +    DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", vra->avail_user_a=
ddr);
> +    DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", vra->log_guest_ad=
dr);
>
>      vq->vring.flags =3D vra->flags;
>      vq->vring.desc =3D qva_to_va(dev, vra->desc_user_addr);
> --
> MST
>


--=20
Marc-Andr=C3=A9 Lureau
