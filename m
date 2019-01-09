Received: from eggs.gnu.org ([209.51.188.92]:60012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghFJP-0003tx-2n
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghFJN-00013v-Pm
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:58:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghFJN-000135-He
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:58:29 -0500
Date: Wed, 9 Jan 2019 14:58:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109145820.GV3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547043869-10520-1-git-send-email-thuth@redhat.com>
	<20190109143122.GR3998@redhat.com>
	<21c94e77-ad1d-3ce2-72cd-fc86f6d619fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21c94e77-ad1d-3ce2-72cd-fc86f6d619fc@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] configure: Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jan 09, 2019 at 03:51:33PM +0100, Thomas Huth wrote:
> On 2019-01-09 15:31, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jan 09, 2019 at 03:24:29PM +0100, Thomas Huth wrote:
> >> Different versions of GCC and Clang use different versions of the C =
standard.
> >> This repeatedly caused problems already, e.g. with duplicated typede=
fs:
> >>
> >>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
> >>
> >> or with for-loop variable initializers:
> >>
> >>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
> >>
> >> To avoid these problems, we should enforce the C language version to=
 the
> >> same level for all compilers. Since our minimum compiler versions is
> >> GCC v4.8, our best option is "gnu99" right now ("gnu17" is not avail=
able
> >> there yet, and "gnu11" is marked as "experimental").
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  v2: Use gnu99 instead of gnu11
> >>
> >>  configure | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >=20
> >> diff --git a/configure b/configure
> >> index b9f34af..721ade7 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -105,7 +105,8 @@ update_cxxflags() {
> >>      for arg in $QEMU_CFLAGS; do
> >>          case $arg in
> >>              -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-exter=
ns|\
> >> -            -Wold-style-declaration|-Wold-style-definition|-Wredund=
ant-decls)
> >> +            -Wold-style-declaration|-Wold-style-definition|-Wredund=
ant-decls|\
> >> +            -std=3Dgnu99)
> >=20
> > IIUC this is to  drop  -std=3Dgnu99 from CXXFLAGS, so C++ code (only =
the
> > guest-agent on Win32 IIUC) will use the compiler default still.
>=20
> We also use it for the capstone disassembler and disas/libvixl.
>=20
> > We could consider also setting a suitable -std for CXXFLAGS too in fu=
ture
> > though...
>=20
> Shall I send a v3 with "-std=3Dgnu++98" (which seems to be the only usa=
ble
> option right now), or shall we wait until we really hit a problem with
> the C++ code?

I'd have a slight preference for adding a C++ suitable -std now
just to give us a more predictable build setup. I don't consider
it a blocker though, hence my R-b on this v2 patch as it is now.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
