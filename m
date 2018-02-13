Received: from eggs.gnu.org ([2001:4830:134:3::10]:44211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcJO-000565-9M
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elcJN-0003WA-Il
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:16:02 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:44458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elcJN-0003Vp-EL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:16:01 -0500
Received: by mail-ot0-x242.google.com with SMTP id l5so17561096otj.11
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:16:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-15-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-15-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 15:15:40 +0000
Message-ID: <CAFEAcA9rg2o-2pW_AutcwX_QWYosPTRj2+0kUhGHOZqU0vNppA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/20] fpu/softfloat: re-factor muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9 January 2018 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
> We can now add float16_muladd and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 muladd functions.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
