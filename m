Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYVm8-0004I5-En
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYVm6-0006LP-Nx
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:44:03 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYVm6-0006L6-IN
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:44:02 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so9691616otm.13
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 04:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20181214031923.29527-1-richard.henderson@linaro.org>
	<CAFEAcA-7irqz__ZywybEORVtZiZgRGESFJaxdZShrKruuOACGw@mail.gmail.com>
	<6b3c561e-44d4-b15c-f6a9-e436ad47638f@linaro.org>
In-Reply-To: <6b3c561e-44d4-b15c-f6a9-e436ad47638f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Dec 2018 12:43:50 +0000
Message-ID: <CAFEAcA9ruCb+aiUc2LSrSJ4wJSW5e4ui7xmzZGoPMwsELawW-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/32] tcg patch queue
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

On Sun, 16 Dec 2018 at 07:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/15/18 1:18 PM, Peter Maydell wrote:
> > This didn't pass 'make check' on sparc64 host.
> > It looks like the handful of tests that exercise TCG
> > in the process of doing what they do failed, and there
> > was a tcg assert in there too:
> ...
> > qemu-system-x86_64: /home/pm215/qemu/tcg/sparc/tcg-target.inc.c:319:
> > patch_reloc: Assertion `check_fit_ptr(value, 13)' failed.
>
> If there were extra asserts, they should have been outside tcg/foo/*.  Any
> extra asserts inside I cannot explain.  Unfortunately, sparc and s390 are two
> that I cannot test directly.

You have access to the gcc compile farm, right? The sparc
tests run on gcc202.fsffrance.org.

Our s390 system I can get you access to for testing purposes
if necessary.

thanks
-- PMM
