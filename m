Received: from eggs.gnu.org ([208.118.235.92]:49304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Wnn-0002sH-ID
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Wnj-0006G3-19
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:46:31 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Wni-0006Dw-LH
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:46:26 -0400
Received: by mail-ot1-x333.google.com with SMTP id j9-v6so19953987otl.2
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 07:46:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 15:46:04 +0100
Message-ID: <CAFEAcA8-2sCjBe-vaF=7wkW81UzLLbTfp0MtT0sAp1gJtymzVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 8 October 2018 at 14:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue: the big things in here are SVE in system
> emulation mode, and v8M stack limit checking; there are
> also a handful of smaller fixes.
>
> thanks
> -- PMM
>
> The following changes since commit 079911cb6e26898e16f5bb56ef4f9d33cf92d32d:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-fpu-20181005' into staging (2018-10-08 12:44:35 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181008
>
> for you to fetch changes up to 74e2e59b8d0a68be0956310fc349179c89fd7be0:
>
>   hw/display/bcm2835_fb: Silence Coverity warning about multiply overflow (2018-10-08 14:55:05 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: fix error in a code comment
>  * virt: Suppress external aborts on virt-2.10 and earlier
>  * target/arm: Correct condition for v8M callee stack push
>  * target/arm: Don't read r4 from v8M exception stackframe twice
>  * target/arm: Support SVE in system emulation mode
>  * target/arm: Implement v8M hardware stack limit checking
>  * hw/display/bcm2835_fb: Silence Coverity warning about multiply overflow

Applied, thanks.

-- PMM
