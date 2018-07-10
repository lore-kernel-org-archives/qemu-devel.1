Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcmdl-0006mI-Q4
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcmdk-00044G-Qd
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:00:49 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcmdk-00043w-Jc
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 03:00:48 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so40621681oih.11
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:00:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709175603.1320-1-richard.henderson@linaro.org>
References: <20180709175603.1320-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 08:00:27 +0100
Message-ID: <CAFEAcA-Y0DvZgvjrdpMqnFjQdwsr=xinr0hJiBc9+tPrsDzVtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] target/sh4: Fix translator.c
 assertion failure for gUSA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 July 2018 at 18:56, Richard Henderson <richard.henderson@linaro.org> wrote:
> This patch got lost, and represents a regression from 2.12.
>
> Running check-tcg with all of the docker bells and whistles
> will show this up, and is what reminded me.
>
>
> r~
>
>
> The following changes since commit ec7eb2ae77cc207064e17ace048f7ec0c4b85d6f:
>
>   translate-all: honour CF_NOCACHE in tb_gen_code (2018-07-09 16:14:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-sh4-20180709
>
> for you to fetch changes up to be0e3d7a1e148180fe1b89c7f93720db0607614e:
>
>   target/sh4: Fix translator.c assertion failure for gUSA (2018-07-09 10:34:04 -0700)
>
> ----------------------------------------------------------------
> Fix translation for gUSA regions.
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       target/sh4: Fix translator.c assertion failure for gUSA
>
>  target/sh4/translate.c | 81 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 44 insertions(+), 37 deletions(-)


Applied, thanks.

-- PMM
