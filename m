Received: from eggs.gnu.org ([2001:4830:134:3::10]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fbPiy-0003Hl-MS
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fbPiu-0008IQ-Ve
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fbPiu-0008Gw-BB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:20:28 -0400
Date: Fri, 6 Jul 2018 08:42:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180706114238.GS7451@localhost.localdomain>
References: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
	<20180704194327.GJ914@localhost.localdomain>
	<20180706084313.GB28022@redhat.com>
	<a6bac7b6-58b5-6cad-d4c8-01a104465e29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a6bac7b6-58b5-6cad-d4c8-01a104465e29@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Jingqi Liu <jingqi.liu@intel.com>, wei.w.wang@intel.com, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On Fri, Jul 06, 2018 at 11:31:38AM +0200, Paolo Bonzini wrote:
> On 06/07/2018 10:43, Daniel P. Berrang=E9 wrote:
> >> Based on the Linux patch at [1], guests may try to detect the
> >> feature by writing to the MSR unconditionally.
> >>
> >> If this happens, KVM needs to provide a mechanism to
> >> enable/disable the MSR emulation.  Otherwise users will end up
> >> with VMs that can't be migrated to older hosts even if they are
> >> using older machine-types.
> > Is there really no CPUID flag that can be used to detect the feature =
?
> > Unconditionally probing for existance of arbitrary MSRs seems to be
> > just re-inventing CPUID feature detection, but worse because as you
> > say we need to now invent a way to control existance of individual
> > MSRs too :-(
>=20
> Now that I know that no silicon exists for this feature, the solution i=
s
> simple.  The feature will be rejected until a CPUID bit exists.

This sounds even better than requiring a new mechanism to
enable/disable MSRs in KVM.

--=20
Eduardo
