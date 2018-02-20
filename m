Received: from eggs.gnu.org ([2001:4830:134:3::10]:36427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eo9XJ-0003dZ-QU
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eo9XF-0000IP-B9
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:08:53 -0500
Received: from mail-bn3nam01on0047.outbound.protection.outlook.com
	([104.47.33.47]:43037
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1eo9XE-0000Hx-UQ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:08:49 -0500
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Tue, 20 Feb 2018 15:08:45 +0000
Message-ID: <CY4PR12MB17686F97FA2C8865AEBF41DA95CF0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <20180126213944.7594-1-babu.moger@amd.com>
In-Reply-To: <20180126213944.7594-1-babu.moger@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "pixo@polepetko.eu" <pixo@polepetko.eu>
Cc: "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

Ping..
Looks like these patches got lost in the mix. Any comments on these patches=
?
Thanks
Babu

> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org]
> On Behalf Of Babu Moger
> Sent: Friday, January 26, 2018 3:40 PM
> To: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> pixo@polepetko.eu
> Cc: mtosatti@redhat.com; Moger, Babu <Babu.Moger@amd.com>; qemu-
> devel@nongnu.org; kvm@vger.kernel.org
> Subject: [PATCH 0/5] Enable TOPOEXT to support hyperthreading on AMD
> CPU
>=20
> These series enable TOPOEXT feature on AMD CPU. These are required to
> support
> hyperthreading on kvm guests.
>=20
> Stanislav Lanci posted few patches earlier.
> https://patchwork.kernel.org/patch/10040903/
>=20
> Rebased his patches with few changes.
> 1. Spit the patches into two, separating cpuid functions
>    0x8000001D and 0x8000001E (Patch 2 and 3).
> 2. Removed the generic non-intel check and made a separate patch
>    with some changes(Patch 5).
> 3. Fixed L3_N_SETS_AMD(from 4096 to 8192) based on
> CPUID_Fn8000001D_ECX_x03.
>=20
> Added 2 more patches.
> Patch 1. Fixes cache associativity.
> Patch 4. Adds TOPOEXT feature on AMD EPYC CPU.
>=20
> Babu Moger (3):
>   target/i386: Fix instruction cache associativity for AMD
>   target/i386: Enable TOPOEXT feature on AMD EPYC CPU
>   target/i386: Remove generic SMT thread check
>=20
> Stanislav Lanci (2):
>   target/i386: Populate AMD Processor Cache Information
>   target/i386: Add support for CPUID_8000_001E for AMD
>=20
>  target/i386/cpu.c | 104
> +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  target/i386/kvm.c |  29 +++++++++++++--
>  2 files changed, 122 insertions(+), 11 deletions(-)
>=20
> --
> 2.16.0
