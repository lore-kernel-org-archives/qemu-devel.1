Received: from eggs.gnu.org ([2001:4830:134:3::10]:59332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQPo-0003IY-90
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCQPk-0005h6-8P
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:29:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCQPk-0005gr-1x
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:29:08 -0500
Date: Wed, 8 Nov 2017 13:28:57 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108132857.GT12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171030040056.11780-1-f4bug@amsat.org>
	<20171030082029.GY2993@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171030082029.GY2993@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Oct 30, 2017 at 09:20:29AM +0100, Eduardo Habkost wrote:
> On Mon, Oct 30, 2017 at 01:00:56AM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > examples configuring with '--enable-kvm --disable-tcg'
> >=20
> > - before
> >=20
> >   $ qemu-system-x86_64 -accel help
> >   Possible accelerators: kvm, xen, hax, tcg
> >=20
> >   $ qemu-system-x86_64 -accel tcg
> >   qemu-system-x86_64: -machine accel=3Dtcg: No accelerator found
> >=20
> >   # qemu-system-x86_64 -accel hax
> >   qemu-system-x86_64: -machine accel=3Dhax: No accelerator found
> >=20
> >   # qemu-system-x86_64 -accel xen
> >   xencall: error: Could not obtain handle on privileged command inter=
face: No such file or directory
> >   xen be core: xen be core: can't open xen interface
> >   can't open xen interface
> >   qemu-system-x86_64: failed to initialize Xen: Operation not permitt=
ed
> >=20
> > - after
> >=20
> >   $ qemu-system-x86_64 -accel help
> >   Possible accelerators: kvm
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > RFC because:
> >     - I don't think this is the nicest way, too much #ifdef'fery in m=
ain()
>=20
> I suggest using object_class_get_list(TYPE_ACCEL, false).

And check the result of the available() method on the returned classes
too, to filter the results.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
