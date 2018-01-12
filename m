Received: from eggs.gnu.org ([2001:4830:134:3::10]:47975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ea7K6-0004eb-Vh
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1ea7K3-0003jM-Tk
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:57:15 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:32972
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1ea7K3-0003i1-Mp
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 16:57:11 -0500
References: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <129c0f17-ada9-92ce-eb0d-1596da397638@weilnetz.de>
Date: Fri, 12 Jan 2018 22:57:06 +0100
MIME-Version: 1.0
In-Reply-To: <1515788548-3570-1-git-send-email-juterry@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Implements the Windows Hypervisor
 Platform accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosthwaite.peter@gmail.com

Am 12.01.2018 um 21:22 schrieb Justin Terry (VM) via Qemu-devel:
> Hello QEMU Community!
>=20
> Over the past few months the Hyper-V team at Microsoft has been working=
 hard on
> a new user-mode API for our hypervisor that will be released as part of=
 the
> upcoming SDK. This new API adds user-mode capabilities to create and ma=
nage
> partitions at the hypervisor level, configure memory mappings for the
> partition, and create and control execution of virtual processors.
>=20
> With this new API we are now able to bring our hypervisor to the QEMU
> community! The following patches implement the Windows Hypervisor Platf=
orm
> accelerator (WHPX) for QEMU on Windows 10 hosts.
>=20
> When compiling QEMU for x86_64 passing the --enable-whpx flag will comp=
ile the
> accelerator for use. At runtime using the '-accel whpx' should see a
> significant performance improvement over emulation, much like when usin=
g 'hax'
> on Windows.
>=20
> Over the next few days the pre-release version of the documentation for=
 this new
> API will be visible at https://docs.microsoft.com/en-us/virtualization =
under
> the 'Windows Hypervisor Platform' section. Here you will see the requir=
ements,
> API, and examples.
>=20
> Thank you for your feedback.=20
>=20
> Justin Terry (VM) (4):
>   Add the Windows Hypervisor Platform accelerator.
>   Add the WHPX vcpu API
>   Introduce the WHPX impl
>   Add the WHPX acceleration enlightenments
>=20
>  accel/stubs/Makefile.objs |    9 +-
>  accel/stubs/whpx-stub.c   |   48 ++
>  configure                 |   48 +-
>  cpus.c                    |   66 ++-
>  include/sysemu/hw_accel.h |   13 +
>  include/sysemu/whpx.h     |   40 ++
>  qemu-options.hx           |    8 +-
>  target/i386/Makefile.objs |    1 +
>  target/i386/helper.c      |    2 +-
>  target/i386/whpx-all.c    | 1395 +++++++++++++++++++++++++++++++++++++=
++++++++
>  10 files changed, 1619 insertions(+), 11 deletions(-)
>  create mode 100644 accel/stubs/whpx-stub.c
>  create mode 100644 include/sysemu/whpx.h
>  create mode 100644 target/i386/whpx-all.c


Thank you for this contribution =E2=80=93 I'll test it.

The patches 2 and 3 fail the test with scripts/checkpatch.pl. Please fix
that in the next iteration (maybe wait a little until there was more
feedback).

Regards,
Stefan
