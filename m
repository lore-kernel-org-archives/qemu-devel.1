Received: from eggs.gnu.org ([2001:4830:134:3::10]:40125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cxk56-0001io-5q
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 20:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cxk51-0005n5-NT
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 20:54:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:26356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cxk51-0005lg-Fs
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 20:54:47 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 11 Apr 2017 00:54:41 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A5883D@ORSMSX112.amr.corp.intel.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E842@ORSMSX112.amr.corp.intel.com>
	<20170406115854.GA29142@redhat>
	<4712D8F4B26E034E80552F30A67BE0B1A51E90@ORSMSX112.amr.corp.intel.com>
	<20170410125339.GA31761@redhat>
In-Reply-To: <20170410125339.GA31761@redhat>
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

=20
> I think we shouldn't read it like that. It seems that KVM is always
> returning the VAPIC capability except when the CPU is providing a
> special acceleration [0].
>=20
> I would say you can't really refer yourself at this bit to enable or
> not kvmapic in QEMU.
>=20
> Does that make sense?
>=20
> [0]
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?id=3D774ead3ad9bc
> bc05ef6aaebb9bdf8b4c3126923b


>From this patch and commit message,

"Disable vapic support on Intel machines with FlexPriority"

If the CPU has accelerated tpr, vapic should be disabled.
The function pointer has the name cpu_has_accelerated_tpr.

kvmvapic was created for cpu which doesn't have accelerated tpr,
 https://lists.nongnu.org/archive/html/qemu-devel/2012-02/msg00515.html

from the commit message, I can infer VAPIC means kvmvapic.

My understanding is they are referring to the same thing, though
the return value of KVM_CAP_VAPIC is confusing.

Didn't find explanation about the return value of KVM_CAP_VAPIC,
We can interpret it as following from QEMU perspective,
If KVM_CAP_VAPIC return 1, QEMU should enable VAPIC(kvmvapic).
If KVM_CAP_VAPIC return 0, QEMU should disable VAPIC(kvmvapic).


Anthony
