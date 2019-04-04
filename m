Received: from eggs.gnu.org ([209.51.188.92]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBrZL-00039f-5f
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBrPy-00063P-8h
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:43:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBrPx-0005sm-H5
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 21:43:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id t8so852338otp.7
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 18:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190329200445.28512-1-chen.zhang@intel.com>
In-Reply-To: <20190329200445.28512-1-chen.zhang@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2019 08:43:27 +0700
Message-ID: <CAFEAcA9PU4=C8yApkU8bRd2-rCHd2DqtnDv5v=pC5M+PK8rkMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] bitops.h: Remove unused bitops function
 test_and_change_bit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-dev <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>

On Sat, 30 Mar 2019 at 03:09, Zhang Chen <chen.zhang@intel.com> wrote:
>
> From: Zhang Chen <chen.zhang@intel.com>
>
> In current codes we use change_bit() to finish the job.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  include/qemu/bitmap.h |  1 -
>  include/qemu/bitops.h | 15 ---------------
>  2 files changed, 16 deletions(-)

Do we gain anything by removing this function? IIRC these functions
are all borrowed from the Linux kernel, so keeping the same API
as the kernel does would make sense to me, even if we happen
not to use all of it right now.

thanks
-- PMM
