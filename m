Received: from eggs.gnu.org ([2001:4830:134:3::10]:37000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gEW53-0007a4-Hp
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gEW51-00086S-AW
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 05:00:57 -0400
Date: Mon, 22 Oct 2018 10:00:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181022100022.0dc514b9@igors-macbook-pro.local>
In-Reply-To: <20181019202321.GM31060@habkost.net>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
	<20181019184408.GG31060@habkost.net>
	<20181019215345.521d58d7@igors-macbook-pro.local>
	<20181019202321.GM31060@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/45] Machine queue, 2018-10-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Libvirt <libvir-list@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, 19 Oct 2018 17:23:21 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Oct 19, 2018 at 09:53:45PM +0200, Igor Mammedov wrote:
> > On Fri, 19 Oct 2018 15:44:08 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >=20
> > > On Fri, Oct 19, 2018 at 03:12:31PM +0100, Peter Maydell wrote:
> > > > On 18 October 2018 at 21:03, Eduardo Habkost <ehabkost@redhat.com> =
wrote:
> > > > > The following changes since commit 09558375a634e17cea6cfbfec883ac=
2376d2dc7f:
> > > > >
> > > > >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target=
-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-reque=
st
> > > > >
> > > > > for you to fetch changes up to 6d8e1bcc7dd5e819ce81e6a87fffe23e39=
c700cc:
> > > > >
> > > > >   numa: Clean up error reporting in parse_numa() (2018-10-17 16:3=
3:40 -0300)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > Machine queue, 2018-10-18
> > > > >
> > > > > * sysbus init/realize cleanups
> > > > >   (C=C3=A9dric Le Goater, Philippe Mathieu-Daud=C3=A9)
> > > > > * memory-device refactoring (David Hildenbrand)
> > > > > * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
> > > > > * -numa parsing cleanups (Markus Armbruster)
> > > > > * Fix hostmem-file memory leak (Zhang Yi)
> > > > > * Typo fix (Li Qiang)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > >
> > > >=20
> > > > Hi. This had some problems in merge testing, I'm afraid:
> > > >=20
> > > > On aarch64 host, warnings running tests/cpu-plug-test for i386 and =
s390 targets:
> > > >=20
> > > > TEST: tests/cpu-plug-test... (pid=3D12602)
> > > >   /i386/cpu-plug/pc-i440fx-3.0/cpu-add/1x3x2&maxcpus=3D12:
> > > > qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
> > > > (1) * cores (3) * threads (2) !=3D maxcpus (12)
> > > [...]
> > > >=20
> > > > (plus similar ppc64, x86_64 targets)
> > >=20
> > > Ouch.  Apologies.
> > >=20
> > > Can we please do something make sure "make check" will fail on
> > > these cases?  I'd like to be able to trust CI systems like
> > > travis-ci.
> > >=20
> >=20
> > we probably don't want make check fail on warning.
>=20
> I disagree.  If a warning is blocking a pull request from being
> merged, it must make CI systems fail too.  Otherwise we're
> defeating the purpose of CI systems.

When we deprecate options we are bound to trigger warning which are not err=
ors
and are meant to be there until deprecated options are removed/tested by ma=
ke check.
So what would you suggest to do wrt tests that use deprecated features,
drop testing for it?

[...]
