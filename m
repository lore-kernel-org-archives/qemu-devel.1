Received: from eggs.gnu.org ([209.51.188.92]:53363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPem-00039s-77
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPeg-0007wH-C3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:03:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPeg-0007vg-8M
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:03:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so26599478qtr.9
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-8-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-8-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 12:02:58 +0100
Message-ID: <CAMxuvaz6ZHh9X3ZV4iXndMcCTFAemRFqAF=6UWj+Mg+B=5BFjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/25] gdbstub: Let put_buffer() use
 size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Feb 20, 2019 at 2:04 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> All callers provide a size_t argument, we can safely use size_t
> for this function.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  gdbstub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 69340d7cd1..860e9bb7c7 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -475,10 +475,10 @@ static int gdb_continue_partial(GDBState *s, char *=
newstates)
>      return res;
>  }
>
> -static void put_buffer(GDBState *s, const uint8_t *buf, int len)
> +static void put_buffer(GDBState *s, const uint8_t *buf, size_t len)
>  {
>  #ifdef CONFIG_USER_ONLY
> -    int ret;
> +    ssize_t ret;
>
>      while (len > 0) {
>          ret =3D send(s->fd, buf, len, 0);
> --
> 2.20.1
>
