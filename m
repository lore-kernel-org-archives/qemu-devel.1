Received: from eggs.gnu.org ([2001:4830:134:3::10]:56895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmzmM-0002iJ-JJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmzmL-0006zc-Pv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:59:22 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dmzmL-0006zG-LO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:59:21 -0400
Received: by mail-ua0-x244.google.com with SMTP id 105so2413448uad.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 02:59:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824192730.8440-3-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-3-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Aug 2017 02:59:20 -0700
Message-ID: <CAJ+F1CLA6XEoJ_guM8SbwGNYzG7tXYWQfA14+r2HYJKMMgx30w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 02/32] vhub: Only process received packets
 on started queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, a.perevalov@samsung.com, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, aarcange@redhat.com, Felipe Franciosi <felipe@nutanix.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On Thu, Aug 24, 2017 at 9:27 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Only process received packets if the queue has been started.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/vhost-user-bridge.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> index 1e5b5ca3da..324abee53d 100644
> --- a/tests/vhost-user-bridge.c
> +++ b/tests/vhost-user-bridge.c
> @@ -277,6 +277,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
>      DPRINT("    hdrlen =3D %d\n", hdrlen);
>
>      if (!vu_queue_enabled(dev, vq) ||
> +        !vu_queue_started(dev, vq) ||
>          !vu_queue_avail_bytes(dev, vq, hdrlen, 0)) {
>          DPRINT("Got UDP packet, but no available descriptors on RX virtq=
.\n");
>          return;

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau
