Received: from eggs.gnu.org ([2001:4830:134:3::10]:55673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXqZ6-0006J3-FW
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXqZ5-0007ir-Nf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:43:52 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:34351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXqZ5-0007iZ-Ib
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:43:51 -0500
Received: by mail-ot1-x32a.google.com with SMTP id t5so6004577otk.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 08:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20181213145445.17935-1-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 16:43:39 +0000
Message-ID: <CAFEAcA8_sAA6c-SwFs_sPvWMDYvSrjhVqyf+Bz0cqdgUKYoQdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/37] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 13 Dec 2018 at 14:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> First target-arm pullreq of the 4.0 series; most of this
> is Mao's cleanups that finally let us drop sysbus::init;
> the most interesting user-visible feature is RTH's patches
> adding some v8.1 and v8.2 architecture features.
>
> thanks
> -- PMM
>
> The following changes since commit 6145a6d84b3bf0f25935b88543febe076c61b0f4:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181212' into staging (2018-12-13 13:06:09 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181213
>
> for you to fetch changes up to 2d7137c10fafefe40a0a049ff8a7bd78b66e661f:
>
>   target/arm: Implement the ARMv8.1-LOR extension (2018-12-13 14:41:24 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Convert various devices from sysbus init to instance_init
>  * Remove the now unused sysbus init support entirely
>  * Allow AArch64 processors to boot from a kernel placed over 4GB
>  * hw: arm: musicpal: drop TYPE_WM8750 in object_property_set_link()
>  * versal: minor fixes to virtio-mmio instantation
>  * arm: Implement the ARMv8.1-HPD extension
>  * arm: Implement the ARMv8.2-AA32HPD extension
>  * arm: Implement the ARMv8.1-LOR extension (as the trivial
>    "no limited ordering regions provided" minimum)
>
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
