Received: from eggs.gnu.org ([209.51.188.92]:60552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ght1Q-0004VY-Jx
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ght1O-0005PR-Ob
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:22:36 -0500
Date: Fri, 11 Jan 2019 09:22:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190111092220.GB18491@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547194672-24169-2-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/3] ppc: Move spapr-related prototypes
 from xics.h into a seperate header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Jan 11, 2019 at 09:17:50AM +0100, Thomas Huth wrote:
> When compiling with Clang in -std=3Dgnu99 mode, there is a warning/erro=
r:
>=20
>   CC      ppc64-softmmu/hw/intc/xics_spapr.o
> In file included from /home/thuth/devel/qemu/hw/intc/xics_spapr.c:34:
> /home/thuth/devel/qemu/include/hw/ppc/xics.h:203:34: error: redefinitio=
n of typedef 'sPAPRMachineState' is a C11 feature
>       [-Werror,-Wtypedef-redefinition]
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
> /home/thuth/devel/qemu/include/hw/ppc/spapr_irq.h:25:34: note: previous=
 definition is here
> typedef struct sPAPRMachineState sPAPRMachineState;
>                                  ^
>=20
> We have to remove the duplicated typedef here and include "spapr.h" ins=
tead.
> But "spapr.h" should not be included for the pnv machine files. So move
> the spapr-related prototypes into a new file called "xics_spapr.h" inst=
ead.
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/intc/xics_kvm.c          |  1 +
>  hw/intc/xics_spapr.c        |  1 +
>  hw/ppc/spapr_irq.c          |  1 +
>  include/hw/ppc/xics.h       |  7 -------
>  include/hw/ppc/xics_spapr.h | 37 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 40 insertions(+), 7 deletions(-)
>  create mode 100644 include/hw/ppc/xics_spapr.h

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
