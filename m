Received: from eggs.gnu.org ([2001:4830:134:3::10]:32971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotfj-0005tb-1m
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eotfi-00083M-Aa
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:39 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:42056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eotfi-00082D-65
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:24:38 -0500
Received: by mail-ot0-x235.google.com with SMTP id a7so5107379otk.9
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 08:24:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216215608.13227-3-richard.henderson@linaro.org>
References: <20180216215608.13227-1-richard.henderson@linaro.org>
	<20180216215608.13227-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 16:24:17 +0000
Message-ID: <CAFEAcA-C_OPPkhBVLYvAH_-r=ErJOZYchC0M5v0Ox5h+7zPCfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] aarch64-linux-user: Split out
 helpers for guest signal handling
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

On 16 February 2018 at 21:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Split out helpers from target_setup_frame and target_restore_sigframe
> for dealing with general registers, fpsimd registers, and the end record.
>
> When we add support for sve registers, the relative positions of
> these will change.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
