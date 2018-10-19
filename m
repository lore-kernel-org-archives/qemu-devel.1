Received: from eggs.gnu.org ([2001:4830:134:3::10]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDW0F-0006c4-1q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDW0E-0007D8-94
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:43:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDW0D-0007BM-Q6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:43:50 -0400
Received: by mail-ot1-x342.google.com with SMTP id p23so33385637otf.11
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 07:43:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-5-git-send-email-thuth@redhat.com>
	<CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
	<a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 15:43:28 +0100
Message-ID: <CAFEAcA9Pb5Dw9zu5_esYwor+MEmUJ=f4ZZqifui9qyJdKWbTiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for
 the "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

On 19 October 2018 at 15:40, Thomas Huth <thuth@redhat.com> wrote:
> Anyway, it's also not only about speeding up the compilation process for
> people who don't want to use the corresponding targets, this is also
> very useful for downstream distributions of QEMU who want to make sure
> to not compile-in more devices than urgently needed. For example we
> disable this device here and the others in downstream RHEL version of
> QEMU, and I guess it might be interesting for nemu, too. So having more
> flexibility here in the Makefiles would be really great to decrease the
> burden with downstream-specific patches...

I think if we want to support this for downstreams we need
to look at something better than the default-configs/
mechanism for it. (Perhaps the kconfig-alike Paolo mentioned
in a previous thread?)

My dividing line for "should something go in a specific
architecture's default-configs/ list" is "is this an SoC
or real piece of hardware that is naturally limited to
one or a few SoCs".

thanks
-- PMM
