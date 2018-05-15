Received: from eggs.gnu.org ([2001:4830:134:3::10]:39777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXXk-0002Ip-Mb
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXXj-0001XE-S2
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:50:56 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIXXj-0001Ww-M9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:50:55 -0400
Received: by mail-oi0-x244.google.com with SMTP id k5-v6so13534869oiw.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:50:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514221219.7091-6-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:50:34 +0100
Message-ID: <CAFEAcA89peFo5DcqZ1E3GNVpGEe=uudff1KEZ5evVAQmGkNgUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 05/28] fpu/softfloat: Canonicalize NaN
 fraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 14 May 2018 at 23:11, Richard Henderson <richard.henderson@linaro.org> wrote:
> Shift the NaN fraction to a canonical position, much like we
> do for the fraction of normal numbers.  This will facilitate
> manipulation of NaNs within the shared code paths.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
