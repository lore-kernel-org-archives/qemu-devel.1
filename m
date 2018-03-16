Received: from eggs.gnu.org ([2001:4830:134:3::10]:35830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewrJJ-0002hA-Tr
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewrJI-0002O7-RD
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:30:25 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewrJI-0002NQ-Gq
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:30:24 -0400
Received: by mail-ot0-x243.google.com with SMTP id i28-v6so6052483otf.8
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 08:30:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313185303.21914-1-jcmvbkbc@gmail.com>
References: <20180313185303.21914-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 15:30:03 +0000
Message-ID: <CAFEAcA-w-ornxKm+F_J8G8=bjAfpMMnJHzAuXL9=DULrkA--gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] target/xtensa linux-user support
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

On 13 March 2018 at 18:53, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following series that adds linux-user support for
> target/xtensa.
> There's a trivial merge conflict with linux-user pull request from
> Laurent Vivier.
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
>   git://github.com/OSLL/qemu-xtensa.git tags/20180313-xtensa
>
> for you to fetch changes up to be00d35eab124bb4e4e393ac2b0a451e065b7041:
>
>   MAINTAINERS: fix W: address for xtensa (2018-03-13 11:30:23 -0700)
>

Hi. This fails to build on 32-bit:

In file included from /home/peter.maydell/qemu/include/exec/exec-all.h:41:0,
                 from /home/peter.maydell/qemu/target/xtensa/helper.c:30:
/home/peter.maydell/qemu/target/xtensa/helper.c: In function
'xtensa_cpu_handle_mmu_fault':
/home/peter.maydell/qemu/target/xtensa/helper.c:331:32: error: format
'%lx' expects argument of type 'long unsigned int', but argument 4 has
type 'vaddr {aka long long unsigned int}' [-Werror=format=]
     qemu_log_mask(CPU_LOG_INT, "%s: rw = %d, address = 0x%08lx, size = %d\n",
                                ^
/home/peter.maydell/qemu/include/qemu/log.h:84:22: note: in definition
of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^

'vaddr' type is uint64_t, so you need PRIx64 here.

thanks
-- PMM
