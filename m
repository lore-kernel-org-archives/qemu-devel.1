Received: from eggs.gnu.org ([209.51.188.92]:58630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPyv-0008P4-J3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPyu-0000aR-Lx
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:24:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPyu-0000Ze-Fz
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:24:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so1736124qkf.3
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 03:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-18-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-18-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 12:23:52 +0100
Message-ID: <CAMxuvax-F7PWF_ncpoTtVLu327Tph=J_q8OnFa1Qject7u6b9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 17/25] net/filter-mirror: Use size_t
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

Hi

On Wed, Feb 20, 2019 at 2:07 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Since iov_size() returns a size_t, no need to use a signed type.

And it is the variable only purpose.

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  net/filter-mirror.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index 3a61cf21e8..97b52d0544 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -48,7 +48,7 @@ static int filter_send(MirrorState *s,
>  {
>      NetFilterState *nf =3D NETFILTER(s);
>      int ret =3D 0;
> -    ssize_t size =3D 0;
> +    size_t size =3D 0;
>      uint32_t len =3D 0;
>      char *buf;
>
> --
> 2.20.1
>
