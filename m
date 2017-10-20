Received: from eggs.gnu.org ([2001:4830:134:3::10]:58366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5aWI-0003NU-IM
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5aWH-0005zt-R3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:51:38 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:47228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5aWH-0005xg-K7
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:51:37 -0400
Received: by mail-wr0-x231.google.com with SMTP id y39so11883668wrd.4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:51:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171013145714.2740-1-shorne@gmail.com>
References: <20171013145714.2740-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 17:51:13 +0100
Message-ID: <CAFEAcA-w9d1-FQ_E4Aes0dzdx_rNEm3XdKnkJDVrwAWq4ZxH9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] OpenRISC SMP Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>

On 13 October 2017 at 15:57, Stafford Horne <shorne@gmail.com> wrote:
> Hello,
>
> Please consider for pull.
>
> The following changes since commit 7851197b812b383ae1208c5d86391c5179c8209d:
>
>   Update version for 2.10.1 release (2017-10-02 12:42:58 -0500)
>
> are available in the git repository at:
>
>   git://github.com/stffrdhrn/qemu.git tags/openrisc-20171113-smp-pr
>
> for you to fetch changes up to 017a118ebed8757ccdce6fa217640963579aeb13:
>
>   openrisc: Only kick cpu on timeout, not on update (2017-10-13 23:31:22 +0900)
>
> ----------------------------------------------------------------
> OpenRISC SMP patchset 20171113
>
> ----------------------------------------------------------------
> Stafford Horne (5):
>   openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
>   target/openrisc: Make coreid and numcores variable
>   openrisc/cputimer: Perparation for Multicore
>   openrisc: Initial SMP support
>   openrisc: Only kick cpu on timeout, not on update

Hi -- I'm afraid this pull request doesn't apply to master.
Looking at it, that seems to be because you've based it on the
2.10.1 branch. All pull requests for master need to be based
on master -- can you rebase to the right thing and resubmit,
please?

thanks
-- PMM
