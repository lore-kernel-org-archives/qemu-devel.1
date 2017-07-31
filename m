Received: from eggs.gnu.org ([2001:4830:134:3::10]:56074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcCo5-0001Ro-Ip
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcCo4-0004YZ-P4
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:40:33 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcCo4-0004Y1-HR
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:40:32 -0400
Received: by mail-wm0-x22a.google.com with SMTP id k20so16264839wmg.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 08:40:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
References: <1501503765-15639-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 16:40:10 +0100
Message-ID: <CAFEAcA8sCJryehMgrDCiXGHXGmVhkg_XUdoni+-SU+pSChOtNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 31 July 2017 at 13:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queue for 2.10: all M profile bugfixes...
>
> thanks
> -- PMM
>
> The following changes since commit 25dd0e77898c3e10796d4cbeb35e8af5ba6ce9=
75:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' i=
nto staging (2017-07-31 11:27:43 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-=
20170731
>
> for you to fetch changes up to 89cbc3778a3d61761e2231e740269218c9a8a41d:
>
>   hw/mps2_scc: fix incorrect properties (2017-07-31 13:11:56 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * fix broken properties on MPS2 SCC device
>  * fix MPU trace handling of write vs exec
>  * fix MPU M profile bugs:
>    - not handling system space or PPB region correctly
>    - not resetting state
>    - not migrating MPU_RNR
>
> ----------------------------------------------------------------
> Peter Maydell (6):
>       target/arm: Correct MPU trace handling of write vs execute
>       target/arm: Don't do MPU lookups for addresses in M profile PPB reg=
ion
>       target/arm: Don't allow guest to make System space executable for M=
 profile
>       target/arm: Rename cp15.c6_rgnr to pmsav7.rnr
>       target/arm: Move PMSAv7 reset into arm_cpu_reset() so M profile MPU=
s get reset
>       target/arm: Migrate MPU_RNR register state for M profile cores
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       hw/mps2_scc: fix incorrect properties

Applied, thanks.

-- PMM
