Received: from eggs.gnu.org ([2001:4830:134:3::10]:32981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqETp-00024g-2T
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqETo-0004iC-EZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:22:09 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqETo-0004hy-9j
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:22:08 -0400
Received: by mail-oi0-x242.google.com with SMTP id q11-v6so6808344oic.12
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 02:22:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180816090604.3970-1-marcel.apfelbaum@gmail.com>
References: <20180816090604.3970-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 10:21:46 +0100
Message-ID: <CAFEAcA_ayZkSGLVSh7f1qZfykg1e_oV+0pQBN_aMRt_jnEGgaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] config: split PVRDMA from RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, Thomas Huth <thuth@redhat.com>, Rebecca Cran <rebecca@bluestop.org>

On 16 August 2018 at 10:06, Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
> In some BSD systems RDMA migration is possible while
> the pvrdma device can't be compiled because the mremap
> system call is missing.
>
> Reported-by: Rebecca Cran <rebecca@bluestop.org>
> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

> +##########################################
> +# PVRDMA detection
> +
> +if test "$rdma" = "yes" ; then
> +    case "$pvrdma" in
> +    "")
> +        if test "$bsd" = "yes"; then
> +            pvrdma="no"
> +        else
> +            pvrdma="yes"
> +        fi

Please don't do tests against "which host OS is this?"
unless there is absolutely no other option. Prefer to
test for presence/absence of specific features (eg
"do we have mremap()?".

Otherwise you're likely to give the wrong answer
for other host OSes we have support for (Haiku,
Solaris) or other host OSes we add in future.

thanks
-- PMM
