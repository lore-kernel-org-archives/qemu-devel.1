Received: from eggs.gnu.org ([2001:4830:134:3::10]:44990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQchD-0002xR-1D
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQch9-0006GP-3X
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:53:35 -0400
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-6-f4bug@amsat.org>
	<9403a3d0-41f6-add2-04fd-12034fe7699a@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ecb12a15-5b0c-67ef-18ad-e627b591148e@weilnetz.de>
Date: Thu, 29 Jun 2017 18:52:57 +0200
MIME-Version: 1.0
In-Reply-To: <9403a3d0-41f6-add2-04fd-12034fe7699a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND 5/8] tcg/tci: enable bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, QEMU Trivial <qemu-trivial@nongnu.org>

Am 29.06.2017 um 18:29 schrieb Eric Blake:
> On 06/28/2017 08:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> remove some copy/paste leftover, code seems sane.
>>
>=20
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Double-sob seems odd.

Maybe that double SOB can be cleaned by qemu-trivial (cc'ed).

>=20
>> ---
>>  tcg/tci.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>=20
> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Note from the author: it's not a copy/paste leftover, but was
there on purpose: that code part was simply never executed
before, and I only removed the TODO() statements from tested
code.

So you are the first one who found a test case. Congratulations.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
