Received: from eggs.gnu.org ([2001:4830:134:3::10]:48181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZhzD-000643-Pv
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZhzD-0001rD-03
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:21:43 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZhzC-0001qm-OY
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:21:42 -0400
Received: by mail-wm0-x22f.google.com with SMTP id c184so32814046wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:21:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
References: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 19:21:20 +0100
Message-ID: <CAFEAcA-2YmirPHEiVO9kfSx68+pM_b+7QpJTkVJXYExGJWHy+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 18:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queue, mostly bug fixes to go into rc0.
> The integratorcp and fsl_imx* changes are migration
> compat breakers but that's ok for these boards.
>
> thanks
> -- PMM
>
>
> The following changes since commit ce1d20aac8533357650774c2c240e30de87dc122:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-24' into staging (2017-07-24 16:20:47 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170724
>
> for you to fetch changes up to b2d1b0507d1b80f23da12dd8aab56944fe380a09:
>
>   integratorcp: Don't migrate flash using vmstate_register_ram_global() (2017-07-24 17:59:28 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * fix a TCG temporary leak in aarch64 rev16
>  * fsl_imx*: migrate the ROM contents
>  * integratorcp: don't use vmstate_register_ram_global for flash
>  * mps2: Correctly set parent bus for SCC device
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
