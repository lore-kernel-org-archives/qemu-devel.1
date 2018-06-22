Received: from eggs.gnu.org ([2001:4830:134:3::10]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJUS-0004eP-J1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJUS-0006Ni-0v
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:40:28 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:37334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWJUR-0006NU-Nj
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:40:27 -0400
Received: by mail-oi0-x230.google.com with SMTP id l22-v6so5731311oib.4
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:40:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 11:40:06 +0100
Message-ID: <CAFEAcA8ZEu10r9WLVrAXtBoNfksaGgBeY2YYGqXTQxPtgEo9bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/19] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 12 June 2018 at 01:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Version 3 does not attempt the whole thing in one go,
> and does attempt to incorporate strace into the reorg.
>
> Thoughts?

This approach works for me. I won't bother to review the
rest of the patchset for the moment, until Laurent weighs
in on whether he likes the structure or not...

thanks
-- PMM
