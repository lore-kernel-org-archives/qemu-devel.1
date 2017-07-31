Received: from eggs.gnu.org ([2001:4830:134:3::10]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcBox-00006q-1n
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcBos-0001Bq-3J
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcBor-0001BA-P6
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 10:37:17 -0400
Date: Mon, 31 Jul 2017 15:36:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170731143656.GC21310@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
	<20170729135042.GA1139@pks-xps>
	<CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
	<192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
	<CAFEAcA9dvAnkKhKq03VccO1MLgg-4g20Mt2=85TZ1jF9XxHPRw@mail.gmail.com>
	<20170731142308.GB3206@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170731142308.GB3206@lemon.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Kamil Rytarowski <kamil@netbsd.org>, Alistair Francis <alistair23@gmail.com>, Kamil Rytarowski <n54@gmx.com>, Patrick Steinhardt <ps@pks.im>

On Mon, Jul 31, 2017 at 10:23:08PM +0800, Fam Zheng wrote:
> On Sun, 07/30 19:23, Peter Maydell wrote:
> > On 30 July 2017 at 17:51, Kamil Rytarowski <n54@gmx.com> wrote:
> > > On 29.07.2017 21:34, Peter Maydell wrote:
> > >> On 29 July 2017 at 14:50, Patrick Steinhardt <ps@pks.im> wrote:
> > >>> On Fri, Jul 28, 2017 at 02:20:49PM -0300, Philippe Mathieu-Daud=C3=
=A9 wrote:
> > >>>> This is likely to break on BSD, but now than patchew has a NetBS=
D job
> > >>>> you can trigger a build RESENDing this patch.
> > >>
> > >
> > > I just checked patchew, and there is FreeBSD job. How far are we fr=
om
> > > adding more BSDs?
> >=20
> > I now test OpenBSD and NetBSD as well in my pre-merge
> > test setup. Patchew could add them as well if desired.
> > (vm setup instructions at http://wiki.qemu.org/Hosts/BSD)
>=20
> No objection to adding more BSDs to patchew as long as I can find a few=
 more
> gigabytes RAM to run the VM (BTW I'm also thinking about converting lon=
g running
> VMs to boot/shutdown on demand, to support more types of guests). But s=
till want
> to ask this: how likely it is for a patch to compile on one BSD flavor =
but fail
> on the other?

While they share common ancestry, they are largely independant projects,
so each has its own quirks & potentially differing features. IOW it isn't
like Linux distros, where there's a common kernel & userspace in every
distros, and you're largely just dealing with software version difference=
s.
So if you have the resources, I think it'd be worth running patchew acros=
s
the different BSDs that QEMU claims support for. I'd far rather see the
failures upfront, than when Peter tries to merge my pull request.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
