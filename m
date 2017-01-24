Received: from eggs.gnu.org ([2001:4830:134:3::10]:41457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2Na-00086W-GJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cW2NV-0000b7-Is
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:47:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cW2NV-0000aw-9u
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:47:21 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0OEjPEa047070
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:47:19 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 285ee5rc55-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:47:18 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 24 Jan 2017 14:47:15 -0000
Date: Tue, 24 Jan 2017 15:47:10 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <CAP_ceTwZW-13b7wtnWZ3kGbERuqMfXO1DswyTP-PS4OXeHuEFQ@mail.gmail.com>
References: <20170124092820.23832-1-cornelia.huck@de.ibm.com>
	<CAP_ceTwZW-13b7wtnWZ3kGbERuqMfXO1DswyTP-PS4OXeHuEFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170124154710.5cb13f40.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/kvm: include hw_accel.h instead of
 kvm.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Vincent Palatin <vpalatin@chromium.org>, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, jfrei@linux.vnet.ibm.com, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 24 Jan 2017 13:41:32 +0100
Vincent Palatin <vpalatin@chromium.org> wrote:

> On Tue, Jan 24, 2017 at 10:28 AM, Cornelia Huck
> <cornelia.huck@de.ibm.com> wrote:
> >
> > Commit b394662 ("kvm: move cpu synchronization code") switched
> > to hw_accel.h instead of kvm.h, but missed s390x, resulting in
> >
> >   CC      s390x-softmmu/target/s390x/kvm.o
> > /home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98kvm_sclp=
_service_call=E2=80=99:
> > /home/cohuck/git/qemu/target/s390x/kvm.c:1034:5: error: implicit declar=
ation of function =E2=80=98cpu_synchronize_state=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
> >      cpu_synchronize_state(CPU(cpu));
> >      ^
> > /home/cohuck/git/qemu/target/s390x/kvm.c:1034:5: error: nested extern d=
eclaration of =E2=80=98cpu_synchronize_state=E2=80=99 [-Werror=3Dnested-ext=
erns]
> > /home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98sigp_ini=
tial_cpu_reset=E2=80=99:
> > /home/cohuck/git/qemu/target/s390x/kvm.c:1628:5: error: implicit declar=
ation of function =E2=80=98cpu_synchronize_post_reset=E2=80=99 [-Werror=3Di=
mplicit-function-declaration]
> >      cpu_synchronize_post_reset(cs);
> >      ^
> > /home/cohuck/git/qemu/target/s390x/kvm.c:1628:5: error: nested extern d=
eclaration of =E2=80=98cpu_synchronize_post_reset=E2=80=99 [-Werror=3Dneste=
d-externs]
> > /home/cohuck/git/qemu/target/s390x/kvm.c: In function =E2=80=98sigp_set=
_prefix=E2=80=99:
> > /home/cohuck/git/qemu/target/s390x/kvm.c:1665:5: error: implicit declar=
ation of function =E2=80=98cpu_synchronize_post_init=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
> >      cpu_synchronize_post_init(cs);
> >      ^
> > /home/cohuck/git/qemu/target/s390x/kvm.c:1665:5: error: nested extern d=
eclaration of =E2=80=98cpu_synchronize_post_init=E2=80=99 [-Werror=3Dnested=
-externs]
> > cc1: all warnings being treated as errors
> > /home/cohuck/git/qemu/rules.mak:64: recipe for target 'target/s390x/kvm=
.o' failed
> >
> > Fix this.
> >
> > Fixes: b394662 ("kvm: move cpu synchronization code")
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>=20
>=20
> Acked-by: Vincent Palatin <vpalatin@chromium.org>
>=20
> Sorry for the miss.
>=20
>=20
> >
> > ---
> >  target/s390x/kvm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 3ac29f92b3..5ad0acbc82 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -32,7 +32,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/timer.h"
> >  #include "sysemu/sysemu.h"
> > -#include "sysemu/kvm.h"
> > +#include "sysemu/hw_accel.h"
> >  #include "hw/hw.h"
> >  #include "sysemu/device_tree.h"
> >  #include "qapi/qmp/qjson.h"
> > --
> > 2.11.0
> >
>=20

Added to my s390-next branch.
