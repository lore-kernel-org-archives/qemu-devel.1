Received: from eggs.gnu.org ([2001:4830:134:3::10]:35792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMXHI-0000mQ-Ao
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMXHE-0004jV-Sa
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:54:42 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:45233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMXHD-0004iQ-1h
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 06:54:40 -0500
Received: by mail-oi1-x229.google.com with SMTP id b141so1014894oii.12
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 03:54:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113115230.30257-1-peter.maydell@linaro.org>
References: <20181113115230.30257-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 11:54:16 +0000
Message-ID: <CAFEAcA-7LDSG950dA8FqkDBUF0=zZ+Wht5Z28VEuTdmyZFe4eA@mail.gmail.com>
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

On 13 November 2018 at 11:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> v2: fix compile failure on arm hosts...
>
> thanks
> -- PMM
>
> The following changes since commit 6db87aae61bc6ac0a8cd9bc2e05d7ebfbcfd3657:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-11-12 17:11:22 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181113
>
> for you to fetch changes up to 436c0cbbeb38dd97c02fe921a7cb253a18afdd86:
>
>   target/arm/cpu: Give Cortex-A15 and -A7 the EL2 feature (2018-11-13 10:47:59 +0000)
>
> ----------------------------------------------------------------
> target/arm queue:
>  * Remove no-longer-needed workaround for small SAU regions for v8M
>  * Remove antique TODO comment
>  * MAINTAINERS: Add an entry for the 'collie' machine
>  * hw/arm/sysbus-fdt: Only call match_fn callback if the type matches
>  * Fix infinite recursion in tlbi_aa64_vmalle1_write()
>  * ARM KVM: fix various bugs in handling of guest debugging
>  * Correctly implement handling of HCR_EL2.{VI, VF}
>  * Hyp mode R14 is shared with User and System
>  * Give Cortex-A15 and -A7 the EL2 feature
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
