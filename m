Received: from eggs.gnu.org ([2001:4830:134:3::10]:53823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHVdX-0006uJ-Iy
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHVdO-0000En-Ne
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:08:52 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com
	([104.47.37.126]:12670
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gHVdL-0008KR-3J
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:08:44 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 30 Oct 2018 15:08:36 +0000
Message-ID: <BN6PR2201MB1251453E1BCA964409054060C6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-5-git-send-email-aleksandar.markovic@rt-rk.com>
	<f9b3eb95-7696-93b1-6b63-14b80e4d9217@redhat.com>,
	<602e0be5-4d29-e552-cb4b-4ba0c0e09218@redhat.com>
In-Reply-To: <602e0be5-4d29-e552-cb4b-4ba0c0e09218@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/mips: Misc R5900-related
 cosmetic changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

>> --- a/target/mips/translate_init.inc.c
>> +++ b/target/mips/translate_init.inc.c
>> @@ -411,18 +411,6 @@ const mips_def_t mips_defs[] =3D
>>           .mmu_type =3D MMU_TYPE_R4000,
>>       },
>>       {
>> -        /*
>> -         * The Toshiba TX System RISC TX79 Core Architecture manual
>> -         *
>> -         * https://wiki.qemu.org/File:C790.pdf
>> -         *
>> -         * describes the C790 processor that is a follow-up to the
>> R5900.
>> -         * There are a few notable differences in that the R5900 FPU
>> -         *
>> -         * - is not IEEE 754-1985 compliant,
>> -         * - does not implement double format, and
>> -         * - its machine code is nonstandard.
>> -         */
>
> Why remove this documentation? This entry is specific to the R5900.
>

The doc content is virtually duplicated in translate.c

The FPU content is virtually duplicated twenty lines below.

This file is not a place suitable for extensive commenting.

Aleksandar=
