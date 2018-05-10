Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGoxr-0005gI-Ra
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGoxr-0001Q7-34
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:02:47 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:37381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGoxq-0001Pq-VO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:02:47 -0400
Received: by mail-ot0-x22b.google.com with SMTP id 77-v6so3100594otd.4
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 10:02:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502221552.3873-14-richard.henderson@linaro.org>
References: <20180502221552.3873-1-richard.henderson@linaro.org>
	<20180502221552.3873-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:02:25 +0100
Message-ID: <CAFEAcA_v5kVGLKwdX-U6AA1qEkU9KTJBCdh-ZRGMJqSMqjna8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/14] target/arm: Implement FMOV
 (immediate) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 2 May 2018 at 23:15, Richard Henderson <richard.henderson@linaro.org> wr=
ote:
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> All the hard work is already done by vfp_expand_imm, we just need to
> make sure we pick up the correct size.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> [rth: Merge unallocated_encoding check with TCGMemOp conversion.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
