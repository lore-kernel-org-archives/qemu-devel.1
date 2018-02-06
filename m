Received: from eggs.gnu.org ([2001:4830:134:3::10]:49381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejA7c-000791-Qp
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejA7Z-0002Cs-Po
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:45:44 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:41107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejA7Z-0002CW-IC
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:45:41 -0500
Received: by mail-wr0-x232.google.com with SMTP id v15so3373163wrb.8
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 12:45:41 -0800 (PST)
References: <20180204041136.17525-1-richard.henderson@linaro.org>
	<CAFEAcA8+zNg8S=sFuUwPKjzzJZFUYDZFU11nH+_M60wuXRAVrQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8+zNg8S=sFuUwPKjzzJZFUYDZFU11nH+_M60wuXRAVrQ@mail.gmail.com>
Date: Tue, 06 Feb 2018 20:45:38 +0000
Message-ID: <878tc5x2x9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/24] re-factor and add fp16 using glibc
 soft-fp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, hsp.cat7@gmail.com


Peter Maydell <peter.maydell@linaro.org> writes:

> On 4 February 2018 at 04:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Or there's the code from glibc.  I know Peter didn't like the idea;
>> debugging this code is fairly painful -- the massive preprocessor
>> macros mean that you can't step through anything.  But at least we
>> have a good relationship with glibc, so merging patches back and
>> forth should be easy.
>
> Yeah. I didn't like dealing with this code two decades ago
> when I first encountered it, and it hasn't improved any.
> It's pretty much write-only code, and it isn't going to be
> any fun for debugging.

I think I've managed to pull the performance back on softfloat-v4 thanks
to the attribute(flatten) changes to addsub/div/mul/mulladd.

--
Alex Benn=C3=A9e
