Received: from eggs.gnu.org ([2001:4830:134:3::10]:43693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEbdc-0007pG-N3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEbdc-00037o-01
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:52:28 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:56655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEbdb-00036t-OR
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:52:27 -0500
Received: by mail-wm0-x235.google.com with SMTP id z3so22179435wme.5
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 05:52:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 13:52:05 +0000
Message-ID: <CAFEAcA-DqzkuZUmwCgB_Khui3B8ek7kLTEYjWb6O-8_CYd5RpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 13 November 2017 at 14:11, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM bugfixes for rc1...
>
>
> The following changes since commit f291910db61b5812e68f1e76afb3ade41d567bea:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-11-09' into staging (2017-11-13 13:13:12 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171113
>
> for you to fetch changes up to d25f2a72272b9ffe0d06710d6217d1169bc2cc7d:
>
>   accel/tcg/translate-all: expand cpu_restore_state addr check (2017-11-13 13:55:27 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * translate-a64.c: silence gcc5 warning
>  * highbank: validate register offset before access
>  * MAINTAINERS: Add entries for Smartfusion2
>  * accel/tcg/translate-all: expand cpu_restore_state addr check
>    (so usermode insn aborts don't crash with an assertion failure)
>  * fix TCG initialization of some Arm boards by allowing them
>    to specify min/default number of CPUs to create
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
