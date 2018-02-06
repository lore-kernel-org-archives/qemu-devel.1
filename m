Received: from eggs.gnu.org ([2001:4830:134:3::10]:33930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eizm0-00063K-Or
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eizlu-0005tF-W6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:42:44 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:45947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eizlu-0005sy-Qi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:42:38 -0500
Received: by mail-ot0-x234.google.com with SMTP id 73so1126307oti.12
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 01:42:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <540d164d-23b7-c511-80ee-037cdcb3d86b@amsat.org>
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-3-git-send-email-peter.maydell@linaro.org>
	<540d164d-23b7-c511-80ee-037cdcb3d86b@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 09:42:17 +0000
Message-ID: <CAFEAcA_2qoWcJ9wL+ewXD1Fp6XFYb5EuotcD=_WMxyNf1aTZ+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/7] target/arm: Split "get
 pending exception info" from "acknowledge it"
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

On 5 February 2018 at 23:44, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> maybe:
>
> assert(ptargets_secure && pirq);

This is one of those areas where people have different opinions,
but personally I think the point of assertions is to turn
bugs that manifest later and in confusing ways into bugs
that manifest early and clearly. In this case, if either of
those pointers is NULL then we'll immediately segfault in
this function, and the stacktrace will point directly at
the buggy code, so the assert doesn't gain anything.

thanks
-- PMM
