Received: from eggs.gnu.org ([2001:4830:134:3::10]:34149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etDWP-0004pw-7u
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etDWM-0001Jb-0G
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:24:53 -0500
Date: Tue, 6 Mar 2018 14:24:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180306142440.GK6163@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306134402.997-1-berrange@redhat.com>
	<10097c87-9302-5de5-9b63-e76200989ac1@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10097c87-9302-5de5-9b63-e76200989ac1@ilande.co.uk>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc,
 ide: remove use of HWADDR_PRIx in trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Mar 06, 2018 at 02:16:00PM +0000, Mark Cave-Ayland wrote:
> On 06/03/18 13:44, Daniel P. Berrang=C3=A9 wrote:
>=20
> > The trace events all use a uint64_t data type, so should be using the
> > corresponding PRIx64 format, not HWADDR_PRIx which is intended for us=
e
> > with the 'hwaddr' type.
>=20
> Ha okay looks like you beat me to it ;)  I wonder if we can teach
> checkpatch.pl about this...

We should just make tracetool whitelist the data types it permits, and
it could also report on unusual format macros like this - only allow
the standard PRI* ones. That way all build configs would immediately
fail, instead of only the  ust build config

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
