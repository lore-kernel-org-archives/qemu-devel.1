Received: from eggs.gnu.org ([209.51.188.92]:36716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggTQg-00085u-J5
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggTQf-00047m-Pt
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:50:50 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggTQf-00045S-DT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:50:49 -0500
Received: by mail-wr1-x441.google.com with SMTP id j2so131968wrw.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:50:49 -0800 (PST)
References: <20181220111008.24954-1-alex.bennee@linaro.org>
	<20181221193037.GB11197@flamenco>
	<72dff278-24d4-61db-3b49-a50a5aec6448@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <72dff278-24d4-61db-3b49-a50a5aec6448@linaro.org>
Date: Mon, 07 Jan 2019 11:50:46 +0000
Message-ID: <87lg3wvg89.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] fpu: add compile time check for old
 glibc/libm and fma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, laurent.desnogues@gmail.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/21/18 11:30 AM, Emilio G. Cota wrote:
>> +    ua.s =3D 0x0020000000000001;
>> +    ub.s =3D 0x3ca0000000000000;
>> +    uc.s =3D 0x0020000000000000;
>> +    ur.h =3D fma(ua.h, ub.h, uc.h);
>> +    if (ur.s !=3D 0x0020000000000001) {
>
> Forgot your ull's, but otherwise ok.
>
> In email to Alex, I did wonder if we should check for fma hardware (at le=
ast on
> x86).  Without a hardware insn, the libm routine is probably no faster th=
an
> softmmu.

My only worry is we could end up doing a bunch of these processor
id/capability type checks. Is a correct but slow libm FMA going to be
much slower than our FMA? Will users even notice?

--
Alex Benn=C3=A9e
