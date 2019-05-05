Received: from eggs.gnu.org ([209.51.188.92]:47594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJCt-0005Au-8X
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNJCs-0001ZO-9L
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:37:39 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNJCs-0001Yw-3p
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:37:38 -0400
Received: by mail-ot1-x344.google.com with SMTP id b1so9412457otp.5
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190505070059.4664-1-zhengxiang9@huawei.com>
In-Reply-To: <20190505070059.4664-1-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 5 May 2019 16:37:26 +0100
Message-ID: <CAFEAcA-_bk0hr3g4VhxWHktMOyQ-vDvYSCBXcjMjusMFbwScgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pflash: Only read non-zero parts of
 backend image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiang Zheng <zhengxiang9@huawei.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Heyi Guo <guoheyi@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Sun, 5 May 2019 at 08:02, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> Currently we fill the memory space with two 64MB NOR images when
> using persistent UEFI variables on virt board. Actually we only use
> a very small(non-zero) part of the memory while the rest significant
> large(zero) part of memory is wasted.
>
> So this patch checks the block status and only writes the non-zero part
> into memory. This requires pflash devices to use sparse files for
> backends.

Do you mean "pflash devices will no longer work if the file
that is backing them is not sparse", or just "if the file that
is backing them is not sparse then you won't get the benefit
of using less memory" ?

thanks
-- PMM
