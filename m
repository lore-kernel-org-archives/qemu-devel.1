Received: from eggs.gnu.org ([2001:4830:134:3::10]:49755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqJQ3-0007Ky-4O
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqJPt-00053m-U1
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:38:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35706 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqJPp-0004eE-VK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:38:23 -0400
Date: Thu, 16 Aug 2018 15:38:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180816143814.GJ23515@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180514171913.17664-1-berrange@redhat.com>
	<20180607094747.GA12019@redhat.com>
	<20180710171157.GA3636@rkaganb.sw.ru>
	<20180710172309.GK914@localhost.localdomain>
	<20180816143442.GA6075@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180816143442.GA6075@rkaganb.sw.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] i386: fix handling of multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Aug 16, 2018 at 05:34:43PM +0300, Roman Kagan wrote:
> On Tue, Jul 10, 2018 at 02:23:09PM -0300, Eduardo Habkost wrote:
> > On Tue, Jul 10, 2018 at 08:11:58PM +0300, Roman Kagan wrote:
> > > On Thu, Jun 07, 2018 at 10:47:47AM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > ping...
> > > >=20
> > > > On Mon, May 14, 2018 at 06:19:10PM +0100, Daniel P. Berrang=C3=A9=
 wrote:
> > > > > This short series fixes a flaw identified by coverity which bro=
ke the
> > > > > handling of multiboot modules.
> > > > >=20
> > > > > Daniel P. Berrang=C3=A9 (3):
> > > > >   i386: fix regression parsing multiboot initrd modules
> > > > >   i386: only parse the initrd_filename once for multiboot modul=
es
> > > > >   opts: remove redundant check for NULL parameter
> > > > >=20
> > > > >  hw/i386/multiboot.c | 35 ++++++++++++++++-------------------
> > > > >  util/qemu-option.c  |  8 +++-----
> > > > >  2 files changed, 19 insertions(+), 24 deletions(-)
> > > > >=20
> > > > > --=20
> > > > > 2.17.0
> > >=20
> > > Any reason this hasn't been merged yet?
> >=20
> > Lack of reviews, unfortunately.  I guess we don't have many
> > people familiar with the multiboot code.
> >=20
> > >=20
> > > This fixes a regression that, in particular, makes QEMU segfault wh=
en
> > > running kvm-unit-tests.
> >=20
> > As it is a bug fix, I will try to review merge it for the next
> > rc.
>=20
> Looks like it ended up missing 3.0, so kvm-unit-tests still segfault
> with the released version of QEMU :(

Please check again, as I see it merged before 3.0:


  commit 59b5552f020b739e273e969a0933c23d8f4e2284
  Merge: ccf02d73d1 dfaa7d50b0
  Author: Peter Maydell <peter.maydell@linaro.org>
  Date:   Tue Jul 17 17:06:32 2018 +0100

    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into=
 staging
   =20
    Bug fixes.
   =20
    # gpg: Signature made Tue 17 Jul 2018 16:06:07 BST
    # gpg:                using RSA key BFFBD25F78C7AE83
    # gpg: Good signature from "Paolo Bonzini <bonzini@gnu.org>"
    # gpg:                 aka "Paolo Bonzini <pbonzini@redhat.com>"
    # Primary key fingerprint: 46F5 9FBD 57D6 12E7 BFD4  E2F7 7E15 100C C=
D36 69B1
    #      Subkey fingerprint: F133 3857 4B66 2389 866C  7682 BFFB D25F 7=
8C7 AE83
   =20
    * remotes/bonzini/tags/for-upstream:
      Document command line options with single dash
      opts: remove redundant check for NULL parameter
      i386: only parse the initrd_filename once for multiboot modules
      i386: fix regression parsing multiboot initrd modules
      virtio-scsi: fix hotplug ->reset() vs event race
      qdev: add HotplugHandler->post_plug() callback
      hw/char/serial: retry write if EAGAIN
      PC Chipset: Improve serial divisor calculation
      vhost-user-test: added proper TestServer *dest initialization in te=
st_migrate()
      hyperv: ensure VP index equal to QEMU cpu_index
      hyperv: rename vcpu_id to vp_index
      accel: Fix typo and grammar in comment
      dump: add kernel_gs_base to QEMU CPU state
   =20
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


$ git describe  59b5552f020b739e273e969a0933c23d8f4e2284
v3.0.0-rc0-80-g59b5552f02

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
