Received: from eggs.gnu.org ([2001:4830:134:3::10]:60708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnnvy-0001Yz-3o
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnnvs-0001Bh-GY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:00:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnnvs-0001Ad-Ao
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:00:16 -0400
Received: by mail-wr0-x230.google.com with SMTP id l37so126000751wrc.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 08:00:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489491125-23648-1-git-send-email-peter.maydell@linaro.org>
References: <1489491125-23648-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 15:59:54 +0100
Message-ID: <CAFEAcA-iRi7NcVKdGy-EgLJ4H1JB1d2iZ-22EHcOppbEqCDR=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 14 March 2017 at 12:32, Peter Maydell <peter.maydell@linaro.org> wrote:
> Couple of minor patches to sneak in before rc0. The PSCI return
> values fix is the most important one.
>
> -- PMM
>
> The following changes since commit 94b5d57d2f5a3c849cecd65e424bb6f50b998df9:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170314' into staging (2017-03-14 10:13:19 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170314
>
> for you to fetch changes up to d5affb0d8677e1a8a8fe03fa25005b669e7cdc02:
>
>   target/arm/arm-powerctl: Fix psci info return values (2017-03-14 11:28:54 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * arm-powerctl: Fix psci info return values
>  * implement armv8 PMUSERENR (user-mode enable bits)
>
> ----------------------------------------------------------------
> Andrew Baumann (1):
>       target/arm: implement armv8 PMUSERENR (user-mode enable bits)
>
> Andrew Jones (1):
>       target/arm/arm-powerctl: Fix psci info return values
>
>  target/arm/cpu.h    |  4 +--
>  target/arm/helper.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 73 insertions(+), 10 deletions(-)
>


Applied, thanks.

-- PMM
