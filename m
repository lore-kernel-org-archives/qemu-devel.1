Received: from eggs.gnu.org ([209.51.188.92]:52035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPZN-0007LC-NL
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPZM-0003KC-4L
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:57:41 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPZL-0003Jb-No
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:57:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so26639094qtb.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-6-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-6-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 11:57:27 +0100
Message-ID: <CAMxuvay41f60+vi9BTv7CFU1coTViQrzAC-PTGoY7Ffmx+KPVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/25] gdbstub: Use size_t for strlen()
 return value
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
> Since strlen() returns an unsigned value, it is pointless to
> convert it to a signed one. Use size_t to hold its return value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(it looks like the variable is hiding len from outer scope btw)

> ---
>  gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index bc774ae992..76eca3bb7e 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1693,7 +1693,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>          }
>  #else /* !CONFIG_USER_ONLY */
>          else if (strncmp(p, "Rcmd,", 5) =3D=3D 0) {
> -            int len =3D strlen(p + 5);
> +            size_t len =3D strlen(p + 5);
>
>              if ((len % 2) !=3D 0) {
>                  put_packet(s, "E01");
> --
> 2.20.1
>
