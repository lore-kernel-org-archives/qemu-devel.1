Received: from eggs.gnu.org ([2001:4830:134:3::10]:42483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYeHx-00013F-FY
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYeHw-000219-Ge
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:49:29 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:44096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYeHw-0001t6-6u
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:49:28 -0500
Received: by mail-ot1-x335.google.com with SMTP id f18so10389950otl.11
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 13:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20181214144214.1260-1-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Dec 2018 21:49:08 +0000
Message-ID: <CAFEAcA-_b26nsXfJqf9s=ZdUi8N=UMSQyLDe-mUs9xsDFpmD-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] misc queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 14:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This is a colletion of miscellaneous patches (mostly mine),
> which fix minor bugs or do some refactoring/cleanup.
> No user-visible changes in here.
>
> thanks
> -- PMM
>
> The following changes since commit 0f98c9945899c5dfacd5a410ff04178eda605a16:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-12-12' into staging (2018-12-14 10:19:47 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-misc-20181214
>
> for you to fetch changes up to bbac02f1e8edfd0663543f6fdad1e7094d860b29:
>
>   virt: Fix broken indentation (2018-12-14 13:30:55 +0000)
>
> ----------------------------------------------------------------
> miscellaneous patches:
>  * checkpatch.pl: Enforce multiline comment syntax
>  * Rename cpu_physical_memory_write_rom() to address_space_write_rom()
>  * disas, monitor, elf_ops: Use address_space_read() to read memory
>  * Remove load_image() in favour of load_image_size()
>  * Fix some minor memory leaks in arm boards/devices
>  * virt: fix broken indentation
>
Applied, thanks.
-- PMM
