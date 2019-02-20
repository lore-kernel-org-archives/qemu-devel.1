Received: from eggs.gnu.org ([209.51.188.92]:48909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPKR-0007or-PC
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwPKP-0000Fu-MU
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:42:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwPKP-0000Fb-HR
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:42:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so26658321qtz.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-26-philmd@redhat.com>
	<20190220103836.GC21870@redhat.com>
In-Reply-To: <20190220103836.GC21870@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 11:42:02 +0100
Message-ID: <CAMxuvayMF+3Y-cMkvBW8KqfuBy_AQCg771wyV660nnsmeG-q2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <minyard@acm.org>, Stefano Stabellini <sstabellini@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Zhang Chen <zhangckid@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Hi

On Wed, Feb 20, 2019 at 11:39 AM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Wed, Feb 20, 2019 at 02:02:32AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>
> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> > index 0341dd1ba2..2e3b5a15ca 100644
> > --- a/include/chardev/char.h
> > +++ b/include/chardev/char.h
> > @@ -221,7 +221,7 @@ void qemu_chr_set_feature(Chardev *chr,
> >                            ChardevFeature feature);
> >  QemuOpts *qemu_chr_parse_compat(const char *label, const char *filenam=
e,
> >                                  bool permit_mux_mon);
> > -int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write=
_all);
> > +int qemu_chr_write(Chardev *s, const uint8_t *buf, size_t len, bool wr=
ite_all);
>
> Seeing this cleanup reminds me that I think we ought to change
> the chardev read & write functions to take "void *buf" instead.
> as is done for regular libc  read/write functions. This would
> avoid casts in the callers between char */uint8_t *
>
> Something to think about for a future cleanup job....same applies
> for the QIOChannel APIs which take a 'char *buf', annoyingly
> different from the chardev APIs :-( Both ought to have void *buf

I fully agree, and I started that conversion some time ago, and lost
it somewhere. That should be easier than changing the sign of return
values though!

>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
