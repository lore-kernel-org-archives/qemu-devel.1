Received: from eggs.gnu.org ([2001:4830:134:3::10]:53411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCPze-0004Eq-B9
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCPzY-0000jf-Kz
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:02:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eCPzY-0000jB-Dg
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:02:04 -0500
Date: Wed, 8 Nov 2017 13:01:02 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171108130102.GS12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>

On Wed, Nov 08, 2017 at 09:26:01AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 11/08/2017 06:57 AM, Thomas Huth wrote:
> >=20
> > That automatic git submodule stuff now broke my workflow again. I
> > usually keep the git repository on my laptop and then simply rsync th=
e
> > sources (without .git directories) to my target machine to compile it
> > there. Used to work great for years. Now it's broken, the build proce=
ss
> > complains:
> >=20
> > GIT submodule checkout is out of date. Please run
> >   scripts/git-submodule.sh update
> > from the source directory checkout /home/thuth/devel/qemu
> >=20
> > Running "scripts/git-submodule.sh update" did not fix the issue at al=
l -
> > I first had to tinker with it for a while to find out that I simply h=
ave
> > to delete ".git-submodule-status" in my git tree to fix the issue.
> >=20
> > I've got the feeling that all this submodule crap is constantly causi=
ng
> > pain ... do we really need this? Can't we find another solution inste=
ad?
> > Or at least stop modifying files automatically in the $SRC_PATH ?
>=20
> Also yesterday on IRC:
>=20
> <RaV3N> [...] I downloaded the qemu source from git and tried to compil=
e
> it. I am getting this:
>=20
> ./configure --static && make && sudo make install
>  CC      ui/input-keymap.o
> ui/input-keymap.c:8:10: fatal error: ui/input-keymap-linux-to-qcode.c:
> No such file or directory

I had a pull request merged yesterday later afternoon which possibly
would address that problem, though hard hard to say for certain.

> <cota> [...] you might want to do "git submodule init && git submodule
> update"

This certainly should not be required - the build system should always
take care of that, so it would be considered a bug if it didn't happen.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
