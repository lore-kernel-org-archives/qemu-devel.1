Received: from eggs.gnu.org ([2001:4830:134:3::10]:45922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYUXf-0006kn-06
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYUXe-0005AS-Ah
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:52:47 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:42425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYUXe-00058F-5e
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:52:46 -0400
Received: by mail-ot0-x22a.google.com with SMTP id n24-v6so5613832otl.9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 03:52:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627043328.11531-31-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 11:52:24 +0100
Message-ID: <CAFEAcA9c7=yUujTKS3nE99kxB-j4GagdG1eq4EGVZ=bUCs8Yow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 30/35] target/arm: Pass index to AdvSIMD
 FCMLA (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 June 2018 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
> For aa64 advsimd, we had been passing the pre-indexed vector.
> However, sve applies the index to each 128-bit segment, so we
> need to pass in the index separately.
>
> For aa32 advsimd, the fp32 operation always has index 0, but
> we failed to interpret the fp16 index correctly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
