Received: from eggs.gnu.org ([2001:4830:134:3::10]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fUubr-00036k-8V
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fUubo-00079K-6i
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1fUubo-000790-08
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:54:16 -0400
Date: Mon, 18 Jun 2018 09:54:10 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180618135410.GA18383@localhost.localdomain>
References: <CAFEAcA_S41uEj=ae1efd042aTJcLUe+LXpD8WUwSkeWLnPCj=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_S41uEj=ae1efd042aTJcLUe+LXpD8WUwSkeWLnPCj=w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] enabling smart-http git protocol on git.qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Iliya Dyachenko <gandalfthewhite@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jun 18, 2018 at 11:55:05AM +0100, Peter Maydell wrote:
> On 18 June 2018 at 10:47, Daniel P. Berrang=E9 <berrange@redhat.com> wr=
ote:
> > On Mon, Jun 18, 2018 at 12:32:01PM +0300, Iliya Dyachenko wrote:
> >> Signed-off-by: Iliya Dyachenko <gandalfthewhite@mail.ru>
> >> ---
> >>  .gitmodules | 32 ++++++++++++++++----------------
> >>  1 file changed, 16 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/.gitmodules b/.gitmodules
> >> index 49e9c2e3f4..e6bc732d16 100644
> >> --- a/.gitmodules
> >> +++ b/.gitmodules
> >> @@ -1,48 +1,48 @@
> >>  [submodule "roms/vgabios"]
> >>       path =3D roms/vgabios
> >> -     url =3D git://git.qemu-project.org/vgabios.git/
> >> +     url =3D https://git.qemu.org/git/vgabios.git
> >
> > [snip]
> >
> > This is highly desirable, however, we cannot do it right now.
> >
> > The git.qemu.org server is still using the dumb git http protocol, so=
 it
> > would be a performance regression over git://
> >
> > We need the server config fixing to use the smart http protocol.
> >
> > Essentially this just involves configuring apache to add
> >
> >   <Directory /usr/libexec/git-core>
> >     Allow from all
> >   </Directory>
> >
> >   SetEnv GIT_PROJECT_ROOT /data/git
> >
> >   ScriptAliasMatch "^/git/(.*\.git/(HEAD|info/refs))$" \
> >     /usr/libexec/git-core/git-http-backend/$1
> >   ScriptAliasMatch "^/git/(.*\.git/git-(upload|receive)-pack)$" \
> >     /usr/libexec/git-core/git-http-backend/$1
>=20
> Sounds like a good idea -- I've cc'd Jeff and Stefan (who
> are the people who care for our git server)...
>

Thanks, it is a good idea.  I think Peter also brought this up once befor=
e,
if I am not mistaken.  I'll work on implementing that today.

-Jeff
