Received: from eggs.gnu.org ([2001:4830:134:3::10]:44898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzgp-0004mU-Ed
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzgo-0002io-Nr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:48:11 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzgo-0002iA-Is
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:48:10 -0500
Received: by mail-ot0-x244.google.com with SMTP id a24so5073504otd.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 05:48:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-7-alex.bennee@linaro.org>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 13:47:49 +0000
Message-ID: <CAFEAcA_nMQOwLk4BFhtc8xEqc27BbW3zyUfVtnjRevC1yQpxRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/20] include/fpu/softfloat: add some
 float16 constants
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
> This defines the same set of common constants for float 16 as defined
> for 32 and 64 bit floats. These are often used by target helper
> functions. I've also removed constants that are not used by anybody.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

With the fix to the value for float16_one that Philippe suggests:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
