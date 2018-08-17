Received: from eggs.gnu.org ([2001:4830:134:3::10]:40741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhO3-0008LV-Jt
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqh8h-0004aV-WF
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:58:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqh8h-0004aC-PS
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:58:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id 13-v6so14802268ois.1
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 08:58:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-5-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 16:57:54 +0100
Message-ID: <CAFEAcA9V27aT81_eK21F0TtagN8mvsoPCPubtnTWPjZ8d+pYdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/20] target/arm: Adjust sve_exception_el
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Check for EL3 before testing CPTR_EL3.EZ.  Return 0 when the exception
> should be routed via AdvSIMDFPAccessTrap.  Mirror the structure of
> CheckSVEEnabled more closely.
>
> Fixes: 5be5e8eda78
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 96 ++++++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 50 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
