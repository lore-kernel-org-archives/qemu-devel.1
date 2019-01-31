Received: from eggs.gnu.org ([209.51.188.92]:50522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCEb-0006UV-Ba
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpCEa-0003Ur-JB
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:18:25 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpCEZ-0003UD-1q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:18:23 -0500
Received: by mail-oi1-x243.google.com with SMTP id u18so2639937oie.10
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 05:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20190130202243.79545-1-mathew1800@gmail.com>
In-Reply-To: <20190130202243.79545-1-mathew1800@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 13:18:10 +0000
Message-ID: <CAFEAcA_-DCm9WiFpOVOidBu=RKVDABDNYLZ97e3sUVjvNn0VAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1] target/arm: Amend erroneous BRAA/BLRAA
 opcode check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mathew Maidment <mathew1800@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 30 Jan 2019 at 20:22, Mathew Maidment <mathew1800@gmail.com> wrote:
> This is a patch that fixes a condition within disas_uncond_b_reg() related to
> BRAA and BLRAA that would always result in the unallocated encoding path being
> taken.
>
> Hopefully everything is in order. This is only my second patch, so if anything
> is wrong, that's my bad.
>
> Thanks in advance for reviewing =)

Hi -- thanks for this patch. I think this bug is already
covered by this patch that went onto the mailing list last week:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06728.html
-- you might like to test that series.


thanks
-- PMM
