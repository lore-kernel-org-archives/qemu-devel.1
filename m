Received: from eggs.gnu.org ([2001:4830:134:3::10]:56073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZF4k-0002uV-I4
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 08:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZF4j-0000vy-KJ
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 08:34:02 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZF4j-0000vE-E9
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 08:34:01 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so6960243oih.11
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 05:34:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629145347.652-1-peter.maydell@linaro.org>
References: <20180629145347.652-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 13:33:39 +0100
Message-ID: <CAFEAcA-3Aen5edk_9nT3+-L9GpZVQ5OJcN3uTy5CmsbbqSmQ8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/55] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2018 at 15:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hopefully last target-arm queue before softfreeze;
> this one's largest part is the remainder of the SVE patches,
> but there are a selection of other minor things too.
>
> thanks
> -- PMM
>
> The following changes since commit 109b25045b3651f9c5d02c3766c0b3ff63e6d193:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-06-29 12:30:29 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180629
>
> for you to fetch changes up to 802abf4024d23e48d45373ac3f2b580124b54b47:
>
>   target/arm: Add ID_ISAR6 (2018-06-29 15:30:54 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * last of the SVE patches; SVE is now enabled for aarch64 linux-user
>  * sd: Don't trace SDRequest crc field (coverity bugfix)
>  * target/arm: Mark PMINTENSET accesses as possibly doing IO
>  * clean up v7VE feature bit handling
>  * i.mx7d: minor cleanups
>  * target/arm: support reading of CNT[VCT|FRQ]_EL0 from user-space
>  * target/arm: Implement ARMv8.2-DotProd
>  * virt: add addresses to dt node names (which stops dtc from
>    complaining that they're not correctly named)
>  * cleanups: replace error_setg(&error_fatal) by error_report() + exit()
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
