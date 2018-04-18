Received: from eggs.gnu.org ([2001:4830:134:3::10]:54719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8oKH-0001mE-SA
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8oKD-0004zT-VX
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:44:49 -0400
Date: Wed, 18 Apr 2018 15:44:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180418144433.GV27579@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Olaf Hering <olaf@aepfle.de>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Apr 18, 2018 at 02:29:47PM +0100, Peter Maydell wrote:
> On 18 April 2018 at 13:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > On Wed, Apr 18, 2018 at 02:38:37PM +0200, Olaf Hering wrote:
> >> Since usage of g_realloc_n was introduced, glib-2.22 can not be used=
 anymore.
> >> Fixes commit 418026ca43 ("util: Introduce vfio helpers")
> >
> > Normally we expect ./include/glib-compat.h to be changed in this scen=
ario
> > to add compat for the missing symbol.
> >
> > IIRC, one of Peters desired build targets required 2.22, but I guess =
we
> > missed this bug because that platform would not enable vfio functiona=
lity ?
>=20
> Yes, my OSX build system is on glib 2.22. It's using 'fink' for 3rd
> party library installations, and they somehow seem to have got stuck
> on 2.22. Looking at the website the project seems to have basically
> stagnated, and I guess I need to move to homebrew at some point
> (likely after we get 2.12 out the door). But for the moment this
> patch would break my pullrequest testing builds.

Yeah that sounds reasonable as it would also align your build env with
what we are testing via travis too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
