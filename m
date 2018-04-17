Received: from eggs.gnu.org ([2001:4830:134:3::10]:49345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8MPn-0002y9-8N
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8MPm-0004VZ-FX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:56:39 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8MPm-0004Tm-9d
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:56:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id j10-v6so3108903oii.12
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 01:56:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <614d4cef-07d2-f025-1039-2577be467c71@linaro.org>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<614d4cef-07d2-f025-1039-2577be467c71@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 09:56:16 +0100
Message-ID: <CAFEAcA-qBWUW7gtfzfQ91gx4YrPB=+WmrCF=rJGbod9BOycMxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 16 April 2018 at 20:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/16/2018 03:54 AM, Alex Benn=C3=A9e wrote:
>> +    /* Inf / x or 0 / x */
>> +    if (a.cls =3D=3D float_class_inf || a.cls =3D=3D float_class_zero) =
{
>> +        a.sign =3D sign;
>> +        return a;
>> +    }
>
> 0/0 should raise an exception.

It does -- we check for 0/0 and Inf/Inf first, just before this check.

thanks
-- PMM
