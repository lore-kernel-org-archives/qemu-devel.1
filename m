Received: from eggs.gnu.org ([2001:4830:134:3::10]:58033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fbMGE-0007Ux-RU
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fbMGA-0007zn-Tb
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:38:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:21264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fbMGA-0007tu-Kx
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:38:34 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Fri, 6 Jul 2018 08:38:22 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D3527622A6@SHSMSX103.ccr.corp.intel.com>
References: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
	<20180704194327.GJ914@localhost.localdomain>
In-Reply-To: <20180704194327.GJ914@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: Add support to get/set/migrate MSR
 (33H)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, Wei W" <wei.w.wang@intel.com>, "rth@twiddle.net" <rth@twiddle.net>


On 05/07/2018 03:43, Eduardo Habkost wrote:
> On Wed, Jul 04, 2018 at 09:21:06PM +0800, Jingqi Liu wrote:
> > The MSR (33H) controls support for #AC exception for split locked
> > accesses. When bit 29 of the MSR (33H) is set, the processor causes an
> > #AC exception to be issued instead of suppressing LOCK on bus (during
> > split lock access).
> >
> > Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> [...]
> > diff --git a/target/i386/machine.c b/target/i386/machine.c index
> > 4d98d36..c82dc0d 100644
> > --- a/target/i386/machine.c
> > +++ b/target/i386/machine.c
> > @@ -935,6 +935,25 @@ static const VMStateDescription
> vmstate_msr_virt_ssbd =3D {
> >      }
> >  };
> >
> > +static bool split_lock_ctrl_needed(void *opaque) {
> > +    X86CPU *cpu =3D opaque;
> > +    CPUX86State *env =3D &cpu->env;
> > +
> > +    return env->split_lock_ctrl !=3D 0; }
>=20
> Based on the Linux patch at [1], guests may try to detect the feature by =
writing
> to the MSR unconditionally.
>=20
> If this happens, KVM needs to provide a mechanism to enable/disable the M=
SR
> emulation.  Otherwise users will end up with VMs that can't be migrated t=
o older
> hosts even if they are using older machine-types.
>=20
Hi Eduardo,
Thanks for your review, will provide the mechanism in next version.
Jingqi

> [1] https://lkml.org/lkml/2018/6/29/408
>=20
> --
> Eduardo
