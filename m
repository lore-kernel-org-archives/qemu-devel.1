Received: from eggs.gnu.org ([2001:4830:134:3::10]:37213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwBzV-0000VN-Hj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwBzS-0002IO-Cz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:18:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:57935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cwBzS-0002I2-2q
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:18:38 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Thu, 6 Apr 2017 18:18:33 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A51E90@ORSMSX112.amr.corp.intel.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E842@ORSMSX112.amr.corp.intel.com>
	<20170406115854.GA29142@redhat>
In-Reply-To: <20170406115854.GA29142@redhat>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH]Enable kvmvapic only when host doesn't
 support VAPIC capability in KVM mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Stefan Hajnoczi' <stefanha@gmail.com>

> > --- a/kvm-all.c
> > +++ b/kvm-all.c
> > @@ -2232,6 +2232,10 @@ int kvm_has_sync_mmu(void)
> >      return kvm_check_extension(kvm_state, KVM_CAP_SYNC_MMU);
> >  }
> >
> > +int kvm_has_vapic(void){
> > +    return !kvm_check_extension(kvm_state, KVM_CAP_VAPIC);
> > +}
> > +
>=20
> Is that function shouldn't return true if KVM is providing VAPIC
> capability?
>=20

It should, but it doesn't. see below KVM kernel code segment,
it returns false if KVM provides VAPIC.

Thanks for your comments,

Will resend the patch.


Anthony



arch/x86/kvm/x86.c

        case KVM_CAP_VAPIC:
                r =3D !kvm_x86_ops->cpu_has_accelerated_tpr();
                break;
