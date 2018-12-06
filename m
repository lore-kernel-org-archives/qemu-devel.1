Received: from eggs.gnu.org ([2001:4830:134:3::10]:47474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUshH-0000t6-1q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUsUD-000262-NB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:10:34 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUsUD-00025X-Dg
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:10:33 -0500
Received: by mail-ot1-x342.google.com with SMTP id v23so164542otk.9
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 04:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20181203203839.757-1-richard.henderson@linaro.org>
	<20181203203839.757-2-richard.henderson@linaro.org>
In-Reply-To: <20181203203839.757-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 12:10:21 +0000
Message-ID: <CAFEAcA_7p2UWkcA5-SJ6J3n=yXZ1VF=rHJqJrL5yVa9T=tvy5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 01/10] target/arm: Move id_aa64mmfr* to
 ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 3 Dec 2018 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> At the same time, define the fields for these registers,
> and use those defines in arm_pamax().
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ----
> v2: Include the v8.5 fields; init the registers for kvm.
>     Upcase all of the field names.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
