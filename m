Received: from eggs.gnu.org ([2001:4830:134:3::10]:44411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f1CJx-0006jP-KL
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f1CJt-0005TE-Um
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:45:01 -0400
Date: Wed, 28 Mar 2018 15:44:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180328144440.GU28913@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180323225739.17329-1-laurent@vivier.eu>
	<87a7us8dov.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7us8dov.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 00/20] linux-user: move arch
 specific parts to arch directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org

On Wed, Mar 28, 2018 at 03:41:52PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Laurent Vivier <laurent@vivier.eu> writes:
>=20
> > Some files like signal.c are really hard to read
> > because all architectures are mixed in the same
> > file.
> >
> > This series moves from signal.c these parts to
> > the architecture dedicated directories in linux-user.
> > Moreover, this allows to compare easier functions
> > between architectures (it helps to debug problems).
> > Adding new functions for a new architecture will
> > be facilitated too.
> >
> > checkpatch.pl is not happy... but I only want to
> > move code from a file to another. I don't want
> > to change the content of the parts I move.
>=20
> I think de-tabifying is worth it as it's a whitespace fix. Sure you can
> leave everything else.

I'm all for doing cleanups of existing code to satisfy checkpatch
too. Just make sure any cleanups are done as completely separate
patches, not fixed with other functional changes.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
