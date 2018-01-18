Received: from eggs.gnu.org ([2001:4830:134:3::10]:58565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecBx8-00026v-Q7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecBx8-0002HP-0v
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:18:06 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:37330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecBx7-0002H6-S8
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:18:05 -0500
Received: by mail-ot0-x235.google.com with SMTP id a24so20367729otd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:18:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <782d052d-f390-1a55-8a73-120753aa1472@amsat.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
	<1393deaf-c207-6055-1f7c-f7ae814cf2db@amsat.org>
	<87shb3nwkc.fsf@linaro.org>
	<CAAdtpL48633TDoSnhv1-iZ0QjWWQsuD1DxJTsniJg+AHbeiT_g@mail.gmail.com>
	<CAFEAcA8bEPohja9fw-5_BUnfExX4KA_syce8dpdD=trShV=qAg@mail.gmail.com>
	<782d052d-f390-1a55-8a73-120753aa1472@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 15:17:44 +0000
Message-ID: <CAFEAcA90331Sezm-PwVFrMqP6Fgav0ujJv0Mkt7PAd_9CBrEFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Francisco Iglesias <frasse.iglesias@gmail.com>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Dutcher <andrew@andrewdutcher.com>, bharata@linux.vnet.ibm.com, Aurelien Jarno <aurelien@aurel32.net>

On 18 January 2018 at 14:59, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> My comment was for a previous line:
>
>   uint64_t frac   : 64;
>
> I don't have enough compiler knowledge to be sure how this bitfield is
> interpreted by the compiler. I understood the standard as bitfields are
> for 'unsigned', and for IL32 we have sizeof(unsigned) =3D 32, so I wonder
> how a :64 bitfield ends (bits >=3D 32 silently truncated?).

Defining a 64-bit bitfield is a bit pointless (why not just use
uint64_t?) but there's nothing particularly different for IL32P64 here.
The spec says the underlying type is _Bool, signed int, unsigned
into, or an implementation defined type. For QEMU's hosts 'int'
is always 32 bits, so if gcc and clang allow bitfields on a
64-bit type like uint64_t (as an impdef extension) then they
should work on all hosts. (In any case it needs to either work
or give a compiler error, silent truncation isn't an option.)

thanks
-- PMM
