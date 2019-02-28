Received: from eggs.gnu.org ([209.51.188.92]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQy6-0006Ok-QQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 14:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzQy5-00085y-Qz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 14:03:42 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:34262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzQy5-0007zZ-Il
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 14:03:41 -0500
Received: by mail-ot1-x331.google.com with SMTP id 98so18725708oty.1
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 11:03:27 -0800 (PST)
MIME-Version: 1.0
References: <20190228110835.16159-1-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 19:03:13 +0000
Message-ID: <CAFEAcA9qP6m1GmrVtHraAs-jK2sBhN7w9mZ4uxRCTOft9-Ys8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/16] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 28 Feb 2019 at 11:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit adf2e451f357e993f173ba9b4176dbf3e65fee7e:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-26 19:04:47 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190228-1
>
> for you to fetch changes up to 1c9af3a9e05c1607a36df4943f8f5393d7621a91:
>
>   linux-user: Enable HWCAP_ASIMDFHM, HWCAP_JSCVT (2019-02-28 11:03:05 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * add MHU and dual-core support to Musca boards
>  * refactor some VFP insns to be gated by ID registers
>  * Revert "arm: Allow system registers for KVM guests to be changed by QEMU code"
>  * Implement ARMv8.2-FHM extension
>  * Advertise JSCVT via HWCAP for linux-user
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
