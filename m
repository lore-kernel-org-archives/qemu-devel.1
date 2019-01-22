Received: from eggs.gnu.org ([209.51.188.92]:38713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm0wF-0005F5-HY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm0w6-00007y-CL
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm0w5-0008Nc-MY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:38:10 -0500
Date: Tue, 22 Jan 2019 16:12:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122161236.GZ13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181031025712.18602-1-famz@redhat.com>
	<4f6eb24d-fe13-cbf3-907e-6b3e566e33f4@comstyle.com>
	<20181114095807.GB22784@magic> <20190109135504.GA12179@redhat.com>
	<20190109135917.GP3998@redhat.com>
	<A3EA5405-A5EE-4E77-8C77-A67398756B96@euphon.net>
	<20190114101515.GA3686@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114101515.GA3686@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fam@euphon.net>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>

On Mon, Jan 14, 2019 at 10:15:15AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Jan 14, 2019 at 11:50:08AM +0800, Fam Zheng wrote:
> >=20
> >=20
> > > On Jan 9, 2019, at 21:59, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >=20
> > > On Wed, Jan 09, 2019 at 01:55:04PM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> > >> On Wed, Nov 14, 2018 at 05:58:07PM +0800, Fam Zheng wrote:
> > >>> On Sun, 11/11 18:20, Brad Smith wrote:
> > >>>> ping.
> > >>>=20
> > >>> Queued. Will send a pull request soon.
> > >>=20
> > >> ping, this seems to have got lost, and is blocking us deleting SDL=
 1.2
> > >> support from QEMU.
> > >=20
> > > Sigh, never mind, I found the PR is here:
> > >=20
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00732.html
> >=20
> > I had to drop it from the queue because Peter didn=E2=80=99t like the=
 QEMU version
> > requirement (for the slirp tftp parameters). :(
>=20
> IIUC, currently we're just downloading
>=20
>    http://download.patchew.org/openbsd-6.1-amd64.img.xz
>=20
> can't you just refresh that pre-built image to have SDL 2, based on you=
r
> auto-install patches, so we don't have to wait for that to merge.

Please could we just get this pre-built img updated so that we are
not blocked on the SDL 1 removal anymore.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
