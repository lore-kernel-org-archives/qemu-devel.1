Received: from eggs.gnu.org ([2001:4830:134:3::10]:35406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwARR-0003nW-3M
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwARQ-000179-E4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:39:25 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cwARQ-00016S-7e
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:39:24 -0400
Received: by mail-wr0-x235.google.com with SMTP id t20so71269188wra.1
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 09:39:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <30f2db0a-2132-4f6e-cd06-f5505f01db88@amsat.org>
References: <1491486340-25988-1-git-send-email-peter.maydell@linaro.org>
	<30f2db0a-2132-4f6e-cd06-f5505f01db88@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Apr 2017 17:39:02 +0100
Message-ID: <CAFEAcA_2gdAC04gOEyZwgSU5WD+pBiuv4BxGE6q3r05ZMuMadg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Add missing entries
 to excnames[] for log strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 6 April 2017 at 17:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
> excnames[] is only used in arm_log_exception(), can we move it there?

Seems like a good idea. I think this is historic, we used to use
it in separate functions in different files for the 32-bit and
64-bit exception entry code, but those got unified a little while back.

I'll do that as a separate patch, though.

thanks
-- PMM
