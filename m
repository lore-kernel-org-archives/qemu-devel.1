Received: from eggs.gnu.org ([2001:4830:134:3::10]:36776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dl1GZ-0002ad-8T
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dl1GX-0001fJ-Vo
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:10:23 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dl1GX-0001es-QK
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 19:10:21 -0400
Received: by mail-ua0-x241.google.com with SMTP id x18so400849uah.5
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-2-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-2-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 23:10:07 +0000
Message-ID: <CAJ+F1CJes1RPzwC18GdgmHMLfN9OhCMA+-8DwHnfzrzztkwH5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 01/32] vhu: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com
Cc: lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com, peterx@redhat.com, quintela@redhat.com

Hi

On Thu, Aug 24, 2017 at 9:39 PM Dr. David Alan Gilbert (git) <
dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add a vu_queue_started method to complement vu_queue_enabled.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  contrib/libvhost-user/libvhost-user.c | 6 ++++++
>  contrib/libvhost-user/libvhost-user.h | 9 +++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c
> b/contrib/libvhost-user/libvhost-user.c
> index 35fa0c5e56..201b9846e9 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -930,6 +930,12 @@ vu_queue_enabled(VuDev *dev, VuVirtq *vq)
>      return vq->enable;
>  }
>
> +bool
> +vu_queue_started(VuDev *dev, VuVirtq *vq)
>

I guess we could make it const, but this is true for many other functions.
Could be done later in one go.

> +{
> +    return vq->started;
> +}
> +
>  static inline uint16_t
>  vring_avail_flags(VuVirtq *vq)
>  {
> diff --git a/contrib/libvhost-user/libvhost-user.h
> b/contrib/libvhost-user/libvhost-user.h
> index 53ef222c0b..acd019876d 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -328,6 +328,15 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq
> *vq, int enable);
>  bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
>
>  /**
> + * vu_queue_started:
> + * @dev: a VuDev context
> + * @vq: a VuVirtq queue
> + *
> + * Returns: whether the queue is started.
> + */
> +bool vu_queue_started(VuDev *dev, VuVirtq *vq);
> +
> +/**
>   * vu_queue_empty:
>   * @dev: a VuDev context
>   * @vq: a VuVirtq queue
> --
> 2.13.5
>
>
> --
Marc-Andr=C3=A9 Lureau
