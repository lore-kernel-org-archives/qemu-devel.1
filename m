Received: from eggs.gnu.org ([209.51.188.92]:47263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guK9o-0000YQ-RY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guK3z-00040m-W3
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:40:41 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guK3w-0003wE-D2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:40:38 -0500
Received: by mail-ot1-x343.google.com with SMTP id s5so11546169oth.7
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:40:35 -0800 (PST)
MIME-Version: 1.0
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
	<1549390526-24246-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-38-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 16:40:23 +0000
Message-ID: <CAFEAcA-F-4WQ4OrEYh_sjpgxGOoAY3ZLpwhro0GTw3Dva1o7xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 37/76] i386: import & use bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Stefano Garzarella <sgarzare@redhat.com>

On Tue, 5 Feb 2019 at 19:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> it's from v4.20-rc5.
>
> CC: Stefano Garzarella <sgarzare@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/pc.c                                 |  8 +------
>  include/standard-headers/asm-x86/bootparam.h | 34 ++++++++++++++++++++++++++++
>  scripts/update-linux-headers.sh              |  6 +++++
>  3 files changed, 41 insertions(+), 7 deletions(-)
>  create mode 100644 include/standard-headers/asm-x86/bootparam.h

Hi -- I just noticed this commit while I was looking through
git logs for a different reason. For future changes to
the standard-headers/, can we keep the "change the update
script" patches separate from the "and now update the headers
from upstream kernel commit X with the new script" parts,
please? Otherwise it's very hard to be sure that the header
changes are correct and that we still have an in-sync
set of header files that aren't a patchwork of files from
different versions. (For instance, this commit claims it is
"from v4.20-rc5", but the rest of the header files are already
at 4.21-rc1/5.0-rc1.)

thanks
-- PMM
