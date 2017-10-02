Received: from eggs.gnu.org ([2001:4830:134:3::10]:54330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dz9JE-0004U3-MW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dz9JD-0006Ma-PR
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:35:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:50719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dz9JD-0006Jf-JS
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 18:35:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id y64so11508277oia.7
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 15:35:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002191521.15748-2-dgilbert@redhat.com>
References: <20171002191521.15748-1-dgilbert@redhat.com>
	<20171002191521.15748-2-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Oct 2017 00:35:26 +0200
Message-ID: <CAJ+F1CKxCeqAcHne9tJ3bwFzoS8kWX7Juffh1-2uStZ7kfLruQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] libvhost-user: vu_queue_started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On Mon, Oct 2, 2017 at 9:15 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add a vu_queue_started method to complement vu_queue_enabled.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  contrib/libvhost-user/libvhost-user.c | 6 ++++++
>  contrib/libvhost-user/libvhost-user.h | 9 +++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index d27d6303db..5ee8483a32 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -943,6 +943,12 @@ vu_queue_enabled(VuDev *dev, VuVirtq *vq)
>      return vq->enable;
>  }
>
> +bool
> +vu_queue_started(const VuDev *dev, const VuVirtq *vq)
> +{
> +    return vq->started;
> +}
> +
>  static inline uint16_t
>  vring_avail_flags(VuVirtq *vq)
>  {
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
> index 4021f1124e..94d7cc8fbd 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -335,6 +335,15 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq *=
vq, int enable);
>  bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
>
>  /**
> + * vu_queue_started:
> + * @dev: a VuDev context
> + * @vq: a VuVirtq queue
> + *
> + * Returns: whether the queue is started.
> + */
> +bool vu_queue_started(const VuDev *dev, const VuVirtq *vq);
> +
> +/**
>   * vu_queue_empty:
>   * @dev: a VuDev context
>   * @vq: a VuVirtq queue
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
