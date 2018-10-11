Received: from eggs.gnu.org ([2001:4830:134:3::10]:55545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAXOq-0004IN-SA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAXOq-0006q4-2Z
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:36:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAXOp-0006q0-UC
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:36:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id q50so8293833otd.0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 02:36:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
References: <20181007153731.GA32288@humpty.home.comstyle.com>
	<a43190b8-ad91-01dc-621c-377a80e3f3ea@gmx.com>
	<CAFEAcA_9+bhPHsHDNi+Jwgbf76m=vDzAWMQ7f5mPg-A_M61bPg@mail.gmail.com>
	<933be526-741f-28a7-dab4-11789db7c4ba@gmx.com>
	<a67f0c2c-5a5b-7a78-141b-2e829304e72e@comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 10:36:34 +0100
Message-ID: <CAFEAcA9rJZNeRJdjLU724qgr6PEyVE-8hOn_gk_uU+mYSxuxDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Use MAP_STACK in
 qemu_alloc_stack() on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: Kamil Rytarowski <n54@gmx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 11 October 2018 at 00:55, Brad Smith <brad@comstyle.com> wrote:
> And from FreeBSD...
>
>      MAP_STACK MAP_STACK implies MAP_ANON, and offset of 0.  The fd
> argument must be -1 and prot must include at least
> PROT_READ and PROT_WRITE.
>
> This option creates a memory region that grows to at
> most len bytes in size, starting from the stack top
> and growing down.  The stack top is the starting
> address returned by the call, plus len bytes.  The
> bottom of the stack at maximum growth is the starting
> address returned by the call.
>
> Stacks created with MAP_STACK automatically grow.
> Guards prevent inadvertent use of the regions into
> which those stacks can grow without requiring mapping
> the whole stack in advance.

Hmm. That "automatically growing" part sounds like
behaviour we definitely do not want for our use case.
So we're going to need to make this OS-specific :-(

thanks
-- PMM
