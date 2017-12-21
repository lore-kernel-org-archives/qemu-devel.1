Received: from eggs.gnu.org ([2001:4830:134:3::10]:38598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9t6-0008Ng-46
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9t5-0002uS-5w
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:04:28 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:44836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS9t4-0002u0-VY
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:04:27 -0500
Received: by mail-ot0-x231.google.com with SMTP id d27so23799150ote.11
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 15:04:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAdtpL46YjfBuH5XDAKYecGh0Va2bup7EVAGqT6jEO=Dwj_n5Q@mail.gmail.com>
References: <20171221211103.30311-1-laurent@vivier.eu>
	<CAFEAcA8MvShVAZf1+OOf2ZZnhD3sQ_jgED4NPWBOOySwJitD2Q@mail.gmail.com>
	<CAAdtpL46YjfBuH5XDAKYecGh0Va2bup7EVAGqT6jEO=Dwj_n5Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 23:04:05 +0000
Message-ID: <CAFEAcA8yLUgu3jx-ymRU2HRdN9Wwr6RB-Q1WVFAeB9DFrbU_Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i386/vmport: fix missing definitions
 with x86_64-w64-mingw32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 21 December 2017 at 22:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>>> Fixes: 7299e1a411
>>>        ("hw/i386/vmport: replace fprintf() by trace events or LOG_UNIMP=
")
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>
>> Looks to me like it'll be a bug for anything not configured
>> using the 'log' trace backend, rather than win32 specific.
>
> Sorry my bad, it seems I don't test enough lately, I'll try to do more
> testing, and somehow to reduce CI build time, more they last, less we
> rely on it, even with personal repositories.

It's unfortunate that trace.h pulls in qemu/log.h if you're
using the log backend, because it makes this particular
mistake easy; we've had quite a few instances of it...
(I could probably configure one of my test setups with a
different trace backend which would at least catch these
before they hit master.)

thanks
-- PMM
