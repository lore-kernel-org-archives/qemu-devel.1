Received: from eggs.gnu.org ([209.51.188.92]:58092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1Jp-0000jz-N5
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1Jn-0005W4-Ny
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:02:41 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1Jk-0005UC-PH
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:02:37 -0500
Received: by mail-oi1-x242.google.com with SMTP id v6so18359203oif.2
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:02:35 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-9-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 15:29:52 +0000
Message-ID: <CAFEAcA9+8XBXDqL8JfTpS8q05XwaZ+Ck1nqAhTLsyN_=WCjXNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/11] target/arm: Add guarded_pages cpu
 property for user-only
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

On Thu, 10 Jan 2019 at 12:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While waiting for a proper userland ABI, allow static test
> cases to be written assuming that GP is set for all pages.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           |  4 ++++
>  target/arm/cpu64.c         | 18 ++++++++++++++++++
>  target/arm/translate-a64.c |  8 +++++++-
>  3 files changed, 29 insertions(+), 1 deletion(-)

This is OK code-wise but I'm a bit wary of committing it
because then we're stuck with the property forever even
if it turns out to be irrelevant to whatever the userland
ABI eventually is.

thanks
-- PMM
