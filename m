Received: from eggs.gnu.org ([2001:4830:134:3::10]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYozX-0006cs-7O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYozW-0004su-CA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:42:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYozW-0004rj-6s
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:42:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id 21-v6so7757335oip.8
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 01:42:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-7-richard.henderson@linaro.org>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 09:42:33 +0100
Message-ID: <CAFEAcA9JkC_9niGrEoVf8FKzT+k6yn0WS0Mjbwz8WpLpzJhszQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/6] target/arm: Set ISAR bits for -cpu max
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

On 29 June 2018 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
> For the supported extensions, fill in the appropriate bits in
> ID_ISAR5, ID_ISAR6, ID_AA64ISAR0, ID_AA64ISAR1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

This makes sense, but I'd rather have a bit of time to think
about how exactly we want to handle feature bits vs ID
register values (the current codebase is not entirely
coherent on the topic), so I'd rather not put this in
for softfreeze unless there's a strong reason we should...

thanks
-- PMM
