Received: from eggs.gnu.org ([2001:4830:134:3::10]:54700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwmf-0007Es-Vf
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpwmW-00054w-Km
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:23:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpwmW-00054N-F5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:23:44 -0400
Date: Thu, 7 Sep 2017 15:23:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907152337.02f7aec8.cohuck@redhat.com>
In-Reply-To: <09ff8ae8-3ad2-7dd3-16d9-0528c1ee665a@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-8-david@redhat.com>
	<3f858041-2cc1-7beb-78bc-d43c3b42b6ab@redhat.com>
	<09ff8ae8-3ad2-7dd3-16d9-0528c1ee665a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/19] s390x: move two function
 declarations to s390-virtio-ccw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 7 Sep 2017 14:46:44 +0200
David Hildenbrand <david@redhat.com> wrote:

> >> +++ b/target/s390x/interrupt.c
> >> @@ -15,6 +15,9 @@
> >>  #include "exec/exec-all.h"
> >>  #include "sysemu/kvm.h"
> >>  #include "hw/s390x/ioinst.h"
> >> +#if !defined(CONFIG_USER_ONLY)
> >> +#include "hw/s390x/s390-virtio-ccw.h"
> >> +#endif
> >> =20
> >>  /* Ensure to exit the TB after this call! */
> >>  void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_=
t ilen)
> >> =20
> >=20
> > If I listen to my gut feeling, I still think we should rather move
> > s390_cpu_addr2state() to cpu.c instead. It does not sound as it's really
> > specific to the virtio-ccw machine... Just my 0.02 =E2=82=AC
> >  =20
>=20
> I prefer to leave it as is for now, so just a header cleanup. E.g. with
> patch 18 we could implement it directly using ms->possible_cpus.

If you do that, would you also get rid of the conditional include above?
