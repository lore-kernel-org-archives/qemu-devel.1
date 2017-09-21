Received: from eggs.gnu.org ([2001:4830:134:3::10]:35450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dv4gY-00032W-9e
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dv4gV-0002OL-Az
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:50:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55250
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dv4gU-0002LQ-6O
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:50:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LGnG5E058324
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 12:50:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4fg562sa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 12:50:36 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 12:50:36 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170921172142.1052a887.cohuck@redhat.com>
References: <20170921151446.40015-1-borntraeger@de.ibm.com>
	<20170921151446.40015-2-borntraeger@de.ibm.com>
	<20170921172142.1052a887.cohuck@redhat.com>
Date: Thu, 21 Sep 2017 11:50:28 -0500
Message-Id: <150601262807.14100.4805165453968988313@sif>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/ais: for 2.10 stable: disable
 ais facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>

Quoting Cornelia Huck (2017-09-21 10:21:42)
> On Thu, 21 Sep 2017 17:14:46 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> =

> > The migration interface for ais was introduced with kernel 4.13
> > but the capability itself had been active since 4.12. As migration
> > support is considered necessary lets disable ais in the 2.10
> > stable version. A proper fix and re-enablement will be done
> > for qemu 2.11.
> =

> Also now with qemu-devel on cc:
> =

> So, should I apply to s390-next? Or can this be applied just to stable?

Ideally we would get it in master or at least a branch that'll
eventually get pulled so we can reference the upstream commit ID.
It's not set in stone, but usually only patches specifically ported
to stable are applied directly.

> =

> > =

> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/kvm.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > =

> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index c4c5791..eb0dbb3 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -308,8 +308,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >          }
> >      }
> >  =

> > -    /* Try to enable AIS facility */
> > -    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> > +    /*
> > +     * The migration interface for ais was introduced with kernel 4.13
> > +     * but the capability itself had been active since 4.12. As migrat=
ion
> > +     * support is considered necessary let's disable ais in the 2.10
> > +     * machine.
> > +     */
> > +    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> >  =

> >      qemu_mutex_init(&qemu_sigp_mutex);
> >  =

>=20
