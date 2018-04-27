Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fC3sR-0004m3-Mw
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fC3sO-0002EJ-L0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:57:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fC3sO-0002E8-GZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:57:28 -0400
Date: Fri, 27 Apr 2018 14:57:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180427135724.GD16118@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAOCZyUWKV6fko1gmdNvJdBO4pDLAjNVgVdBpYJkBfPUA42Fv7w@mail.gmail.com>
	<9b4880b5-d082-b791-b520-532d13beaf05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b4880b5-d082-b791-b520-532d13beaf05@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] POD document had syntax errors at /usr/bin/pod2man
 line 68.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Rahul Gusai <rgusai97@gmail.com>, qemu-devel@nongnu.org

On Fri, Apr 27, 2018 at 08:52:53AM -0500, Eric Blake wrote:
> On 04/27/2018 03:47 AM, Rahul Gusai wrote:
> > I am getting the following error while trying to compile the binaries=
 for
> > QEMU emulator.
> >
>=20
> Your mailer corrupted line spacing, making it difficult to read.
>=20
> > *GEN   qemu.1qemu.pod around line 95: Non-ASCII character seen before
> > =3Dencoding in 'Sch=EF=BF=BDtz.'. Assuming UTF-8POD document had synt=
ax errors at
> > /usr/bin/pod2man line 68.Makefile:297: recipe for target 'qemu.1'
> > failedmake: *** [qemu.1] Error 255make: *** Deleting file 'qemu.1'*
>=20
> qemu.pod is a generated file; the version in my build tree starts out:
>=20
> =3Dencoding UTF-8
>=20
> and then uses proper UTF-8 encoding of line 95:
>=20
> by Tibor "TS" Sch=C3=BCtz.
>=20
> > What could be the issue ?
>=20
> What do the following output in your setup:
>=20
> $ locale
> $ grep =3Dencoding qemu.pod
> $ sed -n '92,98p' qemu.pod | od -tx1z
>=20
> I'm wondering if somehow you have a non-UTF-8 locale such that the
> generated .pod file is encoded in a different locale, to the point that
> pod2man then chokes on the file.

If that is the cause, it just reinforces that we should make our makefile
set a sane LC_CTYPE for *every* command we invoke, not just the few place=
s
we set it for python.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
