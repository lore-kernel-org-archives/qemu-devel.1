Received: from eggs.gnu.org ([2001:4830:134:3::10]:38527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYwoC-0005uo-V1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYwo8-0005Js-BQ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:03:44 -0400
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-2-f4bug@amsat.org>
	<20180627132747.76773eb9@redhat.com>
	<3dd9341a-f4e6-c107-2f1f-0745d039f03e@redhat.com>
	<15aad1db-2f4c-ea49-9966-a969f0c769f5@amsat.org>
	<c1939f7b-76e2-eca9-2819-d0b4d9a134b1@redhat.com>
	<0822da0f-1da2-bff3-e465-57654aad7c16@amsat.org>
	<20180629150236.GV27016@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9ecf4b8-6b9d-7094-e364-2d53b7d40187@redhat.com>
Date: Fri, 29 Jun 2018 12:03:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180629150236.GV27016@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/46] include: Add IEC binary prefixes
 in "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

On 06/29/2018 10:02 AM, Daniel P. Berrang=C3=A9 wrote:
>> Are you suggesting this?
>>
>> #define KiB     (INT32_C(1) << 10)
>> #define MiB     (INT32_C(1) << 20)
>> #define GiB     (INT32_C(1) << 30)
>>
>> #define TiB     (INT64_C(1) << 40)
>> #define PiB     (INT64_C(1) << 50)
>> #define EiB     (INT64_C(1) << 60)

Maybe, but then '8 * GiB' overflows, rather than giving a 64-bit result.

>=20
> This feels dangerous to me as now the calculation may or may not be 32-=
bit
> or 64-bit depending on which constant you happen to pick. I think this
> inconsistency is going to be surprising to both devs and reviewers lead=
ing
> to bugs.

Being consistently 64-bit may be annoying, but it's easy enough to=20
reason about, compared to worrying whether an overflow will happen.

>=20
> Did you consider just adding unsigned versions  ?  eg UKiB, UMiB, UGiB.=
 It
> is a bit ugly but is has the benefit of being obvious whether you're in=
tending
> the calculation  to be signed vs unsigned.

That might also be worthwhile, although I'd tend towards the name KiBU=20
instead if UKiB (since I'm already used to U as a suffix).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
