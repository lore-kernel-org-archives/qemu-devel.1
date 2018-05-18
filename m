Received: from eggs.gnu.org ([2001:4830:134:3::10]:45501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJeJA-0004IW-CW
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJeJ9-0006uA-GB
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:16:28 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:35361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJeJ9-0006tl-9w
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:16:27 -0400
Received: by mail-oi0-x231.google.com with SMTP id a6-v6so6904667oia.2
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 05:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 13:16:06 +0100
Message-ID: <CAFEAcA9p2WAsb7xiC9Y65EZYWzOrG11P_hKTx5BBPQAnd1xgcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3-a 00/27] target/arm: Scalable Vector
 Extension
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

On 16 May 2018 at 23:29, Richard Henderson <richard.henderson@linaro.org> wrote:
> This is the first third, more or less, of my current patch set.
> I'm sending only this portion now, rather than another monster
> set all at once.
>
> The major change is to move the call to sve_access_check inside
> any final decode reject that might be required.  There are other
> minor cleanups to patch integrity and comments.
>
> The changes are mostly trivial from the February v2 patch set,
> so if an R-b was given, I have retained it.
>
> That leaves 4, 7, 8, and 26 (new) as unreviewed.
>
> The patch that enables SVE for aarch64-linux-user is not present.

I've applied 1-25 to target-arm.next.

thanks
-- PMM
