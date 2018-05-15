Received: from eggs.gnu.org ([2001:4830:134:3::10]:54108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIbRH-0003hX-FO
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIbRC-0003SK-W8
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:00:31 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIbRC-0003S3-O4
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:00:26 -0400
Received: by mail-oi0-x22f.google.com with SMTP id l1-v6so442333oii.1
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:00:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 16:00:05 +0100
Message-ID: <CAFEAcA_xnH3ShT+psOg7URZ4si1h1SEFMrXnT+A3JrwFcBZg=g@mail.gmail.com>
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

On 15 May 2018 at 15:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> The following changes since commit ad1b4ec39caa5b3f17cbd8160283a03a3dcfe2ae:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/input-20180515-pull-request' into staging (2018-05-15 12:50:06 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180515
>
> for you to fetch changes up to ae7651804748c6b479d5ae09aeac4edb9c44f76e:
>
>   tcg: Optionally log FPU state in TCG -d cpu logging (2018-05-15 14:58:44 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix coverity nit in int_to_float code
>  * Don't set Invalid for float-to-int(MAXINT)
>  * Fix fp_status_f16 tininess before rounding
>  * Add various missing insns from the v8.2-FP16 extension
>  * Fix sqrt_f16 exception raising
>  * sdcard: Correct CRC16 offset in sd_function_switch()
>  * tcg: Optionally log FPU state in TCG -d cpu logging
>

Applied, thanks.

-- PMM
