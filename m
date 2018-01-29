Received: from eggs.gnu.org ([2001:4830:134:3::10]:57315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1egFZt-0001sQ-Mw
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1egFZo-0005bV-RS
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:58:53 -0500
Received: from mail-sn1nam01on0090.outbound.protection.outlook.com
	([104.47.32.90]:64435
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1egFZo-0005aD-Gn
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 14:58:48 -0500
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 29 Jan 2018 19:58:46 +0000
Message-ID: <CY4PR2101MB0866914EE81498938229BA5FB6E50@CY4PR2101MB0866.namprd21.prod.outlook.com>
References: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
In-Reply-To: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>

Hi All,

Is there any additional feedback I can address here to help out the process=
? Please let me know.

Thanks again,
Justin

> -----Original Message-----
> From: Justin Terry (VM)
> Sent: Monday, January 22, 2018 1:08 PM
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; crosthwaite.peter@gmail.com; rth@twiddle.net;
> ehabkost@redhat.com; Justin Terry (VM) <juterry@microsoft.com>
> Subject: [PATCH v2 0/4] Updates based on feedback.
>=20
> Updates based on review feedback.
>=20
> 1. Fixes style issues and properly ran the scripts/checkpatch pre submiss=
ion.
> 2. Added migration blockers for CPUID, dirty memory tracking, and
> XSAVE/XRSTOR.
> 3. Fixed some bugs around register states when using bios vs efi.
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
>  target/i386/whpx-all.c    | 1366
> +++++++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 1590 insertions(+), 11 deletions(-)  create mode 10064=
4
> accel/stubs/whpx-stub.c  create mode 100644 include/sysemu/whpx.h
> create mode 100644 target/i386/whpx-all.c
>=20
> --
> 2.7.4
