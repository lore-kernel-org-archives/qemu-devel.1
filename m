Received: from eggs.gnu.org ([209.51.188.92]:32837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h378G-000597-K1
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 18:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h36rY-0002sR-QH
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 18:24:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h36rY-0002s3-Jd
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 18:24:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id i12so2327309otp.12
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 15:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <1552119170-15474-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1552119170-15474-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Mar 2019 22:23:55 +0000
Message-ID: <CAFEAcA_RMTxLswpecZyT-RtivUJh4c9ZAj4LmzP066is9g9_DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/parallel: Make it possible to
 compile also without CONFIG_PARALLEL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Miroslav Rezanina <mrezanin@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Sat, 9 Mar 2019 at 08:21, Thomas Huth <thuth@redhat.com> wrote:
>
> For the downstream distribution of QEMU, we want to compile without
> CONFIG_PARALLEL. Commit 9157eee1b1c076ff3 already moved the function
> parallel_hds_isa_init() (which is still required for linking) into a file
> that is included anyway, but commit bb3d5ea858e7f888563a moved it
> to a separate file which is only compiled again if CONFIG_PARALLEL is
> set. To be able to link QEMU again without CONFIG_PARALLEL, let's
> move this file unconditionally to common-obj-y again. And while we're
> at it, also rename it to parallel-helper.c (since parallel.c is also
> about ISA already)

parallel.c also provides an MMIO interface to the
parallel port via parallel_mm_init(), used by the MIPS
Jazz board. (In an ideal world this would be a proper
device, but it is ancient code.)

thanks
-- PMM
