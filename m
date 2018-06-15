Received: from eggs.gnu.org ([2001:4830:134:3::10]:57303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTpVp-0001ad-NN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fTpVn-0000Jy-35
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:15:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fTpVm-0000Jn-UC
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:15:35 -0400
Date: Fri, 15 Jun 2018 17:15:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180615165251-mutt-send-email-mst@kernel.org>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180614081800.GH6355@redhat.com>
	<2219a7fd-b496-6653-b79a-c20136727f98@redhat.com>
	<20180614154441.GC18967@redhat.com>
	<14e39e34-6314-05f1-2b90-42bea564efaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <14e39e34-6314-05f1-2b90-42bea564efaa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Thu, Jun 14, 2018 at 10:32:00PM +0200, Paolo Bonzini wrote:
> On 14/06/2018 17:44, Daniel P. Berrang=E9 wrote:
> >> "-cpu" is certainly wrong for KVM_CAP_X86_DISABLE_EXITS. "-cpu" is a
> >> device option, while this is about host behavior.  "-realtime"'s nam=
e is
> >> awful, but I still think it's the best place for this option.  Maybe=
 we
> >> could call it "-realtime power-mgmt=3D{host|guest}".
> > If none of the existing ones are a suitable fit, then we should just
> > introduce a new CLI arg instead stuffing it into somewhere odd.
>=20
> It is related to mlock in my opinion.  Both options are about applying
> settings that reduce latency but may not be applicable in general.

I would add, it's also about host resource handling.

With mlock guest memory is locked so there's no memory overcommit.
With cpu-pm guest does not give up host cpu which mostly disables
host cpu overcommit.


> Maybe "-realtime" could be renamed to "-perftune" or something like
> that, but I'd like to keep the grouping.
>=20
> Paolo

-overcommit ?

> > IOW, why not just "--power-mgmt host|guest"
