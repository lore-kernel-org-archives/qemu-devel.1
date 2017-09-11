Received: from eggs.gnu.org ([2001:4830:134:3::10]:37228)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drXV3-0004iH-VT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drXV0-0006ld-S7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:48:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:54952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1drXV0-0006lR-Gf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 18:48:14 -0400
References: <20170911213328.9701-1-f4bug@amsat.org>
	<20170911213328.9701-6-f4bug@amsat.org>
	<aa266e28-853b-4703-8495-8fa862aea106@gmx.com>
	<9bdda758-c62c-cb04-15cd-1e93bd1664f7@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <278d8d46-bda2-ea89-dd5c-3221c37ce478@gmx.com>
Date: Tue, 12 Sep 2017 00:37:35 +0200
MIME-Version: 1.0
In-Reply-To: <9bdda758-c62c-cb04-15cd-1e93bd1664f7@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1cDvlqtbH4jRfFQepCoKxWpnJDM1eeEeR"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tcg: restrict i386 regs definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1cDvlqtbH4jRfFQepCoKxWpnJDM1eeEeR
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Message-ID: <278d8d46-bda2-ea89-dd5c-3221c37ce478@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tcg: restrict i386 regs definitions
References: <20170911213328.9701-1-f4bug@amsat.org>
 <20170911213328.9701-6-f4bug@amsat.org>
 <aa266e28-853b-4703-8495-8fa862aea106@gmx.com>
 <9bdda758-c62c-cb04-15cd-1e93bd1664f7@amsat.org>
In-Reply-To: <9bdda758-c62c-cb04-15cd-1e93bd1664f7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.2017 00:13, Philippe Mathieu-Daud=C3=A9 wrote:
> On 09/11/2017 06:44 PM, Kamil Rytarowski wrote:
>> On 11.09.2017 23:33, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> cleaning while here :)
>>>
>>> =C2=A0 accel/tcg/user-exec.c | 18 +++++++++---------
>>> =C2=A0 1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
>>> index 2a975eaf69..484a3f5f8f 100644
>>> --- a/accel/tcg/user-exec.c
>>> +++ b/accel/tcg/user-exec.c
>>> @@ -25,15 +25,6 @@
>>> =C2=A0 #include "exec/cpu_ldst.h"
>>> =C2=A0 #include "translate-all.h"
>>> =C2=A0 -#undef EAX
>>> -#undef ECX
>>> -#undef EDX
>>> -#undef EBX
>>> -#undef ESP
>>> -#undef EBP
>>> -#undef ESI
>>> -#undef EDI
>>> -#undef EIP
>>> =C2=A0 #ifdef __linux__
>>> =C2=A0 #include <sys/ucontext.h>
>>> =C2=A0 #endif
>>> @@ -131,6 +122,15 @@ static inline int handle_cpu_signal(uintptr_t
>>> pc, unsigned long address,
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 #if defined(__i386__)
>>> +#undef EAX
>>> +#undef ECX
>>> +#undef EDX
>>> +#undef EBX
>>> +#undef ESP
>>> +#undef EBP
>>> +#undef ESI
>>> +#undef EDI
>>> +#undef EIP
>>> =C2=A0 =C2=A0 #if defined(__NetBSD__)
>>> =C2=A0 #include <ucontext.h>
>>>
>>
>> Why to move under i386?
>=20
> I tracked the origin of these #defines in op-i386.c (7bfdb6d18c7b) and
> thought the Exx naming was for i386 while the x86_64 uses the Rxx namin=
g
> (RAX .. RIP) so you'd only have them on i386 arch.
> However it seems I didn't realize you can access x86_64 registers in
> 32-bit mode via the EAX .. EIP naming, as you see I'm not confident wit=
h
> this CISC arch :S
>=20
> So I guess it's best to ignore this patch?
>=20

A typical 64-bit x86_64 OS can run 32-bit programs and reuse x86 32-bit
headers.

>>
>> SmartOS pollutes namespace with these symbols on x86_64.
>>
>=20
> you should provide some VM :P
>=20

Hope to see it too.

> I plan to test this project soon:
> https://www.packer.io/docs/builders/qemu.html
>=20
> Regards,
>=20
> Phil.



--1cDvlqtbH4jRfFQepCoKxWpnJDM1eeEeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlm3EDgMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs+GkP/jLvNxhtER13fGvKUDu+4+Fo3mOcAPGz2iPT4Xt9
eC6aecYtcsi0tiRF3zQAnlWzTe0g7mMyJaxMQqdsnJ487BOQodVaOUpZLgbCnByX
WCS0jEaHGLNVnDAR9QWTQW5wm1fvj+umlTdMz0lVW4GXZdZnxs6HJ3eDDNjF/Klu
Y1AQoipGCjbU54KCCgLrXa58Pnpm+E1kuD6uRIPCJKJE4wpTTgm2jtyXqLFB2vKx
7H69epkKw9BYEstgkFGkcy0PnkTwTLJuSCyaxk4A/RWm02TaoLShN6guVEREBLpY
mHE6otFwlwH0hugY/cZQfB0t+ctAxtiW0zKjF9GPjUIcDiCczz5cvE+ZIKZqS+Zj
nLjnxrDAuOqFgozAn1gy3+/EDv5o3EwMZRzOu4LQ7NUtM4mQKFmjg30hd+SJ4A3H
gmo2NhCYcNhSTbd13/PV3ZSiEqLLR+i6BrC1ZmL1AYSjKex72jYcRFSwLbcoca0g
0TfXHFiEF7l5+/j4xVDWAEokcVUX/e438I8JEN8oBjpsFgP+55hI1/e+6L00eucr
TYwRQlnvsfLzvt/i9lYRLI39dkXS0KqM1omBoV7k1z8aHLFCK/lCGix+v49i4dKD
sSZelPdb3vW0lDCn5J8N9ghpchFSi1txpdsUG0ahRwCjWR6mvDllOSDpESWuE4ol
uF1D
=4ix5
-----END PGP SIGNATURE-----

--1cDvlqtbH4jRfFQepCoKxWpnJDM1eeEeR--
