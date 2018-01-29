Received: from eggs.gnu.org ([2001:4830:134:3::10]:46114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDIB-0007Iu-3f
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egDIA-00050U-Cf
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:32:27 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:46693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egDIA-0004zp-7c
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:32:26 -0500
Received: by mail-oi0-x22e.google.com with SMTP id 8so5655857oix.13
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 09:32:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123035349.24538-4-richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 17:32:05 +0000
Message-ID: <CAFEAcA9AnDeEf0EqTzyXJMWdY+EsimEEaShtVR+cCSs29tmN2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] target/arm: Add SVE to migration
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 23 January 2018 at 03:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Save the high parts of the Zregs and all of the Pregs.
> The ZCR_ELx registers are migrated via the CP mechanism.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/machine.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
