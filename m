Received: from eggs.gnu.org ([2001:4830:134:3::10]:34093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEbji-0002UZ-0X
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 11:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gEbjZ-0006wT-9J
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 11:03:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<CAFEAcA9p0dLoNQy7kBdcXMz0HiMGEZTBX67Lq2SizTY3kgeksw@mail.gmail.com>
	<20181019184408.GG31060@habkost.net>
	<20181019215345.521d58d7@igors-macbook-pro.local>
	<20181019202321.GM31060@habkost.net>
	<20181022100022.0dc514b9@igors-macbook-pro.local>
Date: Mon, 22 Oct 2018 17:02:34 +0200
In-Reply-To: <20181022100022.0dc514b9@igors-macbook-pro.local> (Igor
	Mammedov's message of "Mon, 22 Oct 2018 10:00:22 +0100")
Message-ID: <87h8heaut1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Libvirt <libvir-list@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Igor Mammedov <imammedo@redhat.com> writes:

> On Fri, 19 Oct 2018 17:23:21 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>
>> On Fri, Oct 19, 2018 at 09:53:45PM +0200, Igor Mammedov wrote:
>> > On Fri, 19 Oct 2018 15:44:08 -0300
>> > Eduardo Habkost <ehabkost@redhat.com> wrote:
>> >=20
>> > > On Fri, Oct 19, 2018 at 03:12:31PM +0100, Peter Maydell wrote:
>> > > > On 18 October 2018 at 21:03, Eduardo Habkost <ehabkost@redhat.com>=
 wrote:
>> > > > > The following changes since commit 09558375a634e17cea6cfbfec883a=
c2376d2dc7f:
>> > > > >
>> > > > >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-targe=
t-arm-20181016-1' into staging (2018-10-16 17:42:56 +0100)
>> > > > >
>> > > > > are available in the Git repository at:
>> > > > >
>> > > > >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-requ=
est
>> > > > >
>> > > > > for you to fetch changes up to 6d8e1bcc7dd5e819ce81e6a87fffe23e3=
9c700cc:
>> > > > >
>> > > > >   numa: Clean up error reporting in parse_numa() (2018-10-17 16:=
33:40 -0300)
>> > > > >
>> > > > > ----------------------------------------------------------------
>> > > > > Machine queue, 2018-10-18
>> > > > >
>> > > > > * sysbus init/realize cleanups
>> > > > >   (C=C3=A9dric Le Goater, Philippe Mathieu-Daud=C3=A9)
>> > > > > * memory-device refactoring (David Hildenbrand)
>> > > > > * -smp: deprecate incorrect CPUs topology (Igor Mammedov)
>> > > > > * -numa parsing cleanups (Markus Armbruster)
>> > > > > * Fix hostmem-file memory leak (Zhang Yi)
>> > > > > * Typo fix (Li Qiang)
>> > > > >
>> > > > > ----------------------------------------------------------------
>> > > > >
>> > > >=20
>> > > > Hi. This had some problems in merge testing, I'm afraid:
>> > > >=20
>> > > > On aarch64 host, warnings running tests/cpu-plug-test for i386 and=
 s390 targets:
>> > > >=20
>> > > > TEST: tests/cpu-plug-test... (pid=3D12602)
>> > > >   /i386/cpu-plug/pc-i440fx-3.0/cpu-add/1x3x2&maxcpus=3D12:
>> > > > qemu-system-i386: warning: Invalid CPU topology deprecated: sockets
>> > > > (1) * cores (3) * threads (2) !=3D maxcpus (12)
>> > > [...]
>> > > >=20
>> > > > (plus similar ppc64, x86_64 targets)
>> > >=20
>> > > Ouch.  Apologies.
>> > >=20
>> > > Can we please do something make sure "make check" will fail on
>> > > these cases?  I'd like to be able to trust CI systems like
>> > > travis-ci.
>> > >=20
>> >=20
>> > we probably don't want make check fail on warning.
>>=20
>> I disagree.  If a warning is blocking a pull request from being
>> merged, it must make CI systems fail too.  Otherwise we're
>> defeating the purpose of CI systems.
>
> When we deprecate options we are bound to trigger warning which are not e=
rrors
> and are meant to be there until deprecated options are removed/tested by =
make check.
> So what would you suggest to do wrt tests that use deprecated features,
> drop testing for it?

We commonly suppress the warning when testing.  Search for
'if (qtest_enabled())'.
