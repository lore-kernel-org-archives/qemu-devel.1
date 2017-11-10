Received: from eggs.gnu.org ([2001:4830:134:3::10]:48633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eD6kt-0004X4-DV
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eD6kq-0004Iv-A1
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:41:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eD6kq-0004Ew-3k
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:41:44 -0500
Date: Fri, 10 Nov 2017 10:41:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171110104135.GB30685@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<96ded936-f9e3-c712-291e-fcb3d44bbe65@amsat.org>
	<20171108130102.GS12670@redhat.com>
	<fd7bb230-bbe3-ce3c-3026-d3d51544a14a@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd7bb230-bbe3-ce3c-3026-d3d51544a14a@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>

On Fri, Nov 10, 2017 at 09:35:54PM +1100, Alexey Kardashevskiy wrote:
> On 09/11/17 00:01, Daniel P. Berrange wrote:
> > On Wed, Nov 08, 2017 at 09:26:01AM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote:
> >> On 11/08/2017 06:57 AM, Thomas Huth wrote:
> >>>
> >>> That automatic git submodule stuff now broke my workflow again. I
> >>> usually keep the git repository on my laptop and then simply rsync =
the
> >>> sources (without .git directories) to my target machine to compile =
it
> >>> there. Used to work great for years. Now it's broken, the build pro=
cess
> >>> complains:
> >>>
> >>> GIT submodule checkout is out of date. Please run
> >>>   scripts/git-submodule.sh update
> >>> from the source directory checkout /home/thuth/devel/qemu
> >>>
> >>> Running "scripts/git-submodule.sh update" did not fix the issue at =
all -
> >>> I first had to tinker with it for a while to find out that I simply=
 have
> >>> to delete ".git-submodule-status" in my git tree to fix the issue.
> >>>
> >>> I've got the feeling that all this submodule crap is constantly cau=
sing
> >>> pain ... do we really need this? Can't we find another solution ins=
tead?
> >>> Or at least stop modifying files automatically in the $SRC_PATH ?
> >>
> >> Also yesterday on IRC:
> >>
> >> <RaV3N> [...] I downloaded the qemu source from git and tried to com=
pile
> >> it. I am getting this:
> >>
> >> ./configure --static && make && sudo make install
> >>  CC      ui/input-keymap.o
> >> ui/input-keymap.c:8:10: fatal error: ui/input-keymap-linux-to-qcode.=
c:
> >> No such file or directory
> >=20
> > I had a pull request merged yesterday later afternoon which possibly
> > would address that problem, though hard hard to say for certain.
>=20
> wow, already? :(
>=20
> I still wonder why do not we checkout submodules into the build directo=
ry
> and why .git-submodule-status is not there too...

That simply isn't the way submodules work, they are inherently part of
the source tree, and the status file reflects that too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
