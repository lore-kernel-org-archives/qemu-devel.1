Received: from eggs.gnu.org ([2001:4830:134:3::10]:39026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exE65-00007Q-Pc
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 11:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exE64-0007qm-SV
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 11:50:17 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exE64-0007pg-MT
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 11:50:16 -0400
Received: by mail-oi0-x241.google.com with SMTP id c12so11039957oic.7
	for <qemu-devel@nongnu.org>; Sat, 17 Mar 2018 08:50:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180316175022.26792-1-jcmvbkbc@gmail.com>
References: <20180316175022.26792-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Mar 2018 15:49:55 +0000
Message-ID: <CAFEAcA-V4TvBubFAfd28=sVxNwo7SmJCKqN9paJwq3KAkmWaQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/11] target/xtensa linux-user support
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

On 16 March 2018 at 17:50, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following series that adds linux-user support for
> target/xtensa.
> There's a trivial merge conflict with linux-user pull request from
> Laurent Vivier.
>
> Changes since v1 pull request:
> - fix vaddr print format from %lx to %VADDR_PRIx
>
> Changes since v6 patch series:
> - rebase to the current master.
>
> The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180316-xtensa
>
> for you to fetch changes up to b8105d2194f06ab8e3566467e8e3c582457424bb:
>
>   MAINTAINERS: fix W: address for xtensa (2018-03-16 09:40:35 -0700)
>
> ----------------------------------------------------------------
> target/xtensa linux-user support.
>
> - small cleanup for xtensa registers dumping (-d cpu);
> - add support for debugging linux-user process with xtensa-linux-gdb
>   (as opposed to xtensa-elf-gdb), which can only access unprivileged
>   registers;
> - enable MTTCG for target/xtensa;
> - cleanup in linux-user/mmap area making sure that it works correctly
>   with limited 30-bit-wide user address space;
> - import xtensa-specific definitions from the linux kernel,
>   conditionalize user-only/softmmu-only code and add handlers for
>   signals, exceptions, process/thread creation and core registers dumping.
>

Applied, thanks.

-- PMM
