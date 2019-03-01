Received: from eggs.gnu.org ([209.51.188.92]:40209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzem8-0000qK-B5
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzem7-00010J-Fm
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:48:16 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:44681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzem7-000109-Ar
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:48:15 -0500
Received: by mail-ot1-x32e.google.com with SMTP id g1so20389817otj.11
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 01:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20190228221033.14484-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190228221033.14484-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2019 09:48:03 +0000
Message-ID: <CAFEAcA-MjQXvyi=FdYh6X+CdssvhqmCN0va3V6B3pZ6NXe37xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/40] target/xtensa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Feb 2019 at 22:10, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following batch of target/xtensa updates.
> Changes v1->v2:
> - fix build with clang.
>
> The following changes since commit 1c3d45df5e94042d5fb2bb31416072563ab30e49:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-02-04' into staging (2019-02-05 12:46:18 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20190228-xtensa
>
> for you to fetch changes up to de0cebd93089ff2ebf2ebf9d287381eb73cbb9aa:
>
>   tests/tcg/xtensa: add FPU2000 coprocessor tests (2019-02-28 04:43:24 -0800)
>
> ----------------------------------------------------------------
> target/xtensa: FLIX support, various fixes and test improvements
>
> - add FLIX (flexible length instructions extension) support;
> - make testsuite runnable on wider range of xtensa cores;
> - add floating point opcode tests;
> - don't add duplicate 'static' in import_core.sh script;
> - fix undefined opcodes detection in test_mmuhifi_c3 overlay.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
