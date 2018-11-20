Received: from eggs.gnu.org ([2001:4830:134:3::10]:51793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP2We-0005nm-Ce
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP2Wd-0008Vh-KE
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 04:40:56 -0500
Date: Tue, 20 Nov 2018 09:40:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181120094043.GB25047@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<5508fd21-b2e6-26d3-78f0-9ea89db10ccc@redhat.com>
	<08baf15a-7205-7a47-c806-dccadcaca291@redhat.com>
	<20181119103752.GH19532@redhat.com>
	<1f7459ea-00bc-21ec-b941-d5b12fb7badc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f7459ea-00bc-21ec-b941-d5b12fb7badc@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon, Nov 19, 2018 at 11:00:38AM -0600, Eric Blake wrote:
> On 11/19/18 4:37 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
> > > Actually, I tracked this message down to using socat (which actuall=
y
> > > connects and then abruptly exits) when probing whether the socket i=
s up and
> > > listening.  That is, the message is being produced as a side effect=
 of
> > > nbd_server_wait_for_tcp_socket rather than during the actual $QEMU_=
IMG
> > > command we are interested in testing.
>=20
> > > > This is the first use of socat in iotests.=C2=A0 Might not be the=
 most
> > > > portable, but I don't know if I have better ideas.
> > > > nbdkit.git/tests/test-ip.sh greps the output of 'ss -ltn' to loca=
te free
> > > > ports, but I don't know if ss is any better than socat.
> > >=20
> > > So, I'm planning to squash this in, to use ss instead of socat, as =
follows:
> >=20
> > Personally I prefer socat since it is more portable, per my previous
> > message.
>=20
> socat is indeed probably more portable, but since tests 233 uses
> '_supported_os Linux', ss availability isn't a problem until a future u=
ser
> ports this test to non-Linux.  I'd like to patch qemu-nbd to NOT warn a=
bout
> a user that connects but does not consume data (the socat case, as well=
 as
> port probes), but as that patch does not exist yet and -rc2 is getting
> close, I'll go ahead and send the pull request with ss instead of socat=
.

Yes, that's ok with me.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
