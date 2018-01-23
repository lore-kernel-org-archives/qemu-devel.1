Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edvbY-00054T-JJ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edvbX-0006tV-LK
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:15:00 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:44222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edvbX-0006tG-GU
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:14:59 -0500
Received: by mail-ot0-x22c.google.com with SMTP id t20so10184595ote.11
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 02:14:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2018 10:14:38 +0000
Message-ID: <CAFEAcA-RKozBvsEm1d_52=nm367-7d3m=dUid8vwOyEQzZcBzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/43] Add hppa-softmmu
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

On 22 January 2018 at 03:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This has some improvements to the patch set posted on Dec 28.
>
>   * Change cpu init as requested by Igor Mammedov.
>   * Add SMP support
>   * Add firmware image
>   * Implement qemu-specific pause and system reset insns.
>
>
> r~
>
>
> The following changes since commit b384cd95eb9c6f73ad84ed1bb0717a26e29cc7=
8f:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-01-19 16:35:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20180121
>
> for you to fetch changes up to 350e2a714ac8db559b255f9e8fe91c574f45df53:
>
>   hw/hppa: Add MAINTAINERS entry (2018-01-21 14:05:03 -0800)
>
> ----------------------------------------------------------------
> Add hppa-softmmu

Hi. Patchew is complaining that this doesn't build on some hosts:


/var/tmp/patchew-tester-tmp-z8zo58jf/src/target/sh4/op_helper.c: In
function =E2=80=98superh_cpu_do_unaligned_access=E2=80=99:
/var/tmp/patchew-tester-tmp-z8zo58jf/src/target/sh4/op_helper.c:31:5:
error: enumeration value =E2=80=98MMU_DEBUG_LOAD=E2=80=99 not handled in sw=
itch
[-Werror=3Dswitch]
     switch (access_type) {
     ^~~~~~

so I'm going to drop it from my to-process queue.

Also, the patchew coding style check seems to be showing a lot
of whitespace and similar nits which I don't think there's any
reason to have in new code. Could you also fix those, please?

thanks
-- PMM
