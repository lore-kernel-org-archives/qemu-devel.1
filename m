Received: from eggs.gnu.org ([209.51.188.92]:52157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwPZq-0007iT-Ly
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gwPZp-0003fa-RN
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:58:10 -0500
Date: Wed, 20 Feb 2019 11:57:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190220115749.7589f868.cohuck@redhat.com>
In-Reply-To: <CAMxuvazRLabuNiGdKb9HSxyqJ+9NhxJkqkv824BTFj95j5u9rA@mail.gmail.com>
References: <20190220010232.18731-1-philmd@redhat.com>
	<CAMxuvazRLabuNiGdKb9HSxyqJ+9NhxJkqkv824BTFj95j5u9rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/25] chardev: Convert qemu_chr_write()
 to take a size_t argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, 20 Feb 2019 11:53:42 +0100
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Hi
>=20
> On Wed, Feb 20, 2019 at 2:02 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi,
> >
> > This series convert the chardev::qemu_chr_write() to take unsigned
> > length argument. To do so I went through all caller and checked if
> > there are no negative value possible. =20
>=20
>=20
> Changing signedness is problematic and can easily introduce bugs that
> are easy to miss during review.
>=20
> I agree with Cornelia about idiomatic use of int. Changing "int" for
> "size_t" isn't systematically a clear win.
>=20
> Even Google C++ style recommends to avoid unsigned types "(except for
> representing bitfields or modular arithmetic). Do not use an unsigned
> type merely to assert that a variable is non-negative."
> https://google.github.io/styleguide/cppguide.html#Integer_Types - see rat=
ionale
>=20
> Since Paolo you suggested the change, could you give some convincing
> arguments that it's worth taking the plunge?

FWIW, using an explicitly unsigned type for a length sounds fine; but
not all conversions are really convincing (albeit not wrong).
