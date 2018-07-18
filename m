Received: from eggs.gnu.org ([2001:4830:134:3::10]:47057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1ffmns-0003xf-38
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1ffmnn-0005lU-L2
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:47:40 -0400
Received: from mail-bl2nam02on0055.outbound.protection.outlook.com
	([104.47.38.55]:26816
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1ffmnn-0005lJ-A4
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:47:35 -0400
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Wed, 18 Jul 2018 13:47:32 +0000
Message-ID: <DM5PR12MB24718D806870352CD2DFDF9095530@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20180717194010.30096-1-ehabkost@redhat.com>,
	<4d551ea5-4ee7-db0d-bc15-688c70029ecc@amsat.org>
	<BN7PR08MB4868446F9A56BE8C3F95D5C7C6530@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868446F9A56BE8C3F95D5C7C6530@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-3.0] i386: Rename enum CacheType members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>


> -----Original Message-----
> From: Aleksandar Markovic [mailto:amarkovic@wavecomp.com]
> Sent: Wednesday, July 18, 2018 8:35 AM
> To: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>; Eduardo Habkost
> <ehabkost@redhat.com>; qemu-devel@nongnu.org
> Cc: Moger, Babu <Babu.Moger@amd.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Aurelien Jarno <aurelien@aurel32.net>; Richard
> Henderson <rth@twiddle.net>
> Subject: Re: [PATCH for-3.0] i386: Rename enum CacheType members
>=20
>=20
> On 07/17/2018 04:40 PM, Eduardo Habkost wrote:
> > Rename DCACHE to DATA_CACHE and ICACHE to INSTRUCTION_CACHE.
> >
> > This avoids conflict with Linux asm/cachectl.h macros and fixes
> > build failure on mips hosts.
> >
> > Reported-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
Reviewed-by: Babu Moger <babu.moger@amd.com>
