Received: from eggs.gnu.org ([2001:4830:134:3::10]:49547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgjY-0002G0-R2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgjY-0003UP-2K
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:24:48 -0500
Date: Mon, 19 Nov 2018 10:24:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119102439.GD19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-4-berrange@redhat.com>
	<0bbf4d8b-8a1d-d208-5fa1-278d39e1ea5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bbf4d8b-8a1d-d208-5fa1-278d39e1ea5a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: pull qemu-nbd iotest helpers
 into common.nbd file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Sat, Nov 17, 2018 at 09:01:57PM -0600, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > The helpers for starting/stopping qemu-nbd in 058 will be useful in
> > other test cases, so move them into a common.nbd file.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
>=20
> > +function nbd_server_start_unix_socket()
> > +{
> > +    nbd_server_stop
> > +    $QEMU_NBD -v -t -k "$nbd_unix_socket" $@ &
>=20
> Needs to be "$@" to properly preserve whitespace and/or empty arguments=
 (the
> latter if someone passes -x '' for a default-named export).

ok

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
