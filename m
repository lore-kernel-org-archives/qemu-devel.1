Received: from eggs.gnu.org ([2001:4830:134:3::10]:57912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDmbg-00067n-8X
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDmbd-00046V-7L
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:50:48 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <ann.zhuangyanying@huawei.com>) id 1dDmbc-000467-Kq
	for qemu-devel@nongnu.org; Thu, 25 May 2017 02:50:45 -0400
From: Zhuangyanying <ann.zhuangyanying@huawei.com>
Date: Thu, 25 May 2017 06:50:18 +0000
Message-ID: <EC9759BC1E3E98429B5DE9A03DF86D8B59D2BD53@DGGEML503-MBX.china.huawei.com>
References: <1495604922-4496-1-git-send-email-ann.zhuangyanying@huawei.com>
	<20170524143418.GA7778@potion>
In-Reply-To: <20170524143418.GA7778@potion>
Content-Language: zh-CN
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Fix nmi injection failure when vcpu got
 blocked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>


> -----Original Message-----
> From: Radim Kr=E8m=E1=F8 [mailto:rkrcmar@redhat.com]
> Sent: Wednesday, May 24, 2017 10:34 PM
> To: Zhuangyanying
> Cc: pbonzini@redhat.com; Herongguang (Stephen); qemu-devel@nongnu.org;
> Gonglei (Arei); Zhangbo (Oscar); kvm@vger.kernel.org
> Subject: Re: [PATCH] Fix nmi injection failure when vcpu got blocked
>=20
> Please use tags in patches.
> We usually begin the subject with "KVM: x86:" when touching
> arch/x86/kvm/x86.c.
>=20
Sorry, I will add in patch v2.
> 2017-05-24 13:48+0800, Zhuangyanying:
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c @@ -8394,7
> > +8394,8 @@ static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu=
)
> >  	if (vcpu->arch.pv.pv_unhalted)
> >  		return true;
> >
> > -	if (atomic_read(&vcpu->arch.nmi_queued))
> > +	if (vcpu->arch.nmi_pending ||
> > +	    atomic_read(&vcpu->arch.nmi_queued))
> >  		return true;
>=20
> Hm, I think we've been missing '&& kvm_x86_ops->nmi_allowed(vcpu)'.
>=20
Yes, we've been missing, I will add in patch v2.
> The undesired resume if we have suppressed NMI is not making it much wors=
e,
> but wouldn't "kvm_test_request(KVM_REQ_NMI, vcpu)" also work here?
>=20
> >  	if (kvm_test_request(KVM_REQ_SMI, vcpu))
>=20
> Thanks.
"kvm_test_request(KVM_REQ_NMI, vcpu)", works fine for me.
