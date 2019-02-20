Received: from eggs.gnu.org ([209.51.188.92]:48302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwPHi-0006Hu-MF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gwPHh-0006nP-Ov
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:39:26 -0500
Date: Wed, 20 Feb 2019 10:38:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190220103836.GC21870@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-26-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220010232.18731-26-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 25/25] chardev: Let qemu_chr_write[_all]
 use size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <minyard@acm.org>, Stefano Stabellini <sstabellini@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Zhang Chen <zhangckid@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Feb 20, 2019 at 02:02:32AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:

> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 0341dd1ba2..2e3b5a15ca 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -221,7 +221,7 @@ void qemu_chr_set_feature(Chardev *chr,
>                            ChardevFeature feature);
>  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e,
>                                  bool permit_mux_mon);
> -int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write=
_all);
> +int qemu_chr_write(Chardev *s, const uint8_t *buf, size_t len, bool wr=
ite_all);

Seeing this cleanup reminds me that I think we ought to change
the chardev read & write functions to take "void *buf" instead.
as is done for regular libc  read/write functions. This would
avoid casts in the callers between char */uint8_t *

Something to think about for a future cleanup job....same applies
for the QIOChannel APIs which take a 'char *buf', annoyingly
different from the chardev APIs :-( Both ought to have void *buf


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
