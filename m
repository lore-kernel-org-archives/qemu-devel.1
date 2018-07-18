Received: from eggs.gnu.org ([2001:4830:134:3::10]:44769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ffmbd-0006D8-PU
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1ffmba-0000an-K4
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:35:01 -0400
Received: from mail-eopbgr700132.outbound.protection.outlook.com
	([40.107.70.132]:55746
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1ffmba-0000Zc-9F
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:34:58 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 18 Jul 2018 13:34:53 +0000
Message-ID: <BN7PR08MB4868446F9A56BE8C3F95D5C7C6530@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180717194010.30096-1-ehabkost@redhat.com>,
	<4d551ea5-4ee7-db0d-bc15-688c70029ecc@amsat.org>
In-Reply-To: <4d551ea5-4ee7-db0d-bc15-688c70029ecc@amsat.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] i386: Rename enum CacheType members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Babu Moger <babu.moger@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>


On 07/17/2018 04:40 PM, Eduardo Habkost wrote:
> Rename DCACHE to DATA_CACHE and ICACHE to INSTRUCTION_CACHE.
>
> This avoids conflict with Linux asm/cachectl.h macros and fixes
> build failure on mips hosts.
>
> Reported-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
