Received: from eggs.gnu.org ([2001:4830:134:3::10]:41257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYQSF-0008Qj-5Q
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 02:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYQSB-0003hz-4i
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 02:03:11 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:42974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYQS9-0003SR-7i
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 02:03:05 -0500
Received: by mail-pf1-x42b.google.com with SMTP id 64so4809793pfr.9
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 23:03:02 -0800 (PST)
References: <20181214031923.29527-1-richard.henderson@linaro.org>
	<CAFEAcA-7irqz__ZywybEORVtZiZgRGESFJaxdZShrKruuOACGw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b3c561e-44d4-b15c-f6a9-e436ad47638f@linaro.org>
Date: Sat, 15 Dec 2018 23:02:57 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-7irqz__ZywybEORVtZiZgRGESFJaxdZShrKruuOACGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/32] tcg patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12/15/18 1:18 PM, Peter Maydell wrote:
> This didn't pass 'make check' on sparc64 host.
> It looks like the handful of tests that exercise TCG
> in the process of doing what they do failed, and there
> was a tcg assert in there too:
...
> qemu-system-x86_64: /home/pm215/qemu/tcg/sparc/tcg-target.inc.c:319:
> patch_reloc: Assertion `check_fit_ptr(value, 13)' failed.

If there were extra asserts, they should have been outside tcg/foo/*.  Any
extra asserts inside I cannot explain.  Unfortunately, sparc and s390 are two
that I cannot test directly.


r~
