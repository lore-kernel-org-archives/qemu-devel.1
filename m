Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6d4-0001t0-6k
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP6cy-0004W2-5H
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:03:50 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP6cy-0004VF-0T
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 09:03:44 -0500
Received: by mail-ot1-x344.google.com with SMTP id i20so1757111otl.0
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 06:03:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113165247.4806-5-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-5-sameo@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 14:03:22 +0000
Message-ID: <CAFEAcA9X5oZJHjc4mdgnnQHXyULXH_ZhLErubPWbZqbEywXi2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/13] target: arm: Move all interrupt and
 exception handlers into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Most of them are TCG dependent so we want to be able to not build them
> in order to support TCG disablement with ARM.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> ---
>  target/arm/excp_helper.c | 550 +++++++++++++++++++++++++++++++++++++++
>  target/arm/helper.c      | 531 -------------------------------------
>  target/arm/Makefile.objs |   2 +-
>  3 files changed, 551 insertions(+), 532 deletions(-)
>  create mode 100644 target/arm/excp_helper.c
>
> diff --git a/target/arm/excp_helper.c b/target/arm/excp_helper.c
> new file mode 100644
> index 0000000000..38fe9703de
> --- /dev/null
> +++ b/target/arm/excp_helper.c
> @@ -0,0 +1,550 @@
> +/*
> + * Exception and interrupt helpers.
> + *
> + * This code is licensed under the GNU GPL v2 and later.

*or* later. Wording matters in licensing. Same for other new
files added in this series.

> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

thanks
-- PMM
