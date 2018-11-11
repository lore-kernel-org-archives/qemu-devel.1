Received: from eggs.gnu.org ([2001:4830:134:3::10]:33226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLr1e-00052a-VI
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gLr1c-0004SA-U4
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:47:46 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gLr1b-0004Ps-0w
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:47:44 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so5789724otk.1
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 06:47:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181109152119.9242-8-alex.bennee@linaro.org>
References: <20181109152119.9242-1-alex.bennee@linaro.org>
	<20181109152119.9242-8-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Nov 2018 14:47:20 +0000
Message-ID: <CAFEAcA-iOLcP50jbKLJwpwL333hbQi1t0ig6zp8SNNLsJL8=vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] arm: fix
 aa64_generate_debug_exceptions to work with EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 9 November 2018 at 15:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> The test was incomplete and incorrectly caused debug exceptions to be
> generated when returning to EL2 after a failed attempt to single-step
> an EL1 instruction. Fix this while cleaning up the function a little.

> @@ -2833,9 +2845,6 @@ static inline bool aa32_generate_debug_exceptions(C=
PUARMState *env)
>   * since the pseudocode has it at all callsites except for the one in
>   * CheckSoftwareStep(), where it is elided because both branches would
>   * always return the same value.
> - *
> - * Parts of the pseudocode relating to EL2 and EL3 are omitted because w=
e
> - * don't yet implement those exception levels or their associated trap b=
its.
>   */

In hindsight I regret not standardizing on a greppable tag for
marking these kinds of "we don't do X because we don't implement
feature Y" comments...

thanks
-- PMM
