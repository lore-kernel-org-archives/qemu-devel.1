Received: from eggs.gnu.org ([2001:4830:134:3::10]:51731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffgnJ-0002QC-B4
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffgnF-0003xx-6m
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:22:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffgnF-0003w1-0e
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:22:37 -0400
References: <cover.1531859179.git.alistair.francis@wdc.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b9563c3-1e1d-4a34-8995-48e90aaea9fd@redhat.com>
Date: Wed, 18 Jul 2018 09:22:34 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1531859179.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/5] riscv: Fix introspection problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: mjc@sifive.com, Markus Armbruster <armbru@redhat.com>

On 17.07.2018 22:27, Alistair Francis wrote:
> This is based on Thomas's work fixing introspection problems [1] and
> applied to the RISC-V port.
>=20
> 1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html
>=20
> Alistair Francis (5):
>   sifive_e: Fix crash when introspecting the device
>   sifive_u: Fix crash when introspecting the device
>   virt: Fix crash when introspecting the device
>   riscv_hart: Fix crash when introspecting the device
>   spike: Fix crash when introspecting the device
>=20
>  hw/riscv/riscv_hart.c |  7 +++----
>  hw/riscv/sifive_e.c   | 12 ++++++------
>  hw/riscv/sifive_u.c   | 15 +++++++--------
>  hw/riscv/spike.c      | 10 ++++------
>  hw/riscv/virt.c       |  5 ++---
>  5 files changed, 22 insertions(+), 27 deletions(-)

That's interesting, these issues did not appear in my tests (modified
tests/device-introspect-test.c with hmp("info qtree")). Likely because
device-introspect-test only checks with the "none" machine =3D=3D> one mo=
re
reason to test here with all machines, too (I suggested such a patch a
couple of months ago) ...

 Thomas
