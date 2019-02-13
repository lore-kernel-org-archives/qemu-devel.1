Received: from eggs.gnu.org ([209.51.188.92]:46969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtrzJ-0002eN-Is
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtrzI-0007kz-Og
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:41:57 -0500
Date: Wed, 13 Feb 2019 11:41:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190213114145.728f52b0.cohuck@redhat.com>
In-Reply-To: <ac8a0dc5-ab3d-46cd-bb95-18b8589bfae6@redhat.com>
References: <20190212153025.25425-1-cohuck@redhat.com>
	<40c87a8e-88d1-7113-1d33-2869234e767e@redhat.com>
	<20190212165841.7d9d7017.cohuck@redhat.com>
	<ac8a0dc5-ab3d-46cd-bb95-18b8589bfae6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/kvm: add tracepoint to ioeventfd
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 12 Feb 2019 17:12:33 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 12.02.19 16:58, Cornelia Huck wrote:
> > On Tue, 12 Feb 2019 16:52:09 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> Hi Cornelia,
> >>
> >> On 2/12/19 4:30 PM, Cornelia Huck wrote: =20
> >>> Trace when assigning/unassigning.
> >>>
> >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>> ---
> >>>  target/s390x/kvm.c        | 2 ++
> >>>  target/s390x/trace-events | 1 +
> >>>  2 files changed, 3 insertions(+)
> >>>
> >>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >>> index 15fdc168e1c5..7d61bd109092 100644
> >>> --- a/target/s390x/kvm.c
> >>> +++ b/target/s390x/kvm.c
> >>> @@ -1886,6 +1886,8 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifi=
er *notifier, uint32_t sch,
> >>>          .addr =3D sch,
> >>>          .len =3D 8,
> >>>      };
> >>> +    trace_kvm_s390_assign_subch_ioeventfd(kick.fd, kick.addr, assign,
> >>> +                                          kick.datamatch);
> >>>      if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
> >>>          return -ENOSYS;
> >>>      }
> >>> diff --git a/target/s390x/trace-events b/target/s390x/trace-events
> >>> index a84e316e4937..bdc22f42cdbb 100644
> >>> --- a/target/s390x/trace-events
> >>> +++ b/target/s390x/trace-events
> >>> @@ -14,6 +14,7 @@ ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST=
: chsc command 0x%04x, len 0x
> >>>  kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
> >>>  kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
> >>>  kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *m=
sg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
> >>> +kvm_s390_assign_subch_ioeventfd(int fd, uint32_t addr, bool assign, =
int datamatch) "fd: %d sch: @0x%x assign: %d vq: %d"   =20
> >>
> >> I noticed all s390x related trace events don't specify 's390' in the
> >> event name, maybe you can simply strip it. If you agree, feel free to
> >> apply that change directly yourself, no need for v2 ;) =20
> >=20
> > Yeah; not exactly sure why the other events do that, though... I can
> > strip it if others agree. =20
>=20
> Yes, let's keep it consistent. Or if you feel like crafting patches,
> rename the others ;)

I just went with the path of least resistance and removed the 's390' :)

Any acks before I queue this?
