Received: from eggs.gnu.org ([2001:4830:134:3::10]:59222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfqX-0006Pu-LG
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfqU-0001zb-T1
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gFfqU-0001z6-LY
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:38:42 -0400
Date: Thu, 25 Oct 2018 10:36:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181025133637.GH4096@habkost.net>
References: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
	<1539578845-37944-3-git-send-email-robert.hu@linux.intel.com>
	<20181024101643.GE4096@habkost.net>
	<1540436819.80634.2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1540436819.80634.2.camel@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/3] x86: Data structure changes to
 support MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: robert.hu@intel.com, pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org

On Thu, Oct 25, 2018 at 11:06:59AM +0800, Robert Hoo wrote:
> On Wed, 2018-10-24 at 07:16 -0300, Eduardo Habkost wrote:
[...]
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct {=A0=A0=A0/*CPUID that =
enumerate this MSR*/
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0FeatureWord cpuid_=
class;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uint32_t=A0=A0=A0=A0=
cpuid_flag;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} cpuid_dep;
> >=20
> > Aren't you going to use this field anywhere?=A0=A0Probably we want to
> > prevent the VM from starting if a bit is set in the feature world
> > but the cpuid_dep bit is not set.
> >=20
> > e.g.:
> > =A0 qemu-system-x86_64 -cpu Skylake-Client,-arch-capabilities,+rsba
> > probably should fail to start.
>=20
> How about in x86_cpu_filter_features() filters the MSR feature word, if
>  its dependent CPUID feature bit is not set?
> The filter results will be record in cpu->filtered_features, and print
> out, like other filtered features.

Sounds good to me.

--=20
Eduardo
