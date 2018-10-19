Received: from eggs.gnu.org ([2001:4830:134:3::10]:51443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDZnD-0008Rp-2r
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDZnC-00076s-5x
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:46:39 -0400
Date: Fri, 19 Oct 2018 15:44:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181019184408.GG31060@habkost.net>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, Libvirt <libvir-list@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>

On Fri, Oct 19, 2018 at 03:12:31PM +0100, Peter Maydell wrote:
> On 18 October 2018 at 21:03, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
> > The following changes since commit 09558375a634e17cea6cfbfec883ac2376=
d2dc7f:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm=
-20181016-1' into staging (2018-10-16 17:42:56 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to 6d8e1bcc7dd5e819ce81e6a87fffe23e39c700=
cc:
> >
> >   numa: Clean up error reporting in parse_numa() (2018-10-17 16:33:40=
 -0300)
> >
> > ----------------------------------------------------------------
> > Machine queue, 2018-10-18
> >
> > * sysbus init/realize cleanups
> >   (C=E9dric Le Goater, Philippe Mathieu-Daud=E9)
> > * memory-device refactoring (David Hildenbrand)
> > * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
> > * -numa parsing cleanups (Markus Armbruster)
> > * Fix hostmem-file memory leak (Zhang Yi)
> > * Typo fix (Li Qiang)
> >
> > ----------------------------------------------------------------
> >
>=20
> Hi. This had some problems in merge testing, I'm afraid:
>=20
> On aarch64 host, warnings running tests/cpu-plug-test for i386 and s390=
 targets:
>=20
> TEST: tests/cpu-plug-test... (pid=3D12602)
>   /i386/cpu-plug/pc-i440fx-3.0/cpu-add/1x3x2&maxcpus=3D12:
> qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
> (1) * cores (3) * threads (2) !=3D maxcpus (12)
[...]
>=20
> (plus similar ppc64, x86_64 targets)

Ouch.  Apologies.

Can we please do something make sure "make check" will fail on
these cases?  I'd like to be able to trust CI systems like
travis-ci.

--=20
Eduardo
