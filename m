Received: from eggs.gnu.org ([2001:4830:134:3::10]:53544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD69M-0004T1-Hu
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fD69I-0004XM-9J
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:35:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fD69I-0004X5-3a
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:35:12 -0400
Date: Mon, 30 Apr 2018 11:35:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180430103506.GI3249@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<20180427210120.03d037b0@naga.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427210120.03d037b0@naga.suse.cz>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Apr 27, 2018 at 09:01:20PM +0200, Michal Such=C3=A1nek wrote:
> On Fri, 27 Apr 2018 17:24:38 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>=20
> > On 27 April 2018 at 17:17, Thomas Huth <thuth@redhat.com> wrote:
> > > On 27.04.2018 17:51, Peter Maydell wrote: =20
> > >> Hi; I usually let people forget about releases for a month or
> > >> so before bringing this topic up, but:
> > >>
> > >> (1) do we want to call the next release 2.13, or something else?
> > >> There's no particular reason to bump to 3.0 except some
> > >> combination of
> > >>  * if we keep going like this we'll get up to 2.42, which starts t=
o
> > >>    get silly
> > >>  * Linus-style "avoid being too predictable"
> > >>  * triskaidekaphobia =20
> > >
> > > and maybe:
> > >
> > >  * Celebrate 15 years of QEMU =20
> >=20
> > Oh, hey, I hadn't noticed that. That's as good a reason as
> > any other!
> >=20
> > > By the way, just another crazy idea for v3.0 (i.e. feel free to
> > > turn it down immediately ;-)): Since compilation and testing time
> > > for QEMU is really huge, what do you think if we got rid of some
> > > QEMU binaries? qemu-system-aarch64 is a superset of
> > > qemu-system-arm, qemu-system-x86_64 is a superset of
> > > qemu-system-i386 and qemu-system-ppc64 is a superset of
> > > qemu-system-ppc (and qemu-system-ppcemb). Would be feasible to get
> > > rid of the subset binaries with some work? (I think they were
> > > especially useful on 32-bit machines in the past, but most people
> > > are using 64-bit machines nowadays, aren't they?). =20
> >=20
> > I think Markus' backward-compatibility rubber chicken may prevent
> > us from removing those executables...
>=20
> At least the PPC vs PPC64 default to different BIOS, machine type, etc.
>=20
> That could be achieved by a wrapper script around the 64bit binary I
> suppose.
>=20
> Is there any reason why the 64bit emulator would not run on 32bit
> system? The emulated 64bit system is .. emulated after all.

I'm assuming thuat a qemu-system-x86_64  binary cannot use KVM to run
on a 32-bit host kernel, even if it was only running a 32-bit guest ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
