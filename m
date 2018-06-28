Received: from eggs.gnu.org ([2001:4830:134:3::10]:54730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYVy-0002uH-KG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYYVt-0007l9-0y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:07:18 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYYVs-0007jF-Ix
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:07:12 -0400
Received: by mail-oi0-x244.google.com with SMTP id v8-v6so5495079oie.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:07:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625160009.17437-1-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 16:06:51 +0100
Message-ID: <CAFEAcA-GYuOGX11t7DwEkgFuOd86Mc_rF3EZV4CX==s_xD1_AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/5] support reading some CPUID/CNT
 registers from user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 June 2018 at 17:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Hi,
>
> This expands on the previous version by adding the additional CPUID
> registers as exposed by the HWCAP_CPUID kernel feature. Most of the
> work involves judicious use of macros. There is a easily extensible
> test case that uses the shiny new check-tcg infrastructure ;-)
>
> Alex Benn=C3=A9e (5):
>   target/arm: support reading of CNT[VCT|FRQ]_EL0 from user-space
>   target/arm: relax permission checks for HWCAP_CPUID registers
>   target/arm: expose CPUID registers to userspace
>   linux-user/elfload: enable HWCAP_CPUID for AArch64
>   tests/tcg/aarch64: userspace system register test

Patch 1 is a bugfix not very related to the rest, so I've applied
it to target-arm.next, and left review comments on 2/3.

thanks
-- PMM
