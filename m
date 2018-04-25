Received: from eggs.gnu.org ([2001:4830:134:3::10]:53757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fBESa-0006mB-JR
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fBESW-0001Yb-Ey
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:03:24 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:40640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fBESW-0001Xy-8C
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 03:03:20 -0400
Date: Wed, 25 Apr 2018 08:57:45 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180425065745.ozsbiuztfh6aldkp@var.youpi.perso.aquilenet.fr>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<b4090f17-757c-a012-f608-f6950de031ef@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4090f17-757c-a012-f608-f6950de031ef@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/46] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, Agustin Henze <tin@debian.org>, Michael Tokarev <mjt@tls.msk.ru>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Ulises Vitulli <dererk@debian.org>, YunQiang Su <syq@debian.org>

Philippe Mathieu-Daud=C3=A9, le mar. 24 avril 2018 22:25:18 -0300, a ecri=
t:
> > This is starting to shape up pretty nicely. I was able to add a whole
> > bunch of additional architectures thanks to cross compilers in Debian
> > Sid which are there to support the Debian "ports". These may not be
> > around for ever, most "ports" are on the way out, but they will be th=
e
> > last thing to drop out of the Sid repo. Maybe when Debian stops
> > caring (and no other distro does) maybe we should to?
>=20
> I *think* working with Sid is not recommended as very unstable and not
> reproducible. A reproducible way is to use the Debian Snapshot Archive
> (http://snapshot.debian.org/) eventually using package specific version
> and holding packages at this version.
>=20
> I found an example in the following post:
> https://blog.sleeplessbeastie.eu/2017/07/17/how-to-install-packages-usi=
ng-repository-snapshot/
>=20
> (I Cc'ed Debian experts who might have a better idea).

That looks like the correct idea :)
(basically what we use to make "releases" of the hurd port, as sid
snapshots).

Samuel
