Received: from eggs.gnu.org ([2001:4830:134:3::10]:56373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ft83G-0006SK-Hm
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ft83D-0004b5-Cs
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:06:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ft83D-0004an-7i
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:06:39 -0400
Date: Fri, 24 Aug 2018 10:06:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180824090632.GB3430@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<20180824082237.GA3430@redhat.com>
	<20180824085220.GF31581@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824085220.GF31581@lemon.usersys.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Fri, Aug 24, 2018 at 04:52:20PM +0800, Fam Zheng wrote:
> On Fri, 08/24 09:22, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Aug 24, 2018 at 09:21:26AM +0800, Fam Zheng wrote:
> > > Upgrade OpenBSD to 6.3 using auto_install. Especially, drop SDL1,
> > > include SDL2.
> > >=20
> > > One limitation of this patch is that we need a temporary HTTP serve=
r on
> > > host 80 port for auto_install, because slirp cannot do guest forwar=
d on
> > > "host addr".
> >=20
> > That's a pretty big limitation, as port 80 requires root privileges,
> > and that's a pretty strict no for automated testing IMHO.
> >=20
> > Why does it have to be port 80 in particular - is it not possible
> > to use 8080 or even better, detect a random free port ?
>=20
> OpenBSD autoinstall[1] is hardcoded to fetch from port 80. Maybe we can=
 instead
> persuade it into fetching from a different http server than 10.0.2.2. T=
o do that
> we'd need to implement a new slirp option for either "option tftp-serve=
r-name"
> or "next-server" according to the manpage. I'll have to experiment with=
 it to
> see if it will work.
>=20
> Or, do you think there are better options to configure the VM network t=
o serve
> the file?

Why not use guestfwd eg

  guestfwd:tcp:10.0.2.1:80-tcp:127.0.0.1:8080

would redirect the guest IP address port 80, to the loopback interface on=
 the
host port 8080. Now you can tell autoinstall to use 10.0.2.1 ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
