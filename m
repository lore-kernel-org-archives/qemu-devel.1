Received: from eggs.gnu.org ([2001:4830:134:3::10]:42440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1frjUX-0005nG-RG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1frjUU-000676-N1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:41:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:16282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1frjUU-000654-Eq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:41:02 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Mon, 20 Aug 2018 12:38:02 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D35279F806@SHSMSX103.ccr.corp.intel.com>
References: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
	<1531213054-63327-2-git-send-email-jingqi.liu@intel.com>
	<20180806220307.GC23195@localhost.localdomain>
In-Reply-To: <20180806220307.GC23195@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/3] x86/cpu: Enable UMONITOR/UMWAIT/TPAUSE
 cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "Wang, Wei W" <wei.w.wang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, August 7, 2018 6:03 AM
> To: Liu, Jingqi <jingqi.liu@intel.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; Wang, Wei W
> <wei.w.wang@intel.com>; qemu-devel@nongnu.org; Michael S. Tsirkin
> <mst@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH 1/3] x86/cpu: Enable
> UMONITOR/UMWAIT/TPAUSE cpu features
>=20
> On Tue, Jul 10, 2018 at 04:57:32PM +0800, Jingqi Liu wrote:
> > UMONITOR, UMWAIT, and TPAUSE are a set of user wait instructions.
> >
> > UMONITOR arms address monitoring hardware using an address. A store to
> > an address within the specified address range triggers the monitoring
> > hardware to wake up the processor waiting in umwait.
> >
> > UMWAIT instructs the processor to enter an implementation-dependent
> > optimized state while monitoring a range of addresses. The optimized
> > state may be either a light-weight power/performance optimized state
> > or an improved power/performance optimized state.
> >
> > TPAUSE instructs the processor to enter an implementation-dependent
> > optimized state c0.1 or c0.2 state and wake up when time-stamp counter
> > reaches specified timeout.
> >
> > The bit definition:
> > CPUID.(EAX=3D7,ECX=3D0):ECX[bit 05] WAITPKG
> >
> > The release document ref below link:
> > https://software.intel.com/sites/default/files/managed/c5/15/\
> > architecture-instruction-set-extensions-programming-reference.pdf
> >
> > Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>=20
> Is it really OK to expose these features to the guest without "-overcommi=
t cpu-
> pm=3Don"?
>=20
> Don't we need code to migrate IA32_UMWAIT_CONTROL?
>=20
> (I don't see code to handle writes to IA32_UMWAIT_CONTROL on the KVM
> patches, either.)
>=20
> --
Hi Eduardo,

Yes, I'll handle IA32_UMWAIT_CONTROL in the second version.
Thanks for your review.

> Eduardo
